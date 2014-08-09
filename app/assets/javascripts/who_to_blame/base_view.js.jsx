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
      showLatestSnapshot: showLatestSnapshot,
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

      var dates = _.map(gon.dates, function (date) {
        return new Date(date.year, date.month - 1, date.day);
      });
      gon.dates = 'dates have already been initialized!';
      return { authors: authors, dates: dates, activeView: null };
    }

    function componentDidMount() {
      routie({
        'authors/:id': this.showAuthor,
        '': this.showLatestSnapshot,
        '*': function () { routie(''); }
      });
    }

    function showAuthor(id) {
      var author = _.findWhere(this.state.authors, { id: id });
      if (!author) { return; }
      window.alert(author.fullName);
    }

    function showLatestSnapshot() {
      this.showSnapshot(_.last(this.state.dates));
    }

    function showSnapshot(date) {
      var myDate;
      myDate = date;
      this.setState({
        activeView: (
          /* jshint ignore: start */
          <SnapshotView date={myDate} />
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

      var datesHtml = _.map(this.state.dates, function (date) {
        return (
          <option value={date.toISOString()}>{date.toString()}</option>
        );
      });

      return (
        <div>
          <div>{authorsHtml}</div>
          <select>{datesHtml}</select>
          {this.state.activeView}
        </div>
      );
      /* jshint ignore: end */
    }
  }
})();
