/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// deixando o cajado menor
image_xscale = 0.5;
image_yscale = 0.5;

//Velocidade de tiro
//delay do tiro
//tiro

atirar = false;

delay_pega = 0;

delay_tiro = 0;

pai = noone;

//criando meu metodo pra atirar
atirando = function()
{
	//criando meu tiro dentro do intervalo
	delay_tiro --;
	if(atirar)
	{
		if(delay_tiro <= 0)
		{
			//resetando o delay do tiro
			delay_tiro = espera_tiro * room_speed;
						
			//achando a posição para criar o meu tiro
			var _x = lengthdir_x(sprite_width, image_angle);
			var _y = lengthdir_y(sprite_width, image_angle);
			
			var _tiro = instance_create_layer(x+_x, y+_y, layer, tiro);
			//dando velocidade para o tiro
			_tiro.speed = velocidade;
						
			//Definindo a direção do tiro com base na imprecisão
			_tiro.direction = image_angle + random_range(-imprecisao, imprecisao);
			
			//empurrando o player
			//só faço isso se tiver pai
			if (pai)
			{
				//achando o valor do velv e o velh, baseado na direção
				var _velh = lengthdir_x(knockback, image_angle);
				var _velv = lengthdir_y(knockback, image_angle);
				
				pai.velh -= _velh;
				pai.velv -= _velv;
			}
		}
	}
}

quica_parede = function()
{
	// batendo na parede e voltando
	//checar se ta batendo horizontamente ou verticalmente na parede
	
	if(place_meeting(x + hspeed, y, obj_block)) hspeed *= -1;
	if(place_meeting(x, y + vspeed, obj_block)) vspeed *= -1;
	
}