<?php
/**
 * Associative array of JavaScript file links related to the Waypoints library.
 * The files are organized by version type and functionality.
 *
 * - Basic Waypoints for jQuery, Zepto, and without any framework.
 * - Debugging files to help identify issues.
 * - Shortcuts for additional functionalities like infinite scrolling, detecting elements in view, and sticky elements.
 *
 * @package Waypoints
 */

  $links = array(

    /**
     * Waypoints versions for jQuery.
     * 
     * - 'jquery_waypoints1': Full version of Waypoints for jQuery.
     * - 'jquery_waypoints2': Minified version of Waypoints for jQuery.
     */
    'jquery_waypoints1' => 'lib/waypoints/waypoints.js',
    'jquery_waypoints2' => 'lib/waypoints/waypoints.min.js',

    /**
     * Waypoints versions without framework dependencies (no jQuery or Zepto).
     * 
     * - 'noframework_waypoints1': Full version of Waypoints without a framework.
     * - 'noframeworks_waypoints2': Minified version of Waypoints without a framework.
     */
    'noframework_waypoints1' => 'lib/waypoints/noframework.waypoints.js',
    'noframeworks_waypoints2' => 'lib/waypoints/noframeworks.waypoints.min.js',

    /**
     * Waypoints version with debugging tools enabled.
     * 
     * - 'waypoints_debug': Includes debugging messages in the console to help with troubleshooting.
     */
    'waypoints_debug' => 'lib/waypoints/waypoints.debug.js',

    /**
     * Standard minified version of Waypoints.
     * 
     * - 'waypoints': Minified and optimized version of the library.
     */
    'waypoints' => 'lib/waypoints/waypoints.min.js',

    /**
     * Waypoints versions for Zepto.js.
     * 
     * - 'zepto_waypoints1': Full version of Waypoints for Zepto.js.
     * - 'zepto_waypoints2': Minified version of Waypoints for Zepto.js.
     */
    'zepto_waypoints1' => 'lib/waypoints/zepto.waypoints.js',
    'zepto_waypoints2' => 'lib/waypoints/zepto.waypoints.min.js'

    /**
     * Waypoints shortcuts that make common tasks easier to implement.
     * 
     * - 'shortcut_infinite1' and 'shortcut_infinite2': Facilitate the implementation of infinite scrolling.
     * - 'shortcut_inview1' and 'shortcut_inview2': Allow detection of when an element is in view of the user.
     * - 'shortcut_sticky1' and 'shortcut_sticky2': Allow making an element sticky at the top of the page.
     */
    'shortcut_infinite1' => 'lib/waypoints/shortcuts/infinite.js',
    'shortcut_infinite2' => 'lib/waypoints/shortcut/infinite.min.js',
    'shortcut_inview1' => 'lib/waypoints/shortcuts/inview.js',
    'shortcut_inview2' => 'lib/waypoints/shortcuts/inview.min.js',
    'shortcut_sticky1' => 'lib/waypoints/shortcuts/sticky.js',
    'shortcut_sticky2' => 'lib/waypoints/shortcuts/sticky.min.js'
  );
?>
