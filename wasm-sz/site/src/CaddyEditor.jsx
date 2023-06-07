import React, { useState } from "react";
import { cardFramer } from "./CardFramer";

export default function CaddyEditor(props) {
  const { caddyToCsg, setScad } = props;
  const [caddy, setCaddy] = useState(cardFramer);

  function onChange(e) {
    setCaddy(e.target.value);
  }

  function compile() {
    if (!caddyToCsg) {
      return;
    }
    const scad = caddyToCsg(caddy);
    setScad(scad);
  }

  return (
    <div className="column">
      <h2>Caddy</h2>
      <button onClick={compile}>Compile to CSG</button>
      <textarea value={caddy} onChange={onChange}></textarea>
    </div>
  );
}
