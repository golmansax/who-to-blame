/** @jsx React.DOM */

//= require react
//= require reqwest

var StatManager = React.createClass({
  getInitialState: function () {
    return { stats: {} };
  },
  componentDidMount: function () {
    reqwest({
      url: 'who-to-blame/footprints',
      method: 'get',
      success: this.handleDataLoad.bind(this)
    });
  },
  handleDataLoad: function (data) {
    this.setState({ stats: data });
  },
  render: function () {
    return (
      <div>
        <LoadButton onDataLoad={this.handleDataLoad} />
        <div>{JSON.stringify(this.state.stats)}</div>
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
