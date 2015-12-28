<?php
/* @var $this UserController */
/* @var $model User */

$this->breadcrumbs=array(
	'会员'=>array('index'),
	'添加会员',
);

$this->menu=array(
	array('label'=>'会员列表', 'url'=>array('index')),
	array('label'=>'管理会员', 'url'=>array('admin')),
);
?>

<h1>Create User</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>