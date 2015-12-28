<?php

class UCenterController extends Controller
{
	
	/**
	 * Declares class-based actions.
	 */
	public function actions()
	{
		return array(
				// captcha action renders the CAPTCHA image displayed on the contact page
				'captcha'=>array(
						'class'=>'CCaptchaAction',
						'backColor'=>0xFFFFFF,
						'minLength'=>4,
						'maxLength'=>6,
				),
		);
	}
	
	public function actionForgetpass()
	{
		$this->render('forgetpass');
	}

	public function actionIndex()
	{
		$this->render('index');
	}

	public function actionLogin()
	{
		$this->render('login');
	}

	public function actionRegister()
	{
		$model=new User('register');
	
		// uncomment the following code to enable ajax-based validation
		 if(isset($_POST['ajax']) && $_POST['ajax']==='user-register-form')
		 {
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	
		if(isset($_POST['User']))
		{
			//print_r($_POST);exit;
			$model->attributes=$_POST['User'];
			if($model->validate())
			{
				// form inputs are valid, do something here
				$model->save();
				$this->redirect(array('/site/login','id'=>$model->id));
				return;
			}
		}
		$this->render('register',array('model'=>$model));
	}

	// Uncomment the following methods and override them if needed
	/*
	public function filters()
	{
		// return the filter configuration for this controller, e.g.:
		return array(
			'inlineFilterName',
			array(
				'class'=>'path.to.FilterClass',
				'propertyName'=>'propertyValue',
			),
		);
	}

	public function actions()
	{
		// return external action classes, e.g.:
		return array(
			'action1'=>'path.to.ActionClass',
			'action2'=>array(
				'class'=>'path.to.AnotherActionClass',
				'propertyName'=>'propertyValue',
			),
		);
	}
	*/
}