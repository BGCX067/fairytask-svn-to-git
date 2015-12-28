<?php

/**
 * This is the model class for table "ft_category".
 *
 * The followings are the available columns in table 'ft_category':
 * @property integer $id
 * @property integer $lft
 * @property integer $rgt
 * @property integer $level
 * @property string $title
 * @property string $desc
 * @property string $url
 */
class Category extends CActiveRecord
{
	public $parent;
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Category the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
	
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'ft_category';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			//array('lft, rgt, level, title', 'required'),
			array('lft, rgt, level', 'numerical', 'integerOnly'=>true),
			array('title, url', 'length', 'max'=>50),
			array('desc', 'length', 'max'=>255),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, lft, rgt, level, title, desc, url', 'safe', 'on'=>'search'),
		);
	}
	
	public function behaviors()
	{
		return array(
				'TreeBehavior' => array(
						'class' => 'ext.nestedset.TreeBehavior',
						'_idCol' => 'id',
						'_lftCol' => 'lft',
						'_rgtCol' => 'rgt',
						'_lvlCol' => 'level',
				),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'lft' => 'Lft',
			'rgt' => 'Rgt',
			'level' => 'Level',
			'parent' => '上级',
			'title' => '标题',
			'desc' => '描述',
			'url' => '连接',
		);
	}
	
	/**
	 * 取得列表
	 */
	public function getTreeList()
	{
		$root = $this->findByPK(1);
		if(!isset($root))
		{
			$model = new Category();
			$model->attributes = array('lft'=>'0','rgt'=>'1','level'=>'0','title'=>'任务类别');
			$model->save();
		}
		$tree = $root->getNestedTree();
		foreach($tree as $subtree)
		{
			$message = $this->printNestedTree($subtree);
		}
		return $message;
	}
	
	/**
	 * 打印树
	 * @param unknown_type $tree
	 */
	private function printNestedTree($tree)
	{
		$result = false;
		if(@is_array($tree['children']))
		{
			foreach($tree['children'] as $child)
			{
				$result[] = array('id'=>$child['node']->id,'text'=>$child['node']->url?CHtml::link($child['node']->title,'/index.php/'.$child['node']->url):$child['node']->title,'children'=>$this->printNestedTree($child));
			}
		}
		 
		return $result;
	}
	/**
	 * 根据菜单级别来取得
	 * @param unknown_type $pLevel
	 */
	public function getListByLevel($pLevel)
	{
		$root	=	$this->findAll("level={$pLevel}");
		$data = CHtml::listData($root, 'id', 'title');
		return $data;
	}
	/**
	 * 根据父级来取得列表
	 * @param unknown_type $pId
	 */
	public function getListByPid($pId)
	{
		$root	=	$this->findByPK($pId);
		$levels	=	$root->getChildNodes();
		$data = CHtml::listData($levels, 'id', 'title');
		return $data;
	}
	
	/**
	 * 取得父级
	 */
	public function getParent()
	{
		$root = $this->findByPK(1);
		$tree = $root->getTree();
		$data = CHtml::listData($tree, 'id', 'title');
		return $data;
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('lft',$this->lft);
		$criteria->compare('rgt',$this->rgt);
		$criteria->compare('level',$this->level);
		$criteria->compare('title',$this->title,true);
		$criteria->compare('desc',$this->desc,true);
		$criteria->compare('url',$this->url,true);
		
		$result	=	new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
		
		return $result;
	}
	
}