Neste exercício foi desenvolvido um serviço de mensagens simples usando Redis.
Para utilizar este serviço, o utilizador precisa de ser adicionado, passando a constar numa lista de utilizadores.
Cada utilizador tem uma lista de pessoas que o seguem, sendo que outros utilizadores podem se acrescentar ou remover a esta lista (se não for bloqueado).
Um utilizador pode bloquear estas pessoas, impedindo que estes o subscrevam ou recebam mensagens
Sempre que um utilizador publica uma mensagem, esta é duplicada e mandada para cada utilizador. As mensagens são armazenadas numa fila com uma chave do tipo "recetor:emissor", de modo ao utilizador poder filtrar mensagens por emissor. Mensagens já recebidas são eleminadas.