/** @jsx React.DOM */

var BaseView;

(function () {
  'use strict';

  BaseView = React.createClass(new BaseViewConfig());

  function BaseViewConfig() {
    /* jshint validthis: true */

    return {
      getInitialState: getInitialState,
      componentDidMount: componentDidMount,
      showAuthor: showAuthor,
      showSnapshot: showSnapshot,
      render: render
    };

    function getInitialState() {
      var authors = _.map(gon.authors, function (author) {
        return {
          /* jshint camelcase: false */
          fullName: author.full_name,
          id: author.id
          /* jshint camelcase: true */
        };
      });
      gon.authors = 'authors have already been initialized!';
      return { authors: authors, activeView: null };
    }

    function componentDidMount() {
      routie({
        'authors/:id': this.showAuthor,
        '': this.showSnapshot,
        '*': function () { routie(''); }
      });
    }

    function showAuthor(id) {
      var author = _.findWhere(this.state.authors, { id: id });
      if (!author) { return; }
      window.alert(author.fullName);
    }

    function showSnapshot() {
      this.setState({
        activeView: (
          /* jshint ignore: start */
          <SnapshotView />
          /* jshint ignore: end */
        )
      });
    }

    function render() {
      /* jshint ignore: start */
      var authorsHtml = _.map(this.state.authors, function (author) {
        return (
          <AuthorLink fullName={author.fullName} id={author.id} />
        );
      });

      return (
        <div>
          <div>{authorsHtml}</div>
          {this.state.activeView}
        </div>
      );
      /* jshint ignore: end */
    }
  }
})();
