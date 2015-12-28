<?php
/* @var $this UserController */
/* @var $model User */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'user-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'loginname'); ?>
		<?php echo $form->textField($model,'loginname',array('size'=>32,'maxlength'=>32)); ?>
		<?php echo $form->error($model,'loginname'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'password'); ?>
		<?php echo $form->passwordField($model,'password',array('size'=>50,'maxlength'=>50)); ?>
		<?php echo $form->error($model,'password'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'email'); ?>
		<?php echo $form->textField($model,'email',array('size'=>50,'maxlength'=>50)); ?>
		<?php echo $form->error($model,'email'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'dispname'); ?>
		<?php echo $form->textField($model,'dispname',array('size'=>60,'maxlength'=>80)); ?>
		<?php echo $form->error($model,'dispname'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'createdata'); ?>
		<?php echo $form->textField($model,'createdata'); ?>
		<?php echo $form->error($model,'createdata'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'updatedate'); ?>
		<?php echo $form->textField($model,'updatedate'); ?>
		<?php echo $form->error($model,'updatedate'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'titleid'); ?>
		<?php echo $form->textField($model,'titleid'); ?>
		<?php echo $form->error($model,'titleid'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'viplevel'); ?>
		<?php echo $form->textField($model,'viplevel'); ?>
		<?php echo $form->error($model,'viplevel'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'experience'); ?>
		<?php echo $form->textField($model,'experience'); ?>
		<?php echo $form->error($model,'experience'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'level'); ?>
		<?php echo $form->textField($model,'level'); ?>
		<?php echo $form->error($model,'level'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->