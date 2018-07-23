'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var Encounter = function (_React$Component) {
    _inherits(Encounter, _React$Component);

    function Encounter(props) {
        _classCallCheck(this, Encounter);

        var _this = _possibleConstructorReturn(this, (Encounter.__proto__ || Object.getPrototypeOf(Encounter)).call(this, props));

        _this.state = {
            error: null,
            isLoaded: false,
            participants: [],
            inactive: [],
            current_participant: 0
        };
        return _this;
    }

    _createClass(Encounter, [{
        key: "componentDidMount",
        value: function componentDidMount() {
            var _this2 = this;

            fetch("/get-encounter/?id=" + this.props.id).then(function (res) {
                return res.json();
            }).then(function (result) {
                _this2.setState({
                    isLoaded: true,
                    participants: result.participants,
                    inactive: result.inactive,
                    current_participant: result.active_participant_id
                });
            },
            // Note: it's important to handle errors here
            // instead of a catch() block so that we don't swallow
            // exceptions from actual bugs in components.
            function (error) {
                _this2.setState({
                    isLoaded: true,
                    error: error
                });
            });
        }
    }, {
        key: "render",
        value: function render() {
            var _state = this.state,
                error = _state.error,
                isLoaded = _state.isLoaded,
                participants = _state.participants,
                inactive = _state.inactive,
                current_participant = _state.current_participant;


            if (error) {
                return React.createElement(
                    "div",
                    null,
                    "Error: ",
                    error.message
                );
            } else if (!isLoaded) {
                return React.createElement(
                    "div",
                    null,
                    "Loading..."
                );
            } else if (participants == null) {
                return React.createElement(
                    "div",
                    null,
                    "No active participants"
                );
            } else {
                var active_participant_list = participants.filter(function (p, i) {
                    if (p.active == true) {
                        return p;
                    }
                }).map(function (p, i) {
                    return React.createElement(Participant, { props: p, key: i });
                });
                var inactive_participant_list = participants.filter(function (p, i) {
                    if (p.active == false) {
                        return p;
                    }
                }).map(function (p, i) {
                    return React.createElement(Participant, { props: p, key: i });
                });

                active_participant_list.sort(function (a, b) {
                    if (b.props.props.initiative == a.props.props.initiative) {
                        return b.props.props.id - a.props.props.id;
                    }
                    return b.props.props.initiative - a.props.props.initiative;
                });

                var current_participant_index = active_participant_list.map(function (x) {
                    return x.props.props.id;
                }).indexOf(current_participant);
                active_participant_list.push.apply(active_participant_list, active_participant_list.splice(0, current_participant_index));

                return React.createElement(
                    "div",
                    { className: "encounter" },
                    active_participant_list,
                    React.createElement("hr", null),
                    inactive_participant_list
                );
            }
        }
    }]);

    return Encounter;
}(React.Component);

ReactDOM.render(React.createElement(Encounter, { id: $('#participants').data('id') }), document.getElementById('participants'));