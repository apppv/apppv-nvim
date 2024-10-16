; extends

(("not" @keyword.operator) (#set! conceal "!"))
(("continue" @keyword) (#set! conceal "C"))
(("import" @include) (#set! conceal "i"))
(("pass" @keyword) (#set! conceal "P"))
(("elif" @conditional) (#set! conceal "e"))
(("def" @keyword.function) (#set! conceal "f"))
(("while" @repeat) (#set! conceal "W"))
(("assert" @keyword) (#set! conceal "?"))
((call function: (identifier) @function.builtin (#eq? @function.builtin "print")) (#set! conceal "p"))
(("with" @keyword) (#set! conceal "w"))
(("and" @keyword.operator) (#set! conceal "&"))
(("break" @keyword) (#set! conceal "B"))
(("class" @keyword) (#set! conceal "c"))
(("else" @conditional) (#set! conceal "e"))
(("global" @keyword) (#set! conceal "G"))
(("or" @keyword.operator) (#set! conceal "|"))
(("yield" @keyword) (#set! conceal "Y"))
(("for" @repeat) (#set! conceal "F"))
(("del" @keyword) (#set! conceal "D"))
(("lambda" @include) (#set! conceal "λ"))
(("if" @conditional) (#set! conceal "?"))
((yield ("from") @keyword) (#set! conceal "F"))
((import_from_statement ("from") @include) (#set! conceal "f"))
(("return" @keyword) (#set! conceal "R"))

; Module docstring
(module . (expression_statement (string) @comment))

; Class docstring
(class_definition
  body: (block . (expression_statement (string) @comment)))

; Function/method docstring
(function_definition
  body: (block . (expression_statement (string) @comment)))

; Attribute docstring
((expression_statement (assignment)) . (expression_statement (string) @comment))

