/** @jsx React.DOM */

var SnapshotView;

(function () {
  'use strict';

  SnapshotView = React.createClass(new SnapshotViewConfig());

  function SnapshotViewConfig() {
    /* jshint validthis: true */

    return {
      getInitialState: getInitialState,
      getInitialProps: getInitialProps,
      componentDidMount: componentDidMount,
      handleSnapshotLoad: handleSnapshotLoad,
      render: render
    };

    function getInitialState() {
      return { date: null, footprints: [] };
    }

    function getInitialProps() {
      return { date: null };
    }

    function componentDidMount() {
      if (!this.props.date) { return; }

      var year = this.props.date.getFullYear();
      var month = this.props.date.getMonth() + 1;
      var day = this.props.date.getDate();

      reqwest({
        url: 'who-to-blame/snapshots/' + year + '/' + day + '/' + month,
        method: 'get',
        success: this.handleSnapshotLoad
      });
    }

    function handleSnapshotLoad(snapshot) {
      var footprints = _.sortBy(snapshot.footprints, 'num_lines');
      this.setState({ date: this.props.date, footprints: footprints });
    }

    function render() {
      return (
        /* jshint ignore: start */
        <div>
          <div>
            <LoadButton onDataLoad={this.handleSnapshotLoad} />
            <div>{JSON.stringify(this.state.footprints)}</div>
          </div>
          <SnapshotChart snapshot={this.state} />
        </div>
        /* jshint ignore: end */
      );
    }
  }
})();
