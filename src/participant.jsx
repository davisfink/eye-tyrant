function Name(props) {
    return (
        <h5 className="participant_name" onClick={() => props.onClick} >
            {props.name}
        </h5>
    )
}

class Participant extends React.Component {
    constructor(props) {
        super(props);
        this.details = props.props;
        this.state = {
            hitpoints: 0,
            damage: 0,
            initiative 0
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
    renderDamageForm() {
        var uri = "/participant/" + this.details.id + "/damage/"
        return (
            <form action={uri} method="post">
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
    renderHealForm() {
        return ( null )
    }
    renderInitiativeForm() {
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
                    {this.state.damage}/{this.state.hitpoints}
                </div>
                <div className="col text-right">
                    {this.renderConditions()}
                    <ParticipantDamage id={this.details.id}/>
                    <ParticipantHeal id={this.details.id}/>
                    {this.renderInitiativeForm()}
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
        return (
            <div className="panel participant">
                {super.renderDetails()}
            </div>
        )
    }
}

class ParticipantDamage extends React.Component {
    constructor(props) {
        super(props);
        this.state = {value: ''};
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
        });
    }

    handleChange(event) {
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
        this.state = {value: ''};
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
        this.setState({ damage: this.state.damage - this.state.value });
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
