'use strict';

class Encounter extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            error: null,
            isLoaded: false,
            participants: [],
            inactive: []
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
                inactive: result.inactive
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
        const { error, isLoaded, participants, inactive } = this.state;

        if (error) {
            return <div>Error: {error.message}</div>;
        } else if (!isLoaded) {
            return <div>Loading...</div>;
        } else if (participants == null) {
            return <div>No active participants</div>;
        } else {
            var participant_list = participants.map(function(p,i) {
                return <Participant props={p} key={i}/>
            })
            return(
                <div className="encounter">
                    {participant_list}
                </div>
            )
        }
    }
}

ReactDOM.render(
    <Encounter id={$('#participants').data('id')}/>,
    document.getElementById('participants')
)
