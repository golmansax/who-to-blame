/** @jsx React.DOM */

//= require react
//= require reqwest
//= require chartjs
//= require underscore

(function () {
  'use strict';

  var StatManager;
  StatManager = React.createClass(new StatManagerConfig());

  var LoadButton;
  LoadButton = React.createClass(new LoadButtonConfig());

  React.renderComponent(
    (
      /* jshint ignore: start */
      <StatManager />
      /* jshint ignore: end */
    ),
    window.document.getElementById('example')
  );

  function StatManagerConfig() {
    return {
      getInitialState: getInitialState,
      componentDidMount: componentDidMount,
      handleStatsLoad: handleStatsLoad,
      render: render
    };

    function getInitialState() {
      return { stats: {} };
    }

    function componentDidMount() {
      reqwest({
        url: 'who-to-blame/footprints',
        method: 'get',
        success: this.handleStatsLoad
      });
    }

    function handleStatsLoad(stats) {
      console.log(stats);
      this.setState({ stats: stats });

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
      var chartData = _.map(stats.rb, function (numLines, author) {
        var colorOptions = colors[colorIndex];
        colorIndex = (colorIndex + 1) % colors.length;

        return _.extend({
          value: numLines,
          label: author
        }, colorOptions);
      });

      var ctx = window.document.getElementById('myChart').getContext('2d');
      new Chart(ctx).Doughnut(chartData);
    }

    function render() {
      return (
        /* jshint ignore: start */
        <div>
          <LoadButton onDataLoad={this.handleStatsLoad} />
          <div>{JSON.stringify(this.state.stats)}</div>
          <canvas id="myChart" width="400" height="400"></canvas>
        </div>
        /* jshint ignore: end */
      );
    }
  }

  function LoadButtonConfig() {
    var buttonText = {
      default: 'Load Data',
      loading: 'Loading...'
    };

    return {
      getInitialState: getInitialState,
      loadData: loadData,
      render: render
    };

    function getInitialState() {
      return { loading: false };
    }

    function loadData() {
      if (this.state.loading) {
        alert('Already loading data');
        return;
      }

      var result = window.confirm('Are you sure you want to load data?');
      if (result) {
        this.setState({ loading: true });

        var today = new Date();
        var request_data = {
          year: today.getFullYear(),
          month: today.getMonth() + 1,
          day: today.getDate(),
          num_steps: 3,
          step: 7
        };

        reqwest({
          url: 'who-to-blame/footprints',
          method: 'post',
          data: request_data,
          success: function (data) {
            this.props.onDataLoad(data);
            this.setState({ loading: false });
          }.bind(this),
          error: function () {
            this.setState({ loading: false });
          }.bind(this),
        });
      }
    }

    function render() {
      return (
        /* jshint ignore: start */
        <button onClick={this.loadData}>
          {this.state.loading ? 'Loading...' : 'Load Data'}
        </button>
        /* jshint ignore: end */
      );
    }
  }

})();
