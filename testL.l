/* ce fichier contient les entitées lexical */
%{
#include<stdio.h>
#include<string.h>
#include "testY.tab.h"
extern YYSTYPE yylval;
int line = 0;
int colonne = 0;
%}
tint "INT"
treel "REEL"
debut "DEBUT"
inst "INST"
fin "FIN"
int 0|[1-9][0-9]*
reel [0-9]+"."[0-9]+
idf [A-Z][a-z0-9]*
separateur " "|\t

%%

{int} {
	colonne = colonne +yyleng;
	yylval.entier = atoi(yytext);
	return Int;
}

{reel} {
	colonne ++;
	yylval.reel = atoi(yytext);
	return reel;
}

{idf} {
	colonne = colonne +yyleng;
	if(yyleng > 5) printf("erreur\n");
	else {
		yylval.chaine = strdup(yytext);
		return idf;
	}
}

{separateur} {colonne ++;}

"+" {colonne ++; return '+';}
"-" {colonne ++; return '-';}
"*" {colonne ++; return '*';}
"/" {colonne ++; return '/';}
"=" {colonne ++; return '=';}
")" {colonne ++; return ')';}
"(" {colonne ++; return '(';}
"," {colonne ++; return ',';}
";" {colonne ++; return ';';}

{tint} {
	colonne ++;
	yylval.chaine = strdup(yytext);
	return INT;
}

{treel} {
	colonne ++;
	yylval.chaine = strdup(yytext);
	return REEL;
}


[\n] { line ++; colonne = 0;}
{debut} {
	colonne ++;
	yylval.chaine = strdup(yytext);
	return DEBUT;
}

{inst} {
	colonne ++;
	yylval.chaine = strdup(yytext);
	return INST;
}

{fin} {
	colonne ++;
	yylval.chaine = strdup(yytext);
	return FIN;
}

.	{printf("ERROR, line= %d colonne= %d\n",line,colonne);}
%%
int yywrap(void)
{
return 0;
}