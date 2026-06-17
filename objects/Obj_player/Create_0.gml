/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Iniciando variaveis
velh = 0;
velv = 0;
max_vel = 3;
//velocidade geral
vel = 0;
//Direção do movimento
move_dir = 0;

arma = noone;

dano = false;
vida_max = 3
vida = vida_max;

tempo_invenc = room_speed * 2;

xscale = 1;

//metodo de olhando onde o jogador esta olhando
olha_mouse = function()
{
	//checar se o x do mouse do jogador é maior ou igual que o meu x
	if(mouse_x >= x)
	{
		//eu olho para a direita
		xscale = 1;
	}
	else //o valor do x do mouse e menor que o meu
	{
		//eu olho para a esquerda
		xscale = -1;
	}
}

efeito_dano = function()
{
	static _valor = -.01
	//se eu tomei dano eu mudo minha transparencia
	
	//checando se eu tomei dano
	//se eu n tomei dano, n executo nada
	if(!dano) return;
	
	//se eu sumir o valor fica positivo
	//se eu apareci o valor fica negativo
	if(image_alpha <= 0) _valor *= -1;
	if(image_alpha > 1) _valor *= -1;
	
	//codigo com o efeito
	image_alpha += _valor;
}

toma_dano = function()
{
	//quando eu tomar dano, eu perco 1 de vida se eu ainda n tomei dano
	//se a variavel dano for false, então eu tomo dano
	//se eu estou tyomando dano eu n executo o resto do codigo
	if(dano) return;

	//perdendo vida
	vida--;	
	
	//avisando que eu tomei dano!
	dano = true;
	
	//garantir que eu posso tomar dano tempos de um tempo
	alarm[0] = tempo_invenc;
}
//Criando metode de usar a arma
usar_arma = function()
{
	if(arma)
	{
		var _fire = mouse_check_button(mb_left);
		arma.atirar = _fire;
		
		var _dir = point_direction(x, y, mouse_x, mouse_y);
		
		//achando a posição da arma
		var _x = x + lengthdir_x(sprite_width /2, _dir);
		var _y = y + lengthdir_y(sprite_height /2, _dir);
		
		//levando arma conosco
		arma.x = _x;
		arma.y = _y;
		
		//fazendo arma apontar pro mouse
		arma.image_angle = _dir;
	}
}

//criando metodo para me livrar de uma arma
joga_arma = function()
{
	if(arma)
	{
		var _joga = keyboard_check_released(ord("G"));
		var _col;
		//checando se o cajado esta dentro da parede
		//rodando o codigo de dentro da arma
		with(arma)
		{
			//isso esta dentro da arma
			_col = place_meeting(x, y, obj_block);
		}
		
		//só posso jogar a arma se eu apertei para jogar e se ela n estiver na parede
		if(_joga && !_col)
		{
			arma.speed = 3;
			arma.direction = arma.image_angle;
			
			//avisando que a arma n atira mais
			arma.atirar = false;
			
			// falando pra arma que vou comprar cigarro
			arma.pai = noone;
			
			//dando delay para a arma
			arma.delay_pega = room_speed * 2;
			
			arma = noone;
		}
	}
}