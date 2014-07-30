/** @jsx React.DOM */

var SnapshotChart;

(function () {
  'use strict';

  SnapshotChart = React.createClass(new SnapshotChartConfig());

  function SnapshotChartConfig() {
    /* jshint validthis: true */

    return {
      componentWillReceiveProps: componentWillReceiveProps,
      getDefaultProps: getDefaultProps,
      render: render
    };

    function getDefaultProps() {
      return {
        snapshot: { date: new Date(), footprints: [] },
      };
    }

    function loadChart(snapshot) {
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
      var chartData = _.map(snapshot.footprints, function (footprint) {
        var colorOptions = colors[colorIndex];
        colorIndex = (colorIndex + 1) % colors.length;

        return _.extend({
          /* jshint camelcase: false */
          value: footprint.num_lines,
          label: footprint.author
          /* jshint camelcase: true */
        }, colorOptions);
      });

      var element = window.document.getElementById('snapshot-chart');
      var context = element.getContext('2d');
      new Chart(context).Doughnut(chartData);
    }

    function componentWillReceiveProps(nextProps) {
      if (!_.isEqual(nextProps.snapshot, this.props.snapshot)) {
        loadChart(nextProps.snapshot);
      }
    }

    function render() {
      return (
        /* jshint ignore: start */
        <canvas id="snapshot-chart" width="400" height="400"></canvas>
        /* jshint ignore: end */
      );
    }
  }
})();
