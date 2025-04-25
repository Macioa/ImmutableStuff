# Architecture
## (in ImmutableStack)

---

---

## Immutable Stack Architecture

### Back end

Elixir Phoenix provides extensive out-of-the-box tooling for back-end systems. Worker queues, [Server Tasks](https://en.wikipedia.org/wiki/Cron), in-memory storage (like [Redis](https://redis.io/)), and data streams can all be handled out-of-the-box on a single server. Many of these tools have integration with Phoenix clusters, providing easy mid-level scaling.

This, coupled with Elixir's strong language paradigms, make Phoenix a great choice for both IOT and distributed back ends, providing a simple path from a monolithic back end to a distributed system.

For example, I can create a worker queue that runs on my http server. When the worker queue starts pulling too many resources from the server, I can make a slight change to my configuration and split the queue to a dedicated server. If the queue outgrows this server, I can cluster the queue or migrate the task to a cloud worker. The ease with which I can do so is determined by [how I made the worker itself](https://github.com/Macioa/ImmutableStuff/blob/master/composability.md).

### Front end

By default Immutable Stack uses React for a web-centric interface, but the same interface can be extended to mobile using [React Native](https://reactnative.dev/) or desktop using an embedded browser like [chromium](https://www.chromium.org/). At present, the Immutable Stack does not provide automated extensions to these frameworks.

The browser-driven front end makes distribution easy across environments and provides a strong security layer for front-ends.

![single server](https://raw.githubusercontent.com/Macioa/ImmutableStuff/master/singleserver.drawio.svg)

![distributed system](https://raw.githubusercontent.com/Macioa/ImmutableStuff/master/distributed.drawio.svg)

## See also
* [Dataflow in ImmutableStack](https://github.com/Macioa/ImmutableStuff/blob/master/dataflow.md)
* [Composability in ImmutableStack](https://github.com/Macioa/ImmutableStuff/blob/master/composability.md)