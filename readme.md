# Bison/Flex Calculator

This is a calculator written in c that uses the bison parser and flex lexer. To
create it, first make an "out" directory at the base of the repository 
(`mkdir out`), and then run `make calc.` To delete the generated files run `make clean`.
Use `./calc` to run the calculator. Notice that the imports are written so that
the functions used by the calculator are specified in a different file than the 
grammar. The chiventure cli++ code should probably be similar to this so that you 
can write more complex functions similar to the fibonacci one in this example.

To compare it to a set of test cases, run `make calc && ./calc < test_exps.txt | diff -y test_expectation.txt -`

## Next Steps (cli team)
Follow this [stackoverflow response](https://stackoverflow.com/questions/39133560/how-to-parse-a-c-string-with-bison) 
to parse input from strings rather than only the command line (to allow for 
easier and repeatable testing).

## Issues
it evaluates from right to left, so there are errors with integer division.
