<?php
/* @var $this PartyController */
/* @var $model Party */

$this->breadcrumbs=array(
	'Parties'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List Party', 'url'=>array('index')),
	array('label'=>'Create Party', 'url'=>array('create')),
	array('label'=>'View Party', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage Party', 'url'=>array('admin')),
);
?>

<h1>Update Party <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>