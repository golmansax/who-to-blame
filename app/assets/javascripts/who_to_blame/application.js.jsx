/** @jsx React.DOM */

//= require react/react-with-addons
//= require reqwest
//= require chartjs
//= require underscore

//= require who_to_blame/stat_manager
//= require who_to_blame/load_button

(function () {
  'use strict';

  var container = window.document.getElementById('example');
  if (container) {
    React.renderComponent(
      (
        /* jshint ignore: start */
        <StatManager />
        /* jshint ignore: end */
      ),
      container
    );
  }
})();
