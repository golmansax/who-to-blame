/** @jsx React.DOM */

var SnapshotView;

(function () {
  'use strict';

  SnapshotView = React.createClass(new SnapshotViewConfig());

  function SnapshotViewConfig() {
    /* jshint validthis: true */

    return {
      componentWillReceiveProps: componentWillReceiveProps,
      getInitialState: getInitialState,
      getInitialProps: getInitialProps,
      setDate: setDate,
      componentDidMount: componentDidMount,
      handleSnapshotLoad: handleSnapshotLoad,
      render: render
    };

    function componentWillReceiveProps(nextProps) {
      console.log('Receiving props', nextProps.date);
      if (nextProps.date !== this.props.date) {
        console.log('here', nextProps.date);
        this.setDate(nextProps.date);
      }
    }

    function getInitialState() {
      return { date: null, footprints: [] };
    }

    function getInitialProps() {
      return { date: null };
    }

    function componentDidMount() {
      if (!this.props.date) { return; }
      this.setDate(this.props.date);
    }

    function setDate(date) {
      var year = date.getFullYear();
      var month = date.getMonth() + 1;
      var day = date.getDate();

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
