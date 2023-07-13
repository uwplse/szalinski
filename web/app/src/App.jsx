import React, { useState } from "react";
import Split from "react-split";

import CodeEditor from "./CodeEditor.jsx";
import Renderer from "./Renderer";
import { cardFramer } from "./cardFramer";

export default function App(props) {
  const NUM_PANES = 3;

  const { wasm } = props;
  const [csg, setCsg] = useState(cardFramer);
  const [caddy, setCaddy] = useState("");
  const [paneWidths, setPaneWidths] = useState(
    Array(NUM_PANES).fill(100 / NUM_PANES)
  );

  const runSynthesis = (csgCode) => {
    try {
      return wasm.synthesize_caddy(csgCode);
    } catch (e) {
      console.warn(e);
    }
  };
  const onRunClick = () => {
    setCaddy(runSynthesis(csg) || "");
  };

  const onDrag = (widths) => {
    if (widths.length === NUM_PANES) {
      setPaneWidths(widths);
    } else {
      console.warn(`unknown pane widths: ${widths}`);
    }
  };

  const buttons = [
    {
      id: "szalinski",
      label: "Run Szalinski",
      onClick: () => onRunClick("szalinski"),
    },
    { id: "au", label: "Run AU", onClick: () => onRunClick("AU") },
  ];

  return (
    <Split className="split" onDrag={onDrag}>
      <CodeEditor
        code={csg}
        setCode={setCsg}
        allowImport
        width={paneWidths[0]}
      />

      {/* <RunButtons buttons={buttons} /> */}
      <CodeEditor
        buttons={buttons}
        code={caddy}
        setCode={setCaddy}
        readOnly
        width={paneWidths[1]}
      />
      <Renderer caddyToScad={wasm.caddy_to_scad} caddy={caddy} />
    </Split>
  );
}
