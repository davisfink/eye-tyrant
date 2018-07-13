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
        if (this.props.id) {
            ReactDOM.unmountComponentAtNode( document.getElementById('monster_pane'));
            var monster = <Monster id={this.props.id} />
            ReactDOM.render(
                monster,
                document.getElementById('monster_pane')
            );
        }
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


