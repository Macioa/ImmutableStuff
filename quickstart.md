# Immutable Stack Quick Start

## Setup

### PreReqs
* MacOs

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

### Initialize project
Initialize and install dependencies
```
immutable -init my_proj && \
cd my_proj && \
mix deps.get
```
Ensure database is available, Check database connection details in `my_proj/config/dev.exs` and Run database migrations
```
mix ecto.migrate
```
Start server
```
IEx -S mix phx.server
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

### 4. Check and run database migrations
my_app_umbrella/apps/my_app/priv/repo/migrations
```
mix ecto.migrate
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

### 6. Start server with interactive shell and launch app
```
IEx -S mix phx.server
```
and navigate to
```
http://localhost:4000/
```

## Custom Immutable Build

## 1. Create a custom code base
Clone Immutable and Immutable-homebrew repositories. 
```
git clone https://github.com/Macioa/ImmutableStack && \
git clone https://github.com/Macioa/homebrew-immutable

```
## 2. Create or update generators
Alter Immatable source code directly or generate literals from existing code with
```
immutable -gentemplate my_entity my_folder/myfile.ex
```
## 4. Package source and move to homebrew-immutable
From Immutable Source root
```
cd ImmutableStack && \
npm install && npm run build && \
cd .build && tar -czvf CustomImmutableStack.tar.gz -C . . && \
mv CustomImmutableStack.tar.gz ../homebrew-immutable
```
## 5. Update homebrew-immutable/immutable.rb declaration
Change source url and remove sha256
```ruby
    url "file://#{File.expand_path("CustomImmutableStack.tar.gz", __dir__)}"
    # sha256 "88b621cffba66e524a54dfa21b890e36f39acf9f39c5f2c8b9f6f68df23c8048"
```
## 6. Reinstall Immutable
```
cd homebrew-immutable && \
brew reinstall --build-from-source immutable.rb
```