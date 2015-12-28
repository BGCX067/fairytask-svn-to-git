<?php
/* @var $this StaticdefineController */
/* @var $model Staticdefine */

$this->breadcrumbs=array(
	'Staticdefines'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List Staticdefine', 'url'=>array('index')),
	array('label'=>'Create Staticdefine', 'url'=>array('create')),
	array('label'=>'Update Staticdefine', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete Staticdefine', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Staticdefine', 'url'=>array('admin')),
);
?>

<h1>View Staticdefine #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'label',
		'desc',
		'count',
	),
)); ?>
