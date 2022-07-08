
%{
    
    #include <iostream>
    #include <cstring>
    #include <vector>
    #include <string>
    #include "Node.h"
    using namespace std;

    extern int yylex();
    int yyerror(const char* message);
    extern FILE* yyin;
    extern FILE* yyout;

    int running_mode = 0;



//Node* Tree = new Node(NULL);
// Node* Node* temp = new Node();
// Node* Node* temp2 = new Node();
// Node* Node* temp3 = new Node();
// Node* Node* temp4 = new Node();


int step = 0;

void print_preorder(Node* head, int mode)
{
    Node* tmp = head;
    bool leaf = tmp->children.size()>0?false:true;
    for(int i=0; i<step; i++)
        cout << "\t";
    if (mode == 0)
        if(leaf)
        {
            cout << "\e[0;32m" << tmp->data <<endl << "\e[0m";
        }
        else
            cout << "\e[0;34m" << tmp->data <<endl << "\e[0m";
    else
        cout << "\e[0;31m" << tmp->name << endl << "\e[0m";

    if (tmp->children.size()==0)
        {
            step--;
            return;
        }
    for (int i=0 ; i < tmp->children.size() ; i++ )
    {
        step++;
        print_preorder(tmp->children[i], mode);
    }

    step--;
    return;
}

    
%}



