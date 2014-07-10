/** @jsx React.DOM */

//= require react
//= require reqwest
//= require chartjs
//= require underscore

var StatManager = React.createClass({
  getInitialState: function () {
    return { stats: {} };
  },
  componentDidMount: function () {
    reqwest({
      url: 'who-to-blame/footprints',
      method: 'get',
      success: this.handleStatsLoad
    });
  },
  handleStatsLoad: function (stats) {
    this.setState({ stats: stats });

    var colors = [
      {
        color: "#F7464A",
        highlight: "#FF5A5E"
      },
      {
        color: "#46BFBD",
        highlight: "#5AD3D1"
      },
      {
        color: "#FDB45C",
        highlight: "#FFC870"
      }
    ];

    var colorIndex = 0;
    var chartData = _.map(stats['rb'], function (numLines, author) {
      console.log(author, colorIndex);
      var colorOptions = colors[colorIndex];
      colorIndex = (colorIndex + 1) % colors.length;

      return _.extend({
        value: numLines,
        label: author,
      }, colorOptions);
    });

    var ctx = window.document.getElementById('myChart').getContext('2d');
    var chart = new Chart(ctx).Doughnut(chartData);
  },
  render: function () {
    return (
      <div>
        <LoadButton onDataLoad={this.handleStatsLoad} />
        <div>{JSON.stringify(this.state.stats)}</div>
        <canvas id="myChart" width="400" height="400"></canvas>
      </div>
    );
  }
});

var LoadButton = React.createClass({
  loadData: function () {
    var result = window.confirm('Are you sure you want to load data?');
    if (result) {
      reqwest({
        url: 'who-to-blame/footprints',
        method: 'post',
        success: function (data) {
          this.props.onDataLoad(data);
        }.bind(this)
      });
    }
  },
  render: function () {
    return (
      <button onClick={this.loadData}>Load Data</button>
    );
  }
});

React.renderComponent(
  <StatManager />,
  document.getElementById('example')
);
