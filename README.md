# Gerenciador de Tarefas em Haskell

Este projeto é um simples **Gerenciador de Tarefas** desenvolvido em Haskell. Ele permite ao usuário adicionar, remover e visualizar tarefas diretamente pelo terminal.

## Funcionalidades

- ✅ Adicionar novas tarefas à lista  
- 🗑️ Remover tarefas com base no número  
- 📋 Listar todas as tarefas cadastradas  
- 🚪 Sair do programa com segurança  

## Estrutura do Código

O programa é composto por funções puras e de entrada/saída (`IO`) para manipulação das tarefas. As principais funções são:

- `adicionarTarefa`: Adiciona uma tarefa à lista.  
- `removerTarefa`: Remove uma tarefa dado seu índice.  
- `exibirTarefas`: Mostra todas as tarefas na tela.  
- `exibirMenu`: Mostra o menu principal.  
- `processarOpcao`: Processa a escolha do usuário.  
- `mainLoop`: Loop principal do programa.  
- `main`: Função inicial.  

## Como Executar

### Pré-requisitos

- [GHC (Glasgow Haskell Compiler)](https://www.haskell.org/ghc/) instalado.

### Executando

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/gerenciador-tarefas-haskell.git
   cd gerenciador-tarefas-haskell
   ```

2. Inicie o Haskell:
   ```bash
   ghci
   ```

3. Carregue o Arquivo:
   ```bash
   : load GerenciadorTarefas · hs
   ```
   
4. Execute a Função Principal:
   ```bash
   main
   ```

   

## Exemplo de Uso

```txt
--- Gerenciador de Tarefas ---
1. Adicionar tarefa
2. Remover tarefa
3. Exibir tarefas
4. Sair
Escolha uma opção: 1
Digite a descrição da nova tarefa: Estudar Haskell
Tarefa adicionada!

--- Suas Tarefas ---
1. Estudar Haskell
--------------------
```
