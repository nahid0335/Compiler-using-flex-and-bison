%{
	#include "1607005.tab.h"
	#include <string.h>
	int yyparse();
	int yylex();
	int yyerror();
	void InvalidToken();
%}



char [a-zA-Z]
digit [0-9]
special [$_@]
space [ \t\r\v\f]
newline "\n"

%option yylineno




%%

"@@include".+\n 	{/*header*/}
"!-".*\n 			{/*This is comment*/}
"$"[^$]*"$" 		{/*multi line comment*/}
";"			 		{return SEMI_COLON;}
"," 		 		{return COMMA;}
{digit}+ 			{yylval.val = atoi(yytext); return NUMBER;}

"main" 						{ return MAIN;}
"tout>>" 					{ return PRINTVAR;}
"touts>>" 					{ return PRINTSTR;}
"toutn>>" 					{ return PRINTLN;}
"toutf>>"					{ return PRINTFUNC;}

"func->"({char}|{digit}|{special})+ 		{ return FUNCTION;}



"int" 			{  return INT;}
"double" 		{ return DOUBLE;}
"char" 			{ return CHAR;}

"(" 			{ return PB;}
")" 			{ return PE;}

"{" 			{ return BB;}
"}" 			{ return BE;}

"=" 			{return ASSIGN;}
"+" 			{return PLUS;}
"-" 			{return MINUS;}
"*" 			{return MULTIPLY;}
"/" 			{return DIVIDE;}
"%" 			{return MOD;}
"<" 			{return LESSTHEN;}
">" 			{return GREATERTHEN;}
"<=" 			{return LESSEQUAL;}
">=" 			{return GREATEREQUAL;}
"==" 			{return EQUAL;}
"!=" 			{return NOTEQUAL;}

"MAX"  			{return MAXNUMBER;}
"MIN"  			{return MINNUMBER;}
"CMP" 			{return COMPARE;}
"CMPR" 			{return COMPAREREVERSE;}
"REV" 			{return REVERSE;}
"SORT" 			{return SORT;}
"FACT"			{return FACT;}
"sin" 			{return SINFUNC;}
"cos" 			{return COSFUNC;}
"tan" 			{return TANFUNC;}
"log10"			{return LOG10FUNC;}
"log" 			{return LOGFUNC;}
"gcd" 			{return GCDFUNC;}
"lcm" 			{return LCMFUNC;}
"pow" 			{return POWERFUNC;}

"elseif"		{return ELSEIF;}
"if"			{ return IF;}
"else"			{return ELSE;}

"for"			{return FOR;}
"IncrementBy"	{return INC;}
"..."			{return TO;}

"switch"		{return SWITCH;}
"default"				{return DEFAULT;}
":"				{return COLON;}

"\""(.)*"\"" 	{strcpy(yylval.text,yytext);return STR;}
({char}|{digit}|{special})+ 		{ strcpy(yylval.text,yytext); return ID;}
{space}|{newline} {}

. 				{InvalidToken();}






%%


int yywrap()
{
	return 1;
}


void InvalidToken(){
    printf("ERROR ON LINE %d : \n Invalid Token \n", yylineno);
    exit(0);
}


int main(){
	yyin = freopen("input.txt","r",stdin);
	freopen("output.txt","w",stdout);
	yyparse();
}