# Simple Word Parser

The goal of this is to show basic parsing of a word-based "language".
This is based partly on the [following tutorial](https://begriffs.com/posts/2021-11-28-practical-parsing.html),
which goes much deeper into the modern versions of flex and bison.

This handles the "GO" command in the basic form of `GO ring of fire` or 
`GO TO ring of fire`, and it extracts the location which is a phrase
consisting of any number of words.

The trickiness in using C involves managing the limitations of C's memory scheme
while parsing. One of these issues that would arise is with stack-allocated strings. 
For this reason, the sdsnew call is performed to allocate the string on the heap. 
This uses the [sds library](https://github.com/antirez/sds), which is a rather nice
library for manipulating strings in C. If you'd prefer to not use this library, you
could probably use the `strdup` function instead. 

Another limitation of the C's memory scheme is that there are no resizable arrays
in the core language. As a result, 
this means we must define patterns recursively. For example, in 
the `phrase` pattern (`words.y:55`), we wish to match any number of words and 
represent them as a list. Of course, C has no list type and since we don't know
how much memory will be taken beforehand, we will use a linked list. We can think
of the pattern as a recursion with the "base" case being the line with the simple
match `: WORD`. Since this is the base case, then we must create the linked list.
In the recursive case (line 57), we match `| phrase WORD`. Since phrase is represented
by a list, then we know that this list already exists, so we simply append the next
word to it. 

Note: the linked list library I am using is [utlist](https://troydhanson.github.io/uthash/utlist.html), 
which is also what chiventure uses.