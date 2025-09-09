# 📌 Sistema de Oficina Mecânica

Este projeto implementa um banco de dados relacional para gerenciar uma **oficina mecânica**, permitindo o controle de clientes, veículos, ordens de serviço, mecânicos, serviços e peças.

---

## 🔧 Estrutura do Banco

O banco foi modelado em **modelo relacional**, conforme abaixo:

### Entidades Principais
- **CLIENTE**: armazena informações dos clientes.
- **VEICULO**: vinculado ao cliente.
- **MECANICO**: profissionais da oficina.
- **ORDEM_SERVICO**: representa o atendimento realizado.
- **SERVICO**: tipos de serviços disponíveis.
- **PECA**: peças utilizadas nas ordens.
- **OS_SERVICO**: associação N:N entre ordem e serviços.
- **OS_PECA**: associação N:N entre ordem e peças.

### Relacionamentos
- Um cliente pode ter **vários veículos**.
- Um veículo pode ter **várias ordens de serviço**.
- Cada ordem de serviço é atendida por **um mecânico**.
- Uma ordem pode conter **diversos serviços** e **diversas peças**.

---

## 📊 Modelo Relacional (Diagrama)

<p align="center">
  <img src="diagramasql.png" alt="Diagrama SQL" width="600"/>
</p>

---

## 💾 Criação do Banco de Dados

- O script SQL de criação e inserção de dados está no arquivo [`script.sql`](script.sql).  
- Ele cria todas as tabelas e adiciona dados de teste.

---

## 🔍 Consultas SQL (Exemplos)

### 1. Listar clientes
```sql
SELECT nome, telefone FROM CLIENTE;
