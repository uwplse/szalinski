import("./node_modules/wasm-sz/wasm_sz.js").then((js) => {
  console.log(js.greet("WebAssembly with npm"));
});
