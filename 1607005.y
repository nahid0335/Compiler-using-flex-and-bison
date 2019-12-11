/* C Declarations */

%{
	#include<stdio.h>
	#include<stdlib.h>
	#include <string.h>
	#include <math.h>

	#include "langFunction.h"

	int yyparse();
	int yylex();
	int yyerror();
	extern int yylineno;

	int isdeclared(char*);
	int addnewval(char*,int );
	int getval(char*);
	int setval(char* , int );
   


%}

%union {
  char text[1000];
  int val;
}


%token <text>  ID
%token <val>  NUMBER
%token <text> STR

%type <val> expression
%type <val> testament

%left LESSTHEN GREATERTHEN LESSEQUAL GREATEREQUAL
%left PLUS MINUS
%left MULTIPLY DIVIDE



%token	INT DOUBLE CHAR MAIN PB PE BB BE SEMI_COLON COMMA ASSIGN PRINTVAR PRINTSTR PRINTLN PRINTFUNC
%token	PLUS MINUS MULTIPLY DIVIVE LESSTHEN GREATERTHEN LESSEQUAL GREATEREQUAL MOD FACT
%token	IF ELSE ELSEIF FOR INC TO SWITCH DEFAULT COLON FUNCTION EQUAL NOTEQUAL LOGFUNC LOG10FUNC TANFUNC
%token	MAXNUMBER MINNUMBER COMPARE COMPAREREVERSE REVERSE SORT SINFUNC COSFUNC GCDFUNC LCMFUNC POWERFUNC


%nonassoc IFX
%nonassoc ELSE
%nonassoc UMINUS
%left SH


%%

starthere 	: function program function { printf("\n\n\n****Compilation Successful****\n\n"); }
			;

program		: INT MAIN PB PE BB statement BE 
			;
statement	: /* empty */
			| statement declaration
			| statement print
			| statement expression 
			| statement ifelse
			| statement assign
			| statement forloop
			| statement switch
			| statement looplifecycle  
			| statement testament
			;


looplifecycle	: /* empty */
			| looplifecycle loopstatement
			;

iflifecycle	: /* empty */
			| iflifecycle ifstatement
			;



/*--------declaration begin--------*/


declaration : type variables SEMI_COLON {}
			;
type		: INT | DOUBLE | CHAR {}
			;
variables	: variable COMMA variables {}
			| variable {}
			;
variable   	: ID 							{//printf("%s\n",$1);
												int x = addnewval($1,0);
												if(!x) {
													printf("Compilation Error:\nLine no: %d   Variable %s is already declared\n",yylineno,$1);
													exit(-1);
												}

											}
			| ID ASSIGN expression 			{//printf("%s %d\n",$1,$3);
												int x = addnewval($1,$3);
												if(!x) {
													printf("Compilation Error:\nLine no: %d   Variable %s is already declared\n",yylineno,$1);
													exit(-1);
													}
											}
			| ID ASSIGN testament 			{//printf("%s %d\n",$1,$3);
												int x = addnewval($1,$3);
												if(!x) {
													printf("Compilation Error:\nLine no: %d   Variable %s is already declared\n",yylineno,$1);
													exit(-1);
													}
											}

			;

/*-------declaration end----------*/

/*------variable assign begin-----*/

testament : 	  MAXNUMBER PB expression PE SEMI_COLON		{ printf("%d\n",$3);}
				| MINNUMBER PB expression PE SEMI_COLON		{ printf("%d\n",$3);}
				| SINFUNC PB expression PE SEMI_COLON 		{ printf("%lf\n",sin($3*3.1416/180));}
				| COSFUNC PB expression PE SEMI_COLON 		{ printf("%lf\n",cos($3*3.1416/180));}
				| TANFUNC PB expression PE SEMI_COLON		{ printf("%lf\n",tan($3*3.1416/180));}
				| LOG10FUNC PB expression PE SEMI_COLON		{ printf("%lf\n",(log($3*1.0)/log(10.0)));}
				| LOGFUNC PB expression PE SEMI_COLON		{ printf("%lf\n",(log($3)));}
				| PB expression  PE SEMI_COLON				{ $$=$2;}
				| FACT PB expression PE SEMI_COLON			{ int n=$3;
																int ans=1,i;
																for(i=n;i>1;i--)
																	ans*=i;
																printf("%d\n",ans);
															}
				| REVERSE PB STR PE SEMI_COLON				{ int l = strlen($3);
																int i;
																for(i = l-2;  i >0; i--) 
																	printf("%c",$3[i]);
															}
				| SORT PB STR PE SEMI_COLON					{ int l = strlen($3);
																int i,j;
																for(i=1; i<l-1; i++)
																{
																	for(j=i+1; j<l-1; j++)
																	{
																		if($3[i] > $3[j])
																		{
																			char temp     = $3[i];
																			$3[i] = $3[j];
																			$3[j] = temp;
																		}
																	}
																}
																for(i = 1;  i < l-1; i++) 
																	printf("%c",$3[i]);
															}
				;


