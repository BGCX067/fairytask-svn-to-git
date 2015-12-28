<?php
/* @var $this TaskController */
/* @var $model Task */
/* @var $form CActiveForm */
?>
<?php $this->widget('ext.kindeditor.KindEditorWidget',array(
	'id'=>'Task_content',	//Textarea id
	// Additional Parameters (Check http://www.kindsoft.net/docs/option.html)
	'items' => array(
		'width'=>'700px',
		'height'=>'300px',
		'themeType'=>'simple',
		'allowImageUpload'=>false,
		'allowFlashUpload'=>false,
		'allowMediaUpload'=>false,
		'allowFileUpload'=>false,
		'items'=>array(
			'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
			'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
			'insertunorderedlist', '|', 'emoticons', 'image', 'link',),
	),
)); ?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'task-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'lable'); ?>
		<?php echo $form->textField($model,'lable',array('size'=>40,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'lable'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'summery'); ?>
		<?php echo $form->textArea($model,'summery',array('size'=>100,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'summery'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'categoryid'); ?>
		<?php 
		$initArr	=	Category::model()->getListByPid(2);
		$initArr[0]	=	"请选择";
		ksort($initArr);
		//print_r($initArr);exit;
		echo CHtml::dropDownList('cid','', $initArr,
			array(
			'ajax' => array(
				'type'=>'POST', //request type
				'url'=>CController::createUrl("task/listCate"), //url to call
				'update'=>'#subcate_id', //selector to update
				//'data'=>'js:javascript statement'
				'cache'=>false,
			)));
		
		//empty since it will be filled by the other dropdown
		echo CHtml::dropDownList('subcate_id','', array(),
				array(
		'ajax' => array(
				'type'=>'POST', //request type
				'url'=>CController::createUrl("task/listSubCate"), //url to call
				'update'=>'#categoryid', //selector to update
				//'data'=>'js:javascript statement'
				'cache'=>false,
		)));
		echo CHtml::dropDownList('categoryid','1', array());
		?>
		<?php echo $form->error($model,'categoryid'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'content'); ?>
		<?php echo $form->textArea($model,'content',array('rows'=>6, 'cols'=>50)); ?>
		<?php echo $form->error($model,'content'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->