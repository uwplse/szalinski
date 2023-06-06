import React, { useState } from "react";
import "./App.css";
import CaddyEditor from "./CaddyEditor";
import JSCadEditor from "./JSCadEditor";
import ScadEditor from "./ScadEditor";

export default function App() {
  const [designName, setDesignName] = useState("");

  const onSelect = (e) => {
    setDesignName(e.target.value);
  };

  return (
    <div>
      <div className="row">
        <CaddyEditor />
        <ScadEditor designName={designName} onSelect={onSelect} />
        <JSCadEditor designName={designName} />
      </div>
    </div>
  );
}
