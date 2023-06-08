import React, { Component } from "react";
import "./index.css";
import CodeEditor from "./CodeEditor.jsx";
import Renderer from "./Renderer";

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

    if (wasm.greet) {
      console.log(wasm.greet("test"));
    }

    return (
      <div className="App">
        <header className="App-header">
          <div className="row">
            <CodeEditor />
            <CodeEditor />
            <Renderer />
          </div>
        </header>
      </div>
    );
  }
}

export default Loader;
