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
"boolean"   {yylval.str = strdup(yytext);return TOKEN_BOOLEANTYPE;}
"break"     {yylval.str = strdup(yytext);return TOKEN_BREAKSTMT;}
"callout"   {yylval.str = strdup(yytext);return TOKEN_CALLOUT;}
"class"     {yylval.str = strdup(yytext);return TOKEN_CLASS;}
"continue"  {yylval.str = strdup(yytext);return TOKEN_CONTINUESTMT;}
"else"      {yylval.str = strdup(yytext);return TOKEN_ELSECONDITION;}
"false"     {yylval.str = strdup(yytext);return TOKEN_BOOLEANCONST;}
"for"       {yylval.str = strdup(yytext);return TOKEN_LOOP;}
"if"        {yylval.str = strdup(yytext);return TOKEN_IFCONDITION;}
"int"       {yylval.str = strdup(yytext);return TOKEN_INTTYPE;}
"return"    {yylval.str = strdup(yytext);return TOKEN_RETURN;}
"true"      {yylval.str = strdup(yytext);return TOKEN_BOOLEANCONST;}
"void"      {yylval.str = strdup(yytext);return TOKEN_VOIDTYPE;}
"Program"   {yylval.str = strdup(yytext);return TOKEN_PROGRAMCLASS;}
"main"      {yylval.str = strdup(yytext);return TOKEN_MAINFUNC;}

([a-zA-Z_]+[0-9]*)+ {;return TOKEN_ID;}
"*"         {yylval.str = strdup(yytext);return TOKEN_ARITHMATICOP_MUL;}
"/"         {yylval.str = strdup(yytext);return TOKEN_ARITHMATICOP_DIV;}
"%"         {yylval.str = strdup(yytext);return TOKEN_ARITHMATICOP_REM;}
"&&"        {yylval.str = strdup(yytext);return TOKEN_CONDITIONOP_AND;}
"||"        {yylval.str = strdup(yytext);return TOKEN_CONDITIONOP_OR;}
"+="        {yylval.str = strdup(yytext);return TOKEN_ASSIGNOP_ADD;}
"+"         {yylval.str = strdup(yytext);return TOKEN_ARITHMATICOP_ADD;}
"-="        {yylval.str = strdup(yytext);return TOKEN_ASSIGNOP_SUB;}
"-"         {yylval.str = strdup(yytext);return TOKEN_ARITHMATICOP_SUB;}
"<="        {yylval.str = strdup(yytext);return TOKEN_RELATIONOP_SE;}
"<"         {yylval.str = strdup(yytext);return TOKEN_RELATIONOP_S;}
">"         {yylval.str = strdup(yytext);return TOKEN_RELATIONOP_B;}
">="        {yylval.str = strdup(yytext);return TOKEN_RELATIONOP_BE;}
"!="        {yylval.str = strdup(yytext);return TOKEN_EQUALITYOP_NE;}
"=="        {yylval.str = strdup(yytext);return TOKEN_EQUALITYOP_E;}
"="         {yylval.str = strdup(yytext);return TOKEN_ASSIGNOP_ASS;}
"!"         {yylval.str = strdup(yytext);return TOKEN_LOGICOP;}
"{"         {yylval.str = strdup(yytext);return TOKEN_LCB;}
"}"         {yylval.str = strdup(yytext);return TOKEN_RCB;}
"("         {yylval.str = strdup(yytext);return TOKEN_LP;}
")"         {yylval.str = strdup(yytext);return TOKEN_RP;}
"["         {yylval.str = strdup(yytext);return TOKEN_RB;}
"]"         {yylval.str = strdup(yytext);return TOKEN_LB;}
";"         {yylval.str = strdup(yytext);return TOKEN_SEMICOLON;}
","         {yylval.str = strdup(yytext);return TOKEN_COMMA;}


" "*"//".*\n {}


("-"?"+"?[0-9]+) {
    if(strtol(yytext, &tmp, 10) <= MAX && strtol(yytext, &tmp,10) >= -(MAX)-1 )
    { 
        yylval.str = strdup(yytext);
        return TOKEN_DECIMALCONST;
    }
    else 
    {
        flag = 1;
    }
    }


"0x"[a-fA-F0-9]+ {
    if(strtol(yytext, &tmp, 16)<= MAX && strtol(yytext, &tmp,16) >= -(MAX)-1 )
    {
        yylval.str = strdup(yytext);
        return TOKEN_HEXADECIMALCONST;
    }
    else 
    {
        flag = 1;
    }
    }

\"[ -~]*\"  {yylval.str = strdup(yytext);return TOKEN_STRINGCONST;}

\'([ -~])\' {yylval.str = strdup(yytext);return TOKEN_CHARCONST;}
\'(\\"n")\' {yylval.str = strdup(yytext);return TOKEN_CHARCONST;}
\'(\\"t")\' {yylval.str = strdup(yytext);return TOKEN_CHARCONST;}
\'(\\\')\'  {yylval.str = strdup(yytext);return TOKEN_CHARCONST;}
\'(\\\")\'  {yylval.str = strdup(yytext);return TOKEN_CHARCONST;}

("\n")     {line_number++;}
("\t")     {}
(" ")      {}


[0-9]+[a-zA-Z0-9_]+   {flag = 1;}
.                     {flag = 1;}

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