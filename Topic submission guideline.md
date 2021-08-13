# Topic submission guideline

## Outline
To propose a new benchmark topic, please follow the outline below:

#### Title

Topic name or a benchmark title.

#### Programming languages

What languages would you like to test? 

#### Motivation 

Why should the proposed benchmark be tested? Any questions you hope find answers to by viewing benchmark results?

#### Benchmark criteria 

What is the focus here, test criteria, key moments, concepts, etc...

#### Implementation

Please provide an implementation(s) in any of the following languages (copy&paste the code or link):
* C
* C++
* D
* Java
* Python
* R

You may provide an implementation in a language not mentioned here, but I may not understand it, thus, I won't be able to translate it to other langauges. For example, a Rust implementation might be difficult to understand (it's very cryptic sometimes).

## Example

#### Title

Fisher's Exact Test (FET) Benchmark

#### Programming languages 

C, C++, D, Rust, Python, R

#### Motivation

The purpose of this benchmark is to find how quickly various compiled programming languages are able to perform compared to Python and R library implementations. I would like to examine, whether the performance gains achieved by rewriting the Python/R code in a compiled language is worth the time and effort required for such a task. In addition, I'm just curious what would be the results, what language attains the best result.  

#### Benchmark criteria 

* execution time (sec)
* memory consumption (kb)
* binary size (kb)
* conciseness of a programming language (lines of code)

#### Implementation

* [C](fishers-exact-test/c/cfet.c)
* ...



