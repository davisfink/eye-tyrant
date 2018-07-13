'use strict';

class EncounterDetails extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            error: null,
            isLoaded: false,
            details: []
        };
    }

    componentDidMount() {
        fetch("/get-experience-details/?encounter_id="+this.props.encounter_id)
        .then(res => res.json())
        .then(
            (result) => {
            this.setState({
                isLoaded: true,
                details: result
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
        const { error, isLoaded, details } = this.state;

        if (error) {
            return <div>Error: {error.message}</div>;
        } else if (!isLoaded) {
            return <div>Loading...</div>;
        } else if (details == null) {
            return <div>Monster not found</div>;
        } else {
            return(
                <div className="panel">
                    <div className="row margin-bottom">
                        <div className="col-md">
                            <h4>Encounter:</h4>
                            <div className="row">
                                <div className="col-md-7">
                                    Per Character:
                                </div>
                                <div className="col-md">
                                    <strong>{details.character_experience}xp</strong>
                                </div>
                            </div>
                            <div className="row">
                                <div className="col-md-7">
                                    Total:
                                </div>
                                <div className="col-md">
                                    {details.total_experience}xp
                                </div>
                            </div>
                            <div className="row">
                                <div className="col-md-7">
                                    Adjusted:
                                </div>
                                <div className="col-md">
                                    {details.adjusted_experience}xp
                                </div>
                            </div>
                        </div>
                        <div className="col-md">
                            <div className="row">
                                <div className="col-md-7">
                                    easy:
                                </div>
                                <div className="col-md">
                                    {details.easy}xp
                                </div>
                            </div>
                            <div className="row">
                                <div className="col-md-7">
                                    medium:
                                </div>
                                <div className="col-md">
                                    {details.medium}xp
                                </div>
                            </div>
                            <div className="row">
                                <div className="col-md-7">
                                    hard:
                                </div>
                                <div className="col-md">
                                    {details.hard}xp
                                </div>
                            </div>
                            <div className="row">
                                <div className="col-md-7">
                                    deadly:
                                </div>
                                <div className="col-md">
                                    {details.deadly}xp
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md text-right">
                            <a className="button" href="/newencounter/">New Encounter</a>
                        </div>
                    </div>
                </div>
            )
        }
    }
}

ReactDOM.render(
    <EncounterDetails encounter_id={$("#encounter-details").data('encounter-id')} />,
    document.getElementById('encounter-details')
);
