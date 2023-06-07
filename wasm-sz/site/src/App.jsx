import React, { useState } from "react";
import "./App.css";
import CaddyEditor from "./CaddyEditor";
import JSCadEditor from "./JSCadEditor";
import ScadEditor from "./ScadEditor";
import { cardFramer } from "./CardFramer";

export default function App(props) {
  const { caddyToCsg } = props;

  const [designName, setDesignName] = useState("");

  const onSelect = (e) => {
    setDesignName(e.target.value);
  };

  return (
    <div>
      <div className="row">
        <CaddyEditor caddyToCsg={caddyToCsg} />
        <ScadEditor designName={designName} onSelect={onSelect} />
        <JSCadEditor designName={designName} />
      </div>
    </div>
  );
}
