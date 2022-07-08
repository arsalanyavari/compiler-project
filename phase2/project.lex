%{
    //Definitions
    #include <iostream>
    #include "Node.h"
    #include <vector>
    #include "app.hpp"
    #include <stdlib.h>

    using namespace std;
    int line_number = 1;
    char* tmp;
    int flag = 0;
    #define MAX 2147483647
    
    
%}


%%
    //rules
"boolean"   {printf("TOKEN_BOOLEANTYPE %s\n",yytext);return TOKEN_BOOLEANTYPE;}
"break"     {printf("TOKEN_BREAKSTMT %s\n",yytext);return TOKEN_BREAKSTMT;}
"callout"   {printf("TOKEN_CALLOUT %s\n",yytext);return TOKEN_CALLOUT;}
"class"     {printf("TOKEN_CLASS %s\n",yytext);return TOKEN_CLASS;}
"continue"  {printf("TOKEN_CONTINUESTMT %s\n",yytext);return TOKEN_CONTINUESTMT;}
"else"      {printf("TOKEN_ELESECONDITION %s\n",yytext);return TOKEN_ELSECONDITION;}
"false"     {printf("TOKEN_BOOLEANCONST %s\n",yytext);return TOKEN_BOOLEANCONST;}
"for"       {printf("TOKEN_LOOP %s\n",yytext);return TOKEN_LOOP;}
"if"        {printf("TOKEN_IFCONDITION %s\n",yytext);return TOKEN_IFCONDITION;}
"int"       {printf("TOKEN_INTTYPE %s\n",yytext);return TOKEN_INTTYPE;}
"return"    {printf("TOKEN_RETURN %s\n",yytext);return TOKEN_RETURN;}
"true"      {printf("TOKEN_BOOLEANCONST %s\n",yytext);return TOKEN_BOOLEANCONST;}
"void"      {printf("TOKEN_VOIDTYPE %s\n",yytext);return TOKEN_VOIDTYPE;}
"Program"   {printf("TOKEN_PROGRAMCLASS %s\n",yytext);return TOKEN_PROGRAMCLASS;}
"main"      {printf("TOKEN_MAINFUNC %s\n",yytext);return TOKEN_MAINFUNC;}

([a-zA-Z_]+[0-9]*)+ {printf("TOKEN_ID %s\n", yytext);return TOKEN_ID;}
"*"         {printf("TOKEN_ARITHMATICOP_MUL %s\n", yytext);return TOKEN_ARITHMATICOP_MUL;}
"/"         {printf("TOKEN_ARITHMATICOP_DIV %s\n", yytext);return TOKEN_ARITHMATICOP_DIV;}
"%"         {printf("TOKEN_ARITHMATICOP_REM %s\n", yytext);return TOKEN_ARITHMATICOP_REM;}
"&&"        {printf("TOKEN_CONDITIONOP_AND %s\n", yytext);return TOKEN_CONDITIONOP_AND;}
"||"        {printf("TOKEN_CONDITIONOP_OR %s\n", yytext);return TOKEN_CONDITIONOP_OR;}
"+="        {printf("TOKEN_ASSIGNOP_ADD %s\n", yytext);return TOKEN_ASSIGNOP_ADD;}
"+"         {printf("TOKEN_ARITHMATICOP_ADD %s\n", yytext);return TOKEN_ARITHMATICOP_ADD;}
"-="        {printf("TOKEN_ASSIGNOP_SUB %s\n", yytext);return TOKEN_ASSIGNOP_SUB;}
"-"         {printf("TOKEN_ARITHMATICOP_SUB %s\n", yytext);return TOKEN_ARITHMATICOP_SUB;}
"<="        {printf("TOKEN_RELATIONOP_SE %s\n", yytext);return TOKEN_RELATIONOP_SE;}
"<"         {printf("TOKEN_RELATIONOP_S  %s\n", yytext);return TOKEN_RELATIONOP_S;}
">"         {printf("TOKEN_RELATIONOP_B  %s\n", yytext);return TOKEN_RELATIONOP_B;}
">="        {printf("TOKEN_RELATIONOP_BE %s\n", yytext);return TOKEN_RELATIONOP_BE;}
"!="        {printf("TOKEN_EQUALITYOP_NE %s\n", yytext);return TOKEN_EQUALITYOP_NE;}
"=="        {printf("TOKEN_EQUALITYOP_E  %s\n", yytext);return TOKEN_EQUALITYOP_E;}
"="         {printf("TOKEN_ASSIGNOP_ASS %s\n", yytext);return TOKEN_ASSIGNOP_ASS;}
"!"         {printf("TOKEN_LOGICOP %s\n", yytext);return TOKEN_LOGICOP;}
"{"         {printf("TOKEN_LCB %s\n", yytext);return TOKEN_LCB;}
"}"         {printf("TOKEN_RCB %s\n", yytext);return TOKEN_RCB;}
"("         {printf("TOKEN_LP %s\n", yytext);return TOKEN_LP;}
")"         {printf("TOKEN_RP %s\n", yytext);return TOKEN_RP;}
"["         {printf("TOKEN_LB %s\n", yytext);return TOKEN_RB;}
"]"         {printf("TOKEN_RB %s\n", yytext);return TOKEN_LB;}
";"         {printf("TOKEN_SEMICOLON %s\n", yytext);return TOKEN_SEMICOLON;}
","         {printf("TOKEN_COMMA %s\n", yytext);return TOKEN_COMMA;}


" "*"//".*\n {printf("TOKEN_COMMENT %s\n", yytext);}


("-"?"+"?[0-9]+) {
    if(strtol(yytext, &tmp, 10) <= MAX && strtol(yytext, &tmp,10) >= -(MAX)-1 )
    { 
        printf("TOKEN_DECIMALCONST %s\n", yytext);
        return TOKEN_DECIMALCONST;
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
       return TOKEN_HEXADECIMALCONST;
    }
    else 
    {
        printf("\e[0;31mOut of range \e[41mError!\e[0;31m line %d\n\e[0m", line_number);
        flag = 1;
    }
    }

\"[ -~]*\"  {printf("TOKEN_STRINGCONST %s\n", yytext);return TOKEN_STRINGCONST;}

\'([ -~])\' {printf("TOKEN_CHARCONST %s\n", yytext);return TOKEN_CHARCONST;}
\'(\\"n")\' {printf("TOKEN_CHARCONST %s\n", yytext);return TOKEN_CHARCONST;}
\'(\\"t")\' {printf("TOKEN_CHARCONST %s\n", yytext);return TOKEN_CHARCONST;}
\'(\\\')\'  {printf("TOKEN_CHARCONST %s\n", yytext);return TOKEN_CHARCONST;}
\'(\\\")\'  {printf("TOKEN_CHARCONST %s\n", yytext);return TOKEN_CHARCONST;}

("\n")     {printf("TOKEN_WHITESPACE [newline]\n");line_number++;}
("\t")     {printf("TOKEN_WHITESPACE [tab]\n");}
(" ")      {printf("TOKEN_WHITESPACE [space]\n");}


[0-9]+[a-zA-Z0-9_]+   {printf("\e[0;31mID definition \e[41mError!\e[0;31m line %d\n\e[0m", line_number); flag = 1;}
.                     {printf("\e[0;31mUnrecognized \e[41mError!\e[0;31m line %d\n\e[0m", line_number); flag = 1;}

%%


int yywrap() {}

// int main(){
//     FILE * f = fopen("main.x", "r");
//     yyin = f;
//     yylex();
//     if(flag)
//         return 1;
//     return 0;
// }