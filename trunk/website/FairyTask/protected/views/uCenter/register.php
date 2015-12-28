<?php
/* @var $this UserController */
/* @var $model User */
/* @var $form CActiveForm */
//加入日期选择
//Yii::import('application.extensions.CJuiDateTimePicker.CJuiDateTimePicker');
// $this->widget('CJuiDateTimePicker',array(
// 		'model'=>$model, //Model object
// 		'attribute'=>'createdata', //attribute name
// 		'mode'=>'datetime', //use "time","date" or "datetime" (default)
// 		'options'=>array() // jquery plugin options
// ));

?>
<h1>加入我们</h1>
<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'user-register-form',
	'enableAjaxValidation'=>true,
)); ?>

	<p class="note">标 <span class="required">*</span> 的为必填内容.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'loginname'); ?>
		<?php echo $form->textField($model,'loginname'); ?>
		<?php echo $form->error($model,'loginname'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'password'); ?>
		<?php echo $form->passwordField($model,'password'); ?>
		<?php echo $form->error($model,'password'); ?>
	</div>
	
	<div class="row">
		<?php echo $form->labelEx($model,'password2'); ?>
		<?php echo $form->passwordField($model,'password2'); ?>
		<?php echo $form->error($model,'password2'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'email'); ?>
		<?php echo $form->textField($model,'email'); ?>
		<?php echo $form->error($model,'email'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'dispname'); ?>
		<?php echo $form->textField($model,'dispname'); ?>
		<?php echo $form->error($model,'dispname'); ?>
	</div>
	
	<?php if(extension_loaded('gd')): ?>
	<div class="row">
	        <?php echo CHtml::activeLabel($model,'verifyCode', array('style'=>'width:150px;')); ?>
	        <div>
	        <?php $this->widget('CCaptcha'); ?>
	        <?php echo CHtml::activeTextField($model,'verifyCode'); ?>
	        </div>
	        <p class="hint">Please enter the letters as they are shown in the image above.
	        <br/>Letters are not case-sensitive.</p>
	</div>
	<?php endif; ?>


	<div class="row buttons">
		<?php echo CHtml::submitButton('Submit'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->