%union {
    char* str;
    int number;
    Node* node;    
    
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
%right TOKEN_COMMA




%type <node> program
%type <node> decl
%type <node> field_decl
%type <node> multi_field
%type <node> method_decl
%type <node> header
%type <node> func_name
%type <node> func_args
%type <node> arg
%type <node> block
%type <node> var_decl
%type <node> statement
%type <node> ret_stmt
%type <node> else_stmt
%type <node> location
%type <node> assign_op
%type <node> expr
%type <node> method_call
%type <node> multi_expr
%type <node> multi_expr_inner
%type <node> multi_callout_args
%type <node> callout_args
%type <node> type
%type <node> multi_id
%type <node> literal
%type <node> int_literal
%type <node> decimal_literal
%type <node> hex_literal
%type <node> bool_literal
%type <node> char_literal
%type <node> string_literal
%type <node> id
%type <node> multi_callout_args_inner
%type <node> decl_method








%%
    program:    // class program {}
                TOKEN_CLASS TOKEN_PROGRAMCLASS TOKEN_LCB decl TOKEN_RCB
                {
                    $$ =         new Node();
                    $$->name =   strdup(" < func_name > ");
                    $$->data =   strdup(" < func_name > ");

                    Node* temp2 =   new Node();
                    temp2->name =   strdup("TOKEN_CLASS");
                    temp2->data =   strdup($1);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    Node* temp3 =   new Node();
                    temp3->name =   strdup("TOKEN_PROGRAMCLASS");
                    temp3->data =   strdup($2);
                    //temp3->parent = $$;
                      
                    $$->add_child(temp3);

                    Node* temp4 = new Node();
                    temp4->name =   strdup("TOKEN_LCB");
                    temp4->data =   strdup($3);
                    //temp4->parent = $$;
                      
                    $$->add_child(temp4);

                    //$4->parent = $$;
                    $$->add_child($4);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_RCB");
                    temp->data =   strdup($5);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);


                    cout << "\n\n";
                    print_preorder($$, running_mode);

                    // printf("<program> %s %s %s %s %s\n", running_mode ? "TOKEN_CLASS" : $1, running_mode ? "TOKEN_PROGRAMCLASS" : $2, running_mode ? "TOKEN_LCB" : $3, $4, running_mode ? "TOKEN_RCB" : $5);
                }
                ;
    decl:
                field_decl decl 
                {
                    $$ = new Node();
                    $$->name =   strdup(" < decl > ");
                    $$->data =   strdup(" < decl > ");

                    //$1->parent = $$;
                    $$->add_child($1);

                    //$2->parent = $$;
                    $$->add_child($2);

                    //sprintf($$, "%s %s", $1, $2);
                }
                | decl_method 
                { 
                    $$ = new Node();
                    $$->name =   strdup(" < decl > ");
                    $$->data =   strdup(" < decl > ");

                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$, "%s", $1);
                }
                ;

    decl_method:
                decl_method method_decl
                {
                    $$ = new     Node();
                    $$->name =   strdup(" < decl_method > ");
                    $$->data =   strdup(" < decl_method > ");

                    //$1->parent = $$;
                    $$->add_child($1);

                    //$2->parent = $$;
                    $$->add_child($2);

                    //sprintf($$, "%s %s", $1, $2);
                }
                | method_decl
                { 

                    $$ = new Node();
                    $$->name =   strdup(" < decl_method > ");
                    $$->data =   strdup(" < decl_method > ");

                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$, "%s", $1);

                }
                ;

    field_decl: //int a,b,c[10],b,c;
                type id multi_field TOKEN_SEMICOLON
                {

                    $$ = new Node();
                    $$->name =   strdup(" < field_decl > ");
                    $$->data =   strdup(" < field_decl > ");

                    //$1->parent = $$;
                    $$->add_child($1);

                    //$2->parent = $$;
                    $$->add_child($2);

                    //$3->parent = $$;
                    $$->add_child($3);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_SEMICOLON");
                    temp->data =   strdup($4);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //sprintf($$, "%s %s %s %s", $1, $2, $3, running_mode ? "TOKEN_SEMICOLON" : $4);
                }
                ;

    multi_field://a,b,c[10],b,c[20]
                TOKEN_COMMA id multi_field
                {
                    $$ = new Node();
                    $$->name =   strdup(" < multi_field > ");
                    $$->data =   strdup(" < multi_field > ");


                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_COMMA");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);

                    //$3->parent = $$;
                    $$->add_child($3);

                    //sprintf($$, "%s %s %s", running_mode ? "TOKEN_COMMA" : $1, $2, $3);
                }
                | TOKEN_LB int_literal TOKEN_RB TOKEN_COMMA id multi_field
                {

                    $$ = new Node();
                    $$->name =   strdup(" < multi_field > ");
                    $$->data =   strdup(" < multi_field > ");


                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_LB");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);

                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_RB");
                    temp2->data =   strdup($3);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    Node* temp3 = new Node();
                    temp3->name =   strdup("TOKEN_COMMA");
                    temp3->data =   strdup($4);
                    //temp3->parent = $$;
                      
                    $$->add_child(temp3);

                    //$5->parent = $$;
                    $$->add_child($5);

                    ////$2->parent = $$;
                    $$->add_child($6);

                    //sprintf($$, "%s %s %s %s %s %s", running_mode ? "TOKEN_LB" : $1, $2, running_mode ? "TOKEN_RB" : $3, running_mode ? "TOKEN_COMMA" : $4, $5, $6); 
                }
                | TOKEN_LB int_literal TOKEN_RB
                {

                    $$ = new Node();
                    $$->name =   strdup(" < multi_field > ");
                    $$->data =   strdup(" < multi_field > ");


                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_LB");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);

                    Node* temp2 = new Node();
                    temp2->name =strdup("TOKEN_RB");
                    temp2->data =      strdup($3);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    //sprintf($$, "%s %s %s", running_mode ? "TOKEN_LB" : $1, $2, running_mode ? "TOKEN_RB" : $3);
                }
                | /*epsilon*/ { $$ = new Node();
                                $$->name =   strdup(" < multi_field > ");
                                $$->data =   strdup(" < multi_field > ");

                                Node* temp = new Node();
                                temp->name = strdup("");                 
                                temp->data = strdup("");
                                $$->add_child(temp);                 
                }
                ;


    method_decl://int main(){} // int func(int a, int b){}
                header func_name TOKEN_LP func_args TOKEN_RP block
                {

                    $$ = new Node();
                    $$->name =   strdup(" < method_decl > ");
                    $$->data =   strdup(" < method_decl > ");

                    //$1->parent = $$;
                    $$->add_child($1);

                    //$2->parent = $$;
                    $$->add_child($2);

                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_LP");
                    temp2->data =   strdup($3);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    //$4->parent = $$;
                    $$->add_child($4);


                    Node* temp3 = new Node();
                    temp3->name =   strdup("TOKEN_RP");
                    temp3->data =   strdup($5);
                    //temp3->parent = $$;
                      
                    $$->add_child(temp3);

                    ////$2->parent = $$;
                    $$->add_child($6);

//                    sprintf($$, "%s %s %s %s %s %s", $1, $2, running_mode ? "TOKEN_LP" : $3, $4, running_mode ? "TOKEN_RP" : $5, $6);
                }
                ;
    
    header:     //int//bool//void
                
                TOKEN_VOIDTYPE
                {
                    $$ = new Node();
                    $$->name =   strdup(" < header > ");
                    $$->data =   strdup(" < header > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_VOIDTYPE");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //sprintf($$, "%s", running_mode ? "TOKEN_VOIDTYPE" : $1);
                }
                | type
                {
                    $$ = new Node();
                    $$->name =   strdup(" < header > ");
                    $$->data =   strdup(" < header > ");


                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$, "%s", $1);
                }
                ;

    func_name:  //func //main
                id
                {
                    $$ = new Node();
                    $$->name =   strdup(" < func_name > ");
                    $$->data =   strdup(" < func_name > ");


                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$, "%s", $1);
                }
                | TOKEN_MAINFUNC
                {
                    $$ = new Node();
                    $$->name =   strdup(" < func_name > ");
                    $$->data =   strdup(" < func_name > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_MAINFUNC");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //sprintf($$, "%s", running_mode ? "TOKEN_MAINFUNC" : $1);
                }
                ;

    func_args:  //int a//int a, int b//...
                arg 
                {
                    $$ = new Node();
                    $$->name =   strdup(" < func_args > ");
                    $$->data =   strdup(" < func_args > ");


                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$, "%s", $1);
                }
                | arg TOKEN_COMMA arg 
                { 
                    $$ = new Node();
                    $$->name =   strdup(" < func_args > ");
                    $$->data =   strdup(" < func_args > ");


                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_COMMA");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);



                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2, $3);
                }
                | arg TOKEN_COMMA arg TOKEN_COMMA arg 
                { 
                    $$ = new Node();
                    $$->name =   strdup(" < func_args > ");
                    $$->data =   strdup(" < func_args > ");


                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_COMMA");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_COMMA");
                    temp2->data =   strdup($4);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    //$5->parent = $$;
                    $$->add_child($5);

                    //sprintf($$, "%s %s %s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2, $3, running_mode ? "TOKEN_COMMA" : $4, $5);
                }
                | arg TOKEN_COMMA arg TOKEN_COMMA arg TOKEN_COMMA arg
                {
                    $$ = new Node();
                    $$->name =   strdup(" < func_args > ");
                    $$->data =   strdup(" < func_args > ");


                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_COMMA");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_COMMA");
                    temp2->data =   strdup($4);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    //$5->parent = $$;
                    $$->add_child($5);

                    Node* temp3 = new Node();
                    temp3->name =   strdup("TOKEN_COMMA");
                    temp3->data =   strdup($6);
                    //temp3->parent = $$;
                      
                    $$->add_child(temp3);

                    //$7->parent = $$;
                    $$->add_child($7);

                    //sprintf($$, "%s %s %s %s %s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2, $3, running_mode ? "TOKEN_COMMA" : $4, $5, running_mode ? "TOKEN_COMMA" : $6, $7);
                }
                | /*epsilon*/ { 

                                $$ = new Node();
                                $$->name =   strdup(" < func_args > ");
                                $$->data =   strdup(" < func_args > ");

                                Node* temp = new Node();
                                temp->name = strdup("");                 
                                temp->data = strdup("");
                                $$->add_child(temp);

                }
                ;

    arg:    //int a//bool b
                type id 
                {
                    $$ = new Node();
                    $$->name =   strdup(" < arg > ");
                    $$->data =   strdup(" < arg > ");


                    //$1->parent = $$;
                    $$->add_child($1);


                    //$2->parent = $$;
                    $$->add_child($2);

                    //sprintf($$ , "%s %s" , $1 , $2);
                }
                ;

    block:  //{dec stm}
                TOKEN_LCB var_decl statement TOKEN_RCB
                {
                    $$ = new Node();
                    $$->name =   strdup(" < block > ");
                    $$->data =   strdup(" < block > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_LCB");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);

                    //$3->parent = $$;
                    $$->add_child($3);

                    Node* temp3 = new Node();
                    temp3->name =   strdup("TOKEN_RCB");
                    temp3->data =   strdup($4);
                    //temp3->parent = $$;
                      
                    $$->add_child(temp3);

                    

                    //sprintf($$ , "%s %s %s %s" , running_mode? "TOKEN_LCB" : $1 , $2 , $3 , running_mode ? "TOKEN_RCB" : $4);
                }
                ;

    var_decl:   // int a,b,c;
                type multi_id TOKEN_SEMICOLON
                {
                    $$ = new Node();
                    $$->name =   strdup(" < var_decl > ");
                    $$->data =   strdup(" < var_decl > ");

                    //$1->parent = $$;
                    $$->add_child($1);
                    
                    //$2->parent = $$;
                    $$->add_child($2);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_SEMICOLON");
                    temp->data =   strdup($3);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);
                    
                    //sprintf($$, "%s %s %s" , $1 , $2 , running_mode ? "TOKEN_SEMICOLON" : $3);
                }
                |/*epsilon*/ {
                                $$ = new Node();
                                $$->name =   strdup(" < var_decl > ");
                                $$->data =   strdup(" < var_decl > ");

                                Node* temp = new Node();
                                temp->name = strdup("");                 
                                temp->data = strdup("");
                                $$->add_child(temp);
                 }
                ;

    statement:
                location assign_op expr TOKEN_SEMICOLON // a = 2;//a[3]=b//...
                {
                    $$ = new Node();
                    $$->name =   strdup(" < statement > ");
                    $$->data =   strdup(" < statement > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    //$2->parent = $$;
                    $$->add_child($2);
                    
                    //$3->parent = $$;
                    $$->add_child($3);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_SEMICOLON");
                    temp->data =   strdup($4);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //sprintf($$, "%s %s %s %s", $1 , $2 , $3 , running_mode ? "TOKEN_SEMICOLON" : $4);
                }
                | method_call TOKEN_SEMICOLON //callout(...)//func(...)
                {

                    $$ = new Node();
                    $$->name =   strdup(" < statement > ");
                    $$->data =   strdup(" < statement > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_SEMICOLON");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                   // sprintf($$, "%s %s", $1, running_mode ? "TOKEN_SEMICOLON" : $2);
                }
                | TOKEN_IFCONDITION TOKEN_RP expr TOKEN_LP else_stmt //if(){} else{}
                {
                    $$ = new Node();
                    $$->name =   strdup(" < statement > ");
                    $$->data =   strdup(" < statement > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_IFCONDITION");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_RP");
                    temp2->data =   strdup($2);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    //$3->parent = $$;
                    $$->add_child($3);


                    Node* temp3 = new Node();
                    temp3->name =   strdup("TOKEN_LP");
                    temp3->data =   strdup($4);
                    //temp3->parent = $$;
                      
                    $$->add_child(temp3);

                    //$5->parent = $$;
                    $$->add_child($5);


//                    sprintf($$ , "%s %s %s %s %s", running_mode ? "TOKEN_IFCONDITION" : $1 , running_mode ? "TOKEN_RP" : $2 , $3 , running_mode ? "TOKEN_LP": $4 , $5);
                }
                | TOKEN_LOOP id TOKEN_ASSIGNOP_ASS expr TOKEN_COMMA expr block // for i=0 , 10 {}
                {
                    $$ = new Node();
                    $$->name =   strdup(" < statement > ");
                    $$->data =   strdup(" < statement > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_RP");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);


                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_LP");
                    temp2->data =   strdup($3);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    //$4->parent = $$;
                    $$->add_child($4);


                    Node* temp3 = new Node();
                    temp3->name =   strdup("TOKEN_LP");
                    temp3->data =   strdup($5);
                    //temp3->parent = $$;
                      
                    $$->add_child(temp3);

                    ////$2->parent = $$;
                    $$->add_child($6);


                    //sprintf($$, "%s %s %s %s %s %s %s", running_mode ? "TOKEN_LOOP" : $1, $2, running_mode ? "TOKEN_ASSIGNOP_ASS" : $3, $4, running_mode ? "TOKEN_COMMA" : $5, $6, $7);
                }
                | TOKEN_RETURN ret_stmt TOKEN_SEMICOLON //return 20;
                {
                     $$ = new Node();
                    $$->name =   strdup(" < statement > ");
                    $$->data =   strdup(" < statement > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_RETURN");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);


                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_SEMICOLON");
                    temp2->data =   strdup($3);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                   // sprintf($$, "%s %s %s", running_mode ? "TOKEN_RETURN" : $1, $2, running_mode ? "TOKEN_SEMICOLON" : $3);
                }
                | TOKEN_BREAKSTMT TOKEN_SEMICOLON //break;
                {

                    $$ = new Node();
                    $$->name =   strdup(" < statement > ");
                    $$->data =   strdup(" < statement > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_BREAKSTMT");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);


                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_SEMICOLON");
                    temp2->data =   strdup($2);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    //sprintf($$, "%s %s", running_mode ? "TOKEN_BREAKSTMT" : $1, running_mode ? "TOKEN_SEMICOLON" : $2);
                }
                | TOKEN_CONTINUESTMT TOKEN_SEMICOLON //contineu;
                {
                    $$ = new Node();
                    $$->name =   strdup(" < statement > ");
                    $$->data =   strdup(" < statement > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_CONTINUESTMT");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_SEMICOLON");
                    temp2->data =   strdup($2);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);
                    //sprintf($$, "%s %s", running_mode ? "TOKEN_CONTINUESTMT" : $1 , running_mode ? "TOKEN_SEMICOLON" : $2);
                }
                | block
                {
                    $$ = new Node();
                    $$->name =   strdup(" < statement > ");
                    $$->data =   strdup(" < statement > ");


                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$, "%s", $1);
                }
                |/*epsilon*/ {
                                $$ = new Node();
                                $$->name =   strdup(" < statement > ");
                                $$->data =   strdup(" < statement > ");

                                Node* temp = new Node();
                                temp->name = strdup("");                 
                                temp->data = strdup("");
                                $$->add_child(temp);
                 }
                ;

    ret_stmt:
                expr 
                {
                    $$ = new Node();
                    $$->name =   strdup(" < ret_stmt > ");
                    $$->data =   strdup(" < ret_stmt > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$, "%s" , $1);
                }
                |/*epsilon*/ { 
                                $$ = new Node();
                                $$->name =   strdup(" < ret_stmt > ");
                                $$->data =   strdup(" < ret_stmt > ");

                                Node* temp = new Node();
                                temp->name = strdup("");                 
                                temp->data = strdup("");
                                $$->add_child(temp);
                }
                ;

    else_stmt:  //else {}
                TOKEN_ELSECONDITION block 
                {
                    $$ = new Node();
                    $$->name =   strdup(" < else_stmt > ");
                    $$->data =   strdup(" < else_stmt > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ELSECONDITION");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);

                    //sprintf($$, "%s %s", running_mode ? "TOKEN_ELSECONDITION" : $1, $2);
                }
                |/*epsilon*/ {
                                $$ = new Node();
                                $$->name =   strdup(" < else_stmt > ");
                                $$->data =   strdup(" < else_stmt > ");

                                Node* temp = new Node();
                                temp->name = strdup("");                 
                                temp->data = strdup("");
                                $$->add_child(temp);
                 }
                ;

    location:
                id
                {
                    $$ = new Node();
                    $$->name =   strdup(" < location > ");
                    $$->data =   strdup(" < location > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$, "%s", $1);
                }
                | id TOKEN_LB expr TOKEN_RB
                {
                    $$ = new Node();
                    $$->name =   strdup(" < location > ");
                    $$->data =   strdup(" < location > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_LB");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_RB");
                    temp2->data =   strdup($4);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);
                    
                    //sprintf($$, "%s %s %s %s", $1, running_mode ? "TOKEN_LB" : $2, $3, running_mode ? "TOKEN_RB" : $4);
                }
                ;

    assign_op:
                TOKEN_ASSIGNOP_ASS
                {
                    $$ = new Node();
                    $$->name =   strdup(" < assign_op > ");
                    $$->data =   strdup(" < assign_op > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ASSIGNOP_ASS");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     

                    $$->add_child(temp);

                    //sprintf($$, "%s", running_mode ? "TOKEN_ASSIGNOP_ASS" : $1);
                }
                | TOKEN_ASSIGNOP_ADD
                {
                    $$ = new Node();
                    $$->name =   strdup(" < assign_op > ");
                    $$->data =   strdup(" < assign_op > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ASSIGNOP_ADD");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     

                    $$->add_child(temp);

                    //sprintf($$, "%s", running_mode ? "TOKEN_ASSIGNOP_ADD" : $1);
                }
                | TOKEN_ASSIGNOP_SUB
                {
                    $$ = new Node();
                    $$->name =   strdup(" < assign_op > ");
                    $$->data =   strdup(" < assign_op > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ASSIGNOP_SUB");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     

                    $$->add_child(temp);

                    //sprintf($$, "%s", running_mode ? "TOKEN_ASSIGNOP_SUB" : $1);
                }
                ;

    expr: 
                location //a//a[3]
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$, "%s", $1);
                }
                | method_call //
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$, "%s", $1);
                }
                | literal //all literals
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);
                    
                    //sprintf($$, "%s", $1);
                }
                | expr TOKEN_ARITHMATICOP_ADD expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ARITHMATICOP_ADD");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_ARITHMATICOP_ADD" : $2, $3);
                }
                | expr TOKEN_ARITHMATICOP_SUB expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ARITHMATICOP_SUB");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_ARITHMATICOP_SUB" : $2, $3);
                }
                | expr TOKEN_ARITHMATICOP_MUL expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ARITHMATICOP_MUL");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_ARITHMATICOP_MUL" : $2, $3);
                }
                | expr TOKEN_ARITHMATICOP_DIV expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ARITHMATICOP_DIV");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

