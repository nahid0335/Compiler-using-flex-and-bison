
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID = 258,
     NUMBER = 259,
     STR = 260,
     GREATEREQUAL = 261,
     LESSEQUAL = 262,
     GREATERTHEN = 263,
     LESSTHEN = 264,
     MINUS = 265,
     PLUS = 266,
     DIVIDE = 267,
     MULTIPLY = 268,
     INT = 269,
     DOUBLE = 270,
     CHAR = 271,
     MAIN = 272,
     PB = 273,
     PE = 274,
     BB = 275,
     BE = 276,
     SEMI_COLON = 277,
     COMMA = 278,
     ASSIGN = 279,
     PRINTVAR = 280,
     PRINTSTR = 281,
     PRINTLN = 282,
     PRINTFUNC = 283,
     DIVIVE = 284,
     MOD = 285,
     FACT = 286,
     IF = 287,
     ELSE = 288,
     ELSEIF = 289,
     FOR = 290,
     INC = 291,
     TO = 292,
     SWITCH = 293,
     DEFAULT = 294,
     COLON = 295,
     FUNCTION = 296,
     EQUAL = 297,
     NOTEQUAL = 298,
     LOGFUNC = 299,
     LOG10FUNC = 300,
     TANFUNC = 301,
     MAXNUMBER = 302,
     MINNUMBER = 303,
     COMPARE = 304,
     COMPAREREVERSE = 305,
     REVERSE = 306,
     SORT = 307,
     SINFUNC = 308,
     COSFUNC = 309,
     GCDFUNC = 310,
     LCMFUNC = 311,
     POWERFUNC = 312,
     IFX = 313,
     UMINUS = 314,
     SH = 315
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 25 "1607005.y"

  char text[1000];
  int val;



/* Line 1676 of yacc.c  */
#line 119 "1607005.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


