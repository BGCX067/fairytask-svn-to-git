<?php
/* @var $this PartyController */
/* @var $model Party */

$this->breadcrumbs=array(
	'Parties'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'公告列表', 'url'=>array('index')),
	array('label'=>'管理公会', 'url'=>array('admin')),
);
?>

<h1>创建公会</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>