//                    sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_ARITHMATICOP_DIV" : $2, $3);
                }
                | expr TOKEN_ARITHMATICOP_REM expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ARITHMATICOP_REM");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_ARITHMATICOP_REM" : $2, $3);
                }
                | expr TOKEN_RELATIONOP_SE expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_RELATIONOP_SE");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);
                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_RELATIONOP_SE" : $2, $3);
                }
                | expr TOKEN_RELATIONOP_S expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_RELATIONOP_S");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);
                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_RELATIONOP_S" : $2, $3);
                }
                | expr TOKEN_RELATIONOP_B expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_RELATIONOP_B");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);
                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_RELATIONOP_B" : $2, $3);
                }
                | expr TOKEN_RELATIONOP_BE expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_RELATIONOP_BE");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);
                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_RELATIONOP_BE" : $2, $3);
                }
                | expr TOKEN_EQUALITYOP_E expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_EQUALITYOP_E");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);
                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_EQUALITYOP_E" : $2, $3);
                }
                | expr TOKEN_EQUALITYOP_NE expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_EQUALITYOP_NE");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);
                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_EQUALITYOP_NE" : $2, $3);
                }
                | expr TOKEN_CONDITIONOP_AND expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_CONDITIONOP_AND");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);
                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_CONDITIONOP_AND" : $2, $3);
                }         
                | expr TOKEN_CONDITIONOP_OR expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_CONDITIONOP_OR");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);
                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_CONDITIONOP_OR" : $2, $3);
                }
                | TOKEN_ARITHMATICOP_SUB expr // -a
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ARITHMATICOP_SUB");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);

                    //sprintf($$, "%s %s", running_mode ? "TOKEN_ARITHMATICOP_SUB" : $1, $2);
                }
                | TOKEN_LOGICOP expr // !true
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_LOGICOP");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);

                   // sprintf($$, "%s %s", running_mode ? "TOKEN_LOGICOP" : $1, $2);
                }
                | TOKEN_LP expr TOKEN_RP // (expr)
                {
                    $$ = new Node();
                    $$->name =   strdup(" < expr > ");
                    $$->data =   strdup(" < expr > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_LP");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);
                    
                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_RP");
                    temp2->data =   strdup($3);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    //sprintf($$, "%s %s %s", running_mode ? "TOKEN_LP" : $1, $2, running_mode ? "TOKEN_RP" : $3);
                }
                

    method_call:
                id TOKEN_LP multi_expr TOKEN_RP //func(a,b,1)
                {
                    $$ = new Node();
                    $$->name =   strdup(" < method_call > ");
                    $$->data =   strdup(" < method_call > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_LP");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_RP");
                    temp2->data =   strdup($4);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    

                    //sprintf($$, "%s %s %s %s", $1, running_mode ? "TOKEN_LP" : $2, $3, running_mode ? "TOKEN_RP" : $4);
                }
                | TOKEN_CALLOUT TOKEN_LP string_literal multi_callout_args TOKEN_RP //callout('strcmp','aab','bba')
                {
                    $$ = new Node();
                    $$->name =   strdup(" < method_call > ");
                    $$->data =   strdup(" < method_call > ");
              
                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_CALLOUT");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                    Node* temp2 = new Node();
                    temp2->name =   strdup("TOKEN_LP");
                    temp2->data =   strdup($2);
                    //temp2->parent = $$;
                      
                    $$->add_child(temp2);

                    //$3->parent = $$;
                    $$->add_child($3);

                    //$4->parent = $$;
                    $$->add_child($4);

                    Node* temp3 = new Node();
                    temp3->name =   strdup("TOKEN_LP");
                    temp3->data =   strdup($5);
                    //temp3->parent = $$;
                      
                    $$->add_child(temp3);


                    //sprintf($$, "%s %s %s %s", $1, running_mode ? "TOKEN_LP" : $2, $3, running_mode ? "TOKEN_RP" : $4);
                }
                ;
    
    multi_expr: //1,2,a,b,c//1,b//blank
                multi_expr_inner
                {
                    $$ = new Node();
                    $$->name =   strdup(" < multi_expr > ");
                    $$->data =   strdup(" < multi_expr > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$ , "%s" , $1);
                }
                |/*epsilon*/ {
                                $$ = new Node();
                                $$->name =   strdup(" < multi_expr > ");
                                $$->data =   strdup(" < multi_expr > ");

                                Node* temp = new Node();
                                temp->name = strdup("");                 
                                temp->data = strdup("");
                                $$->add_child(temp);
                 }
                ;

    multi_expr_inner://1,2,a,b,c//1,b
                expr 
                {
                    $$ = new Node();
                    $$->name =   strdup(" < multi_expr_inner > ");
                    $$->data =   strdup(" < multi_expr_inner > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$ , "%s" , $1);
                }
                | expr TOKEN_COMMA multi_expr_inner
                {      
                    $$ = new Node();
                    $$->name =   strdup(" < multi_expr_inner > ");
                    $$->data =   strdup(" < multi_expr_inner > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_COMMA");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     

                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2 , $3);
                }
                ;

    multi_callout_args:
                TOKEN_COMMA multi_callout_args_inner
                {

                    $$ = new Node();
                    $$->name =   strdup(" < multi_callout_args > ");
                    $$->data =   strdup(" < multi_callout_args > ");
              
                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_COMMA");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     

                    $$->add_child(temp);

                    //$2->parent = $$;
                    $$->add_child($2);


                    //sprintf($$, "%s %s", running_mode ? "TOKEN_COMMA" : $1, $2);
                }
                | /*epsilon*/ {
                                $$ = new Node();
                                $$->name =   strdup(" < multi_callout_args > ");
                                $$->data =   strdup(" < multi_callout_args > ");

                                Node* temp = new Node();
                                temp->name = strdup("");                 
                                temp->data = strdup("");
                                $$->add_child(temp);
                 }
                ;

    multi_callout_args_inner:
                callout_args
                {
                    $$ = new Node();
                    $$->name =   strdup(" < multi_callout_args_inner > ");
                    $$->data =   strdup(" < multi_callout_args_inner > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$ , "%s", $1);
                }
                | callout_args TOKEN_COMMA multi_callout_args_inner
                {
                    $$ = new Node();
                    $$->name =   strdup(" < multi_callout_args_inner > ");
                    $$->data =   strdup(" < multi_callout_args_inner > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_COMMA");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     

                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    
                    
                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2, $3);
                }
                ;

    callout_args:
                expr
                {
                    $$ = new Node();
                    $$->name =   strdup(" < callout_args > ");
                    $$->data =   strdup(" < callout_args > ");

                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$ , "%s", $1);
                }
                | string_literal
                {
                    $$ = new Node();
                    $$->name =   strdup(" < callout_args > ");
                    $$->data =   strdup(" < callout_args > ");
                    
                    //$1->parent = $$;
                    $$->add_child($1);

                    //sprintf($$ , "%s", $1);
                }
                ;


    type:
                TOKEN_INTTYPE
                {
                    $$ = new Node();
                    $$->name =   strdup(" < type > ");
                    $$->data =   strdup(" < type > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_INTTYPE");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     

                    $$->add_child(temp);

                    //sprintf($$, "%s", running_mode ? "TOKEN_INTTYPE" : $1);
                }
                | TOKEN_BOOLEANTYPE
                {
                    $$ = new Node();
                    $$->name =   strdup(" < type > ");
                    $$->data =   strdup(" < type > ");

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_BOOLEANTYPE");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     

                    $$->add_child(temp);

                    //sprintf($$, "%s", running_mode ? "TOKEN_BOOLEANTYPE" : $1);
                }
                ;


    multi_id:
                id
                {
                    $$ = new Node();
                    $$->name =   strdup(" < multi_id > ");
                    $$->data =   strdup(" < multi_id > ");
                    //$1->parent = $$;
                    $$->add_child($1);
                    //sprintf($$ , "%s", $1);
                    //cout << "22222222222222222222";
                }
                | multi_id TOKEN_COMMA id  
                {
                    $$ = new Node();
                    $$->name =   strdup(" < multi_id > ");
                    $$->data =   strdup(" < multi_id > ");

                    //$1->parent = $$;
                    $$->add_child($1);

                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_COMMA");
                    temp->data =   strdup($2);
                    //temp->parent = $$;
                     

                    $$->add_child(temp);

                    //$3->parent = $$;
                    $$->add_child($3);

                    //sprintf($$, "%s %s %s", $1, running_mode ? "TOKEN_COMMA" : $2, $3);
                    //cout << "111111111111111";
                }
                ;
   
    literal:
                int_literal
                {
                    $$ = new Node();
                    $$->name =   strdup(" < literal > ");
                    $$->data =   strdup(" < literal > ");
                    //$1->parent = $$;
                    $$->add_child($1);
                    //sprintf($$ , "%s", $1);
                }
                | char_literal
                {
                    $$ = new Node();
                    $$->name =   strdup(" < literal > ");
                    $$->data =   strdup(" < literal > ");
                    //$1->parent = $$;
                    $$->add_child($1);
                    //sprintf($$ , "%s", $1);
                }
                | bool_literal
                {
                    $$ = new Node();
                    $$->name =   strdup(" < literal > ");
                    $$->data =   strdup(" < literal > ");
                    //$1->parent = $$;
                    $$->add_child($1);
                    //sprintf($$ , "%s", $1);
                }
                ;

    int_literal: 
                decimal_literal
                {
                    $$ = new Node();
                    $$->name =   strdup(" < int_literal > ");
                    $$->data =   strdup(" < int_literal > ");
                    //$1->parent = $$;
                    $$->add_child($1);
                    //sprintf($$ , "%s", $1);
                }
                | hex_literal
                {
                    $$ = new Node();
                    $$->name =   strdup(" < int_literal > ");
                    $$->data =   strdup(" < int_literal > ");
                    //$1->parent = $$;
                    $$->add_child($1);
                    //sprintf($$ , "%s", $1);
                }
                ;
    id:
                TOKEN_ID
                {
                    $$ = new Node();
                    $$->name =   strdup(" < id > ");
                    $$->data =   strdup(" < id > ");
                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_ID");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);
            
                    //sprintf($$ , "%s", running_mode ? "TOKEN_ID" : $1);
                }
                ;
     decimal_literal:
                TOKEN_DECIMALCONST
                {
                    $$ = new Node();
                    $$->name =   strdup(" < decimal_literal > ");
                    $$->data =   strdup(" < decimal_literal > ");
                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_DECIMALCONST");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);
                    //sprintf($$ , "%s", running_mode ? "TOKEN_DECIMALCONST" : $1);
                }
                ;
    hex_literal:
                TOKEN_HEXADECIMALCONST
                {
                    $$ = new Node();
                    $$->name =   strdup(" < hex_literal > ");
                    $$->data =   strdup(" < hex_literal > ");
                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_HEXADECIMALCONST");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);
                    //sprintf($$ , "%s", running_mode ? "TOKEN_HEXADECIMALCONST" : $1);
                }
                ;
    bool_literal:
                TOKEN_BOOLEANCONST
                {
                    $$ = new Node();
                    $$->name =   strdup(" < bool_literal > ");
                    $$->data =   strdup(" < bool_literal > ");
                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_BOOLEANCONST");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);
                    //sprintf($$ , "%s", running_mode ? "TOKEN_BOOLEANCONST" : $1);
                }
                ;
    char_literal:
                TOKEN_CHARCONST
                {
                    $$ = new Node();
                    $$->name =   strdup(" < char_literal > ");
                    $$->data =   strdup(" < char_literal > ");
                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_CHARCONST");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);
                    //sprintf($$ , "%s", running_mode ? "TOKEN_CHARCONST" : $1);
                }
                ;
    string_literal:
                TOKEN_STRINGCONST
                {
                    $$ = new Node();
                    $$->name =   strdup(" < string_literal > ");
                    $$->data =   strdup(" < string_literal > ");
                    Node* temp = new Node();
                    temp->name =   strdup("TOKEN_STRINGCONST");
                    temp->data =   strdup($1);
                    //temp->parent = $$;
                     
                    $$->add_child(temp);

                   // sprintf($$ , "%s", running_mode ? "TOKEN_STRINGCONST" : $1);
                }
                ;
    
%%


int main(int argc, char **argv)
{
    running_mode = *argv[1] == '1' ? 1 : 0;

	yyin = fopen("code.x", "r");
	yyout = fopen("output.txt", "w");
	yyparse();
	return 0;
}   


int yyerror(const char* message) {
    cout << "\n\n================ERROR===============\n\n"<<endl;
    cout << message << endl;
    return 0;
}
