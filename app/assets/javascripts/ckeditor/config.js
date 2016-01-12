CKEDITOR.editorConfig = function( config ) {
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    config.uiColor = '#ffffff';
    config.font_names = 'Helvetica;' + 'Arial;' + 'Courier New;' + 'Times New Roman;' + 'Tahoma;' + 'Verdana';

    config.toolbar_Post = [
      { name: 'top', items : [ 'Source','DocProps','Preview','Maximize','PasteFromWord','-','Undo','Redo','Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','Link','Unlink','Table','SpecialChar','PageBreak' ] },
      { name: 'bottom', items : [ 'Styles','Format','Font','FontSize','TextColor','BGColor' ] }
    ];
};
