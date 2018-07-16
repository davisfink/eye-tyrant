var _get = function get(object, property, receiver) { if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { return get(parent, property, receiver); } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

function Name(props) {
    return React.createElement(
        'h5',
        { className: 'participant_name', onClick: function onClick() {
                return props.onClick;
            } },
        props.name
    );
}

var Participant = function (_React$Component) {
    _inherits(Participant, _React$Component);

    function Participant(props) {
        _classCallCheck(this, Participant);

        var _this = _possibleConstructorReturn(this, (Participant.__proto__ || Object.getPrototypeOf(Participant)).call(this, props));

        _this.details = props.props;
        return _this;
    }

    _createClass(Participant, [{
        key: 'handleClick',
        value: function handleClick() {
            if (this.details.monster != null) {
                ReactDOM.unmountComponentAtNode(document.getElementById('monster_pane'));
                var monster = React.createElement(Monster, { id: this.details.monster.monster_type_id });
                ReactDOM.render(monster, document.getElementById('monster_pane'));
            }
        }
    }, {
        key: 'renderParticipant',
        value: function renderParticipant() {
            if (this.details.type == 'character') {
                return React.createElement(Character, { props: this.details });
            } else {
                return React.createElement(NPC, { props: this.details });
            }
        }
    }, {
        key: 'renderConditions',
        value: function renderConditions() {
            return null;
        }
    }, {
        key: 'renderDamageForm',
        value: function renderDamageForm() {
            var uri = "/participant/" + this.details.id + "/damage/";
            return React.createElement(
                'form',
                { action: uri, method: 'post' },
                React.createElement('input', { type: 'input',
                    name: 'damage',
                    placeholder: 'dmg',
                    value: this.state.value,
                    onChange: this.handleChange
                }),
                React.createElement('input', { type: 'submit', value: '-', className: 'button' })
            );
        }
    }, {
        key: 'renderHealForm',
        value: function renderHealForm() {
            return null;
        }
    }, {
        key: 'renderInitiativeForm',
        value: function renderInitiativeForm() {
            return null;
        }
    }, {
        key: 'renderDetails',
        value: function renderDetails() {
            var _this2 = this;

            return React.createElement(
                'div',
                { className: 'row' },
                React.createElement(
                    'div',
                    { className: 'col-5' },
                    React.createElement(
                        'h5',
                        { className: 'participant_name', onClick: function onClick() {
                                return _this2.handleClick();
                            } },
                        this.details.name
                    ),
                    React.createElement(
                        'span',
                        { className: 'hitpoints' },
                        'hp: '
                    ),
                    this.details.damage,
                    '/',
                    this.details.hitpoints
                ),
                React.createElement(
                    'div',
                    { className: 'col text-right' },
                    this.renderConditions(),
                    React.createElement(ParticipantDamage, { id: this.details.id }),
                    React.createElement(ParticipantHeal, { id: this.details.id }),
                    this.renderInitiativeForm()
                )
            );
        }
    }, {
        key: 'render',
        value: function render() {
            this.details.type = this.details.monster != null ? 'monster' : 'character';
            return this.renderParticipant();
        }
    }]);

    return Participant;
}(React.Component);

var Character = function (_Participant) {
    _inherits(Character, _Participant);

    function Character(props) {
        _classCallCheck(this, Character);

        var _this3 = _possibleConstructorReturn(this, (Character.__proto__ || Object.getPrototypeOf(Character)).call(this, props));

        _this3.details = props.props; //this seems weird. I'm curious what I'm doing wrong
        return _this3;
    }

    _createClass(Character, [{
        key: 'render',
        value: function render() {
            this.details.name = this.details.character.name;
            return React.createElement(
                'div',
                { className: 'panel participant character' },
                this.renderDetails()
            );
        }
    }]);

    return Character;
}(Participant);

var NPC = function (_Participant2) {
    _inherits(NPC, _Participant2);

    function NPC(props) {
        _classCallCheck(this, NPC);

        var _this4 = _possibleConstructorReturn(this, (NPC.__proto__ || Object.getPrototypeOf(NPC)).call(this, props));

        _this4.details = props.props;
        return _this4;
    }

    _createClass(NPC, [{
        key: 'render',
        value: function render() {
            this.details.name = this.details.monster.name;
            return React.createElement(
                'div',
                { className: 'panel participant' },
                _get(NPC.prototype.__proto__ || Object.getPrototypeOf(NPC.prototype), 'renderDetails', this).call(this)
            );
        }
    }]);

    return NPC;
}(Participant);

var ParticipantDamage = function (_React$Component2) {
    _inherits(ParticipantDamage, _React$Component2);

    function ParticipantDamage(props) {
        _classCallCheck(this, ParticipantDamage);

        var _this5 = _possibleConstructorReturn(this, (ParticipantDamage.__proto__ || Object.getPrototypeOf(ParticipantDamage)).call(this, props));

        _this5.state = { value: '' };
        _this5.uri = "/participant/" + _this5.props.id + "/damage/";

        _this5.handleChange = _this5.handleChange.bind(_this5);
        _this5.handleSubmit = _this5.handleSubmit.bind(_this5);
        return _this5;
    }

    _createClass(ParticipantDamage, [{
        key: 'handleSubmit',
        value: function handleSubmit(event) {
            event.preventDefault();
            var data = new FormData(event.target);

            fetch(this.uri, {
                method: 'POST',
                body: data
            });
        }
    }, {
        key: 'handleChange',
        value: function handleChange(event) {
            this.setState({ value: event.target.value });
        }
    }, {
        key: 'render',
        value: function render() {
            return React.createElement(
                'form',
                { onSubmit: this.handleSubmit, method: 'post' },
                React.createElement('input', { type: 'input',
                    name: 'damage',
                    placeholder: 'dmg',
                    value: this.state.value,
                    onChange: this.handleChange
                }),
                React.createElement('input', { type: 'submit', value: '-', className: 'button' })
            );
        }
    }]);

    return ParticipantDamage;
}(React.Component);

var ParticipantHeal = function (_React$Component3) {
    _inherits(ParticipantHeal, _React$Component3);

    function ParticipantHeal(props) {
        _classCallCheck(this, ParticipantHeal);

        var _this6 = _possibleConstructorReturn(this, (ParticipantHeal.__proto__ || Object.getPrototypeOf(ParticipantHeal)).call(this, props));

        _this6.state = { value: '' };
        _this6.uri = "/participant/" + _this6.props.id + "/heal/";

        _this6.handleChange = _this6.handleChange.bind(_this6);
        _this6.handleSubmit = _this6.handleSubmit.bind(_this6);
        return _this6;
    }

    _createClass(ParticipantHeal, [{
        key: 'handleSubmit',
        value: function handleSubmit(event) {
            event.preventDefault();
            var data = new FormData(event.target);

            fetch(this.uri, {
                method: 'POST',
                body: data
            });
        }
    }, {
        key: 'handleChange',
        value: function handleChange(event) {
            this.setState({ value: event.target.value });
        }
    }, {
        key: 'render',
        value: function render() {
            return React.createElement(
                'form',
                { onSubmit: this.handleSubmit, method: 'post' },
                React.createElement('input', { type: 'input',
                    name: 'damage',
                    placeholder: 'heal',
                    value: this.state.value,
                    onChange: this.handleChange
                }),
                React.createElement('input', { type: 'submit', value: '-', className: 'button' })
            );
        }
    }]);

    return ParticipantHeal;
}(React.Component);