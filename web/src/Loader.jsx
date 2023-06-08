import React, { Component } from "react";

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

    return (
      <div className="App">
        <header className="App-header">
          <div>
            <p>{wasm.test && wasm.test("TEST STRING")}</p>
          </div>
        </header>
      </div>
    );
  }
}

export default Loader;
