# Dataflow
## (in Immutable Stack)

Dataflow in the ImmutableStack centers around principles of [determinism](https://github.com/Macioa/ImmutableStuff/blob/master/determinism.md) and [composibility](https://github.com/Macioa/ImmutableStuff/blob/master/composability.md).  

The two primary mechanisms for data transfer in a basic Immutable application are:
<br>

`METHOD - TYPE - PROTOCOL - DEFINITION`
* Request - Half-Duplex - HTTP (TCP) - Router / Controller
* Channel - Full-Duplex - WEBSOCKET (TCP) - Channel Handler

<br><br>

![Immutable Data Flow](https://raw.githubusercontent.com/Macioa/ImmutableStuff/master/dataflow.drawio.svg)

<br><br>

## Back End (Elixir / Phoenix)

Data flow in Phoenix follows a standard MVCC pattern:
* Model - Ecto Schema for data definitios, life cycles, and validations
* View - JSON Handler for standardized responses
* Context - internal API layer
* Controller - Controller or Channel

In controllers, requests first run through the router before the controller. In channels, routing is handled in the channel handler since the connection is maintained between data transfers.

## Front End (React / Redux)

Primary state in Immutable stack is handled through Redux. When used with a Higher Order / Render pattern, the higher order component handles behavior and the render component handles rendering.

![Higher Order Component](https://raw.githubusercontent.com/Macioa/ImmutableStuff/master/higherorder.drawio.svg)

When triggering a request, the higher order component fires the request from the request library and sets the data in global state. The state selector in the render component triggers a re-render with the new data.
```
Higher Order Component
   |
   V
Request (Request API)
   |
   V
Reducer (set state)
   |
   V
Store (global app store)
   |
   V
Selector (select data from global state)
   |
   V
Render Component
```

## Channels
Phoenix channels provide two way communication between the server and client. The client subscribes to a topic, like "chat#17" or "lobby", Then both the client and the server can broadcast messages in the topic or send direct client<=>server messages. Channels have the capacity to hold 'channel state' and share this state with connected nodes, although doing so can limit the scalability of the system. Channels also have built in clustering capabilities providing easy scalability for small to mid-range projects. These features make Phoenix Channels a popular choice for live data feeds.