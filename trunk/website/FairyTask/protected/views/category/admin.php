<?php
/* @var $this CategoryController */
/* @var $model Category */
$this->breadcrumbs=array(
		'菜单管理'=>array('admin'),
);

$this->menu=array(
		array('label'=>'新建菜单', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('category-grid', {
data: $(this).serialize()
});
return false;
});
");

?>
<?php echo CHtml::link('高级搜索','#',array('class'=>'search-button')); ?>
<br>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->
<br>
<h1>分类管理</h1>

<div id="category-grid" class="grid-view">
<div class="summary">第 1-10 条, 共 12 条.</div>
<table class="items">
<thead>
<tr>
<th id="category-grid_c0"><a class="sort-link" href="/index.php/category/admin?Category_sort=id">ID</a></th><th id="category-grid_c1"><a class="sort-link" href="/index.php/category/admin?Category_sort=title">标题</a></th><th class="button-column" id="category-grid_c2">操作</th></tr>
</thead>
<tbody>
<?php
$treeList	=	$model->getTreeList();
listTree($treeList);

/**
 * 树列表
 */
function listTree($treeList)
{
	$i	=	0;
	foreach ($treeList as $node)
	{
		echo "<tr class=\"odd\"><td width=\"60\" style=\"text-align:center\">{$node["id"]}</td><td style=\"text-align:center\">{$node["text"]}</td><td width=\"100\" style=\"text-align:center\"><a title=\"上移\" href=\"/index.php/category/moveup/{$node["id"]}\"><img src=\"/css/up.gif\" alt=\"上移\" /></a> <a title=\"下移\" href=\"/index.php/category/movedown/{$node["id"]}\"><img src=\"/css/down.gif\" alt=\"下移\" /></a> <a class=\"update\" title=\"更新\" href=\"/index.php/category/update/{$node["id"]}\"><img src=\"/assets/e78f7722/gridview/update.png\" alt=\"更新\" /></a> <a class=\"delete\" title=\"删除\" href=\"/index.php/category/delete/{$node["id"]}\"><img src=\"/assets/e78f7722/gridview/delete.png\" alt=\"删除\" /></a></td></tr>";
		if(is_array($node['children']))
		{
			listTree($node['children']);
		}
		$i++;
	}
}

//  $this->widget('zii.widgets.grid.CGridView', array(
// 	'id'=>'category-grid',
// 	'dataProvider'=>$model->search(),
// 	'columns'=>array(
// 		array(
// 			'name'=>'id',
// 			'htmlOptions'=>array(
//                 'width'=>'60',
// 				'style'=>'text-align:center',
//              ),
//         ),
// 		array(
// 			'name'=>'title',
// 			'htmlOptions'=>array(
// 				'style'=>'text-align:center',
//              ),
//         ),
// 		array(
// 			'header' => '操作',
// 			'class'=>'CButtonColumn',
// 			'htmlOptions'=>array(
// 				'width'=>'100',
// 				'style'=>'text-align:center',
// 			),
// 			'buttons' => array(
// 				'moveup'=>array(
// 		    		'label'=>'上移',
// 		    		'url'=>'array("moveup","id"=>$data->id)',
// 		   			'imageUrl'=>Yii::app()->request->baseUrl.'/css/up.gif',
// 				),
// 				'movedown'=>array(
// 		    		'label'=>'下移',
// 		    		'url'=>'array("movedown","id"=>$data->id)',
// 		   			'imageUrl'=>Yii::app()->request->baseUrl.'/css/down.gif',
// 				),
//  			),
// 			'template'=>'{moveup} {movedown} {update} {delete}',
// 		),
// 	),
// )); ?>
</tbody>
</table>
</div>
