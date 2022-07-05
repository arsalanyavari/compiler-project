%{
    
    #include <iostream>
    #include <string>
    using namespace std;

    extern int yylex();
    int yyerror(const char* message);
    extern FILE* yyin;
    extern FILE* yyout;

    int running_mode = 0;
    
%}

%define parse.lac full


%union {
    char str[50];
    int number;
    
}

%token<str> TOKEN_CLASS
%token<str> TOKEN_PROGRAMCLASS
%token<str> TOKEN_ID
%token<str> TOKEN_INTTYPE
%token<str> TOKEN_BOOLEANTYPE
%token<str> TOKEN_VOIDTYPE
%token<str> TOKEN_MAINFUNC
%token<str> TOKEN_LP
%token<str> TOKEN_RP
%token<str> TOKEN_COMMA
%token<str> TOKEN_SEMICOLON
%token<str> TOKEN_IFCONDITION
%token<str> TOKEN_LOOP
%token<str> TOKEN_ASSIGNOP_ASS
%token<str> TOKEN_ASSIGNOP_ADD
%token<str> TOKEN_ASSIGNOP_SUB
%token<str> TOKEN_RETURN
%token<str> TOKEN_BREAKSTMT
%token<str> TOKEN_CONTINUESTMT
%token<str> TOKEN_LB
%token<str> TOKEN_RB
%token<str> TOKEN_LCB
%token<str> TOKEN_RCB
%token<str> TOKEN_CALLOUT
%token<str> TOKEN_ELSECONDITION
%token<str> TOKEN_ARITHMATICOP_ADD
%token<str> TOKEN_ARITHMATICOP_SUB
%token<str> TOKEN_ARITHMATICOP_DIV
%token<str> TOKEN_ARITHMATICOP_MUL
%token<str> TOKEN_ARITHMATICOP_REM
%token<str> TOKEN_RELATIONOP_SE
%token<str> TOKEN_RELATIONOP_S
%token<str> TOKEN_RELATIONOP_BE
%token<str> TOKEN_RELATIONOP_B
%token<str> TOKEN_EQUALITYOP_E
%token<str> TOKEN_EQUALITYOP_NE
%token<str> TOKEN_CONDITIONOP_AND
%token<str> TOKEN_CONDITIONOP_OR
%token<str> TOKEN_LOGICOP
%token<str> TOKEN_DECIMALCONST
%token<str> TOKEN_HEXADECIMALCONST
%token<str> TOKEN_BOOLEANCONST
%token<str> TOKEN_CHARCONST
%token<str> TOKEN_STRINGCONST
%token<str> TOKEN_COMMENT
%token<str> TOKEN_WHITESPACE


%left TOKEN_CONDITIONOP_OR
%left TOKEN_CONDITIONOP_AND
%left TOKEN_ARITHMATICOP_MUL TOKEN_ARITHMATICOP_DIV
%left TOKEN_ARITHMATICOP_ADD TOKEN_ARITHMATICOP_SUB
%left TOKEN_ARITHMATICOP_REM
%left TOKEN_EQUALITYOP_NE
%left TOKEN_EQUALITYOP_E
%left TOKEN_RELATIONOP_SE TOKEN_RELATIONOP_S TOKEN_RELATIONOP_B TOKEN_RELATIONOP_BE
%left TOKEN_LOGICOP
%left TOKEN_LP TOKEN_RP 
%left TOKEN_LB TOKEN_RB 
%left TOKEN_LCB TOKEN_RCB
//%left TOKEN_INT TOKEN_BOOL TOKEN_CHAR TOKEN_STRING




%type <str> program
%type <str> decl
%type <str> field_decl
%type <str> multi_field
%type <str> method_decl
%type <str> header
%type <str> func_name
%type <str> func_args
%type <str> arg
%type <str> block
%type <str> var_decl
%type <str> statement
%type <str> ret_stmt
%type <str> else_stmt
%type <str> location
%type <str> assign_op
%type <str> expr
%type <str> method_call
%type <str> multi_expr
%type <str> multi_expr_inner
%type <str> multi_callout_args
%type <str> callout_args
%type <str> type
%type <str> multi_id
%type <str> literal
%type <str> int_literal
%type <str> decimal_literal
%type <str> hex_literal
%type <str> bool_literal
%type <str> char_literal
%type <str> string_literal
%type <str> id
%type <str> multi_callout_args_inner
%type <str> decl_method








