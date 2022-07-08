%{
/* example illustrating the use of states in lex 

   declare a state called INPUT using: %s INPUT

   enter a state using: BEGIN INPUT

   match a token only if in a certain state: <INPUT>\".*\"
*/
%}

%s INPUT
%S CONVERT
%s OUTPUT

%%

[ \t\n]+                ;
inputfile       BEGIN INPUT;
<INPUT>\".*\"   { BEGIN CONVERT; printf("%s is the input file.\n", yytext); }
<CONVERT>\outputfile BEGIN OUTPUT;
<OUTPUT>\".*\"    { printf("%s is the output file.\n", yytext); }
\".*\"          { ECHO; printf("\n"); }
.                ;

%%


int yywrap(){}

int main(){
    FILE * f = fopen("text.txt", "r");
    yyin = f;
    yylex();
}


