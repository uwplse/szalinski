import React, { useEffect, useState } from "react";
import MonacoEditor from "react-monaco-editor";

export default function CodeEditor(props) {
  let { allowImport, buttons, code, setCode, readOnly, width } = props;
  let [editor, setEditor] = useState(null);

  useEffect(() => {
    if (editor) {
      editor.layout();
    }
  }, [width]);

  function handleMount(e) {
    setEditor(e);
  }

  function onClickImport() {
    let input = document.createElement("input");
    input.type = "file";
    input.onchange = async () => {
      let files = Array.from(input.files);
      if (files[0]) {
        const text = await files[0].text();
        if (text) {
          setCode(text);
        }
      }
    };
    input.click();
  }

  return (
    <div style={{ height: "100vh" }}>
      {allowImport && <button onClick={onClickImport}>Import from File</button>}
      {buttons &&
        buttons.map((b) => (
          <button key={b.id} onClick={b.onClick}>
            {b.label}
          </button>
        ))}
      <MonacoEditor
        value={code}
        width={"100%"}
        height={"95%"}
        options={{ readOnly: readOnly, minimap: { enabled: false } }}
        onChange={(value) => setCode(value)}
        editorDidMount={handleMount}
      />
    </div>
  );
}
