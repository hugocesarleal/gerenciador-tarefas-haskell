-- | Módulo principal do Gerenciador de Tarefas.
module GerenciadorTarefas where

-- | Define o tipo de dado Tarefa.
-- Uma tarefa é simplesmente uma descrição em texto.
newtype Tarefa = Tarefa { descricao :: String } deriving (Show, Eq)

-- | Adiciona uma nova tarefa à lista de tarefas.
-- Recebe a descrição da nova tarefa e a lista atual de tarefas,
-- retornando uma nova lista com a tarefa adicionada ao final.
adicionarTarefa :: String -> [Tarefa] -> [Tarefa]
adicionarTarefa desc tarefas = tarefas ++ [Tarefa desc]

-- | Remove uma tarefa da lista pelo seu índice (base 0).
-- Retorna uma nova lista sem a tarefa no índice especificado.
-- Se o índice for inválido, a lista original é retornada.
removerTarefa :: Int -> [Tarefa] -> [Tarefa]
removerTarefa indice tarefas
    | indice >= 0 && indice < length tarefas = take indice tarefas ++ drop (indice + 1) tarefas
    | otherwise = tarefas -- Retorna a lista original se o índice for inválido

-- | Exibe a lista de tarefas formatada com seus índices.
-- Se a lista estiver vazia, uma mensagem apropriada é exibida.
exibirTarefas :: [Tarefa] -> IO ()
exibirTarefas [] = putStrLn "Nenhuma tarefa na lista."
exibirTarefas tarefas = do
    putStrLn "\n--- Suas Tarefas ---"
    -- Usa zip para emparelhar cada tarefa com seu índice (0-based)
    -- mapM_ é usado para aplicar uma ação IO a cada elemento da lista e descartar o resultado
    mapM_ (\(i, Tarefa desc) -> putStrLn $ show (i + 1) ++ ". " ++ desc) (zip [0..] tarefas)
    putStrLn "--------------------\n"

-- | Exibe o menu de opções para o usuário.
exibirMenu :: IO ()
exibirMenu = do
    putStrLn "--- Gerenciador de Tarefas ---"
    putStrLn "1. Adicionar tarefa"
    putStrLn "2. Remover tarefa"
    putStrLn "3. Exibir tarefas"
    putStrLn "4. Sair"
    putStr "Escolha uma opção: "

-- | Processa a opção escolhida pelo usuário.
-- Recebe a opção (Int) e a lista atual de tarefas,
-- retornando uma ação IO que resulta na nova lista de tarefas.
processarOpcao :: Int -> [Tarefa] -> IO [Tarefa]
processarOpcao 1 tarefas = do
    putStr "Digite a descrição da nova tarefa: "
    desc <- getLine -- Lê a linha de entrada do usuário
    putStrLn "Tarefa adicionada!"
    return (adicionarTarefa desc tarefas) -- Retorna a lista atualizada
processarOpcao 2 tarefas = do
    exibirTarefas tarefas -- Mostra as tarefas para que o usuário saiba qual remover
    if null tarefas
        then do
            putStrLn "Não há tarefas para remover."
            return tarefas
        else do
            putStr "Digite o número da tarefa a ser removida: "
            inputIndice <- getLine
            -- Tenta converter a entrada para Int usando 'reads'
            let maybeIndice = reads inputIndice :: [(Int, String)]
            case maybeIndice of
                [(indice, "")] -> do -- Se a conversão foi bem-sucedida e não há resto de string
                    if indice > 0 && indice <= length tarefas
                        then do
                            putStrLn "Tarefa removida!"
                            -- Ajusta o índice para base 0 antes de chamar removerTarefa
                            return (removerTarefa (indice - 1) tarefas)
                        else do
                            putStrLn "Índice inválido."
                            return tarefas
                _ -> do -- Se a entrada não foi um número válido
                    putStrLn "Entrada inválida. Por favor, digite um número."
                    return tarefas
processarOpcao 3 tarefas = do
    exibirTarefas tarefas
    return tarefas -- Retorna a lista inalterada após a exibição
processarOpcao 4 tarefas = do
    putStrLn "Saindo do programa..."
    return tarefas -- Retorna a lista para sinalizar o fim do loop principal
processarOpcao _ tarefas = do -- Caso de opção inválida
    putStrLn "Opção inválida. Escolha uma opção entre 1 e 4."
    return tarefas

-- | Loop principal do programa.
-- Recebe a lista de tarefas atual e continua a exibir o menu
-- e processar opções até que o usuário escolha sair.
mainLoop :: [Tarefa] -> IO ()
mainLoop tarefas = do
    exibirMenu
    input <- getLine
    let maybeOpcao = reads input :: [(Int, String)]
    case maybeOpcao of
        [(opcao, "")] ->
            if opcao == 4
                then processarOpcao opcao tarefas >> return () -- Executa a ação de saída e termina o loop
                else do
                    -- Processa a opção e obtém a nova lista de tarefas
                    novasTarefas <- processarOpcao opcao tarefas
                    -- Chama o mainLoop recursivamente com a lista atualizada
                    mainLoop novasTarefas
        _ -> do
            putStrLn "Entrada inválida. Por favor, digite um número."
            mainLoop tarefas -- Continua o loop com a lista de tarefas atual

-- | Função principal que inicia o programa.
main :: IO ()
main = do
    putStrLn "Bem-vindo ao Gerenciador de Tarefas!"
    mainLoop [] -- Inicia o loop principal com uma lista de tarefas vazia