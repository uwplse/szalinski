import React, { useState } from "react";

import CodeEditor from "./CodeEditor.jsx";
import Renderer from "./Renderer";
import { cardFramer } from "./cardFramer";

export default function App(props) {
  const { wasm } = props;
  const [renderCode, setRenderCode] = useState("");

  return (
    <div className="row">
      <CodeEditor />
      <CodeEditor
        initialCode={cardFramer}
        render={(caddy) => setRenderCode(caddy)}
      />
      <Renderer caddyToScad={wasm.caddy_to_scad} caddy={renderCode} />
    </div>
  );
}
