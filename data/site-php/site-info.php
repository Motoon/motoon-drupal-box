<?php
/**
 * Identify the sitename and stage for the current page request or
 * script, if possible.
 *
 * @return
 *   An array containing sitename and stage, or NULL if
 *   the site directory cannot be found.
 */
function _site_info() {
  // Start by finding a "site directory" which will identify the site.
  if (isset($_SERVER['DOCUMENT_ROOT']) && !empty($_SERVER['DOCUMENT_ROOT'])) {
    $site_dir = $_SERVER['DOCUMENT_ROOT'];
  }
  // If this is not a page request, no  DOCUMENT_ROOT are available. Drush?
  else if (function_exists('drush_get_option')) {
    $site_dir = drush_get_option(array("r", "root"), $_SERVER['PWD']);
  }
  // Otherwise, perhaps we're a script within docroot but running on the
  // command line (e.g. scripts/run-test.sh).
  else {
    $site_dir = dirname(realpath($_SERVER['SCRIPT_FILENAME']));
  }

  // Make sure we are pointing to the canonical location.
  $site_dir = realpath($site_dir) . '/';

  // Verify the site directory is in an expected location, extract the
  // sitename from it.
  if (isset($site_dir) &&
    preg_match('@^/var/www/([a-z0-9_\-]+)/(a-z0-9_\-)/@i', $site_dir, $m)) {
    $site_name = $m[1];
    $site_stage = $m[2];
    return array($site_name, $site_stage);
  }

  return NULL;
}
