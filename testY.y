%{
	#include<stdio.h>
	extern FILE *yyin;
	int yylex();
	int yyerror(char* msg);
	
%}
%union{
	char *chaine;
	int entier;
	float reel;
}
%token '+' '-' '*' '/' '=' ')' '(' ';' ','

%token <chaine> idf DEBUT FIN INST INT REEL
%token <entier> Int
%token <reel> reel

%left '-' '+'
%left '*' '/'
 
%%
S: DEBUT dec INST inst FIN {printf("programme correcte\n");}
;
dec: type listP ';' | type listP ';' dec  {printf("declaration\n");}
;
type: INT {printf("type int\n");} | REEL
;
listP: idf ',' listP {printf("liste\n");}| idf {printf("idf\n");} 
 ;
inst: affectation ';' inst {printf("affectation boucle\n");} | affectation ';'{printf("affectation\n");}
;
affectation: idf '=' expression {printf("idf =\n");}
;
expression: idf operateur expression
	  | '(' '-' idf ')' operateur expression
	  | valeur operateur expression
	  | '(' '-' valeur ')' operateur expression
	  | '(' expression ')' operateur expression
	  | idf
	  | '(' '-' idf ')'
	  | '(' '-' valeur ')'
	  | valeur
	  |'('expression ')'
;
operateur: '+' | '-' | '*' | '/'
;
valeur: Int |reel
;
%%
int yyerror(char* msg)
{printf("%s",msg);
return 1;
}
int main()
{
yyin=fopen("sujet.txt","r");
yyparse();
return 0;
}
