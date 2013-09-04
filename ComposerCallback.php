<?php

namespace basecom\symbox;

class ComposerCallback
{
    protected static function copy($src, $dest)
    {
        if(\is_file($src)) {
            if(\file_exists($dest)) {
                \rename($dest, $dest.'.bak');
            }
            return \copy($src, $dest);
        }

        foreach(\scandir($src) as $file)
        {
            $tmpSrc = $src.'/'.$file;
            $tmpDest = $dest.'/'.$file;

            if(!\is_readable($tmpSrc) || \in_array($file, array('.', '..'))) {
                continue;
            }

            if(\is_dir($tmpSrc)) {
                if(!\is_dir($tmpDest)) {
                    \mkdir($tmpDest, 755, true);
                }
                return self::copy($tmpSrc, $tmpDest);
            }
            else {
                if(\file_exists($tmpDest)) {
                    \rename($tmpDest, $tmpDest.'.bak');
                }
                return \copy($tmpSrc, $tmpDest);
            }
        }

        return false;
    }

    public static function install()
    {
        echo "\nsymbox install triggerd\n";

        $sourceDir = \realpath(__DIR__);
        $targetDir = \realpath(\sprintf("%s/../../../", $sourceDir));

        self::copy($sourceDir.'/symbox', $targetDir.'/symbox');
        self::copy($sourceDir.'/Vagrantfile', $targetDir.'/Vagrantfile');
    }

    public static function remove()
    {
        echo "\nsymbox remove triggerd\n";

        // define target path
        $targetDir = \realpath(\sprintf("%s/../../../", __DIR__));

        // remove source folder
        if(\file_exists($targetDir . '/symbox')) {
            \rmdir($targetDir . '/symbox');
        }
    }
}
