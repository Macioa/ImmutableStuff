```js
{
  "_name": "init_project_test",
  "commands": [
    {
      "command": "mix phx.new test --no-live --no-html --no-assets --binary-id --umbrella --no-install",
      "dir": ".",
      "caller": "init_phoenix_umbrella_app"
    },
    {
      "command": "npx create-vite@latest test_ui --template react-ts --no-install",
      "dir": "test_umbrella/apps",
      "caller": "init_react_app_with_vite"
    }
  ],
  "file_modifications": {
    "mix.exs": [
      "inject_app_declarations",
      "inject_deps_get_aliases_to_mix_exs"
    ],
    "apps": {
      "test_web": {
        "mix.exs": [
          "inject_web_app_libs",
          "inject_custom_compile_to_mix_exs"
        ],
        "lib": {
          "test_web": {
            "endpoint.ex": [
              "inject_web_endpoint",
              "inject_static_output_to_endpoint"
            ],
}}}}}}
```