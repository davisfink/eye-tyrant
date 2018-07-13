'use strict';

function Trait(props) {
    return (
        <div>trait</div>
    )
}

export class Traits extends React.Component {
    constructor(props) {
        super(props);
    }

    renderTraits(props) {
        <Trait/>
    }

    render() {
        <div>
            <h4>Traits</h4>
            {this.renderTraits}
        </div>
    }
}
