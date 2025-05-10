# Immutable Stack Docker Quick Start 
The Immutable Stack provides full docker compose support for projects with ready-to-go containers for both dev and production. In addition, Immutable Stack commands are configured with an option to dockerize mix commands, allowing for full app development without local installations for Elixir and Erlang.

*All commands are executed from project root*

## Setup

### PreReqs
*  hardware virtualization support

### Install

```
brew untap macioa/immutable ; \
brew tap macioa/immutable && \
brew install immutable
```

### Install devkit (optional)

```
immutable -devkit
```

### Set mix to run in docker (optional)
```
immutable -settings nomix: true
```

### Initialize project
Initialize and launch app
```
immutable -init my_proj && \
cd my_proj && \
yarn d.up
```

## Generate Entities

### 1. Create genfile
```
immutable -genfile my_entity
```

### 2. (Optional) Customize generation
`Cmd + click` terminal output to edit genfile

### 3. Run Genfile
```
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
```
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
* d.build -   build full composition (temporary)
* d.restart -   restart all services (persistent)
#### BUILD, RUN, STOP, DESTROY CONTAINERS
* d.up -     Start all (all services build + deps, migrations, compile) (persistent)
* d.down -   Stop all services and destroy containers 
#### HOLD OR KILL CONTAINERS
* d.hold -   Run app container without server for debugging (persistent)
* d.kill -   Stop all services, no clean up
#### PRODUCTION BUILD
* p.build -  Build production docker image
* p.hold -   Run production container without server for debugging (persistent)

