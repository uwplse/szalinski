/* global openscadOpenJscadParser OpenJsCad  */
import React from "react";
import { inputs } from "./inputs.js";

export default function JSCadEditor(props) {
  console.log("render");
  const { designName } = props;
  const scad = inputs[designName] || "";
  const jscad = openscadOpenJscadParser.parse(scad) || "";

  if (scad.length > 0) {
    OpenJsCad.parseJsCadScriptASync(jscad, {}, {}, function (err, obj) {
      if (err) {
        console.warn(err);
        return;
      }
      document.getElementById("viewer").innerHTML = "";
      let solid = OpenJsCad.Processor.convertToSolid(obj);
      const viewer = new OpenJsCad.Viewer(
        document.getElementById("viewer"),
        500
      );
      viewer.setCsg(solid);
      viewer.state = 2;
    });
  }

  return (
    <>
      <div className="column">
        <h2>JSCadEditor</h2>
        <div>
          <button className="hidden">hide me</button>
          <textarea value={jscad} readOnly></textarea>
        </div>
      </div>
      <div className="column">
        <h2>Renderer</h2>
        <button className="hidden">hide me</button>
        <div id="viewer"></div>
      </div>
    </>
  );
}
