# Bison/Flex Calculator

This is a calculator written in c that uses the bison parser and flex lexer. To
create it, run `make calc` and to delete the generated files run `make clean`.

To compare it to a set of test cases, run `make calc && ./calc < test_exps.txt | diff -y test_expectation.txt -`


## Issues
it evaluates from right to left, so there are errors with integer division

link: https://replit.com/@JackNugent/BisonFlex-Calculator#calc.l
