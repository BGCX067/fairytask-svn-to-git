<?php
/* @var $this TaskController */
/* @var $model Task */

$this->breadcrumbs=array(
	'任务'=>array('index'),
	'发布',
);

$this->menu=array(
	array('label'=>'任务列表', 'url'=>array('index')),
	array('label'=>'管理任务', 'url'=>array('admin')),
);
?>

<h1>发布悬赏</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>