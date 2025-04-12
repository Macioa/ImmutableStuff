# Determinism vs Apparent Determinism

## (and their relevance in software)

---

### **What is determinism?**

The term "[**deterministic**](https://en.wikipedia.org/wiki/Deterministic_system)" applies to any process that, when given the exact same conditions, yields the exact same result. The concept is very relevant in the following areas:

- **Mathematics/Physics**
- **Engineering**
- **Computer Science**
- **Philosophy**
- **Time travel science fiction**

When working in software, everything we do falls into this category. Even your AI chatbot, which could potentially respond with a different answer when asked the same question, is still classified as deterministic. If you were to use the exact same code, trained exactly the way, with exactly the same prompts, it would provide the same result. A deterministic process whose output changes based on the order of inputs is called "[**non-commutative**](https://en.wikipedia.org/wiki/Noncommutative_property)".

---

### **What is apparent determinism?**

"**Apparent determinism**" is a relative term that applies to any process that, when given the exact same conditions, yields the exact same result **within reason**. The best example of this type of determinism would be in **dice**. Dice are generally used as random number generators, yet their behavior is driven solely by the deterministic laws of Newtonian physics. The apparent randomness is a result of what is commonly referred to as the "[**butterfly effect**](https://en.wikipedia.org/wiki/Butterfly_effect)", in which a minor deviation propagates a much larger deviation. Therefore, dice can be classified as both "[**deterministic**](https://en.wikipedia.org/wiki/Deterministic_system)" and "**apparently non-deterministic**".

Not all software falls into the category of apparent-determinism. The manner in which we write our code and the tools we use to do so determine whether our software will behave in a predictable manner.

---

### **Relevance in software**

**Systems that permit non-deterministic code can lead to severe and unpredictable failures.** Bugs produced in this manner are some of the hardest to trace. Dependable systems rely on a rational and transactional state exchange.

```text
LAST_STATE => change(state) => NEW_STATE
```

_Is your code deterministic? How sure are you? Can you **prove** it?_  
(HINT – This cannot be proven with unit tests. Unit tests can prove that a specific input will provide a specific output under specific circumstances, but unless you want to provide a unit test for every possible input in all possible conditions, a proof by "**transitive**" properties is required. This type of proof can only be rationally applied to **deterministic** systems.)

---

### **Example of non-deterministic code in JS**

```js
// Create object to use as reference
const myMap = { value: 1 };

const SideEffectFn = (map) => {
  map.value += 1;
  return map.value;
};
const MyFn = async (map) => {
  // delay 1 millisecond
  await new Promise((resolve) => setTimeout(resolve, 1));
  // execute after 1 millisecond
  map.value += 1;
  return map;
};

const Main = async () => {
  // MyFn(myMap) is called twice with the same input but yields different behavior
  const R1 = MyFn(myMap);
  console.log(await R1);
  // (1 + 1) = 2

  const R2 = MyFn(myMap);
  SideEffectFn(myMap);
  console.log(await R2);
  // (2 + 1) = 4      !?!?!?
};

Main();
```

_In this example the combination of a "[**reference**](<https://en.wikipedia.org/wiki/Reference_(computer_science)>)" and a "[**race condition**](https://en.wikipedia.org/wiki/Race_condition)" create a function whose output is altered by external code. While it's easy to spot this the offending function in this simple example, it can be very difficult to find in complex systems._

In **[Functional Programming](https://en.wikipedia.org/wiki/Functional_programming)**, external or out-of-scope influences like this are referred to as "[**side effects**](<https://en.wikipedia.org/wiki/Side_effect_(computer_science)>)". Most Object Oriented Programming languages and many [Functional Programming](https://en.wikipedia.org/wiki/Functional_programming) languages allow for non-deterministic code, but [Functional Programming](https://en.wikipedia.org/wiki/Functional_programming) languages often include mechanisms to discourage or restrict these "[**side effects**](<https://en.wikipedia.org/wiki/Side_effect_(computer_science)>)". The degree to which they've done so can be called "[**functional purity**](https://en.wikipedia.org/wiki/Pure_function)".

In systems with high "[**functional purity**](https://en.wikipedia.org/wiki/Pure_function)" we can use mathematical proofs to verify outcomes. This process is called "[**formal verification**](https://en.wikipedia.org/wiki/Formal_verification)". This technique has been used by companies since the early 90's but has been fairly contained in usage due to the complexity, cost, and effort involved. But this could change in the future as we brace for the possibility of AI taking over this task.

If you want to see an example of this, or, if you want to better understand the relationship between mathematics and your software, I highly recommend the interactive book series [**Software Foundations**](https://softwarefoundations.cis.upenn.edu/) by [**Benjamin Pierce**](https://www.cis.upenn.edu/~bcpierce/). Download the [**ROCQ IDE**](https://rocq-prover.org/) and create an entire programming language from scratch, using mathematical proofs.

---

### **Determinism in [React](<https://en.wikipedia.org/wiki/React_(software)>) / [Redux](<https://en.wikipedia.org/wiki/Redux_(JavaScript_library)>) (front end)**

[React](<https://en.wikipedia.org/wiki/React_(software)>) and [Redux](<https://en.wikipedia.org/wiki/Redux_(JavaScript_library)>) are implemented in JavaScript, a multi-paradigm language, so they are not purely functional by nature.

In **[React](<https://en.wikipedia.org/wiki/React_(software)>)**, UI components are expressed as functions. They receive an input and render html using that input. [React](<https://en.wikipedia.org/wiki/React_(software)>) functions re-execute when their inputs change, producing a new output; otherwise, the previous output is reused, ensuring consistent rendering behavior based on input. This creates a deterministic system for _rendering_ data.

In **[Redux](<https://en.wikipedia.org/wiki/Redux_(JavaScript_library)>)**, application state is saved in a central store. Formal getter and setter functions are provided to interact with the store. These formal functions automatically sever references and protect the centralized state so that if you were to write the SideEffectFn shown above into your code, the side effect would not apply to the state tree. This functional pattern enforces immutability by design, ensures predictability, eliminates unintended side effects, and makes state transitions explicit, traceable, and testable.

```text
LAST_STATE => change(state) => NEW_STATE
```

There are many powerful impacts that this has on our system. Using a browser extension, we can not only see the present state, view the history of state changes, or alter any aspect of the state. This makes tracing and debugging your front end easy and rational.

---

### **Determinism in [Elixir](<https://en.wikipedia.org/wiki/Elixir_(programming_language)>)/Phoenix (back end)**

Billed as a [Functional Programming](https://en.wikipedia.org/wiki/Functional_programming) language, determinism is central to **[Elixir](<https://en.wikipedia.org/wiki/Elixir_(programming_language)>)**. [Elixir](<https://en.wikipedia.org/wiki/Elixir_(programming_language)>) is designed around principles that naturally promote predictable behavior — **immutability**, **referential transparency**, and **process isolation**. While it remains highly accessible and practical for business applications, its concurrency model (built on the **BEAM VM**) avoids the typical pitfalls of shared state and race conditions. In [Elixir](<https://en.wikipedia.org/wiki/Elixir_(programming_language)>), writing deterministic code isn’t a best practice you have to enforce — it’s the default behavior, and breaking that determinism usually requires intentional effort.
