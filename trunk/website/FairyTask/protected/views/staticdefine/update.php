<?php
/* @var $this StaticdefineController */
/* @var $model Staticdefine */

$this->breadcrumbs=array(
	'Staticdefines'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List Staticdefine', 'url'=>array('index')),
	array('label'=>'Create Staticdefine', 'url'=>array('create')),
	array('label'=>'View Staticdefine', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage Staticdefine', 'url'=>array('admin')),
);
?>

<h1>Update Staticdefine <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>