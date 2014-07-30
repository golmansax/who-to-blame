/** @jsx React.DOM */

var StatManager;

(function () {
  'use strict';

  StatManager = React.createClass(new StatManagerConfig());

  function StatManagerConfig() {
    /* jshint validthis: true */

    return {
      getInitialState: getInitialState,
      componentDidMount: componentDidMount,
      handleFootprintsLoad: handleFootprintsLoad,
      render: render
    };

    function getInitialState() {
      return { footprints: [] };
    }

    function componentDidMount() {
      reqwest({
        url: 'who-to-blame/footprints',
        method: 'get',
        success: this.handleFootprintsLoad
      });
    }

    function handleFootprintsLoad(footprints) {
      footprints = _.sortBy(footprints, 'num_lines');
      this.setState({ footprints: footprints });
    }

    function snapshot() {
      return { date: new Date(), footprints: this.state.footprints };
    }

    function render() {
      return (
        /* jshint ignore: start */
        <div>
          <LoadButton onDataLoad={this.handleFootprintsLoad} />
          <div>{JSON.stringify(this.state.footprints)}</div>
          <SnapshotChart snapshot={snapshot.apply(this)} />
        </div>
        /* jshint ignore: end */
      );
    }
  }
})();
