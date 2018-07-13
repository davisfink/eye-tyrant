'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var EncounterDetails = function (_React$Component) {
    _inherits(EncounterDetails, _React$Component);

    function EncounterDetails(props) {
        _classCallCheck(this, EncounterDetails);

        var _this = _possibleConstructorReturn(this, (EncounterDetails.__proto__ || Object.getPrototypeOf(EncounterDetails)).call(this, props));

        _this.state = {
            error: null,
            isLoaded: false,
            details: []
        };
        return _this;
    }

    _createClass(EncounterDetails, [{
        key: "componentDidMount",
        value: function componentDidMount() {
            var _this2 = this;

            fetch("/get-experience-details/?encounter_id=" + this.props.encounter_id).then(function (res) {
                return res.json();
            }).then(function (result) {
                _this2.setState({
                    isLoaded: true,
                    details: result
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
                details = _state.details;


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
            } else if (details == null) {
                return React.createElement(
                    "div",
                    null,
                    "Monster not found"
                );
            } else {
                return React.createElement(
                    "div",
                    { className: "panel" },
                    React.createElement(
                        "div",
                        { className: "row margin-bottom" },
                        React.createElement(
                            "div",
                            { className: "col-md" },
                            React.createElement(
                                "h4",
                                null,
                                "Encounter:"
                            ),
                            React.createElement(
                                "div",
                                { className: "row" },
                                React.createElement(
                                    "div",
                                    { className: "col-md-7" },
                                    "Per Character:"
                                ),
                                React.createElement(
                                    "div",
                                    { className: "col-md" },
                                    React.createElement(
                                        "strong",
                                        null,
                                        details.character_experience,
                                        "xp"
                                    )
                                )
                            ),
                            React.createElement(
                                "div",
                                { className: "row" },
                                React.createElement(
                                    "div",
                                    { className: "col-md-7" },
                                    "Total:"
                                ),
                                React.createElement(
                                    "div",
                                    { className: "col-md" },
                                    details.total_experience,
                                    "xp"
                                )
                            ),
                            React.createElement(
                                "div",
                                { className: "row" },
                                React.createElement(
                                    "div",
                                    { className: "col-md-7" },
                                    "Adjusted:"
                                ),
                                React.createElement(
                                    "div",
                                    { className: "col-md" },
                                    details.adjusted_experience,
                                    "xp"
                                )
                            )
                        ),
                        React.createElement(
                            "div",
                            { className: "col-md" },
                            React.createElement(
                                "div",
                                { className: "row" },
                                React.createElement(
                                    "div",
                                    { className: "col-md-7" },
                                    "easy:"
                                ),
                                React.createElement(
                                    "div",
                                    { className: "col-md" },
                                    details.easy,
                                    "xp"
                                )
                            ),
                            React.createElement(
                                "div",
                                { className: "row" },
                                React.createElement(
                                    "div",
                                    { className: "col-md-7" },
                                    "medium:"
                                ),
                                React.createElement(
                                    "div",
                                    { className: "col-md" },
                                    details.medium,
                                    "xp"
                                )
                            ),
                            React.createElement(
                                "div",
                                { className: "row" },
                                React.createElement(
                                    "div",
                                    { className: "col-md-7" },
                                    "hard:"
                                ),
                                React.createElement(
                                    "div",
                                    { className: "col-md" },
                                    details.hard,
                                    "xp"
                                )
                            ),
                            React.createElement(
                                "div",
                                { className: "row" },
                                React.createElement(
                                    "div",
                                    { className: "col-md-7" },
                                    "deadly:"
                                ),
                                React.createElement(
                                    "div",
                                    { className: "col-md" },
                                    details.deadly,
                                    "xp"
                                )
                            )
                        )
                    ),
                    React.createElement(
                        "div",
                        { className: "row" },
                        React.createElement(
                            "div",
                            { className: "col-md text-right" },
                            React.createElement(
                                "a",
                                { className: "button", href: "/newencounter/" },
                                "New Encounter"
                            )
                        )
                    )
                );
            }
        }
    }]);

    return EncounterDetails;
}(React.Component);

ReactDOM.render(React.createElement(EncounterDetails, { encounter_id: $("#encounter-details").data('encounter-id') }), document.getElementById('encounter-details'));