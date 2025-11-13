# Modelagem de Banco de Dados e Versionamento para Pequeno Comércio

**Autor:** Vinícius da Conceição Teixeira  
**Disciplina:** Projeto Integrador de Tecnologia da Informação II  
**Instituição:** UFMS 
**Período:** 2025.2

---

## 📖 Sobre o Projeto

Este projeto demonstra a aplicação prática de conceitos de **Modelagem de Banco de Dados Relacional** e **Controle de Versão (Git/GitHub)**, desenvolvido como atividade avaliativa do módulo.

### Objetivo

Criar uma estrutura robusta de banco de dados para um sistema de gerenciamento de vendas e produtos de pequeno comércio (livraria, cafeteria, padaria, etc.), aplicando:

- ✅ Modelagem relacional normalizada
- ✅ Relacionamentos entre entidades
- ✅ Integridade referencial
- ✅ Otimização de consultas
- ✅ Versionamento com Git

---

## 🎯 Contexto de Aplicação

O sistema foi projetado para atender estabelecimentos comerciais de pequeno porte, tais como:

- 📚 **Livrarias** - Controle de livros, autores e vendas
- ☕ **Cafeterias** - Gestão de bebidas, alimentos e pedidos
- 🍰 **Confeitarias** - Registro de produtos, encomendas e clientes
- 🛒 **Mercados** - Controle de estoque e transações

---

## 💾 Modelo de Banco de Dados

### Arquitetura Relacional

O modelo implementa um relacionamento **muitos-para-muitos (N:M)** entre Produtos e Pedidos, utilizando uma tabela associativa para garantir flexibilidade e normalização.

```
┌─────────────┐         ┌──────────────────┐         ┌─────────────┐
│  Produtos   │ 1     N │  Itens_Pedido    │ N     1 │   Pedidos   │
├─────────────┤◄────────┤──────────────────┤────────►├─────────────┤
│ id_produto  │         │ id_item          │         │ id_pedido   │
│ nome        │         │ id_pedido (FK)   │         │ data_pedido │
│ preco       │         │ id_produto (FK)  │         │ total       │
│ quantidade  │         │ quantidade       │         └─────────────┘
└─────────────┘         │ preco_unitario   │
                        └──────────────────┘
```

### Tabelas e Relacionamentos

| Tabela | Descrição | Tipo | Relacionamento |
|--------|-----------|------|----------------|
| **`Produtos`** | Catálogo de itens disponíveis para venda (nome, preço, estoque) | Entidade | 1:N com `Itens_Pedido` |
| **`Pedidos`** | Registro de transações comerciais (data, valor total) | Entidade | 1:N com `Itens_Pedido` |
| **`Itens_Pedido`** | Detalhamento de produtos vendidos por pedido | Associativa | N:1 com `Produtos`<br>N:1 com `Pedidos` |

---

## 📊 Estrutura das Tabelas

### Tabela: Produtos

```sql
CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0
);
```

**Campos:**
- `id_produto` - Chave primária (PK)
- `nome` - Nome do produto
- `preco` - Preço unitário
- `quantidade_estoque` - Quantidade disponível

### Tabela: Pedidos

```sql
CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL
);

-- Índice para otimização de consultas por data
CREATE INDEX idx_data_pedido ON Pedidos(data_pedido);
```

**Campos:**
- `id_pedido` - Chave primária (PK)
- `data_pedido` - Data/hora da transação
- `total` - Valor total do pedido

**Índice:**
- `idx_data_pedido` - Otimiza buscas por período

### Tabela: Itens_Pedido

```sql
CREATE TABLE Itens_Pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);
```

**Campos:**
- `id_item` - Chave primária (PK)
- `id_pedido` - Chave estrangeira (FK) → Pedidos
- `id_produto` - Chave estrangeira (FK) → Produtos
- `quantidade` - Quantidade vendida
- `preco_unitario` - Preço no momento da venda

---

## 📦 Conteúdo do Projeto

### Arquivo Principal: `db_model.sql`

O script SQL contém:

1. **DDL (Data Definition Language)**
   - `CREATE TABLE` para as três tabelas
   - Definição de chaves primárias (PK)
   - Definição de chaves estrangeiras (FK)
   - Criação de índice otimizado

