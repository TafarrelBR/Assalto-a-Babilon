//criando o meu estado
estado_parado = new novo_estado();
estado_movendo = new novo_estado(); 
//Iniciando o estado
estado_parado.inicia = function()
{
	image_blend = c_yellow;
}

//criando o roda estado do estado parado
estado_parado.roda = function()
{
	//quando eu apertar uam seta, eu começo a me mover
}

estado_movendo.inicia = function()
{
	//passando a sprite de animação
	//colocando image_index em 0
	image_blend = c_orange;
}
inicia_estado(estado_parado);