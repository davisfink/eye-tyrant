function Name(props) {
    return (
        <h5 className="participant_name" onClick={() => props.onClick} >
            {props.name}
        </h5>
    )
}
function Damage(props) {
    return (
        <span>{props.text}</span>
    )
}

class Participant extends React.Component {
    constructor(props) {
        super(props);
        this.details = props.props;
        this.state = {
            hitpoints: this.details.hitpoints,
            damage: this.details.damage,
            initiative: this.details.initiative,
            active: this.details.active
        }
    }

    handleClick() {
        if (this.details.monster != null) {
            ReactDOM.unmountComponentAtNode( document.getElementById('monster_pane'));
            var monster = <Monster id={this.details.monster.monster_type_id} />
            ReactDOM.render(
                monster,
                document.getElementById('monster_pane')
            );
        }
    }

    updateDamage(props) {
        this.setState({ damage: props});
    }

    renderParticipant() {
        if (this.details.type == 'character') {
            return(
                <Character props={this.details}/>
            )
        } else {
            return (
                <NPC props={this.details}/>
            )
        }
    }

    renderConditions() {
        return ( null )
    }

    renderDetails() {
        return (
            <div className="row">
                <div className="col-5">
                    <h5 className="participant_name" onClick={() => this.handleClick()} >
                        {this.details.name}
                    </h5>
                    <span className="hitpoints">hp: </span>
                    <Damage text={this.state.damage}/>/{this.state.hitpoints}
                </div>
                <div className="col text-right">
                    {this.renderConditions()}
                    <ParticipantDamage
                        damage={this.state.damage}
                        id={this.details.id}
                        hitpoints={this.details.hitpoints}
                        updateDamage={(p) => this.updateDamage(p)}
                    />
                    <ParticipantHeal
                        damage={this.state.damage}
                        id={this.details.id}
                        hitpoints={this.details.hitpoints}
                        updateDamage={(p) => this.updateDamage(p)}/>
                    <ParticipantInitiative
                        id={this.details.id}
                        initiative={this.details.initiative}
                    />
                </div>
            </div>
        );
    }

    render() {
        this.details.type = this.details.monster != null ? 'monster' : 'character';
        return (
            this.renderParticipant()
        );
    }
}

class Character extends Participant {
    constructor(props) {
        super(props);
        this.details = props.props; //this seems weird. I'm curious what I'm doing wrong
    }
    render() {
        this.details.name = this.details.character.name;
        return (
            <div className="panel participant character">
                { this.renderDetails() }
            </div>
        )
    }
}

class NPC extends Participant {
    constructor(props) {
        super(props);
        this.details = props.props;
    }
    render() {
        this.details.name = this.details.monster.name;

        if (this.details.active == true) {
            return (
                <div className="panel participant">
                    {super.renderDetails()}
                </div>
            )
        } else {
            return (
                <div className="inactive panel participant">
                    {super.renderDetails()}
                </div>
            )
        }
    }
}

class ParticipantDamage extends React.Component {
    constructor(props) {
        super(props);
        this.state = {value: '', damage: this.props.damage};
        this.uri = "/participant/" + this.props.id + "/damage/";

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleSubmit(event) {
        event.preventDefault();
        const data = new FormData(event.target);

        fetch(this.uri, {
            method: 'POST',
            body: data,
        }).then(
        this.state = { damage: calculateDamage(this.props.hitpoints, this.props.damage, this.state.value, 'damage') },
        this.setState({ damage: this.state.damage}),
        this.setState({value: ''})
        ).then(
        this.props.updateDamage(this.state.damage)
        );
    }

    handleChange(event) {
        event.preventDefault();
        this.setState({value: event.target.value});

    }

    render() {
        return (
            <form onSubmit={this.handleSubmit} method="post">
                <input type="input"
                    name="damage"
                    placeholder="dmg"
                    value={this.state.value}
                    onChange={this.handleChange}
                />
                <input type="submit" value="-" className="button"/>
            </form>
        )
    }
}

class ParticipantHeal extends React.Component {
    constructor(props) {
        super(props);
        this.state = {value: '', damage: this.props.damage};
        this.uri = "/participant/" + this.props.id + "/heal/";

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleSubmit(event) {
        event.preventDefault();
        const data = new FormData(event.target);

        fetch(this.uri, {
            method: 'POST',
            body: data,
        }).then(
        this.state = { damage: calculateDamage(this.props.hitpoints, this.props.damage, this.state.value, 'heal') },
        this.setState({ damage: this.state.damage}),
        this.setState({value: ''})
        ).then(
        this.props.updateDamage(this.state.damage)
        );
    }

    handleChange(event) {
        this.setState({value: event.target.value});

    }

    render() {
        return (
            <form onSubmit={this.handleSubmit} method="post">
                <input type="input"
                    name="damage"
                    placeholder="heal"
                    value={this.state.value}
                    onChange={this.handleChange}
                />
                <input type="submit" value="-" className="button"/>
            </form>
        )
    }
}

class ParticipantInitiative extends React.Component {
    constructor(props) {
        super(props);
        this.state = {value: ''};
        this.uri = "/participant/" + this.props.id + "/initiative/" + $('#encounter-details').data('encounter-id');

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleSubmit(event) {
        event.preventDefault();
        const data = new FormData(event.target);

        fetch(this.uri, {
            method: 'POST',
            body: data,
        }).then(
        this.setState({ initiative: parseInt(this.state.value) })
        );
    }

    handleChange(event) {
        this.setState({value: event.target.value});

    }

    render() {
        return (
            <form onSubmit={this.handleSubmit} method="post">
                <input type="input"
                    name="initiative"
                    placeholder="0"
                    defaultValue={this.props.initiative}
                    onChange={this.handleChange}
                />
                <input type="submit" value="~" className="button"/>
            </form>
        )
    }
}

function calculateDamage(max, damage, value, type) {
    switch(type) {
        case "damage":
            return Math.min(damage + parseInt(value), max)
        break;
        case "heal":
            return Math.max(damage - parseInt(value), 0)
        break;
    }
}

