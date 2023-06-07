import React from "react";

export default function ScadEditor(props) {
  const { scad } = props;

  return (
    <div className="column">
      <h2>SCAD</h2>
      <div>
        <button className="hidden">hide me</button>
        <textarea value={scad} readOnly></textarea>
      </div>
    </div>
  );
}
