# Developing the Web App

1. Make sure you're using Node version `v16.20.1`
2. Navigate to the `szalinski/web/app` directory
3. Use `wasm-pack` to generate JS from the Rust library

```
wasm-pack build --outdir app/pkg
```

4. Install the frontend dependencies

```
npm install
```

5. Start a local server

```
npm run start
```

6. Navigate to `localhost:3000` in the browser

Changes to JS code will be picked up automatically.  
Changes to the Rust code need to be recompiled to JS.
Run `wasm-pack build --outdir app/pkg` to regenerate the JS code.
