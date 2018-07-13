'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var Monster = function (_React$Component) {
    _inherits(Monster, _React$Component);

    function Monster(props) {
        _classCallCheck(this, Monster);

        var _this = _possibleConstructorReturn(this, (Monster.__proto__ || Object.getPrototypeOf(Monster)).call(this, props));

        _this.state = {
            error: null,
            isLoaded: false,
            stats: []
        };
        return _this;
    }

    _createClass(Monster, [{
        key: 'componentDidMount',
        value: function componentDidMount() {
            var _this2 = this;

            fetch("/get-monster/?id=" + this.props.id).then(function (res) {
                return res.json();
            }).then(function (result) {
                _this2.setState({
                    isLoaded: true,
                    stats: result
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
        key: 'render',
        value: function render() {
            var _state = this.state,
                error = _state.error,
                isLoaded = _state.isLoaded,
                stats = _state.stats;


            if (error) {
                return React.createElement(
                    'div',
                    null,
                    'Error: ',
                    error.message
                );
            } else if (!isLoaded) {
                return React.createElement(
                    'div',
                    null,
                    'Loading...'
                );
            } else if (stats == null) {
                return React.createElement(
                    'div',
                    null,
                    'Monster not found'
                );
            } else {
                console.log('render called', this.state.stats.id);
                var saving_throw = void 0,
                    skill = void 0,
                    immune = void 0,
                    conditionimmune = void 0,
                    senses = void 0,
                    vulnerable = void 0,
                    languages = void 0,
                    resist = void 0,
                    description = void 0,
                    passive = void 0,
                    challenge = void 0;

                if (stats.saving_throw) {
                    saving_throw = React.createElement(
                        'div',
                        null,
                        React.createElement(
                            'p',
                            null,
                            React.createElement(
                                'strong',
                                null,
                                'Saves'
                            ),
                            ' ',
                            stats.saving_throw
                        ),
                        React.createElement('hr', null)
                    );
                }
                if (stats.skill) {
                    skill = React.createElement(
                        'div',
                        null,
                        React.createElement(
                            'p',
                            null,
                            React.createElement(
                                'strong',
                                null,
                                'Skills'
                            ),
                            ' ',
                            stats.skill
                        ),
                        React.createElement('hr', null)
                    );
                }
                if (stats.vulnerable) {
                    vulnerable = React.createElement(
                        'p',
                        null,
                        React.createElement(
                            'strong',
                            null,
                            'Vulnerabilities'
                        ),
                        ' ',
                        stats.vulnerable
                    );
                }
                if (stats.immune) {
                    immune = React.createElement(
                        'p',
                        null,
                        React.createElement(
                            'strong',
                            null,
                            'Immunities'
                        ),
                        ' ',
                        stats.immune
                    );
                }
                if (stats.conditionimmune) {
                    conditionimmune = React.createElement(
                        'p',
                        null,
                        React.createElement(
                            'strong',
                            null,
                            'Condition Immunities'
                        ),
                        ' ',
                        stats.conditionimmune
                    );
                }
                if (stats.resist) {
                    resist = React.createElement(
                        'p',
                        null,
                        React.createElement(
                            'strong',
                            null,
                            'Resistances'
                        ),
                        ' ',
                        stats.resist
                    );
                }
                senses = React.createElement(
                    'p',
                    null,
                    React.createElement(
                        'strong',
                        null,
                        'Senses'
                    ),
                    ' ',
                    stats.senses
                );
                passive = React.createElement(
                    'p',
                    null,
                    React.createElement(
                        'strong',
                        null,
                        'Passive Perception'
                    ),
                    ' ',
                    stats.passive
                );
                languages = React.createElement(
                    'p',
                    null,
                    React.createElement(
                        'strong',
                        null,
                        'Languages'
                    ),
                    ' ',
                    stats.languages
                );
                challenge = React.createElement(
                    'p',
                    null,
                    React.createElement(
                        'strong',
                        null,
                        'Challenge Rating'
                    ),
                    ' ',
                    stats.cr,
                    ' (',
                    stats.xp,
                    'xp)'
                );

                return React.createElement(
                    'div',
                    { id: 'Details', className: 'row' },
                    React.createElement(
                        'div',
                        { className: 'col-md' },
                        React.createElement(
                            'div',
                            { className: 'panel monster-template' },
                            React.createElement(
                                'h3',
                                null,
                                stats.name
                            ),
                            React.createElement(
                                'p',
                                { className: 'italic' },
                                stats.size,
                                ' ',
                                stats.type.name,
                                ', ',
                                stats.alignment
                            ),
                            React.createElement('hr', null),
                            React.createElement(
                                'p',
                                null,
                                React.createElement(
                                    'strong',
                                    null,
                                    'Armor class'
                                ),
                                ' ',
                                stats.ac
                            ),
                            React.createElement(
                                'p',
                                null,
                                React.createElement(
                                    'strong',
                                    null,
                                    'Hit Points'
                                ),
                                ' ',
                                stats.hp
                            ),
                            React.createElement(
                                'p',
                                null,
                                React.createElement(
                                    'strong',
                                    null,
                                    'Speed:'
                                ),
                                ' ',
                                stats.speed
                            ),
                            React.createElement('hr', null),
                            React.createElement(
                                'div',
                                { className: 'row statblock' },
                                React.createElement(
                                    'div',
                                    { className: 'col' },
                                    React.createElement(
                                        'span',
                                        { className: 'stat' },
                                        'Str'
                                    ),
                                    stats.str
                                ),
                                React.createElement(
                                    'div',
                                    { className: 'col' },
                                    React.createElement(
                                        'span',
                                        { className: 'stat' },
                                        'Dex'
                                    ),
                                    stats.dex
                                ),
                                React.createElement(
                                    'div',
                                    { className: 'col' },
                                    React.createElement(
                                        'span',
                                        { className: 'stat' },
                                        'Con'
                                    ),
                                    stats.con
                                ),
                                React.createElement(
                                    'div',
                                    { className: 'col' },
                                    React.createElement(
                                        'span',
                                        { className: 'stat' },
                                        'Int'
                                    ),
                                    stats.int
                                ),
                                React.createElement(
                                    'div',
                                    { className: 'col' },
                                    React.createElement(
                                        'span',
                                        { className: 'stat' },
                                        'Wis'
                                    ),
                                    stats.wis
                                ),
                                React.createElement(
                                    'div',
                                    { className: 'col' },
                                    React.createElement(
                                        'span',
                                        { className: 'stat' },
                                        'Cha'
                                    ),
                                    stats.cha
                                )
                            ),
                            React.createElement('hr', null),
                            saving_throw,
                            skill,
                            senses,
                            languages,
                            challenge,
                            immune,
                            conditionimmune,
                            vulnerable,
                            React.createElement('hr', null),
                            React.createElement(Stats, { props: stats.traits, title: 'Traits', type: 'trait' }),
                            React.createElement(Spells, { props: stats.spells, title: 'Spells', type: 'spell' }),
                            React.createElement(Stats, { props: stats.legendaries, title: 'Legendary Actions', type: 'legendary' }),
                            React.createElement(Stats, { props: stats.actions, title: 'Actions', type: 'action' })
                        )
                    )
                );
            }
        }
    }]);

    return Monster;
}(React.Component);

function Trait(props) {
    var trait = props.props;
    trait.text = trait.text.map(function (t, i) {
        return React.createElement(
            'p',
            { key: i },
            t
        );
    });
    return React.createElement(
        'div',
        null,
        React.createElement(
            'h5',
            null,
            trait.name
        ),
        React.createElement(
            'p',
            null,
            React.createElement(
                'strong',
                null,
                trait.attack
            )
        ),
        trait.text
    );
}

var Stats = function (_React$Component2) {
    _inherits(Stats, _React$Component2);

    function Stats(props) {
        _classCallCheck(this, Stats);

        var _this3 = _possibleConstructorReturn(this, (Stats.__proto__ || Object.getPrototypeOf(Stats)).call(this, props));

        _this3.stats = props.props;
        return _this3;
    }

    _createClass(Stats, [{
        key: 'renderStats',
        value: function renderStats() {
            return this.stats.map(function (e, i) {
                return React.createElement(Trait, { props: e, key: i });
            });
        }
    }, {
        key: 'render',
        value: function render() {
            if (this.stats.length == 0) {
                return null;
            } else {
                return React.createElement(
                    'div',
                    null,
                    React.createElement(
                        'h4',
                        null,
                        this.props.title
                    ),
                    this.renderStats(),
                    React.createElement('hr', null)
                );
            }
        }
    }]);

    return Stats;
}(React.Component);

function Spell(props) {
    var spell = props.props;
    spell.text = spell.text.map(function (t, i) {
        return React.createElement(
            'p',
            { key: i },
            t
        );
    });
    return React.createElement(
        'div',
        { className: 'panel monster-template' },
        React.createElement(
            'h3',
            null,
            spell.name
        ),
        React.createElement(
            'p',
            { className: 'italic' },
            spell.level,
            ' - ',
            spell.school
        ),
        React.createElement(
            'p',
            null,
            React.createElement(
                'strong',
                null,
                'Casting Time:'
            ),
            ' ',
            spell.time
        ),
        React.createElement(
            'p',
            null,
            React.createElement(
                'strong',
                null,
                'Range:'
            ),
            ' ',
            spell.range
        ),
        React.createElement(
            'p',
            null,
            React.createElement(
                'strong',
                null,
                'Components:'
            ),
            ' ',
            spell.components
        ),
        React.createElement(
            'p',
            null,
            React.createElement(
                'strong',
                null,
                'Duration:'
            ),
            ' ',
            spell.duration
        ),
        spell.text
    );
}

var Spells = function (_React$Component3) {
    _inherits(Spells, _React$Component3);

    function Spells(props) {
        _classCallCheck(this, Spells);

        var _this4 = _possibleConstructorReturn(this, (Spells.__proto__ || Object.getPrototypeOf(Spells)).call(this, props));

        _this4.spells = props.props;
        return _this4;
    }

    _createClass(Spells, [{
        key: 'handleChange',
        value: function handleChange() {
            var spell_id = document.getElementById('spellSelect').value;

            var spell = this.spells.map(function (e, i) {
                if (e.id == spell_id) {
                    return React.createElement(Spell, { props: e, key: i });
                }
            });

            ReactDOM.render(spell, document.getElementById('spell-container'));
        }
    }, {
        key: 'renderSpellList',
        value: function renderSpellList() {
            var _this5 = this;

            var spell_list = [React.createElement(
                'option',
                { value: '', key: 'spell_list_select_Key' },
                'Choose a Spell'
            )];
            spell_list.push(this.spells.map(function (e, i) {
                return React.createElement(
                    'option',
                    { value: e.id, key: i },
                    e.name
                );
            }));
            return React.createElement(
                'select',
                { id: 'spellSelect', onChange: function onChange() {
                        return _this5.handleChange();
                    } },
                spell_list
            );
        }
    }, {
        key: 'render',
        value: function render() {
            if (this.spells.length == 0) {
                return null;
            } else {
                return React.createElement(
                    'div',
                    null,
                    React.createElement(
                        'h4',
                        null,
                        'Spell List'
                    ),
                    this.renderSpellList(),
                    React.createElement('div', { id: 'spell-container' }),
                    React.createElement('hr', null)
                );
            }
        }
    }]);

    return Spells;
}(React.Component);

function Name(props) {
    return React.createElement('span', { className: "participant_name", onClick: props.onClick }, props.name);
}

var Participant = function (_React$Component4) {
    _inherits(Participant, _React$Component4);

    function Participant(props) {
        _classCallCheck(this, Participant);

        var _this6 = _possibleConstructorReturn(this, (Participant.__proto__ || Object.getPrototypeOf(Participant)).call(this, props));

        _this6.state = { name: '' };
        return _this6;
    }

    _createClass(Participant, [{
        key: 'handleClick',
        value: function handleClick() {
            ReactDOM.unmountComponentAtNode(document.getElementById('monster_pane'));
            var monster = React.createElement(Monster, { id: this.props.id });
            ReactDOM.render(monster, document.getElementById('monster_pane'));
        }
    }, {
        key: 'renderName',
        value: function renderName(n) {
            var _this7 = this;

            return React.createElement(Name, {
                name: this.props.name,
                onClick: function onClick() {
                    return _this7.handleClick();
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
    // Read the name and ID from a data-* attribute.
    var name = domContainer.dataset.name;
    var id = domContainer.dataset.id;
    ReactDOM.render(React.createElement(Participant, { name: name, id: id }), domContainer);
});

ReactDOM.render(React.createElement(Monster, { id: $('#monster_id').data('id') }), document.getElementById('monster_pane'));