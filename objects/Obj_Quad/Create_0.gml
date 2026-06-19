//criando o meu estado
estado_parado = new novo_estado();
estado_movendo = new novo_estado(); 
estado_cresce = new novo_estado();
estado_diminui = new novo_estado(); 

//Iniciando o estado
estado_parado.inicia = function()
{
	image_blend = c_yellow;
}

//criando o roda estado do estado parado
estado_parado.roda = function()
{
	//quando eu apertar uam seta, eu começo a me mover
	if(keyboard_check(vk_right) or keyboard_check(vk_left))
	{
		//indo para o estado de movendo
		muda_estado(estado_cresce);
	}
}

estado_movendo.inicia = function()
{
	//passando a sprite de animação
	//colocando image_index em 0
	image_blend = c_orange;
}

//roda é o que ocorre DURANTE a execução do estado
estado_movendo.roda = function()
{
	hspeed = keyboard_check(vk_right) - keyboard_check(vk_left);
	
	//saindo do estado
	//se eu n estou me movendo eu estou parado
	if(hspeed ==0)
	{
		muda_estado(estado_diminui);
	}
}

//finalizando o estado movendo
estado_movendo.finaliza = function()
{
	//image_xscale = .5;
	
	//fazendo ele diminuir de tamanho
	image_xscale = lerp(image_xscale, .5, .1);
	
}

estado_cresce.inicia = function()
{
	image_blend = c_aqua;
}

estado_cresce.roda = function()
{
	//aumenta a minha imagem
	image_xscale = lerp(image_xscale, 2, .1);
	
	if(image_xscale >= 1.9)
	{
		//mudando de estado
		muda_estado(estado_movendo);
	}
}

estado_diminui.roda = function()
{
	image_xscale = lerp(image_xscale, 1, .1);
	
	if(image_xscale <= 1.1)
	{
		muda_estado(estado_parado);
	}
}

estado_diminui.finaliza = function()
{
	image_xscale = 1;
}

inicia_estado(estado_parado);