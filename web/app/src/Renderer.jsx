/* global openscadOpenJscadParser OpenJsCad */
import React from "react";

export default function Renderer(props) {
  const { caddyToScad, caddy } = props;

  if (caddy) {
    const scad = caddyToScad(caddy);
    const jscad = openscadOpenJscadParser.parse(scad);
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
    return <div id="viewer" />;
  } else {
    return <div></div>;
  }
}