2. **DML (Data Manipulation Language)**
   - `INSERT` com dados de exemplo
   - Mínimo de 3 produtos cadastrados
   - Mínimo de 3 pedidos registrados

3. **Otimização**
   - `CREATE INDEX` na coluna `data_pedido`

---

## 🔄 Histórico de Versionamento (Git)

### Estratégia de Commits

O desenvolvimento seguiu uma abordagem incremental com commits significativos:

| # | Commit | Descrição | Arquivos Modificados |
|---|--------|-----------|---------------------|
| **1º** | `feat: Modelagem inicial do banco de dados` | Criação das tabelas Produtos, Pedidos e Itens_Pedido com dados iniciais | `db_model.sql` |
| **2º** | `perf: Adiciona índice para otimização de consultas por data` | Implementação de índice na tabela Pedidos | `db_model.sql` |

### Padrão de Mensagens

Seguindo **Conventional Commits**:

```
<tipo>: <descrição>

[corpo opcional]
```

**Tipos utilizados:**
- `feat` - Nova funcionalidade
- `perf` - Melhoria de performance
- `docs` - Documentação
- `fix` - Correção de bug

---

## 🚀 Como Utilizar

### Pré-requisitos

- Sistema Gerenciador de Banco de Dados (SGBD):
  - MySQL 5.7+
  - PostgreSQL 12+
  - MariaDB 10.3+
  - SQLite 3.8+

### Passo a Passo

#### 1. Clonar o Repositório

```bash
git clone https://github.com/seu-usuario/modelagem-banco-dados-comercio.git
cd modelagem-banco-dados-comercio
```

#### 2. Conectar ao Banco de Dados

**MySQL/MariaDB:**
```bash
mysql -u usuario -p
```

**PostgreSQL:**
```bash
psql -U usuario -d nome_banco
```

#### 3. Executar o Script

**Opção A - Linha de comando (MySQL):**
```bash
mysql -u usuario -p nome_banco < db_model.sql
```

**Opção B - Interface gráfica:**
- Abra o `db_model.sql` no MySQL Workbench, DBeaver ou phpMyAdmin
- Execute o script completo

#### 4. Verificar a Instalação

```sql
-- Listar tabelas criadas
SHOW TABLES;

-- Verificar estrutura
DESCRIBE Produtos;
DESCRIBE Pedidos;
DESCRIBE Itens_Pedido;

-- Consultar dados inseridos
SELECT * FROM Produtos;
SELECT * FROM Pedidos;
SELECT * FROM Itens_Pedido;
```

---

## 🔍 Consultas SQL Úteis

### Consulta de Pedidos com Produtos

```sql
SELECT 
    p.id_pedido,
    p.data_pedido,
    pr.nome AS produto,
    ip.quantidade,
    ip.preco_unitario,
    (ip.quantidade * ip.preco_unitario) AS subtotal
FROM Pedidos p
JOIN Itens_Pedido ip ON p.id_pedido = ip.id_pedido
JOIN Produtos pr ON ip.id_produto = pr.id_produto
ORDER BY p.data_pedido DESC;
```

### Relatório de Vendas por Produto

```sql
SELECT 
    pr.nome AS produto,
    SUM(ip.quantidade) AS total_vendido,
    SUM(ip.quantidade * ip.preco_unitario) AS receita_total
FROM Produtos pr
JOIN Itens_Pedido ip ON pr.id_produto = ip.id_produto
GROUP BY pr.id_produto, pr.nome
ORDER BY receita_total DESC;
```

### Pedidos por Período

```sql
SELECT 
    DATE(data_pedido) AS dia,
    COUNT(*) AS total_pedidos,
    SUM(total) AS faturamento
FROM Pedidos
WHERE data_pedido >= '2024-01-01'
GROUP BY DATE(data_pedido)
ORDER BY dia DESC;
```

---

## 📐 Conceitos Aplicados

### Normalização

O modelo atende às três primeiras formas normais (1FN, 2FN, 3FN):

- ✅ **1FN** - Valores atômicos em todas as colunas
- ✅ **2FN** - Todos os atributos dependem da chave primária completa
- ✅ **3FN** - Não há dependências transitivas

### Integridade Referencial

```sql
-- Chaves estrangeiras garantem consistência
FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
```

