-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- Tabela Veículo
CREATE TABLE IF NOT EXISTS VEICULO (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    placa VARCHAR(10),
    modelo VARCHAR(50),
    ano INT,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

-- Tabela Mecânico
CREATE TABLE IF NOT EXISTS MECANICO (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    especialidade VARCHAR(50)
);

-- Tabela Ordem de Serviço
CREATE TABLE IF NOT EXISTS ORDEM_SERVICO (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT,
    id_mecanico INT,
    data_emissao DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_veiculo) REFERENCES VEICULO(id_veiculo),
    FOREIGN KEY (id_mecanico) REFERENCES MECANICO(id_mecanico)
);

-- Tabela Serviço
CREATE TABLE IF NOT EXISTS SERVICO (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100),
    preco DECIMAL(10,2)
);

-- Tabela Peça
CREATE TABLE IF NOT EXISTS PECA (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

-- Tabela associação Ordem-Serviço
CREATE TABLE IF NOT EXISTS OS_SERVICO (
    id_os INT,
    id_servico INT,
    quantidade INT,
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES ORDEM_SERVICO(id_os),
    FOREIGN KEY (id_servico) REFERENCES SERVICO(id_servico)
);

-- Tabela associação Ordem-Peça
CREATE TABLE IF NOT EXISTS OS_PECA (
    id_os INT,
    id_peca INT,
    quantidade INT,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os) REFERENCES ORDEM_SERVICO(id_os),
    FOREIGN KEY (id_peca) REFERENCES PECA(id_peca)
);

-- Inserções de exemplo
INSERT INTO CLIENTE (nome, telefone, email) VALUES
('João Silva', '119999999', 'joao@email.com'),
('Maria Souza', '118888888', 'maria@email.com');

INSERT INTO VEICULO (id_cliente, placa, modelo, ano) VALUES
(1, 'ABC1234', 'Fiat Uno', 2010),
(2, 'XYZ5678', 'Honda Civic', 2018);

INSERT INTO MECANICO (nome, especialidade) VALUES
('Carlos Mecânico', 'Motor'),
('Pedro Mecânico', 'Suspensão');

INSERT INTO SERVICO (descricao, preco) VALUES
('Troca de óleo', 150.00),
('Revisão completa', 500.00);

INSERT INTO PECA (nome, preco) VALUES
('Filtro de óleo', 50.00),
('Pastilha de freio', 200.00);

INSERT INTO ORDEM_SERVICO (id_veiculo, id_mecanico, data_emissao, valor_total)
VALUES (1, 1, '2025-09-01', 0.00);

INSERT INTO OS_SERVICO (id_os, id_servico, quantidade) VALUES
(1, 1, 1),
(1, 2, 1);

INSERT INTO OS_PECA (id_os, id_peca, quantidade) VALUES
(1, 1, 1),
(1, 2, 2);

-- Consultas de exemplo

-- 1. Listar clientes
SELECT nome, telefone FROM CLIENTE;

-- 2. Veículos após 2015
SELECT * FROM VEICULO WHERE ano > 2015;

-- 3. Preço com imposto
SELECT nome, preco, preco * 1.10 AS preco_com_imposto
FROM PECA;

-- 4. Mecânicos ordenados
SELECT * FROM MECANICO ORDER BY nome ASC;

-- 5. Ordens com mais de 1 peça
SELECT id_os, SUM(quantidade) AS total_pecas
FROM OS_PECA
GROUP BY id_os
HAVING total_pecas > 1;

-- 6. Junção cliente-veículo-mecânico
SELECT c.nome AS cliente, v.modelo, m.nome AS mecanico, os.data_emissao
FROM ORDEM_SERVICO os
JOIN VEICULO v ON os.id_veiculo = v.id_veiculo
JOIN CLIENTE c ON v.id_cliente = c.id_cliente
JOIN MECANICO m ON os.id_mecanico = m.id_mecanico;

-- 7. Valor total calculado da OS
SELECT os.id_os,
       SUM(s.preco * oss.quantidade) + SUM(p.preco * osp.quantidade) AS valor_calculado
FROM ORDEM_SERVICO os
JOIN OS_SERVICO oss ON os.id_os = oss.id_os
JOIN SERVICO s ON oss.id_servico = s.id_servico
JOIN OS_PECA osp ON os.id_os = osp.id_os
JOIN PECA p ON osp.id_peca = p.id_peca
GROUP BY os.id_os;
