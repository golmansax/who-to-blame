/** @jsx React.DOM */

var SnapshotView;

(function () {
  'use strict';

  SnapshotView = React.createClass(new SnapshotViewConfig());

  function SnapshotViewConfig() {
    /* jshint validthis: true */

    return {
      getInitialState: getInitialState,
      componentDidMount: componentDidMount,
      handleSnapshotLoad: handleSnapshotLoad,
      render: render
    };

    function getInitialState() {
      return { footprints: [] };
    }

    function componentDidMount() {
      reqwest({
        url: 'who-to-blame/snapshots/latest',
        method: 'get',
        success: this.handleSnapshotLoad
      });
    }

    function handleSnapshotLoad(snapshot) {
      var footprints = _.sortBy(snapshot.footprints, 'num_lines');

      this.setState({ footprints: footprints });
    }

    function render() {
      var snapshot;
      snapshot = { date: new Date(), footprints: this.state.footprints };

      return (
        /* jshint ignore: start */
        <div>
          <div>
            <LoadButton onDataLoad={this.handleSnapshotLoad} />
            <div>{JSON.stringify(this.state.footprints)}</div>
          </div>
          <SnapshotChart snapshot={snapshot} />
        </div>
        /* jshint ignore: end */
      );
    }
  }
})();
