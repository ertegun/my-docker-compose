<h3> Grup Arge Applications | GAPPS</h3>
<?php

function listAllFiles($dir)
{
  $array = array_diff(scandir($dir), array('.', '..'));

  foreach ($array as &$item) {
    $item =  $item;
  }
  unset($item);
  foreach ($array as $item) {
    if (is_dir($item)) {
      $array = array_merge($array, listAllFiles($item . DIRECTORY_SEPARATOR));
    }
  }
  return $array;
}

$data = listAllFiles('software');
?>
<ul>
  <?php
  foreach ($data as $key => $value) :
  ?>
    <li><a href="/software/<?= $value ?>/publish.htm"><?= $value ?></a></li>
  <?php
  endforeach;
  ?>
</ul>