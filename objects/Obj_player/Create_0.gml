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
			arma.delay_pega = game_get_speed(gamespeed_fps) * 2;
			
			arma = noone;
		}
	}
}