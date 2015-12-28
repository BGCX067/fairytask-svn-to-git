<?php
/* @var $this StaticdefineController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Staticdefines',
);

$this->menu=array(
	array('label'=>'Create Staticdefine', 'url'=>array('create')),
	array('label'=>'Manage Staticdefine', 'url'=>array('admin')),
);
?>

<h1>Staticdefines</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
