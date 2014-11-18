Heresy
======

Heresy is a BASIC-inspired functional dialect of Lisp, currently implemented as a Racket language that can be loaded by ``#lang s-exp``.

Basic Lisp primitives are provided, including a basic DEF MACRO, as well as BASIC-like control structures and definition syntax. The intention is to provide a dialect of Lisp with a more familiar BASIC-inspired naming scheme, for those coming from that school. It also serves as a playground for experimenting with how to program without mutable variables, and exploring how traditional imperative control structures like loops might otherwise prove useful in such an environment.

This was primarily written as a learning exercise for practicing Racket macrology and thinking more functionally as a programmer. Future wishlist: more of the Basic and Lisp standard library, structs, pattern-matching/guards

Some more thoughts on Heresy's general philosophy can be found here: http://jarcane.github.io/blog/2014/11/18/so-i-made-a-programming-language-now-what.html

The code Copyright 2014 by John S. Berry III, and is licensed via the LGPL v3.

Installation
------------

To install:

``raco pkg install git://github.com/jarcane/heresy``

To use, append this to the start of your file in DrRacket or your favorite text-editor:

``#lang s-exp heresy``

Quick Reference
---------------

### Declarations ###

```
(let ((*name* *value*) ...) *body* ...)
Defines local variables, to be used in subsequent code.

(def *name* *contents*)
(def fn *name* (*args* ...) *body* ...)
(def macro *name* (*pattern-vars* ...) *pattern* ...)
Defines new variables, functions, and macros

(fn (*args* ...) *body* ...)
The anonymous function
```

### Flow control ###

```
(if *test* then *do1* else *do2*)
(if *test* then *do1*)
Basic conditional execution block

(select [*test* *op1*] ... [else *opn*])
(select case *test* [*test-result* *op1*] ... [else *opn*])
Multiple conditional block: COND-style, or CASE style with CASE.

(do *body* ...)
Executes its body in order (eqv. to begin). Returns result of last function evaluated.

(do loop *body* ...)
executes a block of code, looping continuously, or until it encounters a BREAK. 
Returns last value of cry (see below).

(for (*var* over *list*) *body* ...)
Iterates over list, holding current item in var. Exits once it reaches the end of the list.
Returns last value of cry (see below).

cry
do and for contain a "hidden" argument which is passed at each iteration named cry.
This can be used with carry to pass a value on to the next iteration.

(carry *value*)
Passes the value to cry for the next iteration of the loop. Supported by do and for.

(break [value])
Breaks execution of the current loop, optionally returning a single value
```

### I/O ###

```
(print *datum*)
Print datum with new line (akin to Racket displayln)

(print & *datum*)
Print datum without new line (akin to display)

(print lit *datum*)
Print literal form of datum such that it can be read by *input stx* (akin to write)

(input [*str*])
Accepts input as text and returns it (akin to read-line)
Adding a *str* causes it to output a text prompt first

(input stx)
Takes input as syntax and returns it (akin to read)
```

### Lists and Atoms ###

```
(list a ...)
Returns a list containing a ...

(join *a b*)
Joins two atoms into a pair, creating a list of second atom is another pair or null

(head *list*)
Returns the left item in a pair (the head of a list)

(tail *list*)
Returns the right item of a pair (the tail of a list)

(list? *list*)
Returns true (#t) if item is a list

(null? *list*)
Returns true if item is the empty list '()

(atom? *list*)
Returns true if item is an atom

(eq? *list*)
Returns true if atoms are the same

(lat? *list*)
Returns true if list is composed only of atoms (rather than other lists)

Null
Alternate alias for the empty list '()
```

### Math ###

```
(zero? *num*)
Returns true if zero

(= *a b* ...)
(< a b ...)
(> a b ...)
Returns true if all provided values pass test

(+ *a b* ...)
(- *a b* ...)
(* *a b* ...)
(/ *a b* ...)
(^ *a b*)
Math operators

(! *a fun b*)
Infix operator, allows *fun* to be used infix in this level only 

(range x to y [step s])
Returns a list of numbers from x to y, stepping by step (defaults to 1)
Note: Descending lists must be created with negative step value, otherwise it will return an empty list
```

### Strings ###

```
(=$ *str* ...)
Compares strings for equality

(& *str* ...)
Concats strings

(list$ list)
Converts a string into a list of single character strings
```

### Logic ###

```
(and *a b* ...)
(or *a b* ...)
(not *a*)
Boolean operators

True, False
Alternate syntax for #t and #f
```

### Meta ###

```
(quote *datum*)
Returns datum as data instead of evaluating (can be shortened to ')

(run *form*)
Evaluates and executes the given form.

(rem ...)
Ignores its contents, evaluates to void
```
