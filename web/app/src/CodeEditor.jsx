import React from "react";
import MonacoEditor from "react-monaco-editor";

export default function CodeEditor(props) {
  return (
    <div className="column">
      <MonacoEditor />
    </div>
  );
}
