/* global openscadOpenJscadParser OpenJsCad */
import React from "react";

export default function Renderer(props) {
  const { caddyToScad, caddy } = props;

  if (caddy) {
    try {
      const scad = caddyToScad(caddy);
      try {
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
      } catch (e) {
        console.warn(e);
        return (
          <div>
            <p>Unable to parse Scad to JSCad</p>
            <p>Caddy: {caddy}</p>
            <p>SCAD: {scad}</p>
          </div>
        );
      }
    } catch (e) {
      console.warn(e);
      return (
        <div>
          <p>Unable to parse Caddy to Scad</p>
          <p>Caddy: {caddy}</p>
        </div>
      );
    }
  } else {
    return <div>No Caddy</div>;
  }
}
