% option noyywrap %
{
#include <stdio.h>
    int countKeywords = 0;
    int countIdentifiers = 0;
    int countNumericals = 0;
    int countPreprocessors = 0;
    int countOpenningParenthesis = 0;
    int countClosingParenthesis = 0;
    int countOpenningCurlyBrackets = 0;
    int countClosingCurlyBrackets = 0;
    int countOpenningSquareBracket = 0;
    int countClosingSquareBracket = 0;
    int countDelimiter = 0;
    int countTermination = 0;
    int countStringLiteral = 0;
    int countAnd = 0;
    int countEqualOperator = 0;
    int countlessThan = 0;
    int countIncrement = 0;
    int countEquivalence = 0;
    int countPlusOperator = 0;
    int countNumberOfCommentsIngnored = 0;
    int countAddAsign = 0;
    int countNotEqualOperator = 0;
    int countGreaterThanOperator = 0;
    int countMultiplyAssign = 0;
    int countDecrement = 0;
    int countLessThanOrEqualTo = 0;

    static void multiLineComment(void);
    %
}
whitespace[ \n\t\r] preprocessor "#include <" {letter} + (\.{letter} *) ? >
                                                                              comment "//".*
                                                                                  letter[a - zA - Z_] digit[0 - 9] stringLiteral{letter}
?\"(\\.|[^\\"]) *\"

    % %
    {whitespace} + {/*skip white space*/} {preprocessor}
{
    countPreprocessors++; /*printf("\tPREPROCESSOR: %s\n",yytext);*/
}
"/*"
{
    multiLineComment();
    countNumberOfCommentsIngnored++;
}
{comment} {
    countNumberOfCommentsIngnored++;
}
{} {
    countKeywords++; /*printf("Keyword: %s \n", yytext);*/
}
"if" { countKeywords++; /*return(IF);*/ }
"else" { countKeywords++; /*return(ELSE);*/ }
"while" { countKeywords++; /*return(WHILE);*/ }
"int" { countKeywords++; /*return(INT);*/ }
"switch" { countKeywords++; /*return(SWITCH);*/ }
"for" { countKeywords++; /*return(FOR);*/ }
"char" { countKeywords++; /*return(CHAR);*/ }
"return" { countKeywords++; /*return(RETURN);*/ }
"break" { countKeywords++; /*return(BREAK);*/ }
"double" { countKeywords++; /*return(DOUBLE);*/ }
"do" { countKeywords++; /*return(DO);*/ }
"long" { countKeywords++; /*return(LONG);*/ }
{letter}({letter} | {digit}) * { countIdentifiers++; /*printf("Identifiers: %s \n", yytext);*/ }
{digit} * | {digit} * "." {digit} * { countNumericals++; }
"(" { countOpenningParenthesis++; /* return '('; */ /*)*/ }
")" { countClosingParenthesis++; /* return ')';*/ }
("{" | "<%") { countOpenningCurlyBrackets++; /*return '{';*/ }
("}" | "%>") { countClosingCurlyBrackets++; /*return '}';*/ }
("[" | "<:") { countOpenningSquareBracket++; /*return '[';*/ }
("]" | ":>") { countClosingSquareBracket++; /*return ']';*/ }
"," { countDelimiter++; /* return ',';*/ }
";" { countTermination++; /* return ';';*/ }
"&" { countAnd++; /*return '&';*/ }
"=" { countEqualOperator++; /*return '=';*/ }
"<" { countlessThan++; /*return '<';*/ }
"++" { countIncrement++; /*return INC_OP;*/ }
"==" { countEquivalence++; /*return EQ_OP;*/ }
"+" { countPlusOperator++; /*return '+';*/ }
"+=" { countAddAsign++; /*return ADD_ASSIGN;*/ }
"!=" { countNotEqualOperator++; /*return NE_OP;*/ }
">" { countGreaterThanOperator++; /*return '>';*/ }
"*=" { countMultiplyAssign++; /*return MUL_ASSIGN; */ }
"--" { countDecrement++; /*return DEC_OP;*/ }
"<=" { countLessThanOrEqualTo++; /*return LE_OP; */ }
{stringLiteral} {
    countStringLiteral++;
}
. { printf("invalid: %s \n", yytext); }

% %
    int main(int argc[], char *argv[])
{
    yyin = fopen("Project.cpp", "r");
    yylex();
    printf("\n************************************************************\n");
    printf("\t PREPROCESSORS: \t %d \n", countPreprocessors);
    printf("\t Number of comments: \t %d ", countNumberOfCommentsIngnored);
    int totalIdentifiers = 0;
    totalIdentifiers = countKeywords + countIdentifiers + countNumericals + countOpenningParenthesis + countClosingParenthesis + countOpenningCurlyBrackets + countClosingCurlyBrackets + countOpenningSquareBracket + countClosingSquareBracket + countDelimiter + countTermination + countStringLiteral + countAnd + countEqualOperator + countlessThan + countIncrement + countEquivalence + countPlusOperator + countAddAsign + countNotEqualOperator + countMultiplyAssign + countGreaterThanOperator + countDecrement + countLessThanOrEqualTo;
    printf("\n************************************************************\n");
    printf("\tTOTAL TOKENS FOUND: %d \n", totalIdentifiers);
    printf("\t TOKEN CLASS \t NO. OF TOKENS FOUND \n");
    printf("\t Keywords: \t %d \n", countKeywords);
    printf("\t Identifiers: \t %d \n", countIdentifiers);
    printf("\t Numerials: \t %d \n", countNumericals);
    printf("\t openningParenthesis: \t %d \n", countOpenningParenthesis);
    printf("\t closingParenthesis: \t %d \n", countClosingParenthesis);
    printf("\t openningCurlyBracket: \t %d \n", countOpenningCurlyBrackets);
    printf("\t closingCurlyBracket: \t %d \n", countClosingCurlyBrackets);
    printf("\t openningSquareBracket: \t %d \n", countOpenningSquareBracket);
    printf("\t closingSquareBracket: \t %d \n", countClosingSquareBracket);
    printf("\t delimiter: \t %d \n", countDelimiter);
    printf("\t termination: \t %d \n", countTermination);
    printf("\t stringLiteral: \t %d \n", countStringLiteral);
    printf("\t and: \t %d \n", countAnd);
    printf("\t equalsOperator: \t %d \n", countEqualOperator);
    printf("\t lessThan: \t %d \n", countlessThan);
    printf("\t increment: \t %d \n", countIncrement);
    printf("\t equivalence: \t %d \n", countEquivalence);
    printf("\t plusOperator: \t %d \n", countPlusOperator);
    printf("\t addAssign: \t %d \n", countAddAsign);
    printf("\t notEqualOperator: \t %d \n", countNotEqualOperator);
    printf("\t multiplyAssign: \t %d \n", countMultiplyAssign);
    printf("\t greaterThanOperator: \t %d \n", countGreaterThanOperator);
    printf("\t decrement: \t %d \n", countDecrement);
    printf("\t lessThanOrEqualTo: \t %d \n", countLessThanOrEqualTo);
    return 0;
}

static void multiLineComment(void)
{
    int c;

    while ((c = input()) != 0)
    {
        // printf("%c\n", (char)c);
        if (c == '*')
        {
            while ((c = input()) == '*')
                ;

            if (c == '/')
                return;

            if (c == 0)
                break;
        }
    }
}