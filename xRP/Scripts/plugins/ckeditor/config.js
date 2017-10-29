/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function (config) {
    // Define changes to default configuration here. For example:
    config.toolbar = 'Lite';
    config.toolbar_Lite = [
    ['Source', '-', 'Templates'],
    ['Paste', 'PasteText', 'PasteFromWord'],
    ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat'],
    ['Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak', 'Iframe'],
    ['Link', 'Unlink', 'Anchor'],
    ['Maximize'],
    ['Styles', 'Format', 'Font', 'FontSize'],
    ['TextColor', 'BGColor'],
    ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '- ', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl']];
    config.fontSize_sizes = '8/8px/;9/9px;10/10px;11/11px;12/12px;13/13px;14/14px;16/16px;24/24px;48/48px;';
    config.font_names = 'Arial;Times New Roman;Verdana; .VnTime';
    config.autoParagraph = false;
    config.allowedContent = true;
    config.extraAllowedContent = true;
    config.entities = false;
    config.formatSource = false;
    //config.protectedSource.push(/\s\S*/gi);
    config.removePlugins = 'htmldataprocessor';
    //config.language = 'vi';
    // config.uiColor = '#D1DFF0';

};
