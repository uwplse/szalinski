import React, { useState } from "react";

export default function CaddyEditor(props) {
  const { caddyToCsg } = props;
  const [caddy, setCaddy] = useState("");

  function onChange(e) {
    setCaddy(e.target.value);
  }

  function compile() {
    if (!caddyToCsg) {
      return;
    }
    console.log(caddyToCsg(caddy));
  }

  return (
    <div className="column">
      <h2>Caddy</h2>
      <button onClick={compile}>Compile to CSG</button>
      <textarea value={caddy} onChange={onChange}></textarea>
    </div>
  );
}
