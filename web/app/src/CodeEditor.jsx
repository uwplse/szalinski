import React from "react";
import MonacoEditor from "react-monaco-editor";

export default function CodeEditor(props) {
  let { code, setCode, readOnly } = props;

  return (
    <div className="column">
      <MonacoEditor
        value={code}
        height={"95%"}
        options={{ readOnly: readOnly }}
        onChange={(value) => setCode(value)}
      />
    </div>
  );
}
