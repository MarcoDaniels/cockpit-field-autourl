<?php

$app->on('admin.init', function () {
    $this->helper('admin')->addAssets('cockpit-field-autourl:assets/field-autourl.tag');
});
