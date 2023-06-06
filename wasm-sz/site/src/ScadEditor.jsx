import React from "react";
import { inputs } from "./inputs.js";

export default function ScadEditor(props) {
  const { onSelect, designName } = props;

  const scad = inputs[designName];
  console.log(designName);
  console.log(scad);

  return (
    <div className="column">
      <h2>ScadEditor</h2>
      <div>
        <select onChange={onSelect} name="select" id="select">
          <option value=""></option>
          {Object.keys(inputs).map((i) => (
            <option key={i} value={i}>
              {i}
            </option>
          ))}
        </select>
        <textarea value={scad}></textarea>
      </div>
    </div>
  );
}
