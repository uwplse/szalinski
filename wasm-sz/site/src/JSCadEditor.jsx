/* global openscadOpenJscadParser OpenJsCad  */
import React from "react";

export default function JSCadEditor(props) {
  const { scad } = props;
  let jscad = "";

  if (scad.length > 0) {
    try {
      jscad = openscadOpenJscadParser.parse(scad);
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
    } catch (error) {
      console.log(error);
    }
  }

  return (
    <>
      <div className="column">
        <h2>JSCad</h2>
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
