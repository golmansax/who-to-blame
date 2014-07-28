/** @jsx React.DOM */

describe('LoadButton', function () {
  'use strict';

  var TestUtils = React.addons.TestUtils;
  var onDataLoad;
  var loadButton;

  beforeEach(function () {
    onDataLoad = jasmine.createSpy('onDataLoad');

    loadButton = TestUtils.renderIntoDocument(
      /* jshint ignore: start */
      <LoadButton onDataLoad={onDataLoad} />
      /* jshint ignore: end */
    );
  });

  it('works', function () {
    var button = TestUtils.findRenderedDOMComponentWithTag(
      loadButton, 'button'
    );
    expect(button.getDOMNode().textContent).toEqual('Load Data');
  });
});
