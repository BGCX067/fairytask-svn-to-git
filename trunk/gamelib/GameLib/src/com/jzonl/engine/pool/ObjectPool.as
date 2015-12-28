package com.jzonl.engine.pool
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	/**
	 * 对象池 
	 * @author hanjy
	 * 
	 */	
	public class ObjectPool 
	{
		private static var _instance:ObjectPool;
		private static var _allowInstantiation:Boolean;
		
		private var _pools:Object;
		
		public static function get instance():ObjectPool
		{
			if (!_instance)
			{
				_allowInstantiation = true;
				_instance = new ObjectPool();
				_allowInstantiation = false;
			}
			
			return _instance;
		}
		
		public function ObjectPool() 
		{
			if (!_allowInstantiation)
			{
				throw new Error("Trying to instantiate a Singleton!");
			}
			
			_pools = {};
		}
		
		/**
		 * 注册池对象 
		 * @param objectClass
		 * @param size
		 * @param isDynamic
		 * 
		 */
		public function registerPool(objectClass:Class, size:uint = 1, isDynamic:Boolean = true):void
		{
			//trace(describeType(objectClass));
			if (!(describeType(objectClass).factory.implementsInterface.(@type.match("IPoolable")).length() > 0))
			{
				throw new Error("Can't pool something that doesn't implement IPoolable!");
				return;
			}
			
			var qualifiedName:String = getQualifiedClassName(objectClass);
			
			if (!_pools[qualifiedName])
			{
				_pools[qualifiedName] = new PoolInfo(objectClass, size, isDynamic);
			}
		}
		
		/**
		 * 取得池对象 
		 * @param objectClass
		 * @return 
		 * 
		 */
		public function getObj(objectClass:Class):IPoolable
		{
			var qualifiedName:String = getQualifiedClassName(objectClass);
			trace("qualifiedName_get",qualifiedName);
			if (!_pools[qualifiedName])
			{
				throw new Error("Can't get an object from a pool that hasn't been registered!");
				return;
			}
			
			var returnObj:IPoolable;
			trace("活动池子:",PoolInfo(_pools[qualifiedName]).active,PoolInfo(_pools[qualifiedName]).size);
			if (PoolInfo(_pools[qualifiedName]).active >= PoolInfo(_pools[qualifiedName]).size)
			{
				if (PoolInfo(_pools[qualifiedName]).isDynamic)
				{
					returnObj = new objectClass();
					
					PoolInfo(_pools[qualifiedName]).size++;
					PoolInfo(_pools[qualifiedName]).items.push(returnObj);
				}
				else
				{
					return null;
				}
			}
			else
			{
				returnObj = PoolInfo(_pools[qualifiedName]).items[PoolInfo(_pools[qualifiedName]).active];
				
				returnObj.renew();
			}
			
			PoolInfo(_pools[qualifiedName]).active++;
			
			return returnObj;
		}
		
		/**
		 * 清除一类型的对象 
		 * @param objectClass
		 * 
		 */
		public function clearObj(objectClass:Class):void
		{
			var qualifiedName	:String = getQualifiedClassName(objectClass);
			var poolItems		:Vector.<IPoolable>	=	PoolInfo(_pools[qualifiedName]).items;
			var i:int=0;
			for each(var tmpObj:IPoolable in poolItems)
			{
				if(!tmpObj.destroyed)
				{
					returnObj(tmpObj);
				}
			}
		}
		
		/**
		 * 返回池对象 
		 * @param obj
		 * 
		 */
		public function returnObj(obj:IPoolable):void
		{
			var qualifiedName:String = getQualifiedClassName(obj);
			trace("qualifiedName_return",qualifiedName);
			
			if (!_pools[qualifiedName])
			{
				throw new Error("Can't return an object from a pool that hasn't been registered!");
				return;
			}
			
			var objIndex:int = PoolInfo(_pools[qualifiedName]).items.indexOf(obj);
			trace("归还索引:",objIndex);
			if (objIndex >= 0)
			{
				if (!PoolInfo(_pools[qualifiedName]).isDynamic)
				{
					PoolInfo(_pools[qualifiedName]).items.fixed = false;
				}
				
				PoolInfo(_pools[qualifiedName]).items.splice(objIndex, 1);
				
				obj.destroy();
				
				PoolInfo(_pools[qualifiedName]).items.push(obj);
				
				if (!PoolInfo(_pools[qualifiedName]).isDynamic)
				{
					PoolInfo(_pools[qualifiedName]).items.fixed = true;
				}
				if(PoolInfo(_pools[qualifiedName]).active>0)
				{
					PoolInfo(_pools[qualifiedName]).active--;
				}
			}
		}
		
	}

}

import com.jzonl.engine.pool.IPoolable;

class PoolInfo
{
	public var items:Vector.<IPoolable>;
	public var itemClass:Class;
	public var size:uint;
	public var active:uint;
	public var isDynamic:Boolean;
	
	public function PoolInfo(itemClass:Class, size:uint, isDynamic:Boolean = true)
	{
		this.itemClass = itemClass;
		items = new Vector.<IPoolable>(size, !isDynamic);
		this.size = size;
		this.isDynamic = isDynamic;
		active = 0;
		
		initialize();
	}
	
	/**
	 * 初始化 
	 */
	private function initialize():void
	{
		for (var i:int = 0; i < size; i++)
		{
			items[i] = new itemClass();
		}
	}
}