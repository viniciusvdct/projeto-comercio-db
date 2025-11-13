-- Script SQL para Modelagem de Banco de Dados de um Pequeno Comércio (Livraria/Cafeteria)

-- 1. Criação da Tabela 'Produtos'
-- Armazena informações sobre os itens disponíveis para venda.
CREATE TABLE Produtos (
    produto_id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    categoria VARCHAR(50)
);

-- 2. Criação da Tabela 'Pedidos'
-- Armazena informações sobre os pedidos realizados pelos clientes.
CREATE TABLE Pedidos (
    pedido_id INT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Pendente'
);

-- 3. Criação da Tabela 'Itens_Pedido'
-- Tabela de relacionamento N:M (Muitos para Muitos) entre Pedidos e Produtos.
-- Esta tabela é crucial para um modelo relacional que permite que um pedido tenha vários produtos e um produto esteja em vários pedidos.
CREATE TABLE Itens_Pedido (
    item_pedido_id INT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

-- 4. Inserção de Registros na Tabela 'Produtos' (pelo menos 3)
INSERT INTO Produtos (produto_id, nome, descricao, preco, estoque, categoria) VALUES
(1, 'Café Expresso', 'Café forte e concentrado', 5.50, 100, 'Bebida'),
(2, 'Livro: O Guia do Mochileiro das Galáxias', 'Ficção Científica de Douglas Adams', 45.90, 25, 'Livro'),
(3, 'Bolo de Cenoura', 'Fatia de bolo com cobertura de chocolate', 12.00, 50, 'Comida'),
(4, 'Chá de Hortelã', 'Chá quente de hortelã fresca', 4.00, 80, 'Bebida');

-- 5. Inserção de Registros na Tabela 'Pedidos' (pelo menos 3)
INSERT INTO Pedidos (pedido_id, data_pedido, valor_total, status) VALUES
(101, '2025-11-13', 17.50, 'Concluído'),
(102, '2025-11-13', 45.90, 'Pendente'),
(103, '2025-11-13', 24.00, 'Concluído');

-- 6. Inserção de Registros na Tabela 'Itens_Pedido' (para ligar Pedidos e Produtos)
-- Pedido 101: 1 Café Expresso (5.50) + 1 Bolo de Cenoura (12.00) = 17.50
INSERT INTO Itens_Pedido (item_pedido_id, pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 101, 1, 1, 5.50),
(2, 101, 3, 1, 12.00);

-- Pedido 102: 1 Livro (45.90)
INSERT INTO Itens_Pedido (item_pedido_id, pedido_id, produto_id, quantidade, preco_unitario) VALUES
(3, 102, 2, 1, 45.90);

-- Pedido 103: 2 Bolo de Cenoura (2 * 12.00 = 24.00)
INSERT INTO Itens_Pedido (item_pedido_id, pedido_id, produto_id, quantidade, preco_unitario) VALUES
(4, 103, 3, 2, 12.00);

-- Exemplo de Consulta (Opcional, mas útil para demonstrar o relacionamento)
-- Seleciona o nome do produto e a quantidade pedida para o Pedido 101
SELECT
    P.nome AS Produto,
    IP.quantidade AS Quantidade,
    IP.preco_unitario AS Preco_Unitario
FROM
    Itens_Pedido IP
JOIN
    Produtos P ON IP.produto_id = P.produto_id
WHERE
    IP.pedido_id = 101;

-- 7. Adicionando um índice para otimização de consultas na tabela Pedidos
CREATE INDEX idx_data_pedido ON Pedidos (data_pedido);
