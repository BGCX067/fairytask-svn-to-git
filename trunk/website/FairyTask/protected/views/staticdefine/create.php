<?php
/* @var $this StaticdefineController */
/* @var $model Staticdefine */

$this->breadcrumbs=array(
	'Staticdefines'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List Staticdefine', 'url'=>array('index')),
	array('label'=>'Manage Staticdefine', 'url'=>array('admin')),
);
?>

<h1>Create Staticdefine</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>