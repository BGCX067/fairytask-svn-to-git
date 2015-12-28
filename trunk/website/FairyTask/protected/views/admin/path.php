<?php
/* @var $this AdminController */

$this->breadcrumbs=array(
	'Admin'=>array('/admin'),
	'Path',
);
?>
<h1><?php echo $this->id . '/' . $this->action->id; ?></h1>

<p>
	You may change the content of this page by modifying
	the file <tt><?php 
	echo $this->createUrl("user/admin",array("id"=>1,"name"=>"navyhan"));
	?></tt>.
</p>
