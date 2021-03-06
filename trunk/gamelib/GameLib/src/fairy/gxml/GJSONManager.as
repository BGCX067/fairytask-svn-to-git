package fairy.gxml
{
	import fairy.gxml.jsonspec.IJSONSpec;
	import fairy.gxml.jsonspec.JSONDisplaySpec;
	import fairy.gxml.jsonspec.JSONItemSpec;
	import fairy.gxml.jsonspec.JSONSpec;
	import fairy.gxml.spec.DisplaySpec;
	import fairy.gxml.spec.ISpec;
	import fairy.gxml.spec.ItemGroupSpec;
	import fairy.gxml.spec.ItemSpec;
	import fairy.gxml.spec.Spec;
	import fairy.util.core.Singleton;

	/**
	 * JSON解析类
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class GJSONManager
	{
		/**
		 * 根据JSON创建对象
		 * 
		 * @param obj	JSON数据
		 * @param spec	解析器类型
		 * @param root	初始对象
		 * @return 
		 * 
		 */
		public static function create(obj:*,spec:IJSONSpec = null):*
		{
			if (!spec)
				spec = new JSONSpec();
			
			return spec.createObject(obj);
		}
		
		/**
		 * 创建显示对象
		 * {classRef:"flash.display::Sprite",children:[{classRef:"flash.display::Shape"}]}
		 * 
		 * @param obj	JSON数据
		 * @param classNames	类名替换
		 * @param root	初始对象
		 * @param spec	解析器类型
		 * @return 
		 * 
		 */
		public static  function createDisplayObject(obj:*,classNames:Object = null,root:* = null,spec:JSONItemSpec = null):*
		{
			if (!spec)
				spec = new JSONDisplaySpec(root);
			
			if (classNames)
				spec.classNames = classNames;
			
			return spec.createObject(obj);
		}
		
		/**
		 * 创建数据组
		 * {classRef:"fairy.gxml.spec::ItemGroup",data:[{id:"a"}]}
		 * 
		 * @param obj	JSON数据
		 * @param classNames	类名替换（应当将根节点替换成ItemGroup类型的对象，而子节点的类型应当具有id属性）
		 * @param spec	解析器类型
		 * @return 
		 * 
		 */
		public static function createItemGroup(obj:*,classNames:Object = null,spec:JSONItemSpec = null):*
		{
			if (!spec)
				spec = new JSONItemSpec();
			
			if (classNames)
				spec.classNames = classNames;
			
			return spec.createObject(obj);
		}
	}
}