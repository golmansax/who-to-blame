/** @jsx React.DOM */

//= require chartjs
//= require underscore
//= require react/react-with-addons
//= require reqwest
//= require routie

//= require_tree .

(function () {
  'use strict';

  var container = window.document.getElementById('example');
  if (container) {
    React.renderComponent(
      (
        /* jshint ignore: start */
        <BaseView />
        /* jshint ignore: end */
      ),
      container
    );
  }
})();
