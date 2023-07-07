import React from "react";

export default function RunButtons(props) {
  const { buttons } = props;

  return (
    <div style={styles.container}>
      {buttons.map((b) => (
        <button style={styles.button} key={b.id} onClick={b.onClick}>
          {b.label}
        </button>
      ))}
    </div>
  );
}

const styles = {
  container: {
    verticalAlign: "middle",
    margin: "auto",
    textAlign: "center",
  },
  button: {
    marginTop: 10,
    width: "100%",
  },
};
