<?php

namespace basecom\symbox;

use Composer\Script\Event;

class ComposerCallback
{
    public static function postPackageInstall(Event $event)
    {
        $sourceDir = \realpath(__DIR__);
        $targetDir = \realpath(\sprintf("%s/../../../", $sourceDir));

        // TODO: fill me
    }

    public static function postPackageUpdate(Event $event)
    {
        $sourceDir = \realpath(__DIR__);
        $targetDir = \realpath(\sprintf("%s/../../../", $sourceDir));

        // TODO: fill me
    }

    public static function prePackageUninstall(Event $event)
    {
        $sourceDir = \realpath(__DIR__);
        $targetDir = \realpath(\sprintf("%s/../../../", $sourceDir));

        // TODO: fill me
    }
}
