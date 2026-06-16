estado = noone;
tempo_estado = game_get_speed(gamespeed_fps) * 10;
timer_estado = 0;

destino_x = x;
destino_y = y;

velh = 0;
velv = 0;
vel = 1;

sprite = sprite_index;
xscale = 1;
yscale = 1;

//estado onde ele fica parado

//estado onde ele passeia

//estado onde ele persegue o jogador

//metodo de mudança de estado
muda_estado = function(_estado)
{
	tempo_estado--;
	timer_estado = irandom(tempo_estado);
	if(timer_estado == tempo_estado or tempo_estado <= 0)
	{
		//vou checar qual estado devo ir
		estado = _estado[irandom(array_last(_estado)-1)];
		tempo_estado = game_get_speed(gamespeed_fps) * 10;
	}
}

desenhar_sprite = function()
{
	draw_sprite_ext(sprite, sprite_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}

desenha_sombra = function()
{
	draw_sprite_ext(spr_sombra, 0, x, y, .3, .3, 0, c_white, 0.25);
}

//metodo dele parado
estado_parado = function()
{
	
	sprite = spr_lizard_idle;
	
	//zerando a velocidade quando eu estiver parado
	velh = 0;
	velv = 0;
	
	muda_estado([estado_passeando,estado_parado]);
}

estado_passeando = function()
{
	//definindo a sprite
	sprite = spr_lizard_run;
	
	//fazer ele passear
	//ele vai escolher um ponto para ir
	//checando a distancia do destino
	var _dist = point_distance(x, y, destino_x, destino_y);
	
	//só vou definir um destino se eu estiver proximo do destino
	if(_dist <100)
	{
		destino_x = random(room_width);
		destino_y = random(room_height);
	}
	
	
	//achando a direção para o destino
	var _dir = point_direction(x, y, destino_x, destino_y);
	
	//olhando para o lado que vou
	//evitando o xscale bug com valor 0
	if (ve != 0)
	{
		xscale = sign(velh);	
	}
	
	//me movendo ate o destino
	velh = lengthdir_x(vel, _dir);
	velv = lengthdir_y(vel, _dir);
	
	muda_estado([estado_parado, estado_passeando]);
	
}

//definindo o estado unicial dele
estado = estado_parado();