BIN = calc
CC = gcc
BISON = bison
CFLAGS = -Wall -I.
LDFLAGS="-L/usr/local/opt/flex/lib"
FLEX = flex
RM = rm -f

calc: calc_parse calc_lex
	$(CC) $(LDFLAGS) $(CFLAGS) -o calc calculate.c out/calc.tab.c out/calc.yy.c -lfl -lm

calc_parse: calc.y
	$(BISON) -d -o out/calc.tab.c calc.y

calc_lex: calc.l
	$(FLEX) -o out/calc.yy.c calc.l

clean:
	$(RM) out/* $(BIN)

.PHONY: calc clean
