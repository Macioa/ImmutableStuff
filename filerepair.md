# Automated File Repair
<div align="center">
  <img src="https://raw.githubusercontent.com/macioa/immutablestuff/master/repair_small.png" width="300"/><br/>
</div>

## 
AI works best when performing [isolated and focused tasks](https://github.com/Macioa/ImmutableStuff/blob/master/determinism.md). The Immutable Stack provides tooling to help provide intelligent queries by tracking associated code. Prompt curation provides increased accuracy and reduced token usage. Provide a your own key for an existing llm adapter or create a new adapter for your preferred LLM (requires [customizing the immutable stack](https://github.com/Macioa/ImmutableStuff/blob/master/customimmutable.md))

Apply repairs through command line or with a programmable interface for stored procedures.
## Setup
LLM must be configured and selected before use. 
Using an existing adapter:
```bash
immutable -settings llm: openai openai: MY-OPEN-AI-KEY
```
Or [create](https://github.com/Macioa/ImmutableStuff/blob/master/customimmutable.md) a new adapter in `repair/adapters/` and add it to `index.ts`
## Command Line
Automated file repairs can be applied through command line with:
```bash
immutable -repair ./path/to/my.file 
```
or with smart selection:
```bash
immutable -repair ./path/to/my.file -target CODE_TYPE_ENUM -context entity -contexttargets CODE_TYPE_ENUM
immutable -repair ./path/to/my.file -t CODE_TYPE_ENUM -c entity -f CODE_TYPE_ENUM
```
## Programmable
When [customizing the immutable stack](https://github.com/Macioa/ImmutableStuff/blob/master/customimmutable.md), a programmable interface can be used to create stored procedures. (see `repair/index.ts`) Use smart code selection as with the command line tools or provide custom regex for code selection.

## CONTROLLED CODE TYPES
```ts
enum TARGETS {
  APPSTATE = "APPSTATE",
  INITIAL_APPSTATE = "INITIAL_APPSTATE",
  GENERIC_APPSTATE = "GENERIC_APPSTATE",

  REDUCER = "REDUCER",
  REDUCER_TEST = "REDUCER_TEST",
  SELECTOR = "SELECTOR",
  SELECTOR_TEST = "SELECTOR_TEST",

  FACTORY = "FACTORY",
  TYPEDEF = "TYPEDEF",

  REQUEST_API = "REQUEST_API",

  API_RESPONSE = "API_RESPONSE",

  SCHEMA = "SCHEMA",
  CONTEXT = "CONTEXT",
  CONTEXT_TEST = "CONTEXT_TEST",
  CONTROLLER = "CONTROLLER",
  JSON_HANDLER = "JSON_HANDLER",
  FALLBACK_CONTROLLER = "FALLBACK_CONTROLLER",

  ROUTER = "ROUTER",
}
```