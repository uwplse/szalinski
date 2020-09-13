var in_editor = CodeMirror.fromTextArea(document.getElementById('input'), {
  lineNumbers: true
});

var out_editor = CodeMirror.fromTextArea(document.getElementById('output'), {
  lineNumbers: true
});

function upload(example) {
  var input_id = example.id;
  console.log(input_id);
  switch(input_id) {
    case "tacklebox":
      console.log(progs["TackleBox"]);
      in_editor.setValue(progs["TackleBox"]);
      break;
    case "cncendmill":
      in_editor.setValue(progs["CNCBitCase"]);
      break;
    case "circlecell":
      in_editor.setValue(progs["CircleCell"]);
      break;
  }
}
