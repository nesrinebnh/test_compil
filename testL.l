/* ce fichier contient les entitées lexical */
%{
#include<stdio.h>
#include<string.h>
#include "projet_syntaxique.tab.h"
extern YYSTYPE yylval;
int line = 0;
int colonne = 0;
%}
debut "DEBUT"
fin "FIN"
inst "INST"
fin "FIN"
int 0|[1-9][0-9]*
reel [0-9]+"."[0-9]+
idf [A-Z][a-z0-9]*
separator " "|\t

%%

{int} {
	colonne = colonne +yyleng;
	yylval.entier = atoi(yytext);
	return entier;
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