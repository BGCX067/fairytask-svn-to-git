<?php

/**
 * This is the model class for table "ft_user".
 *
 * The followings are the available columns in table 'ft_user':
 * @property integer $id
 * @property string $loginname
 * @property string $password
 * @property string $email
 * @property string $dispname
 * @property integer $titleid
 * @property integer $viplevel
 * @property integer $experience
 * @property integer $level
 * @property integer $partyid
 * @property integer $create_time
 * @property integer $update_time
 */
class User extends CActiveRecord
{
	public $password2;
	public $verifyCode;
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return User the static model class
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
		return 'ft_user';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('loginname,password,email,dispname,verifyCode', 'required'),
			array('titleid, viplevel, experience, level, partyid, create_time, update_time', 'numerical', 'integerOnly'=>true),
			array('loginname', 'length', 'max'=>32),
			array('password, email', 'length', 'max'=>50, 'min'=>6),
			array('password2','length','max'=>64, 'min'=>6),
			//邮件有效
			array('email','email'),
			//用户名和邮件要唯一
			array('loginname, email', 'unique'),
			// compare password to repeated password
			array('password', 'compare', 'compareAttribute'=>'password2'),
			// verifyCode needs to be entered correctly
			array('verifyCode', 'captcha', 'allowEmpty'=>!extension_loaded('gd')),
			array('dispname', 'length', 'max'=>80),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, loginname,  email, dispname, titleid, viplevel, experience, level, partyid, create_time, update_time', 'safe', 'on'=>'search'),
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
			'loginname' => '用户名',
			'password' => '密码',
			'password2' => '确认密码',
			'email' => 'Email',
			'dispname' => '昵称',
			'titleid' => '称号',
			'viplevel' => 'Vip等级',
			'experience' => '经验',
			'level' => '等级',
			'partyid' => '公会ID',
			'verifyCode' => '验证码',
			'create_time' => '创建时间',
			'update_time' => '更新时间',
		);
	}
	
	/**
	 * 保存前 先加密
	 * @see CActiveRecord::beforeSave()
	 */
	public function beforeSave()
	{
		$pass = md5($this->password);
		$this->password = $pass;
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
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('loginname',$this->loginname,true);
		//$criteria->compare('password',$this->password,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('dispname',$this->dispname,true);
		$criteria->compare('titleid',$this->titleid);
		$criteria->compare('viplevel',$this->viplevel);
		$criteria->compare('experience',$this->experience);
		$criteria->compare('level',$this->level);
		$criteria->compare('partyid',$this->partyid);
		$criteria->compare('create_time',$this->create_time);
		$criteria->compare('update_time',$this->update_time);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}