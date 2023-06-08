import React, { useState } from "react";
import MonacoEditor from "react-monaco-editor";

export default function CodeEditor(props) {
  let { initialCode, render } = props;
  let [code, setCode] = useState(initialCode || "");

  return (
    <div className="column">
      {render && <button onClick={() => render(code)}>Render</button>}
      <MonacoEditor value={code} height={"95%"} />
    </div>
  );
}
