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
    try {
      const scad = caddyToCsg(caddy);

      setScad(scad);
    } catch (error) {
      setScad("There was an error parsing your Caddy. Please try again.");
    }
  }

  return (
    <div className="column">
      <h2>Caddy</h2>
      <button onClick={compile}>Compile to CSG</button>
      <textarea value={caddy} onChange={onChange}></textarea>
    </div>
  );
}
