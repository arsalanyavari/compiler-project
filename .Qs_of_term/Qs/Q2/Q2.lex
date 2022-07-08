%{
    //Definitions
    #include<stdio.h>
%}


%%
    //rules
" "*"//".*\n {printf("\033[92mcomment in // format \033[0m\n");}
" "*"/*"[^*/]*" "*"*/"\n {printf("\033[92mcomment in /* ... */ format \033[0m\n");}
.* {FILE * fw = fopen("cleancommented.cpp", "a");  fprintf(fw, "%s", yytext); fclose(fw);}
\n {FILE * fw = fopen("cleancommented.cpp", "a");  fprintf(fw, "%s", yytext); fclose(fw);}
%%

int yywrap(){}

int main(){
    unlink("cleancommented.cpp");
    FILE * f = fopen("commented.cpp", "r");
    yyin = f;
    yylex();

}