%%
    program:    // class program {}
                TOKEN_CLASS TOKEN_PROGRAMCLASS TOKEN_LCB decl TOKEN_RCB
                {
                    printf("<program> %s %s %s %s %s\n", running_mode ? "TOKEN_CLASS" : $1, running_mode ? "TOKEN_PROGRAMCLASS" : $2, running_mode ? "TOKEN_LCB" : $3, $4, running_mode ? "TOKEN_RCB" : $5);
                }
                ;
    decl:
                field_decl decl 
                {
                    sprintf($$, "%s %s", $1, $2);
                }
                | decl_method 
                { 
                    sprintf($$, "%s", $1);
                }
                ;

    decl_method:
                decl_method method_decl
                {
                    sprintf($$, "%s %s", $1, $2);
                }
                | method_decl
                { 
                    sprintf($$, "%s", $1);
                }
                ;

    field_decl: //int a,b,c[10],b,c;
                type id multi_field TOKEN_SEMICOLON
                {
                    sprintf($$, "%s %s %s %s", $1, $2, $3, running_mode ? "TOKEN_SEMICOLON" : $4);
                }
                ;

    multi_field://a,b,c[10],b,c[20]
                TOKEN_COMMA id multi_field
                {
                    sprintf($$, "%s %s %s", running_mode ? "TOKEN_COMMA" : $1, $2, $3);
                }
                | TOKEN_LB int_literal TOKEN_RB TOKEN_COMMA id multi_field
                {
                    sprintf($$, "%s %s %s %s %s %s", running_mode ? "TOKEN_LB" : $1, $2, running_mode ? "TOKEN_RB" : $3, running_mode ? "TOKEN_COMMA" : $4, $5, $6); 
                }
                | TOKEN_LB int_literal TOKEN_RB
                {
                    sprintf($$, "%s %s %s", running_mode ? "TOKEN_LB" : $1, $2, running_mode ? "TOKEN_RB" : $3);
                }
                | /*epsilon*/ {  }
                ;


    method_decl://int main(){} // int func(int a, int b){}
                header func_name TOKEN_LP func_args TOKEN_RP block
                {
                    sprintf($$, "%s %s %s %s %s %s", $1, $2, running_mode ? "TOKEN_LP" : $3, $4, running_mode ? "TOKEN_RP" : $5, $6);
                }
                ;
    
    header:     //int//bool//void
                
                TOKEN_VOIDTYPE
                {
                    sprintf($$, "%s", running_mode ? "TOKEN_VOIDTYPE" : $1);
                }
                | type
                {
                    sprintf($$, "%s", $1);
                }
                ;

    func_name:  //func //main
                id
                {
                    sprintf($$, "%s", $1);
                }
                | TOKEN_MAINFUNC
                {
                    sprintf($$, "%s", running_mode ? "TOKEN_MAINFUNC" : $1);
                }
                ;

    func_args:  //int a//int a, int b//...
                arg 
                {
                    sprintf($$, "%s", $1);
                }
                | arg TOKEN_COMMA arg 
                { 
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2, $3);
                }
                | arg TOKEN_COMMA arg TOKEN_COMMA arg 
                { 
                    sprintf($$, "%s %s %s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2, $3, running_mode ? "TOKEN_COMMA" : $4, $5);
                }
                | arg TOKEN_COMMA arg TOKEN_COMMA arg TOKEN_COMMA arg
                {
                    sprintf($$, "%s %s %s %s %s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2, $3, running_mode ? "TOKEN_COMMA" : $4, $5, running_mode ? "TOKEN_COMMA" : $6, $7);
                }
                | /*epsilon*/ { }
                ;

    arg:    //int a//bool b
                type id 
                {
                    sprintf($$ , "%s %s" , $1 , $2);
                }
                ;

    block:  //{dec stm}
                TOKEN_LCB var_decl statement TOKEN_RCB
                {
                    sprintf($$ , "%s %s %s %s" , running_mode? "TOKEN_LCB" : $1 , $2 , $3 , running_mode ? "TOKEN_RCB" : $4);
                }
                ;

    var_decl:   // int a,b,c;
                type multi_id TOKEN_SEMICOLON
                {
                    sprintf($$, "%s %s %s" , $1 , $2 , running_mode ? "TOKEN_SEMICOLON" : $3);
                }
                |/*epsilon*/ { }
                ;

    statement:
                location assign_op expr TOKEN_SEMICOLON // a = 2;//a[3]=b//...
                {
                    sprintf($$, "%s %s %s %s", $1 , $2 , $3 , running_mode ? "TOKEN_SEMICOLON" : $4);
                }
                | method_call TOKEN_SEMICOLON //callout(...)//func(...)
                {
                    sprintf($$, "%s %s", $1, running_mode ? "TOKEN_SEMICOLON" : $2);
                }
                | TOKEN_IFCONDITION TOKEN_RP expr TOKEN_LP else_stmt //if(){} else{}
                {
                    sprintf($$ , "%s %s %s %s %s", running_mode ? "TOKEN_IFCONDITION" : $1 , running_mode ? "TOKEN_RP" : $2 , $3 , running_mode ? "TOKEN_LP": $4 , $5);
                }
                | TOKEN_LOOP id TOKEN_ASSIGNOP_ASS expr TOKEN_COMMA expr block // for i=0 , 10 {}
                {
                    sprintf($$, "%s %s %s %s %s %s %s", running_mode ? "TOKEN_LOOP" : $1, $2, running_mode ? "TOKEN_ASSIGNOP_ASS" : $3, $4, running_mode ? "TOKEN_COMMA" : $5, $6, $7);
                }
                | TOKEN_RETURN ret_stmt TOKEN_SEMICOLON //return 20;
                {
                    sprintf($$, "%s %s %s", running_mode ? "TOKEN_RETURN" : $1, $2, running_mode ? "TOKEN_SEMICOLON" : $3);
                }
                | TOKEN_BREAKSTMT TOKEN_SEMICOLON //break;
                {
                    sprintf($$, "%s %s", running_mode ? "TOKEN_BREAKSTMT" : $1, running_mode ? "TOKEN_SEMICOLON" : $2);
                }
                | TOKEN_CONTINUESTMT TOKEN_SEMICOLON //contineu;
                {
                    sprintf($$, "%s %s", running_mode ? "TOKEN_CONTINUESTMT" : $1 , running_mode ? "TOKEN_SEMICOLON" : $2);
                }
                | block
                {
                    sprintf($$, "%s", $1);
                }
                |/*epsilon*/ { }
                ;

    ret_stmt:
                expr 
                {
                    sprintf($$, "%s" , $1);
                }
                |/*epsilon*/ { }
                ;

    else_stmt:  //else {}
                TOKEN_ELSECONDITION block 
                {
                    sprintf($$, "%s %s", running_mode ? "TOKEN_ELSECONDITION" : $1, $2);
                }
                |/*epsilon*/ { }
                ;

    location:
                id
                {
                    sprintf($$, "%s", $1);
                }
                | id TOKEN_LB expr TOKEN_RB
                {
                    sprintf($$, "%s %s %s %s", $1, running_mode ? "TOKEN_LB" : $2, $3, running_mode ? "TOKEN_RB" : $4);
                }
                ;

    assign_op:
                TOKEN_ASSIGNOP_ASS
                {
                    sprintf($$, "%s", running_mode ? "TOKEN_ASSIGNOP_ASS" : $1);
                }
                | TOKEN_ASSIGNOP_ADD
                {
                    sprintf($$, "%s", running_mode ? "TOKEN_ASSIGNOP_ADD" : $1);
                }
                | TOKEN_ASSIGNOP_SUB
                {
                    sprintf($$, "%s", running_mode ? "TOKEN_ASSIGNOP_SUB" : $1);
                }
                ;

    expr: 
                location //a//a[3]
                {
                    sprintf($$, "%s", $1);
                }
                | method_call //
                {
                    sprintf($$, "%s", $1);
                }
                | literal //all literals
                {
                    sprintf($$, "%s", $1);
                }
                | expr TOKEN_ARITHMATICOP_ADD expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_ARITHMATICOP_ADD" : $2, $3);
                }
                | expr TOKEN_ARITHMATICOP_SUB expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_ARITHMATICOP_SUB" : $2, $3);
                }
                | expr TOKEN_ARITHMATICOP_MUL expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_ARITHMATICOP_MUL" : $2, $3);
                }
                | expr TOKEN_ARITHMATICOP_DIV expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_ARITHMATICOP_DIV" : $2, $3);
                }
                | expr TOKEN_ARITHMATICOP_REM expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_ARITHMATICOP_REM" : $2, $3);
                }
                | expr TOKEN_RELATIONOP_SE expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_RELATIONOP_SE" : $2, $3);
                }
                | expr TOKEN_RELATIONOP_S expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_RELATIONOP_S" : $2, $3);
                }
                | expr TOKEN_RELATIONOP_B expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_RELATIONOP_B" : $2, $3);
                }
                | expr TOKEN_RELATIONOP_BE expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_RELATIONOP_BE" : $2, $3);
                }
                | expr TOKEN_EQUALITYOP_E expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_EQUALITYOP_E" : $2, $3);
                }
                | expr TOKEN_EQUALITYOP_NE expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_EQUALITYOP_NE" : $2, $3);
                }
                | expr TOKEN_CONDITIONOP_AND expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_CONDITIONOP_AND" : $2, $3);
                }         
                | expr TOKEN_CONDITIONOP_OR expr
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_CONDITIONOP_OR" : $2, $3);
                }
                | TOKEN_ARITHMATICOP_SUB expr // -a
                {
                    sprintf($$, "%s %s", running_mode ? "TOKEN_ARITHMATICOP_SUB" : $1, $2);
                }
                | TOKEN_LOGICOP expr // !true
                {
                    sprintf($$, "%s %s", running_mode ? "TOKEN_LOGICOP" : $1, $2);
                }
                | TOKEN_LP expr TOKEN_RP // (expr)
                {
                    sprintf($$, "%s %s %s", running_mode ? "TOKEN_LP" : $1, $2, running_mode ? "TOKEN_RP" : $3);
                }
                

    method_call:
                id TOKEN_LP multi_expr TOKEN_RP //func(a,b,1)
                {
                    sprintf($$, "%s %s %s %s", $1, running_mode ? "TOKEN_LP" : $2, $3, running_mode ? "TOKEN_RP" : $4);
                }
                | TOKEN_CALLOUT TOKEN_LP string_literal multi_callout_args TOKEN_RP //callout('strcmp','aab','bba')
                {
                    sprintf($$, "%s %s %s %s", $1, running_mode ? "TOKEN_LP" : $2, $3, running_mode ? "TOKEN_RP" : $4);
                }
                ;
    
    multi_expr: //1,2,a,b,c//1,b//blank
                multi_expr_inner
                {
                    sprintf($$ , "%s" , $1);
                }
                |/*epsilon*/ { }
                ;

    multi_expr_inner://1,2,a,b,c//1,b
                expr 
                {
                    sprintf($$ , "%s" , $1);
                }
                | expr TOKEN_COMMA multi_expr_inner
                {      
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2 , $3);
                }
                ;

    multi_callout_args:
                TOKEN_COMMA multi_callout_args_inner
                {
                    sprintf($$, "%s %s", running_mode ? "TOKEN_COMMA" : $1, $2);
                }
                | /*epsilon*/ { }
                ;

    multi_callout_args_inner:
                callout_args
                {
                    sprintf($$ , "%s", $1);
                }
                | callout_args TOKEN_COMMA multi_callout_args_inner
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2, $3);
                }
                ;

    callout_args:
                 expr
                {
                    sprintf($$ , "%s", $1);
                }
                | string_literal
                {
                    sprintf($$ , "%s", $1);
                }
                ;


    type:
                TOKEN_INTTYPE
                {
                    sprintf($$, "%s", running_mode ? "TOKEN_INTTYPE" : $1);
                }
                | TOKEN_BOOLEANTYPE
                {
                    sprintf($$, "%s", running_mode ? "TOKEN_BOOLEANTYPE" : $1);
                }
                ;


    multi_id:
                id
                {
                    sprintf($$ , "%s", $1);
                }
                | id TOKEN_COMMA multi_id 
                {
                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2, $3);
                }
                ;
   
    literal:
                int_literal
                {
                    sprintf($$ , "%s", $1);
                }
                | char_literal
                {
                    sprintf($$ , "%s", $1);
                }
                | bool_literal
                {
                    sprintf($$ , "%s", $1);
                }
                ;

    int_literal: 
                decimal_literal
                {
                    sprintf($$ , "%s", $1);
                }
                | hex_literal
                {
                    sprintf($$ , "%s", $1);
                }
                ;
    id:
                TOKEN_ID
                {
            
                    sprintf($$ , "%s", running_mode ? "TOKEN_ID" : $1);
                }
                ;
     decimal_literal:
                TOKEN_DECIMALCONST
                {
                    sprintf($$ , "%s", running_mode ? "TOKEN_DECIMALCONST" : $1);
                }
                ;
    hex_literal:
                TOKEN_HEXADECIMALCONST
                {
                    sprintf($$ , "%s", running_mode ? "TOKEN_HEXADECIMALCONST" : $1);
                }
                ;
    bool_literal:
                TOKEN_BOOLEANCONST
                {
                    sprintf($$ , "%s", running_mode ? "TOKEN_BOOLEANCONST" : $1);
                }
                ;
    char_literal:
                TOKEN_CHARCONST
                {
                    sprintf($$ , "%s", running_mode ? "TOKEN_CHARCONST" : $1);
                }
                ;
    string_literal:
                TOKEN_STRINGCONST
                {
                    sprintf($$ , "%s", running_mode ? "TOKEN_STRINGCONST" : $1);
                }
                ;
    
%%


int main(int argc, char **argv)
{
    running_mode = *argv[1] == '1' ? 1 : 0;

	yyin = fopen("file.x", "r");
	yyout = fopen("file.txt", "w");
	yyparse();
	return 0;
}


int yyerror(const char* message) {
    cout << "\n\n================ERROR===============\n\n"<<endl;
    cout << message << endl;
    return 0;
}

