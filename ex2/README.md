# COMP402 Assignment 2

The aim of this project is to build a new programming language, called pi, using Flex and Bison Tools. The main idea is to create a lexer (flex `.l` file) and a syntax (bison `.y` file) analyzer that will convert pi language to C.

---

Flex is a lexical analyzer, which ensures that the input code comprised of valid vocabulary, identifiers, escape characters and etc. Bison is used to design the syntax rules of the language. By merging the these tools, a new programming language is developed. 

The program runs with two custom example scripts (`correct.pi` and `correct.pi`) by the following terminal commands:
- `make correct1`
- `make correct2`

*note: The input pi program needs to consist of one of the following and with same order shown:*

- *one line of const definitions / main function / one more other function*
- *one line of const definitions / main function*
- *main function / one more other function*
- *just main function*
