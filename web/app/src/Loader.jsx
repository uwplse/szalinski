import React, { Component } from "react";
import "./index.css";
import App from "./App";

// Not a functional component because we async load wasm
// in componentDidMount
// todo: there's probably a way to do this with hooks?
// not sure if worth the time though ....
class Loader extends Component {
  constructor(props) {
    super(props);

    this.state = {
      wasm: {},
    };
  }

  componentDidMount() {
    this.loadWasm();
  }

  loadWasm = async () => {
    try {
      const wasm = await import("wasm-sz");
      this.setState({ wasm });
    } catch (err) {
      console.error(`Unexpected error in loadWasm. [Message: ${err.message}]`);
    }
  };

  render() {
    const { wasm = {} } = this.state;

    return <App wasm={wasm} />;
  }
}

export default Loader;
