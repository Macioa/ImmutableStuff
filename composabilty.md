# Composability
## (in software)

---

![masked man photo](https://raw.githubusercontent.com/Macioa/MinCurryPipe/main/_logo_adjusted.png)

---
## **What is composability in software?**

[Software Composability](https://en.wikipedia.org/wiki/Composability) is the degree to which components of a software can be rearranged without additional process edits. There are a number of programming techniques across many different programming paradigms that can contribute to the composability of the software, but the most composable systems are usually [**stateless** and **deterministic**](https://github.com/Macioa/ImmutableStuff/blob/master/determinism.md) and adhere to strict principles of [modular design](https://en.wikipedia.org/wiki/Modular_design).

### Composability example
```elixir
users = User
|> active()
|> with_role("admin")
|> Repo.all()
```
```elixir
users = User
|> active()
|> Repo.all()
|> IO.inspect(label: :active_users)
```
*Functions like Composable Ecto queries and Elixir's inspect can be 'popped' on and off of a pipe without modification of surrounding code*

## Ok... But how to make car?

I don't know of any language or framework that offers guaranteed high composability out of the box. Nearly all development tooling makes some attempt to achieve this type of system. The systems that rank the highest in this regard tend to combine system tooling with idioms or guidelines. 

Most techniques for highly composable systems center heavily on building small, focused, atomic units. This is a recurring concept in many forms of system design. In software, author [Bob Martin](https://en.wikipedia.org/wiki/Robert_C._Martin) has coined this as the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single-responsibility_principle). It is also commonly referred to as [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns). By isolating or [decoupling](https://en.wikipedia.org/wiki/Loose_coupling) the unique tasks a function performs, we improve its [apparent determinism](https://github.com/Macioa/ImmutableStuff/blob/master/determinism.md) and reduce the likelihood of [side-effects](<https://en.wikipedia.org/wiki/Side_effect_(computer_science)>). As a bonus, with the right design patterns, we can gain composability — we make it easy to rearrange at both microscopic and macroscopic levels.

Computer Scientist, [Barbara Liskov](https://en.wikipedia.org/wiki/Barbara_Liskov), provides a formal method to validate this "[behavioral correctness](https://en.wikipedia.org/wiki/Behavioral_subtyping)" with the [Liskov Substitution Principle](https://en.wikipedia.org/wiki/Liskov_substitution_principle). In short, we design subtypes so they can fully replace their parent types without altering the program’s "correct" behavior.

Techniques like [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection) can help us achieve this correctness without code redundancy by separating what code does from what it needs.

[Pipelining](https://en.wikipedia.org/wiki/Pipeline_(computing)) is another good example of a programming technique that improves composability. When implemented at a system level or coupled with techniques like [currying](https://en.wikipedia.org/wiki/Currying), pipelining passes the result of one function directly into the next function. When performed with interfaces designed for pipelining, pipelines become a great example of composable code *(see elixir example above)*, allowing simple code changes for simple process changes.

## Composability in Elixir

Elixir is a functional programming language with built-in implicit pipelining so it provides high composability inherently. We can use design patterns like the pipeline pattern described above to improve that composability further.

[Pattern Matching](https://en.wikipedia.org/wiki/Pattern_matching) and [guard clauses](https://hexdocs.pm/elixir/main/patterns-and-guards.html) in Elixir can also be used to improve the specificity of our functions by separating edge cases and error handling from our primary function specification.

```elixir
  def fib(n) when n >= 0, 
    do: fibp(n, 0, 1)

  defp fibp(0, a, _b), 
    do: a
  defp fibp(n, a, b) when n > 0, 
    do: fibp(n - 1, b, a + b)
```
*Fibonacci Pattern in Elixir - [Pattern Matching](https://en.wikipedia.org/wiki/Pattern_matching), [guard clauses](https://hexdocs.pm/elixir/main/patterns-and-guards.html), and [Tail Call Optimization](https://en.wikipedia.org/wiki/Tail_call_optimization) allow us to break this sequence down into its most atomic level while maintaining O(1) [spatial complexity](https://en.wikipedia.org/wiki/Space_complexity).*

## Composability in React / Redux

Like most UI development frameworks, React offers a reusable component system that offers some degree of composability out of the box. It has functional paradigms that allow the creation of [deterministic render components](https://github.com/Macioa/ImmutableStuff/blob/master/determinism.md), a key ingredient for our composable front end.
```tsx
function UserRender({ name, email }: User {
  return (
    <div>
      <h2>{name}</h2>
      <p>{email}</p>
    </div>
  );
}
```
*Example Render Component in React. We [deconstruct](https://en.wikipedia.org/wiki/Assignment_(computer_science)) the name and email properties from a user and provide an HTML definition for them*

Redux substantially increases the composability of React, particularly when used with [Higher Order](https://en.wikipedia.org/wiki/Higher-order_function) / Render patterns. When designed in this manner our front-end architecture starts to mirror our back-end [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) pattern:
```
        FRONT                    BACK
Higher Order Component         Controller
          |                       |
          V                       V
  Render Component               View
```
<br>

![higher order and render components](https://raw.githubusercontent.com/Macioa/ImmutableStuff/master/higherorder.drawio.svg)
<br><br>

*Higher order patterns provide high separation of concerns. In a basic example, in order to render a User, we must fetch the user data, set the user's data in state, then retrieve and render the data.*

<br><br>
In this pattern we break each task into an atomic function:
* fetching - Request Library Function
* set/retrieve state - Redux Reducers / Selectors
* render - Render Component

Then we can *compose* these tasks to create our Higher Order Component. We can combine a form of [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) with [javascript pipelining](https://github.com/Macioa/MinCurryPipe) to maximize our composability, turning the UserComponent into a thin routing layer.
```tsx
<UserComponent
    onInit={
      pipe(
        userParams,
        FetchUser,
        SetUser(dispatch)
    )}

    userSelector={ SelectUser }

    renderComponent={ UserRender }
/>
```
<br>

 *In this example, the custom-made [Higher Order](https://en.wikipedia.org/wiki/Higher-order_function) **UserComponent** is designed to maximize composability and customization. The [imperative process](https://en.wikipedia.org/wiki/Imperative_programming) is described with concise [pipelining](https://github.com/Macioa/MinCurryPipe) patterns. The tasks this component performs achieve advanced [decoupling](https://en.wikipedia.org/wiki/Loose_coupling) through [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) and pipeline design patterns. We don't need to see the definition of UserComponent to understand or alter its behavior. Any aspect of this component's behavior can be swapped without further code edits. Atomic elements can be recomposed to quickly create new components. In addition, we provide clean separation between our [imperative](https://en.wikipedia.org/wiki/Imperative_programming) and [declarative](https://en.wikipedia.org/wiki/Declarative_programming) code*