**Vantagens:**
- Impossibilidade de inserir itens com pedido/produto inexistente
- Previne exclusão acidental de registros referenciados

### Otimização

```sql
-- Índice acelera consultas por data
CREATE INDEX idx_data_pedido ON Pedidos(data_pedido);
```

**Benefício:** Reduz tempo de busca em tabelas com milhares de registros.

---

## 🧪 Testes e Validação

### Teste de Integridade

```sql
-- Tentar inserir item com pedido inexistente (deve falhar)
INSERT INTO Itens_Pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (9999, 1, 1, 10.00);
-- Erro: Cannot add or update a child row: foreign key constraint fails
```

### Teste de Performance

```sql
-- Comparar performance com e sem índice
EXPLAIN SELECT * FROM Pedidos WHERE data_pedido > '2024-01-01';
```

---

## 📁 Estrutura do Repositório

```
modelagem-banco-dados-comercio/
├── db_model.sql              # Script SQL principal
├── README.md                 # Esta documentação
├── docs/                     # Documentação adicional
│   ├── diagrama_er.png       # Diagrama Entidade-Relacionamento
│   └── dicionario_dados.md   # Dicionário de dados
└── .gitignore                # Arquivos ignorados pelo Git
```

---

## 🛠️ Tecnologias e Ferramentas

| Ferramenta | Versão | Finalidade |
|------------|--------|-----------|
| **MySQL** | 8.0+ | Sistema Gerenciador de Banco de Dados |
| **Git** | 2.40+ | Controle de versão |
| **GitHub** | - | Hospedagem do repositório |
| **MySQL Workbench** | 8.0+ | Modelagem e administração |

---

## 🔮 Melhorias Futuras

### Fase 2 - Expansão do Modelo

- 👥 Tabela `Clientes` com histórico de compras
- 👨‍💼 Tabela `Funcionarios` para controle de vendedores
- 📦 Tabela `Categorias` para classificação de produtos
- 💳 Tabela `Formas_Pagamento` para registrar métodos de pagamento

### Fase 3 - Otimizações Avançadas

- 📊 Views materializadas para relatórios
- 🔍 Full-text search em produtos
- 🔐 Implementação de stored procedures
- 📈 Triggers para atualização automática de estoque

### Fase 4 - Integração

- 🌐 API REST para acesso aos dados
- 📱 Aplicativo mobile para consultas
- 📧 Sistema de notificações automáticas
- ☁️ Migração para cloud database

---

## 📚 Referências e Recursos

### Documentação Oficial

- [MySQL Documentation](https://dev.mysql.com/doc/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Git Documentation](https://git-scm.com/doc)

### Tutoriais e Guias

- [SQL Tutorial - W3Schools](https://www.w3schools.com/sql/)
- [Database Design - FreeCodeCamp](https://www.freecodecamp.org/news/database-design/)
- [Git Branching Strategy](https://nvie.com/posts/a-successful-git-branching-model/)

### Livros Recomendados

- **"Database Design for Mere Mortals"** - Michael J. Hernandez
- **"SQL Antipatterns"** - Bill Karwin
- **"Pro Git"** - Scott Chacon

---

## 🤝 Contribuições

Sugestões e melhorias são bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/NovaFuncionalidade`)
3. Commit suas mudanças (`git commit -m 'feat: Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/NovaFuncionalidade`)
5. Abra um Pull Request

---

## 📄 Licença

Este projeto está licenciado sob a **MIT License**.

```
MIT License

Copyright (c) 2024 Vinícius da Conceição Teixeira

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 👨‍💻 Sobre o Autor

**Vinícius da Conceição Teixeira**  
Estudante de Tecnologia da Informação  
UFMS - Universidade Federal de Mato Grosso do Sul
E-mail: vinicius_teixeira@ufms.br

Projeto desenvolvido como atividade prática da disciplina **Projeto Integrador de Tecnologia da Informação II** no período 2025.2, demonstrando competências em modelagem de banco de dados relacional, normalização, integridade referencial e versionamento de código.

Para reportar problemas ou sugerir melhorias, abra uma **issue** no repositório.

---

**📅 Última atualização:** Novembro de 2025  
**🔖 Versão:** 1.0.0  
**⭐ Status:** Concluído  
**🎯 Propósito:** Atividade Acadêmica