assign : ID ASSIGN expression SEMI_COLON 					{	if(!isdeclared($1)) {
																	printf("Compilation Error:\nLine no: %d   Variable %s is not declared\n",yylineno,$1);
																	exit(-1);
																}
																else{
																	setval($1,$3);
																}
															}
		|ID ASSIGN testament SEMI_COLON 					{	if(!isdeclared($1)) {
																	printf("Compilation Error:\nLine no: %d   Variable %s is not declared\n",yylineno,$1);
																	exit(-1);
																}
																else{
																	setval($1,$3);
																}
															}
		;

/*------variable assign end-------*/


/*--------printing begin----------*/

print		: PRINTVAR PB ID PE SEMI_COLON 					{	if(!isdeclared($3)){
																	printf("Compilation Error:\nLine no: %d   Variable %s is not declared\n",yylineno,$3);
																	exit(-1);
																}
																else{
																	int v = getval($3);
																	printf("%d",v);
																}
															}
			| PRINTSTR PB STR PE SEMI_COLON 				{	int l = strlen($3);
																int i;
																for(i = 1;  i < l-1; i++) 
																	printf("%c",$3[i]);
															}
			| PRINTLN PB PE	SEMI_COLON 						{	printf("\n");}
			
			| PRINTFUNC testament
			;

ifstatement		: PRINTVAR PB ID PE SEMI_COLON 				{	pop++;
																if(!isdeclared($3)){
																	printf("Compilation Error:\nLine no: %d   Variable %s is not declared\n",yylineno,$3);
																	exit(-1);
																}
																else{
																	mark=1;
																	v1[pop] = getval($3);
																}							
															}
				| PRINTSTR PB STR PE SEMI_COLON 			{	pop++;
																mark=2;
																strcpy(keep[pop],$3);	
															}
			| PRINTLN PB PE	SEMI_COLON 						{	pop++;
																mark=3;
															}
			;
			
loopstatement		: PRINTVAR PB ID PE SEMI_COLON 			{
																if(!isdeclared($3)){
																	printf("Compilation Error:\nLine no: %d   Variable %s is not declared\n",yylineno,$3);
																	exit(-1);
																}
																else{
																	
																	mark=1;
																	v1[3] = getval($3);
																}
															}
			| PRINTSTR PB STR PE SEMI_COLON 				{
																mark = 2;
																strcpy(keep[3],$3);
															}
			| PRINTLN PB PE	SEMI_COLON 						{
																mark = 3;
															}
			;


/*--------printing end------------*/

/*--------expression Begin--------*/

expression : NUMBER 							{ $$ = $1;}
			| ID 								{ if(!isdeclared($1)) {
														printf("Compilation Error:\nLine no: %d   Variable %s is not declared\n",yylineno,$1);
														exit(-1);
													}
												  else{
													$$ = getval($1);
													}
												}
			| MINUS expression %prec UMINUS		{ $$ = -$2;}
			| expression PLUS expression 		{ $$ = $1 + $3;}
			| expression MINUS expression 		{ $$ = $1 - $3;}
			| expression MULTIPLY expression 	{ $$ = $1 * $3;}
			| expression DIVIDE expression 		{ if($3) {
 													$$ = $1 / $3;
													}
				  								  else {
													$$ = 0;
													printf("\nRuntime Error:\nLine no: %d   division by zero\n",yylineno);
													exit(-1);
													} 
												}
			| expression MOD expression 		{ if($3)
													$$ = $1 % $3;
												else
													$$=0;
												}
			| expression COMPARE expression 	{ if($1>$3) 
													$$=$1;
												  else 
												  	$$=$3;
												}
			| expression COMPAREREVERSE expression { if($3>$1) 
														$$=$1;
													 else 
													 	$$=$3;
													}
			| expression GCDFUNC expression 		{ int n1=$1;
														int n2=$3;
														while(n1!=n2)
														{
															if(n1 > n2)
																n1 -= n2;
															else
																n2 -= n1;
														}
														//printf("%d\n",n1);
														$$ = n1;
													}
			| expression LCMFUNC expression 		{ int n1=$1;
														int n2=$3;
														int a=n1*n2;
														while(n1!=n2)
														{
															if(n1 > n2)
																n1 -= n2;
															else
																n2 -= n1;
														}
														n1=a/n1;
														//printf("%d\n",n1);
														$$ = n1;
													}
			| expression POWERFUNC expression 		{ int n1=$1;
														int n2=$3;
														int ans=1;
														while(n2)
														{
															ans*=n1;
															n2--;
														}
														//printf("%d\n",ans);
														$$ = ans;
													}
			| expression LESSTHEN expression		{ $$ = $1 < $3; }
			| expression GREATERTHEN expression		{ $$ = $1 > $3; }
			| expression LESSEQUAL expression		{ $$ = $1 <= $3; }
			| expression GREATEREQUAL expression	{ $$ = $1 >= $3; }
			| expression EQUAL expression			{ $$ = $1 == $3; }
			| expression NOTEQUAL expression		{ $$ = $1 != $3; }
			| PB expression PE						{$$ = $2;}
			;


