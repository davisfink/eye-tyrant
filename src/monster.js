'use strict';

class Monster extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            error: null,
            isLoaded: false,
            stats: []
        };
    }

    componentDidMount() {
        fetch("/get-monster/?id="+this.props.id)
        .then(res => res.json())
        .then(
            (result) => {
            this.setState({
                isLoaded: true,
                stats: result
            });
        },
        // Note: it's important to handle errors here
        // instead of a catch() block so that we don't swallow
        // exceptions from actual bugs in components.
        (error) => {
            this.setState({
                isLoaded: true,
                error
            });
        }
        )
    }

    render() {
        const { error, isLoaded, stats } = this.state;

        if (error) {
            return <div>Error: {error.message}</div>;
        } else if (!isLoaded) {
            return <div>Loading...</div>;
        } else if (stats == null) {
            return <div>Monster not found</div>;
        } else {
            console.log('render called', this.state.stats.id );
            let saving_throw,
            skill,
            immune,
            conditionimmune,
            senses,
            vulnerable,
            languages,
            resist,
            description,
            passive,
            challenge;

            if (stats.saving_throw) {
                saving_throw = <div><p><strong>Saves</strong> {stats.saving_throw}</p><hr/></div>;
            }
            if (stats.skill) {
                skill = <div><p><strong>Skills</strong> {stats.skill}</p><hr/></div>;
            }
            if (stats.vulnerable) {
                vulnerable = <p><strong>Vulnerabilities</strong> {stats.vulnerable}</p>;
            }
            if (stats.immune) {
                immune = <p><strong>Immunities</strong> {stats.immune}</p>;
            }
            if (stats.conditionimmune) {
                conditionimmune = <p><strong>Condition Immunities</strong> {stats.conditionimmune}</p>;
            }
            if (stats.resist) {
                resist = <p><strong>Resistances</strong> {stats.resist}</p>;
            }
            senses = <p><strong>Senses</strong> {stats.senses}</p>;
            passive = <p><strong>Passive Perception</strong> {stats.passive}</p>;
            languages = <p><strong>Languages</strong> {stats.languages}</p>;
            challenge = <p><strong>Challenge Rating</strong> {stats.cr} ({stats.xp}xp)</p>;


            return (
                <div id="Details" className="row">
                    <div className="col-md">
                        <div className="panel monster-template">
                            <h3>{stats.name}</h3>
                            <p className="italic">
                                {stats.size} {stats.type.name}, {stats.alignment}
                            </p>
                            <hr />
                            <p><strong>Armor class</strong> {stats.ac}</p>
                            <p><strong>Hit Points</strong> {stats.hp}</p>
                            <p><strong>Speed:</strong> {stats.speed}</p>
                            <hr/>
                            <div className="row statblock">
                                <div className="col">
                                    <span className="stat">Str</span>
                                    {stats.str}
                                </div>
                                <div className="col">
                                    <span className="stat">Dex</span>
                                    {stats.dex}
                                </div>
                                <div className="col">
                                    <span className="stat">Con</span>
                                    {stats.con}
                                </div>
                                <div className="col">
                                    <span className="stat">Int</span>
                                    {stats.int}
                                </div>
                                <div className="col">
                                    <span className="stat">Wis</span>
                                    {stats.wis}
                                </div>
                                <div className="col">
                                    <span className="stat">Cha</span>
                                    {stats.cha}
                                </div>
                            </div>
                            <hr/>
                            {saving_throw}
                            {skill}
                            {senses}
                            {languages}
                            {challenge}
                            {immune}
                            {conditionimmune}
                            {vulnerable}
                            <hr/>
                            <Stats props={stats.traits} title="Traits" type="trait" />
                            <Spells props={stats.spells} title="Spells" type="spell" />
                            <Stats props={stats.legendaries} title="Legendary Actions" type="legendary" />
                            <Stats props={stats.actions} title="Actions" type="action" />
                        </div>
                    </div>
                </div>
            );
        }

    }
}

function Trait(props) {
    var trait = props.props;
    trait.text = trait.text.map(function(t,i) {
        return <p key={i}>{t}</p>
    })
    return (
        <div>
            <h5>{trait.name}</h5>
            <p><strong>{trait.attack}</strong></p>
            {trait.text}
        </div>
    );
}

class Stats extends React.Component {
    constructor(props) {
        super(props);
        this.stats = props.props
    }

    renderStats() {
        return this.stats.map(function(e,i) {
            return <Trait props={e} key={i} />;
        })
    }

    render() {
        if (this.stats.length == 0) {
            return null
        } else {
            return (
                <div>
                    <h4>{this.props.title}</h4>
                    {this.renderStats()}
                    <hr/>
                </div>
            )
        }
    }
}

function Spell(props) {
    var spell = props.props;
    spell.text = spell.text.map(function(t,i) {
        return <p key={i}>{t}</p>
    })
    return (
        <div className="panel monster-template">
            <h3>{spell.name}</h3>
            <p className="italic">
                {spell.level} - {spell.school}
            </p>
            <p><strong>Casting Time:</strong> {spell.time}</p>
            <p><strong>Range:</strong> {spell.range}</p>
            <p><strong>Components:</strong> {spell.components}</p>
            <p><strong>Duration:</strong> {spell.duration}</p>
            {spell.text}
        </div>
    );
}

class Spells extends React.Component {
    constructor(props) {
        super(props);
        this.spells = props.props
    }

    handleChange() {
        var spell_id = document.getElementById('spellSelect').value;

        var spell = this.spells.map(function(e,i) {
            if (e.id == spell_id) {
                return <Spell props={e} key={i} />
            }
        })

        ReactDOM.render(
            spell,
            document.getElementById('spell-container')
        );
    }

    renderSpellList() {
        var spell_list = [<option value="" key="spell_list_select_Key" >Choose a Spell</option>];
        spell_list.push(this.spells.map(function(e,i) {
            return <option value={e.id} key={i} >{e.name}</option>;
        }))
        return <select id="spellSelect" onChange={() => this.handleChange()}>{spell_list}</select>
    }

    render() {
        if (this.spells.length == 0) {
            return null
        } else {
            return (
                <div>
                    <h4>Spell List</h4>
                    {this.renderSpellList()}
                    <div id="spell-container"></div>
                    <hr/>
                </div>
            )
        }
    }
}

function Name(props) {
    return (
          React.createElement(
              'span',
              {className: "participant_name",onClick: props.onClick},
              props.name
    )
    );
}

class Participant extends React.Component {
    constructor(props) {
        super(props);
        this.state = { name:'' };
    }

    handleClick() {
        ReactDOM.unmountComponentAtNode( document.getElementById('monster_pane'));
        var monster = <Monster id={this.props.id} />
        ReactDOM.render(
            monster,
            document.getElementById('monster_pane')
        );
    }

    renderName(n) {
        return (
            <Name
            name={this.props.name}
            onClick={() => this.handleClick()}
            />
        );
    }

    render() {
        return (
            this.renderName()
        );
    }
}

document.querySelectorAll('.participant_name')
.forEach(domContainer => {
    // Read the name and ID from a data-* attribute.
    const name = domContainer.dataset.name;
    const id = domContainer.dataset.id;
    ReactDOM.render(
       <Participant name={name} id={id}/>,
      domContainer
    );
  });


ReactDOM.render(
    <Monster id={$('#monster_id').data('id')} />,
    document.getElementById('monster_pane')
);
