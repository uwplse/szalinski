import React from "react";
import MonacoEditor from "react-monaco-editor";

export default function CodeEditor(props) {
  let { allowImport, code, setCode, readOnly } = props;

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
    <div className="column">
      {allowImport && <button onClick={onClickImport}>Import from File</button>}
      <MonacoEditor
        value={code}
        height={"95%"}
        options={{ readOnly: readOnly, minimap: { enabled: false } }}
        onChange={(value) => setCode(value)}
      />
    </div>
  );
}