/*--------expression Begin--------*/


/*---------ifelse begin----------*/

ifelse 	: IF PB ifexp PE BB iflifecycle BE elseif		{	ifdone[ifptr] = 0;
															ifptr--;
														
															if(mark1){
																if(mark==1){
																	printf("%d",v1[0]);
																}
																else if(mark==2){
																	int i;
																	int l=strlen(keep[0]);
																	for(i = 1;  i < l-1; i++) 
																		printf("%c",keep[0][i]);
																}
																else{
																	printf("\n");
																}
															}
														}
		;
ifexp	: expression 								{	ifptr++;
														ifdone[ifptr] = 0;
														pop = -1;
														mark1 = 0;
														if($1){
															mark1 = 1;
															ifdone[ifptr] = 1;
														}
													}
		;
elseif 	: /* empty */
		| elseif ELSEIF PB expression PE BB iflifecycle BE	{	if($4 && ifdone[ifptr] == 0){
																	ifdone[ifptr] = 1;
																	if(mark==1){
																		printf("%d",v1[1]);
																	}
																	else if(mark==2){
																		int i;
																		int l=strlen(keep[1]);
																		for(i = 1;  i < l-1; i++) 
																			printf("%c",keep[1][i]);
																	}
																	else{
																		printf("\n");
																	}
																}
															}
		| elseif ELSE BB iflifecycle BE						{	if(ifdone[ifptr] == 0){
																	ifdone[ifptr] = 1;
																	if(mark==1)
																	{
																		printf("%d",v1[2]);
																	}
																	else if(mark==2)
																	{
																		int i;
																		int l=strlen(keep[2]);
																		for(i = 1;  i < l-1; i++) 
																			printf("%c",keep[2][i]);
																	}
																	else
																	{
																		printf("\n");
																	}
																}
															}

		;

/*---------ifelse end------------*/


/*------foor loop begin----------*/


forloop	: FOR PB expression TO expression COLON expression PE BB looplifecycle BE 	
					{
						int start = $3;
						int end = $5;
						int dif = $7;
						int count = 0;
						int i = 0;
						finaldif=dif;
						for(i = start; i <= end; i += dif){
							count++;
						}	
						savestate = count;
						if(mark==1){
							int k=0;
							for(k = 1; k <= savestate; k += finaldif){
								printf("%d",v1[3]);
							}
						}
						else if(mark==2){
							int l = strlen(keep[3]);
							int k = 0,i=0;
							for(k = 1; k <= savestate; k += finaldif){
								for(i = 1;  i < l-1; i++) { 
									printf("%c",keep[3][i]);
								}
							}
						}
						else{
							int k = 0;
							for(k = 1; k <= savestate; k += finaldif){
								printf("\n");
							}
						}
						
					}
		;


/*------foor loop end------------*/


/*------switch case begin--------*/

switch	: SWITCH PB expswitch PE BB switchinside BE 
		;

expswitch 	:  expression 				{	switchdone = 0;
											switchvar = $1;
										}
			;


switchinside	: /* empty */
				| switchinside expression COLON BB looplifecycle BE 	{	if($2 == switchvar){
																			if(mark==1){
																				printf("%d\n",v1[3]);
																			}
																			else if(mark==2){
																				int l = strlen(keep[3]);
																				int i=0;
																				for(i = 1;  i < l-1; i++) { 
																						printf("%c",keep[3][i]);
																					}
																			}
																			else{
																				printf("\n");
																			}
																			switchdone = 1;
																		}					
																	}
				| switchinside DEFAULT COLON BB looplifecycle BE 		{	if(switchdone == 0){
																			if(mark==1){
																				printf("%d\n",v1[3]);
																			}
																			else if(mark==2){
																				int l = strlen(keep[3]);
																				int i=0;
																				for(i = 1;  i < l-1; i++) { 
																						printf("%c",keep[3][i]);
																					}
																			}
																			else{
																				printf("\n");
																			}
																			switchdone = 1;
																		}
																	}
				;


/*------switch case end----------*/

/*------function begin-----------*/

function 	: /* empty */
			| function func
			;

func 	: type FUNCTION PB fparameter PE BB statement BE	{	printf("User DEfine Function Declared\n");}
		;
fparameter 	: /* empty */
			| type ID fsparameter
			;
fsparameter : /* empty */
			| fsparameter COMMA type ID
			;


/*-------function end------------*/
%%


int yyerror(char *s){
	printf( "\nError on Line %d:\n %s\n",yylineno, s);
}
