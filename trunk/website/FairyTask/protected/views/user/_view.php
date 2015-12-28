<?php
/* @var $this UserController */
/* @var $model User */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('loginname')); ?>:</b>
	<?php echo CHtml::encode($data->loginname); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('password')); ?>:</b>
	<?php echo CHtml::encode($data->password); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('email')); ?>:</b>
	<?php echo CHtml::encode($data->email); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('dispname')); ?>:</b>
	<?php echo CHtml::encode($data->dispname); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('createdata')); ?>:</b>
	<?php echo CHtml::encode($data->createdata); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('updatedate')); ?>:</b>
	<?php echo CHtml::encode($data->updatedate); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('titleid')); ?>:</b>
	<?php echo CHtml::encode($data->titleid); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('viplevel')); ?>:</b>
	<?php echo CHtml::encode($data->viplevel); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('experience')); ?>:</b>
	<?php echo CHtml::encode($data->experience); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('level')); ?>:</b>
	<?php echo CHtml::encode($data->level); ?>
	<br />

	*/ ?>

</div>