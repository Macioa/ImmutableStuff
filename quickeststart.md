# Immutable Stack Docker Quick Start 
The Immutable Stack provides full docker compose support for projects with ready-to-go containers for both dev and production. In addition, Immutable Stack commands are configured with an option to dockerize mix commands, allowing for full app development without local installations for Elixir and Erlang.

## Insta-Demo 
```bash
brew untap macioa/immutable ; \
brew tap macioa/immutable && \
brew install immutable ; \
immutable -settings nomix: true && \
immutable -init my_proj && \
cd my_proj_umbrella && \
immutable -genfile entity && \
immutable -gen .genfile_entity.ts && \
immutable -gen_channel example && \
yarn d.mig
```
Add components to my_app_umbrella/apps/my_app_ui/src/App.tsx anywhere inside <Provider> <Provider/>
```ts
import { EntityDemo } from "@components/Entity"
import ExampleChannel from "@components/ExampleChannel"
```
```ts
//  <PhoenixSocketProvider>
//  <Provider store={MyProjStore}>
//  ...
<EntityDemo/>
<ExampleChannel/>
//  ...
//  </Provider>
//  </PhoenixSocketProvider>
```
Compile, Start Server, Show logs
```bash
yarn d.comp && yarn d.serv && yarn d.logs
```
Navigate to [Open Localhost](http://localhost:4000)


## Setup

### PreReqs
*  hardware virtualization support

### Install

```bash
brew untap macioa/immutable ; \
brew tap macioa/immutable && \
brew install immutable
```

### Install devkit (optional)

```bash
immutable -devkit
```

### Set mix to run in docker (optional)
```bash
immutable -settings nomix: true
```

### Initialize project
Initialize and launch app
```bash
immutable -init my_proj && \
cd my_proj && \
yarn d.up
```

## Generate Entities

### 1. Create genfile
```bash
immutable -genfile my_entity
```

### 2. (Optional) Customize generation
`Cmd + click` terminal output to edit genfile

### 3. Run Genfile
```bash
immutable -gen .genfile_my_entity.ts
```

### 5. Add generated Demo UI Components to 
`my_app_umbrella/apps/my_app_ui/src/app.tsx`
```js
import "./App.css";
import { Provider } from "react-redux";
import { MyAppStore } from "./store";
import { MyEntityDemo } from '@components/my_entity/index';

function App() {
  return <Provider store={MyAppStore}>
        <MyEntityDemo />
      </Provider>
}

export default App;
``` 

### 6. Start services in Docker
```bash
yarn d.up
```

## Immutable Stack Docker convenience scripts
*YARN SCRIPT - Description (non-docker equivalent) (persistance)*
#### APP MAINTENANCE DOCKERIZED
* d.deps -   Fetch node and phoenix dependencies (run mix deps.get in container) (temporary)
* d.comp -   Compile apps (run mix.compile in container) (temporary)
* d.mig -    Run database migrations (run mix ecto.migrate in container) (temporary)
#### APP STARTUP DOCKERIZED
* d.test -   Run tests (run mix test in container) (temporary)
* d.serv -   Run dev container (run iex -S mix phx.server in container) (persistent)
#### SERVICE LOGS
* d.logs -   View docker logs for app containers
#### COMPOSE UTILITIES
* d.build -   build full composition
* d.restart -   restart all services (persistent)
#### BUILD, RUN, STOP, DESTROY CONTAINERS
* d.up -     Start all (all services build + deps, migrations, compile) (persistent)
* d.down -   Stop all services and destroy containers 
#### HOLD OR KILL CONTAINERS
* d.hold -   Run app container without server for debugging (persistent)
* d.kill -   Halt all services, no clean up
#### PRODUCTION BUILD
* p.build -  Build production docker image
* p.hold -   Run production container without server for debugging (persistent)

