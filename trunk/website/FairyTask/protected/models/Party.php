<?php

/**
 * This is the model class for table "ft_party".
 *
 * The followings are the available columns in table 'ft_party':
 * @property integer $id
 * @property string $label
 * @property string $desc
 * @property integer $level
 * @property string $icon
 * @property integer $createdate
 * @property integer $updatedate
 */
class Party extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Party the static model class
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
		return 'ft_party';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('level, createdate, updatedate', 'numerical', 'integerOnly'=>true),
			array('label', 'length', 'max'=>50),
			array('desc', 'length', 'max'=>255),
			array('icon', 'length', 'max'=>55),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, label, desc, level, icon, createdate, updatedate', 'safe', 'on'=>'search'),
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
			'label' => 'Label',
			'desc' => 'Desc',
			'level' => 'Level',
			'icon' => 'Icon',
			'createdate' => 'Createdate',
			'updatedate' => 'Updatedate',
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
		$criteria->compare('label',$this->label,true);
		$criteria->compare('desc',$this->desc,true);
		$criteria->compare('level',$this->level);
		$criteria->compare('icon',$this->icon,true);
		$criteria->compare('createdate',$this->createdate);
		$criteria->compare('updatedate',$this->updatedate);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}