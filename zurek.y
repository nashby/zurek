/* Polish notation calculator. */

%{
  #define YYSTYPE double
  #include <stdio.h>
  #include <math.h>
%}

%token NUM

%%
input: /* empty */
  | input line
;

line: '\n'
  | exp '\n'  { printf ("= %.10g\n", $1); }
;

exp: NUM { $$ = $1; }
  | '+' exp exp { $$ = $2 + $3;      }
  | '-' exp exp { $$ = $2 - $3;      }
  | '*' exp exp { $$ = $2 * $3;      }
  | '/' exp exp { $$ = $2 / $3;      }
  | '^' exp exp { $$ = pow($2, $3);  }
  | 'n' exp     { $$ = -$2;          }
;
%%

#include <ctype.h>
#include <stdlib.h>

yylex()
{
  int expression;

  /* skip white space */
  while ((expression = getchar()) == ' ' || expression == '\t')
    ;
  /* process numbers */
  if (expression == '.' || isdigit(expression))
    {
      ungetc(expression, stdin);
      scanf("%lf", &yylval);
      return NUM;
    }
  /* return end-of-file */
  if (expression == EOF)
    return 0;
  /* return single chars */
  return expression;
}

int yyerror(char *s)
{
  printf ("ZOMG! %s\n", s);
}

int main()
{
  yyparse();
  return 0;
}
