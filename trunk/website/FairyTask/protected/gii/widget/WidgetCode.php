<?php
class WidgetCode extends CCodeModel
{
    public $className;
 
    public function rules()
    {
        return array_merge(parent::rules(), array(
            array('className', 'required'),
            array('className', 'match', 'pattern'=>'/^\w+$/'),
        ));
    }
 
    public function attributeLabels()
    {
        return array_merge(parent::attributeLabels(), array(
            'className'=>'Widget Class Name',
        ));
    }
 
    public function prepare()
    {
        $path=Yii::getPathOfAlias('application.components.' . $this->className) . '.php';
        $code=$this->render($this->templatepath.'/widget.php');
 
        $this->files[]=new CCodeFile($path, $code);
    }
}
?>