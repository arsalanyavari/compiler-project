%option noyywrap

%{
    //Definitions
    #include<stdio.h>
    #include <stdlib.h>
    int line_number = 1;
    char* tmp;
    int flag = 0;
    #define MAX 2147483647
    
    
%}


%%
    //rules
"boolean"   {printf("TOKEN_BOOLEANTYPE %s\n",yytext);}
"break"     {printf("TOKEN_BREAKSTMT %s\n",yytext);}
"callout"   {printf("TOKEN_CALLOUT %s\n",yytext);}
"class"     {printf("TOKEN_CLASS %s\n",yytext);}
"continue"  {printf("TOKEN_CONTINUESTMT %s\n",yytext);}
"else"      {printf("TOKEN_ELESECONDITION %s\n",yytext);}
"false"     {printf("TOKEN_BOOLEANCONST %s\n",yytext);}
"for"       {printf("TOKEN_LOOP %s\n",yytext);}
"if"        {printf("TOKEN_IFCONDITION %s\n",yytext);}
"int"       {printf("TOKEN_INTTYPE %s\n",yytext);}
"return"    {printf("TOKEN_RETURN %s\n",yytext);}
"true"      {printf("TOKEN_BOOLEANCONST %s\n",yytext);}
"void"      {printf("TOKEN_VOIDTYPE %s\n",yytext);}
"Program"   {printf("TOKEN_PROGRAMCLASS %s\n",yytext);}
"main"      {printf("TOKEN_MAINFUNC %s\n",yytext);}

([a-zA-Z_]+[0-9]*)+ {printf("TOKEN_ID %s\n", yytext);}
"*"         {printf("TOKEN_ARITHMATICOP %s\n", yytext);}
"/"         {printf("TOKEN_ARITHMATICOP %s\n", yytext);}
"%"         {printf("TOKEN_ARITHMATICOP %s\n", yytext);}
"&&"        {printf("TOKEN_CONDITIONOP %s\n", yytext);}
"||"        {printf("TOKEN_CONDITIONOP %s\n", yytext);}
"+="        {printf("TOKEN_ASSIGNOP %s\n", yytext);}
"+"         {printf("TOKEN_ARITHMATICOP %s\n", yytext);}
"-="        {printf("TOKEN_ASSIGNOP %s\n", yytext);}
"-"         {printf("TOKEN_ARITHMATICOP %s\n", yytext);}
"<="        {printf("TOKEN_RELATIONOP %s\n", yytext);}
"<"         {printf("TOKEN_RELATIONOP %s\n", yytext);}
">="        {printf("TOKEN_RELATIONOP %s\n", yytext);}
">"         {printf("TOKEN_RELATIONOP %s\n", yytext);}
"=="        {printf("TOKEN_EQUALITYOP %s\n", yytext);}
"!="        {printf("TOKEN_EQUALITYOP %s\n", yytext);}
"="         {printf("TOKEN_ASSIGNOP %s\n", yytext);}
"!"         {printf("TOKEN_LOGICOP %s\n", yytext);}
"{"         {printf("TOKEN_LCB %s\n", yytext);}
"}"         {printf("TOKEN_RCB %s\n", yytext);}
"("         {printf("TOKEN_LP %s\n", yytext);}
")"         {printf("TOKEN_RP %s\n", yytext);}
"["         {printf("TOKEN_LB %s\n", yytext);}
"]"         {printf("TOKEN_RB %s\n", yytext);}
";"         {printf("TOKEN_SEMICOLON %s\n", yytext);}
","         {printf("TOKEN_COMMA %s\n", yytext);}


" "*"//".*\n {printf("TOKEN_COMMENT %s\n", yytext);}


("-"?"+"?[0-9]+) {
    if(strtol(yytext, &tmp, 10) <= MAX && strtol(yytext, &tmp,10) >= -(MAX)-1 )
    { 
        printf("TOKEN_DECIMALCONST %s\n", yytext);
    }
    else 
    {
        printf("\e[0;31mOut of range \e[41mError!\e[0;31m line %d\n\e[0m", line_number);
        flag = 1;
    }
    }


"0x"[a-fA-F0-9]+ {
    if(strtol(yytext, &tmp, 16)<= MAX && strtol(yytext, &tmp,16) >= -(MAX)-1 )
    {
       printf("TOKEN_HEXADECIMALCONST %s\n", yytext); 
    }
    else 
    {
        printf("\e[0;31mOut of range \e[41mError!\e[0;31m line %d\n\e[0m", line_number);
        flag = 1;
    }
    }

\"[ -~]*\"  {printf("TOKEN_STRINGCONST %s\n", yytext);}

\'([ -~])\' {printf("TOKEN_CHARCONST %s\n", yytext);}
\'(\\"n")\' {printf("TOKEN_CHARCONST %s\n", yytext);}
\'(\\"t")\' {printf("TOKEN_CHARCONST %s\n", yytext);}
\'(\\\')\'  {printf("TOKEN_CHARCONST %s\n", yytext);}
\'(\\\")\'  {printf("TOKEN_CHARCONST %s\n", yytext);}

("\n")     {printf("TOKEN_WHITESPACE [newline]\n");line_number++;}
("\t")     {printf("TOKEN_WHITESPACE [tab]\n");}
(" ")      {printf("TOKEN_WHITESPACE [space]\n");}


[0-9]+[a-zA-Z0-9_]+   {printf("\e[0;31mID definition \e[41mError!\e[0;31m line %d\n\e[0m", line_number); flag = 1;}
.                     {printf("\e[0;31mUnrecognized \e[41mError!\e[0;31m line %d\n\e[0m", line_number); flag = 1;}

%%

int main(){
    FILE * f = fopen("main.x", "r");
    yyin = f;
    yylex();
    if(flag)
        return 1;
    return 0;
}