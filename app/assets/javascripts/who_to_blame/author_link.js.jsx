/** @jsx React.DOM */

var AuthorLink;

(function () {
  'use strict';

  AuthorLink = React.createClass(new AuthorLinkConfig());

  function AuthorLinkConfig() {
    /* jshint validthis: true */

    return {
      getDefaultProps: getDefaultProps,
      render: render
    };

    function getDefaultProps() {
      return { id: '', fullName: '' };
    }

    function render() {
      var link;
      link = '#authors/' + this.props.id;

      return (
        /* jshint ignore: start */
        <a href={link}>{this.props.fullName}</a>
        /* jshint ignore: end */
      );
    }
  }
})();
