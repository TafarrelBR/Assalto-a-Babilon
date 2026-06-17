// Inherit the parent event
event_inherited();

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
						
			for(var i = 0; i < qtd_tiro; i++)
			{
				//achando o valor da direção
				var _val = 90 / (qtd_tiro - 1);
				
				//achando a posição para criar o meu tiro
				var _dir = -45 + (i * _val);

				var _x = lengthdir_x(sprite_width, image_angle + _dir);
				var _y = lengthdir_y(sprite_width, image_angle + _dir);
			
				var _tiro = instance_create_layer(x+_x, y+_y, layer, tiro);
				//dando velocidade para o tiro
				_tiro.speed = velocidade;
						
				//Definindo a direção do tiro com base na imprecisão
				_tiro.direction = image_angle + random_range(-imprecisao, imprecisao) + _dir;
			}
			
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