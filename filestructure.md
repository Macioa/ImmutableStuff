# Immutable Stack File Structure

The Immutable Stack is generated with Phoenix's umbrella app generator. Code is divided into three categories in the app folder. Additional services can be added as a new 'app' here
* Domain Libraries (80%)
* Thin Server Declaration (10%)
* Thin Client Declaration (10%)
<br><br>
![general file structure diagram](https://raw.githubusercontent.com/Macioa/ImmutableStuff/master/filestructure.drawio.svg)

## Notable back end folders:
* **database migrations** - `my_app_umbrella/apps/my_app/priv/repo/migrations` - Table definitions
* **schemas** - `my_app_umbrella/apps/my_app/lib/my_app` - Model definitions
* **context apis** - `my_app_umbrella/apps/my_app/lib` - Domain Entity APIS

## Notable back end files:
* **Mix.Exs** - `my_app_umbrella/mix.exs` - Phoenix project definition, deps, and compilation (similar to package.json) 
* **Application.ex**
  - `my_app_umbrella/apps/my_app/lib/my_app/application.ex` - Startup and supervision tree for library
  - `my_app_umbrella/apps/my_app_web/lib/my_app_web/application.ex` - Startup and supervision tree for webapp
* **Endpoint.Exs** - `my_app_umbrella/apps/my_app_web/lib/my_app_web/endpoint.ex` - Server connection handling
* **Router.ex** - `my_app_umbrella/apps/my_app_web/lib/my_app_web/router.ex` - Server request routing

## Notable front end folders:
* **reusable components** - `my_app_umbrella/apps/my_app/lib/typescript/components` - Render components, Higher Order components
* **reusable state** - `my_app_umbrella/apps/my_app/lib/typescript/state` - Types, Factories, State Reducers and Selectors
* **request api** - `my_app_umbrella/apps/my_app/lib/typescript/components` - Requests


## Notable front end files:
* **package.json** - `my_app_umbrella/apps/my_app_ui/package.json` - UI Package declaration (similar to mix.exs)
* **App.ts** - `my_app_umbrella/apps/my_app_ui/src/App.tsx` - UI App declaration
* **Store** - `my_app_umbrella/apps/my_app_ui/src/store/index.ts` - Redux Global App State declaration