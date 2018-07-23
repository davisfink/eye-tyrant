'use strict';

class Encounter extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            error: null,
            isLoaded: false,
            participants: [],
            inactive: [],
            current_participant: 0
        };
    }

    componentDidMount() {
        fetch("/get-encounter/?id="+this.props.id)
        .then(res => res.json())
        .then(
            (result) => {
            this.setState({
                isLoaded: true,
                participants: result.participants,
                inactive: result.inactive,
                current_participant: result.active_participant_id
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
        const { error, isLoaded, participants, inactive, current_participant } = this.state;

        if (error) {
            return <div>Error: {error.message}</div>;
        } else if (!isLoaded) {
            return <div>Loading...</div>;
        } else if (participants == null) {
            return <div>No active participants</div>;
        } else {
            var active_participant_list = participants.map(function(p,i) {
                if (p.active == true){
                    return <Participant props={p} key={i}/>
                }
            })
            var inactive_participant_list = participants.map(function(p,i) {
                if (p.active == false){
                    return <Participant props={p} key={i}/>
                }
            })

            active_participant_list.sort(function(a,b) {
                if (b.props.props.initiative == a.props.props.initiative) {
                    return b.props.props.id - a.props.props.id
                }
                    return b.props.props.initiative - a.props.props.initiative
            });

            var current_participant_index = active_participant_list.map(
                function(x) {
                return x.props.props.id;
            }).indexOf(current_participant);
            active_participant_list.push.apply(active_participant_list, active_participant_list.splice(0, current_participant_index));

            console.log("current participant:", current_participant);
            active_participant_list.forEach(function(x){
                console.log(x.props.props.id, x.props.props.initiative)
            })

            return(
                <div className="encounter">
                    {active_participant_list}
                    <hr/>
                    {inactive_participant_list}
                </div>
            )
        }
    }
}

ReactDOM.render(
    <Encounter id={$('#participants').data('id')}/>,
    document.getElementById('participants')
)
