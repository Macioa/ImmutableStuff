```ts
interface ImmutableGlobal
  extends GenType<{
//    * Frog * 
    example1: integer;
    example2: string;
    example3: float;
  }> {}

interface AppState
  extends GenType<{
    frog: Frog | null;
    frogs: Frog[];
  }> {}
const Immutable: ImmutableGenerator = {
  name: "frog",
  generate: {
    // BACK END
    http_controller: {
      name: "FrogController",
      routes: [
        "routed_index(conn, entity_queries, page_queries) when entity_queries == %{}",
        "routed_index(conn, entity_queries, page_queries) when entity_queries != %{}",
        "create(conn, frog_list) when is_list(frog_list)",
        "create(conn, frog_params)",
        "show(conn, frog_list) when is_list(frog_list)",
        'show(conn, %{"id" => id})',
        "update(conn, frog_list) when is_list(frog_list)",
        "update(conn, frog_params) when is_map(frog_params)",
        "delete(conn, frog_list) when is_list(frog_list)",
        'delete(conn, %{"id" => id})',
        // "custom_route(conn, %{destructured: params})"
      ],
    },
    channel_controller: "frog_channel",
    context: {
      name: "FrogContext",
      apiFunctions: [
        "create_frog(attrs) when is_list(attrs)",
        "create_frog(frog_params) when is_map(frog_params)",
        "delete_frog(frogs) when is_list(frogs)",
        "delete_frog(frog_params) when is_map(frog_params)",
        "delete_frog(id) when is_binary(id)",
        "get_frog!(frogs) when is_list(frogs)",
        "get_frog!(frog_params) when is_map(frog_params)",
        "get_frog!(id) when is_binary(id)",
        "list_frogs(page_query \ %{})",
        "list_frogs_by(entity_queries, page_queries \ %{})",
        "update_frog(frogs) when is_list(frogs)",
        "update_frog(attrs) when is_map(attrs)",
        // "custom_api_function(${key: _value}) when is_binary('guard_clause')",
      ],
    },
    schema: "Frog",
    databaseTable: "frogs",

    // FRONT END
    requests: {
      requestFunctions: [
        "requestFrog = (frogs: Frog[], dispatch: Dispatch)",
        "createFrog = (frogs: Frog[], dispatch: Dispatch)",
        "updateFrog = (frog: Frog[], dispatch: Dispatch)",
        "deleteFrog = (frog: Frog[], dispatch: Dispatch)",
        // "customRequest = (%{key: _value}, dispatch: Dispatch)",
      ],
    },
    stateSlice: {
      name: "frogSlice",
      reducers: [
        "setFrog = (state, action)",
        "setFrogs = (state, action)",
        // "customReducer = (state, {payload: {key: _value}})",
      ],
      selectors: [
        "selectFrog = (state)",
        "selectFrogs = (state)",
        // "customSelector = (%{key: _value})",
      ],
    },
    appstate: "FrogStoreState",
    tstype: "Frog",
    factory: true,
    demoComponents: true,
    test: true,
  },
};