import PropTypes from 'prop-types';
import React from 'react';

export default class CommentForm extends React.Component {
  static propTypes = {
    name: PropTypes.string.isRequired, // this is passed from the Rails view
  };

  /**
   * @param props - Comes from your rails view.
   * @param _railsContext - Comes from React on Rails
   */
  // constructor(props, _railsContext) {
  //   super(props);

    // How to set initial state in ES6 class syntax
    // https://facebook.github.io/react/docs/reusable-components.html#es6-classes
  //   this.state = { name: this.props.name };
  // }

  // updateName = (name) => {
  //   this.setState({ name });
  // };

  handleClick() { 
    var name = this.refs.comment.value; 
    $.ajax({ 
      url: '/api/v1/items', 
      type: 'POST', 
      data: { 
        item: { comment: comment } }, success: (response) => { console.log('it worked!', response); } 
      }); 
  },
  render() {
    return (
      <div>
       <input ref='comment' placeholder='Add your comment' /> 
       <button onClick={this.handleClick}>Submit</button>
      </div>
    );
  }
}
