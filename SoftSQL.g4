// Grammar EasySQL: gramática simplificada de SQL em português/inglês
grammar EasySQL;

// Regra inicial: programa consiste em uma única query seguida de EOF
prog
    : query EOF
    ;

// Definição das diferentes formas de query suportadas
query
    // SELECT: MOSTRAR [DISTINTO] campos DE tabela [POR grupos] [ONDE condicoes];
    : 'MOSTRAR' DISTINTO? campos 'DE' IDENTIFICADOR ('POR' grupos)? ('ONDE' condicoes)? SEMICOLON

    // INSERT: INSERIR EM tabela (colunas)? VALORES tuplas;
    | 'INSERIR EM' IDENTIFICADOR ('(' colunas ')')? 'VALORES' tuplas SEMICOLON

    // DELETE customizado: REMOVER DE tabela [ONDE condicoes];
    | 'REMOVER DE' IDENTIFICADOR ('ONDE' condicoes)? SEMICOLON

    // DROP TABLE: DELETAR TABELA tabela;
    | 'DELETAR TABELA' IDENTIFICADOR SEMICOLON

    // CREATE TABLE: CRIAR TABELA tabela (definicoes);
    | 'CRIAR TABELA' IDENTIFICADOR '(' definicoes ')' SEMICOLON

    // UPDATE: ATUALIZAR tabela DEFINIR atualizacoes [ONDE condicoes];
    | 'ATUALIZAR' IDENTIFICADOR 'DEFINIR' atualizacoes ('ONDE' condicoes)? SEMICOLON
    ;

// Lista de campos separados por vírgula
campos
    : campo (',' campo)*
    ;

// Campo pode ser agregação, DISTINCT ou nome simples
campo
    : AGREGADOR '(' (DISTINTO IDENTIFICADOR | IDENTIFICADOR) ')'    // SUM(coluna), COUNT(DISTINCT col)
    | DISTINTO IDENTIFICADOR                                        // SELECT DISTINCT coluna
    | IDENTIFICADOR                                                 // coluna simples
    ;

// Palavra-chave DISTINCT em PT/EN
distinto
    : 'DIFERENTES' | 'DISTINCT'
    ;

// Conjunto de tuplas para INSERT: (valores),(...)
tuplas
    : '(' valores ')' (',' '(' valores ')')*
    ;

// Lista de definições de colunas em CREATE TABLE
definicoes
    : definicao (',' definicao)*
    ;

definicao
    : IDENTIFICADOR tipo_dado    // nome_coluna tipo_dado
    ;

// Lista de atualizações em UPDATE: coluna=valor, ...
atualizacoes
    : IDENTIFICADOR '=' valor ( ',' IDENTIFICADOR '=' valor)*
    ;

// Lista de colunas para GROUP BY
grupos
    : IDENTIFICADOR (',' IDENTIFICADOR)*
    ;

// Conjunto de condições unidas por 'E'
condicoes
    : condicao ('E' condicao)*
    ;

// Condição simples ou com agregador
condicao
    : IDENTIFICADOR operador valor                                // coluna operacao valor
    | AGREGADOR '(' IDENTIFICADOR ')' operador valor               // SUM(coluna) > valor
    ;

// Lista de colunas em INSERT (título de colunas)
colunas
    : IDENTIFICADOR (',' IDENTIFICADOR)*
    ;

// Lista de valores em cada tupla de INSERT
valores
    : valor (',' valor)*
    ;

// Operadores de comparação suportados
operador
    : '=' | '<' | '>' | '<=' | '>=' | '!='
    ;

// Literal de valor: string, número, booleano ou NULL
valor
    : STRING
    | NUMERO
    | BOOLEANO
    | 'NULL'
    ;

// Lexer rules abaixo:

// STRING: aspas simples ignoram quebra de linha
STRING
    : '\'' (~['\r\n])* '\''
    ;

// NUMERO: inteiro ou decimal com sinal opcional
NUMERO
    : '-'? [0-9]+ ('.' [0-9]+)?
    ;

// BOOLEANO: True/False
BOOLEANO
    : 'True' | 'False'
    ;

// Tipos de dados suportados em definições de tabela
tipo_dado
    : 'INT'
    | 'SMALLINT'
    | 'BIGINT'
    | 'FLOAT'
    | 'REAL'
    | 'DOUBLE'
    | 'DECIMAL' '(' NUMERO ',' NUMERO ')'
    | 'NUMERIC' '(' NUMERO ',' NUMERO ')'
    | 'CHAR' '(' NUMERO ')'
    | 'VARCHAR' '(' NUMERO ')'
    | 'TEXT'
    | 'NCHAR' '(' NUMERO ')'
    | 'NVARCHAR' '(' NUMERO ')'
    | 'BOOLEAN'
    | 'DATE'
    | 'TIME'
    | 'DATETIME'
    | 'TIMESTAMP'
    | 'YEAR'
    | 'BLOB'
    | 'VARBINARY' '(' NUMERO ')'
    | 'JSON'
    | 'XML'
    | 'GEOMETRY'
    ;


// Funções de agregação em PT/EN
agregador
    : 'SOMA' | 'CONTAGEM' | 'MEDIA' | 'MAX' | 'MIN' | 'AVG' | 'SUM' | 'COUNT'
    ;

// IDENTIFICADOR: nomes de tabelas/colunas
IDENTIFICADOR
    : [a-zA-Z_][a-zA-Z_0-9]*
    ;

// Ponto-e-vírgula final de instrução
SEMICOLON
    : ';'
    ;

// Espaços em branco são ignorados
WS
    : [ \t\r\n]+ -> skip
    ;
