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

      var colors = [
        {
          color: '#F7464A',
          highlight: '#FF5A5E'
        },
        {
          color: '#46BFBD',
          highlight: '#5AD3D1'
        },
        {
          color: '#FDB45C',
          highlight: '#FFC870'
        }
      ];

      var colorIndex = 0;
      var chartData = _.map(footprints, function (footprint) {
        var colorOptions = colors[colorIndex];
        colorIndex = (colorIndex + 1) % colors.length;

        return _.extend({
          /* jshint camelcase: false */
          value: footprint.num_lines,
          label: footprint.author
          /* jshint camelcase: true */
        }, colorOptions);
      });

      var ctx = window.document.getElementById('myChart').getContext('2d');
      new Chart(ctx).Doughnut(chartData);
    }

    function render() {
      return (
        /* jshint ignore: start */
        <div>
          <LoadButton onDataLoad={this.handleFootprintsLoad} />
          <div>{JSON.stringify(this.state.footprints)}</div>
          <canvas id="myChart" width="400" height="400"></canvas>
        </div>
        /* jshint ignore: end */
      );
    }
  }
})();
