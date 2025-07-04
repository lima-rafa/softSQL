# Easy SQL: SQL em Português para Pessoas Simples

**Grupo**
- Rafael Lima
- Evandson César
- Roberth Lins
- Mateus Gonçalves

**Easy SQL** é uma implementação didática de SQL em português, pensada para tornar comandos de banco de dados mais acessíveis e intuitivos para iniciantes e usuários sem experiência prévia em programação.

---

## 💡 Objetivo

- Traduzir os principais comandos de SQL para o português (e termos familiares), mantendo a mesma semântica da linguagem original.
- Facilitar o aprendizado e o uso de consultas de banco de dados por qualquer pessoa, independentemente do seu background técnico.
- Permitir escrever e executar comandos em português que são analisados, traduzidos para SQL padrão e executados em um banco SQLite local.

### Principais facilidades do Easy SQL

1. **Sintaxe em Português**: comandos como `MOSTRAR`, `INSERIR EM`, `REMOVER DE`, `CRIAR TABELA`, etc.
2. **Agregadores traduzidos**: `SOMA`/`SUM`, `CONTAGEM`/`COUNT`, `MÉDIA`/`AVG`, `MAX`, `MIN`.
3. **Alternativa para `*`**: uso de `TUDO` para selecionar todas as colunas de uma tabela.
4. **Interação simples**: ambiente interativo em linha de comando, sem necessidade de scripts SQL separados.

## **Como executar o projeto**

### 1. Criar um ambiente virtual:
```
python -m venv venv
```

### 2. Ativar o ambiente virtual:

venv\Scripts\activate

### 3. Instalar o ANTLR:

```
wget https://www.antlr.org/download/antlr-4.13.2-complete.jar
pip install antlr4-python3-runtime
```

### 4. Rodar a gramática:

```
java -jar antlr.jar -Dlanguage=Python3 SoftSQL.g4
```

### 5. Rodar o códiog:

```
python main.py
```

### 6. Interagir com o Easy SQL:

Após rodar o código, digite os comandos desejados. Para encerrar a execução, pressione apenas a tecla Enter (deixe a entrada vazia).

---

## **Exemplo de código:**

### 1. Tabela Com Produtos de Uma Loja

```
CRIAR TABELA produtos (nome VARCHAR(50),marca VARCHAR(100), preco FLOAT);

INSERIR EM produtos VALORES ('Notebook','DELL', 3500.00);
INSERIR EM produtos VALORES ('Notebook','Lenovo', 2500.00), ('Mouse','Multilaser', 14.99), ('Monitor','Philips', 2000.00);

MOSTRAR SOMA(preco) DE produtos;

ATUALIZAR produtos DEFINIR preco = 20 ONDE marca = 'Multilaser';

MOSTRAR TUDO DE produtos;

REMOVER DE produtos ONDE preco > 3000;

DELETAR TABELA produtos;
```

### 2. Tabela com Informação de Atletas

```
CRIAR TABELA atletas (nome VARCHAR(50),esporte VARCHAR(100),idade INT, aposentado BOOLEAN);

INSERIR EM atletas VALORES ('Cristiano Ronaldo','Futebol', 39, False), ('Chris Bumstead','Fisiculturismo', 29, False),('Mike Tyson','Boxe', 59, True), ('Tiger Woods','Golf', 48, True), ('LeBron James','Basquete', 39, False);

MOSTRAR MEDIA(idade) DE atletas;

ATUALIZAR atletas DEFINIR aposentado = True ONDE nome = 'Chris Bumstead';

MOSTRAR TUDO DE atletas ONDE aposentado = True;

REMOVER DE atletas ONDE esporte = 'Golf';

DELETAR TABELA atletas;
```
