<?php
/* @var $this TaskController */
/* @var $model Task */
?>
<div class="view">
<?php //print_r($data);exit;?>
	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('lable')); ?>:</b>
	<?php echo CHtml::encode($data->lable); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('posterid')); ?>:</b>
	<?php echo CHtml::encode($data->poster->dispname); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('summery')); ?>:</b>
	<?php echo CHtml::encode($data->summery); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('categoryid')); ?>:</b>
	<?php echo CHtml::encode($data->categoryid); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('typeid')); ?>:</b>
	<?php echo CHtml::encode($data->typeid); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('statusid')); ?>:</b>
	<?php echo CHtml::encode($data->statusid); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('content')); ?>:</b>
	<?php echo CHtml::encode($data->content); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('hunterid')); ?>:</b>
	<?php echo CHtml::encode($data->hunterid); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('partyid')); ?>:</b>
	<?php echo CHtml::encode($data->partyid); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('createdate')); ?>:</b>
	<?php echo CHtml::encode($data->createdate); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('updatedate')); ?>:</b>
	<?php echo CHtml::encode($data->updatedate); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('finishdate')); ?>:</b>
	<?php echo CHtml::encode($data->finishdate); ?>
	<br />

	*/ ?>

</div>