import React, { useState } from "react";
import "./App.css";
import CaddyEditor from "./CaddyEditor";
import JSCadEditor from "./JSCadEditor";
import ScadEditor from "./ScadEditor";

export default function App(props) {
  const { caddyToCsg } = props;

  const [scad, setScad] = useState("");

  return (
    <div>
      <div className="row">
        <CaddyEditor caddyToCsg={caddyToCsg} setScad={setScad} />
        <ScadEditor scad={scad} />
        <JSCadEditor scad={scad} />
      </div>
    </div>
  );
}
