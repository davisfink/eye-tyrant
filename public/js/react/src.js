'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var e = React.createElement;

function Name(props) {
    return React.createElement('h5', { className: "participant_name", onClick: props.onClick }, props.name);
}

var Participant = function (_React$Component) {
    _inherits(Participant, _React$Component);

    function Participant(props) {
        _classCallCheck(this, Participant);

        var _this = _possibleConstructorReturn(this, (Participant.__proto__ || Object.getPrototypeOf(Participant)).call(this, props));

        _this.state = { name: '' };
        return _this;
    }

    _createClass(Participant, [{
        key: 'handleClick',
        value: function handleClick() {
            console.log();
        }
    }, {
        key: 'renderName',
        value: function renderName(n) {
            var _this2 = this;

            return React.createElement(Name, {
                name: this.props.name,
                onClick: function onClick() {
                    return _this2.handleClick();
                }
            });
        }
    }, {
        key: 'render',
        value: function render() {
            return this.renderName();
        }
    }]);

    return Participant;
}(React.Component);

document.querySelectorAll('.participant_name').forEach(function (domContainer) {
    // Read the comment ID from a data-* attribute.
    var name = domContainer.dataset.name;
    ReactDOM.render(e(Participant, { name: name }), domContainer);
});