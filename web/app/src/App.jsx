import React, { useState } from "react";

import CodeEditor from "./CodeEditor.jsx";
import Renderer from "./Renderer";
import { cardFramer } from "./cardFramer";

export default function App(props) {
  const { wasm } = props;
  const [csg, setCsg] = useState(cardFramer);
  const [caddy, setCaddy] = useState("");

  const runSzalinski = (csgCode) => {
    try {
      return wasm.run_szalinski(csgCode);
    } catch (e) {
      console.warn(e);
    }
  };
  const onRunClick = () => {
    setCaddy(runSzalinski(csg) || "");
  };

  return (
    <div className="row">
      <CodeEditor code={csg} setCode={setCsg} />
      <button onClick={onRunClick}>Run Szalinski</button>
      <CodeEditor code={caddy} setCode={setCaddy} readOnly />
      <Renderer caddyToScad={wasm.caddy_to_scad} caddy={caddy} />
    </div>
  );
}
