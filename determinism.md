# Determinism vs Apparent Determinism
## (and their relevance in software)

### What is determinism?
The term "deterministic" applies to any process that, when given the exact same conditions, yields the exact same result. The concept is very relevant in the following areas:
* Mathematics/Physics
* Engineering
* Computer Science
* Time travel science fiction

When working in software, everything we do falls into this category. Even your AI chatbot, which could potentially respond with a different answer when asked the same question, is still classified as deterministic. If you were to use the exact same code, trained exactly the way, with exactly the same prompts, it would provide the same result. A deterministic process whose output changes based on the order of inputs is called "non-commutative".

### What is apparent determinism?
"Apparent determinism", or "epistemic determinism," is a relative term that applies to any process that, when given the exact same conditions, yields the exact same result **within reason**. The best example of this type of determinism would be in dice. Dice are generally used as random number generators, yet their behavior is driven solely by the deterministic laws of Newtonian physics. The apparent randomness is a result of what is commonly referred to "the butterfly effect", in which a minor deviation propogates a much larger deviation. Therefore, dice can be classified as both "deterministic" and "apparently non-deterministic"

Not all software falls into the category of apparent-determinism. The manner in which we write our code and the tools we use to do so determine whether our software will behave in this manner. 

Is your code deterministic? How sure are you? Can you *prove* it? (HINT - This cannot be proven with unit tests. Unit tests can prove that a specific input will provide a specific output under specific circumstances, but unless you want to provide a unit test for every possible input in all possible conditions, a proof by "transitive" properties is required. This type of proof can only be rationally applied to code that is *deterministic*)

**Example of non-deterministic code in JS**
```js
const myMap = { value: 1 };

const SideEffectFn = (map) => {
  map.value += 1;
  return map.value;
};
const MyFn = async (map) => {
  await new Promise((resolve) => setTimeout(resolve, 1000));
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
*In this example the combination of a "reference" and a "race condition" create a function whose ouput is altered by external code.*

In Functional Programming, external influences like this are referred to as "Side Effects". Most Object Oriented Programming languages and many Functional Programming languages allow for non-determistic code, but Functional Programming languages often include mechanisms to discourage or restrict these "side-effects". The degree to which they've done so can be called "Functional Purity". 