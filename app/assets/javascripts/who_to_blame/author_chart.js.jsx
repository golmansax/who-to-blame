/** @jsx React.DOM */

var AuthorChart;

(function () {
  'use strict';

  AuthorChart = React.createClass(new AuthorChartConfig());

  function AuthorChartConfig() {
    /* jshint validthis: true */

    return {
      componentWillReceiveProps: componentWillReceiveProps,
      getDefaultProps: getDefaultProps,
      render: render
    };

    function getDefaultProps() {
      return {
        snapshot: { date: new Date(), footprints: [] }
      };
    }


    function loadChart() {
      var months =
        ['January', 'February', 'March', 'April', 'May', 'June', 'July'];

      var chartData = {
        labels: months,
        datasets: [
          {
            label: 'My First dataset',
            fillColor: 'rgba(220,220,220,0.2)',
            strokeColor: 'rgba(220,220,220,1)',
            pointColor: 'rgba(220,220,220,1)',
            pointStrokeColor: '#fff',
            pointHighlightFill: '#fff',
            pointHighlightStroke: 'rgba(220,220,220,1)',
            data: [65, 59, 80, 81, 56, 55, 40]
          }, {
            label: 'My Second dataset',
            fillColor: 'rgba(151,187,205,0.2)',
            strokeColor: 'rgba(151,187,205,1)',
            pointColor: 'rgba(151,187,205,1)',
            pointStrokeColor: '#fff',
            pointHighlightFill: '#fff',
            pointHighlightStroke: 'rgba(151,187,205,1)',
            data: [28, 48, 40, 19, 86, 27, 90]
          }
        ]
      };

      var element = window.document.getElementById('author-chart');
      var context = element.getContext('2d');
      new Chart(context).Line(chartData);
    }

    function componentWillReceiveProps(nextProps) {
      if (!_.isEqual(nextProps.snapshot, this.props.snapshot)) {
        loadChart(nextProps.snapshot);
      }
    }

    function render() {
      return (
        /* jshint ignore: start */
        <canvas id="author-chart" width="400" height="400"></canvas>
        /* jshint ignore: end */
      );
    }
  }
})();
