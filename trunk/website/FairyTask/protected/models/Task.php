<?php

/**
 * This is the model class for table "ft_task".
 *
 * The followings are the available columns in table 'ft_task':
 * @property integer $id
 * @property string $lable
 * @property integer $posterid
 * @property string $summery
 * @property integer $categoryid
 * @property integer $typeid
 * @property integer $statusid
 * @property string $content
 * @property string $poster
 * @property integer $hunterid
 * @property integer $partyid
 * @property integer $finishdate
 * @property integer $toptype
 * @property integer $toptime
 * @property integer $create_time
 * @property integer $update_time
 */
class Task extends CActiveRecord
{
	public $trib_id;
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Task the static model class
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
		return 'ft_task';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			//array('categoryid', 'required'),
			array('posterid, categoryid, typeid, statusid, hunterid, partyid, finishdate, toptype, toptime, create_time, update_time', 'numerical', 'integerOnly'=>true),
			array('lable', 'length', 'max'=>100),
			array('summery', 'length', 'max'=>255),
			array('content', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, lable, posterid, summery, categoryid, typeid, statusid, content, hunterid, partyid, finishdate, toptype, toptime, create_time, update_time', 'safe', 'on'=>'search'),
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
			'poster'=>array(self::BELONGS_TO, 'User', 'posterid'),
		);
	}
	
	/**
	 * 保存前 先加密
	 * @see CActiveRecord::beforeSave()
	 */
	public function beforeSave()
	{
		$this->posterid = Yii::app()->user->id;
		return true;
	}

	/**
	 * 自动加时间
	 * @see CModel::behaviors()
	 */
	public function behaviors(){
		return array(
				'CTimestampBehavior' => array(
						'class' => 'zii.behaviors.CTimestampBehavior',
						'createAttribute' => 'create_time',
						'updateAttribute' => 'update_time',
				)
		);
	}
	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'lable' => '任务名称',
			'posterid' => '悬赏人',
			'summery' => '任务简述',
			'categoryid' => '类别ID',
			'typeid' => 'Typeid',
			'statusid' => '状态ID',
			'content' => '任务内容',
			'hunterid' => '接取人',
			'partyid' => '接取公会',
			'finishdate' => '完成日期',
			'toptype' => '置顶类型',
			'toptime' => '置顶时间',
			'create_time' => 'Create Time',
			'update_time' => 'Update Time',
		);
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
		$criteria->compare('lable',$this->lable,true);
		$criteria->compare('posterid',Yii::app()->user->id);
		$criteria->compare('summery',$this->summery,true);
		$criteria->compare('categoryid',$this->categoryid);
		$criteria->compare('typeid',$this->typeid);
		$criteria->compare('statusid',$this->statusid);
		$criteria->compare('content',$this->content,true);
		$criteria->compare('hunterid',$this->hunterid);
		$criteria->compare('partyid',$this->partyid);
		$criteria->compare('finishdate',$this->finishdate);
		$criteria->compare('toptype',$this->toptype);
		$criteria->compare('toptime',$this->toptime);
		$criteria->compare('create_time',$this->create_time);
		$criteria->compare('update_time',$this->update_time);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}