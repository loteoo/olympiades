import {h} from 'hyperapp'
import {Link, Route, Switch, Redirect, location} from "@hyperapp/router"


// Root view
export const view = (state, actions) => {
  // console.log(state);
  if (state.username) {
    return (
      <section class="login-screen uk-section uk-section-primary">
        <div class="uk-container">
        </div>
      </section>
    )
  } else {
    return (
      <section class="login-screen uk-section uk-section-primary">
        <div class="uk-container">
          <h1>test</h1>
        </div>
      </section>
    )
  }
}
