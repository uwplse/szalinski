import React, { Component } from "react";

class App extends Component {
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
    console.log(wasm);

    return (
      <div className="App">
        <header className="App-header">
          <div>
            <div>
              Name:{" "}
              <input
                type="text"
                onChange={(e) => this.setState({ name: e.target.value })}
              />
            </div>
            <div>{wasm.greet && wasm.greet("test")} </div>
          </div>
        </header>
      </div>
    );
  }
}

export default App;
