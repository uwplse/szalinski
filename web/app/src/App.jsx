import React, { useState } from "react";

import CodeEditor from "./CodeEditor.jsx";
import Renderer from "./Renderer";
import { cardFramer } from "./cardFramer";
import RunButtons from "./RunButtons.jsx";

export default function App(props) {
  const { wasm } = props;
  const [csg, setCsg] = useState(cardFramer);
  const [caddy, setCaddy] = useState("");

  const runSynthesis = (csgCode, type) => {
    try {
      return wasm.synthesize_caddy(csgCode, type);
    } catch (e) {
      console.warn(e);
    }
  };
  const onRunClick = (type) => {
    setCaddy(runSynthesis(csg, type) || "");
  };

  const buttons = [
    {
      id: "szalinski",
      label: "Run Szalinski",
      onClick: () => onRunClick("szalinski"),
    },
    { id: "au", label: "Run AU", onClick: () => onRunClick("AU") },
  ];

  return (
    <div className="row">
      <CodeEditor code={csg} setCode={setCsg} allowImport />
      <RunButtons buttons={buttons} />
      <CodeEditor code={caddy} setCode={setCaddy} readOnly />
      <Renderer caddyToScad={wasm.caddy_to_scad} caddy={caddy} />
    </div>
  );
}
