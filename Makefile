BIN = words
CC = gcc
BISON = bison
CFLAGS = -Wall -I.
FLEX = flex
RM = rm -f

words: words_parse words_lex
	$(CC) $(LDFLAGS) $(CFLAGS) -o words words.c sds/sds.c out/words.tab.c out/words.yy.c -lm

words_parse: words.y
	$(BISON) -d -o out/words.tab.c words.y

words_lex: words.l
	$(FLEX) -o out/words.yy.c words.l

clean:
	$(RM) out/* $(BIN)

.PHONY: words clean
