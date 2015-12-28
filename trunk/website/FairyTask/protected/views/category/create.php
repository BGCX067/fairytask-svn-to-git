<?php
/* @var $this CategoryController */
/* @var $model Category */

$this->breadcrumbs=array(
	'菜单管理'=>array('admin'),
	'新建菜单',
);

$this->menu=array(
	array('label'=>'返回列表', 'url'=>array('admin')),
);
?>

<h1>Create Category</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>