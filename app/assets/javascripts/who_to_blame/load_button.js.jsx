/** @jsx React.DOM */

var LoadButton;

(function () {
  'use strict';

  LoadButton = React.createClass(new LoadButtonConfig());

  function LoadButtonConfig() {
    /* jshint validthis: true */

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
        window.alert('Already loading data');
        return;
      }

      var result = window.confirm('Are you sure you want to load data?');
      if (result) {
        this.setState({ loading: true });

        var today = new Date();
        var requestData = {
          /* jshint camelcase: false */
          year: today.getFullYear(),
          month: today.getMonth() + 1,
          day: today.getDate(),
          num_steps: 3,
          step: 7
          /* jshint camelcase: true */
        };

        reqwest({
          url: 'who-to-blame/footprints',
          method: 'post',
          data: requestData,
          success: function (data) {
            this.props.onDataLoad(data);
            this.setState({ loading: false });
          }.bind(this),
          error: function () {
            this.setState({ loading: false });
          }.bind(this)
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
