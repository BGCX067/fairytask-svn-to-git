<h1>Widget Generator</h1>

<?php $form=$this->beginWidget('CCodeForm', array('model'=>$model)); ?>
 
    <div class="row">
        <?php echo $form->labelEx($model,'className'); ?>
        <?php echo $form->textField($model,'className',array('size'=>65)); ?>
        <div class="tooltip">
            Widget class name must only contain word characters.
        </div>
        <?php echo $form->error($model,'className'); ?>
    </div>
 
<?php $this->endWidget(); ?>