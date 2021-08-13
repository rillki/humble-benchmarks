# Topic submission guideline

## Outline
To propose a new benchmark topic, please follow the outline below:

1. Title
Topic name or a benchmark title.

2. Programming languages
What languages would you like to test? 

3. Motivation 
Why should the proposed benchmark be tested? You personal motives? Questions you hope find answers to by viewing benchmark results?

4. Benchmark criteria 
What is the focus here, test criteria, key moments, concepts, etc...

5. Implementation
Please provide an implementation(s) in any of the following languages (copy&paste the code or link):
* C
* C++
* D
* Java
* Python
* R

You may provide an implementation in a language not mentioned here, but I may not understand it, thus, I won't be able to translate it to other langauges. For example, a Rust implementation might be difficult to understand (it's very cryptic sometimes).

## Example

1. Title
Fisher's Exact Test (FET) Benchmark

2. Programming languages 
C, C++, D, Rust, Python, R

3. Motivation
The purpose of this benchmark is to find how quickly various compiled programming languages are able to perform compared to Python and R library implementations. I would like to examine, whether the performance gains achieved by rewriting the Python/R code in a compiled language is worth the time and effort required for such a task. In addition, I'm just curious what would be the results, what language attains the best result.  

4. Benchmark criteria 
* execution time (sec)
* memory consumption (kb)
* binary size (kb)
* conciseness of a programming language (lines of code)

5. Implementation
* [C](fishers-exact-test/c/cfet.c)
* ...



