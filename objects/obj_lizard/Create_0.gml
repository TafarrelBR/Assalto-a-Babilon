estado = noone;
tempo_estado = room_speed * 10;
timer_estado = 0;

sat = 0;

destino_x = x;
destino_y = y;

velh = 0;
velv = 0;
vel = 1;

alvo = noone;
alvo_dir = 0;
duracao_atq = 0.5;
tempo_atq = duracao_atq;

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
		estado = _estado[irandom(array_length(_estado)-1)];
		tempo_estado = room_speed * 10;
	}
}

desenhar_sprite = function()
{
	draw_sprite_ext(sprite, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}

desenha_sombra = function()
{
	draw_sprite_ext(spr_sombra, 0, x, y, .3, .3, 0, c_white, 0.25);
}

//metodo de campo de visão
campo_visao = function(_largura, _altura, _xscale)
{
	var _x1, _y1, _x2, _y2;
	_x1 = x;
	_y1 = y + _altura / 2 - sprite_height /2;
	_x2 = _x1 + _largura * _xscale;
	_y2 = _y1 - _altura;
	// desenhando o meu quadrado
	//draw_rectangle(_x1, _y1, _x2, _y2, false);
	
	//checando se o jogador esta no campo de visão
	var _alvo = collision_rectangle(_x1, _y1, _x2, _y2, Obj_player, 0, 1);
	
	return _alvo;
}

//metodo dele parado
estado_parado = function()
{
	
	sprite = spr_lizard_idle;
	
	//zerando a velocidade quando eu estiver parado
	velh = 0;
	velv = 0;
	
	alvo = campo_visao(larg_visao, sprite_height * alt_visao, xscale);
	
	//se eu tenho um alvo, eu o sigo
	if(alvo)
	{
		estado = estado_persegue;
	}
	
	muda_estado([estado_passeando, estado_parado]);
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
	if (velh != 0)
	{
		xscale = sign(velh);	
	}
	
	//me movendo ate o destino
	velh = lengthdir_x(vel, _dir);
	velv = lengthdir_y(vel, _dir);
	
	//olhando para frente
	alvo = campo_visao(larg_visao, sprite_height * alt_visao, xscale);
	
	//se eu tenho um alvo, eu o sigo
	if(alvo)
	{
		estado = estado_persegue;
	}
	
	muda_estado([estado_parado, estado_passeando]);
	
}
//estado de perseguição
estado_persegue = function()
{
	//usando a sprite certa
	sprite = spr_lizard_run;
	
	//checar se meu alvo existe
	if(instance_exists(alvo))
	{
		show_debug_message("achei voce");
		//saber a direção do alvo
		var _dir = point_direction(x, y, alvo.x, alvo.y);
		
		//me mover na direção do alvo
		velh = lengthdir_x(vel, _dir);
		velv = lengthdir_y(vel, _dir);
		
		//sabendo a distancia ate meu alvo
		var _dist = point_distance(x, y, alvo.x, alvo.y);
		
		//se o alvo estiver muito proximo eu ataco
		if(_dist < larg_visao / 2)
		{
			
		show_debug_message("grawwwnn");
			estado = estado_prepara_ataque; 
		}
		
		//se o alvo esta muito longe eu desisto
		if(_dist > larg_visao * 2)
		{
			
		show_debug_message("kd vc");
			alvo = noone; 
		}
	}
	else //n tenho alvo
	{
		muda_estado([estado_passeando, estado_parado]);	
	}
}

//estado de preparação de ataque
estado_prepara_ataque = function()
{
	
	//_sat nunca passar de 1
	if(sat <= 1)
	{
		show_debug_message(sat);
		sat += (delta_time / 2000000)
	}
	
	//animação use a _sat
	image_speed = sat;
	
	sprite = spr_lizard_idle;
	velh = 0;
	velv = 0;
	
	image_blend = make_colour_hsv(255, sat * 255, 255)
	
	//se eu esperei 2 segundo eu ataco
	if(sat > 1) 
	{
		
		show_debug_message("atacar");
		estado = estado_ataque;
		alvo_dir = point_direction(x, y, alvo.x, alvo.y);
		sat = 0;
		image_speed = 1;
	}
}

//estado de ataque
estado_ataque = function()
{
	//diminuindo o tempo de ataque
	tempo_atq -= delta_time / 1000000
	image_blend = c_white;
	//avança na posição do jogador 
	velh = lengthdir_x(vel * 4, alvo_dir);
	velv = lengthdir_y(vel * 4, alvo_dir);
	
	//fazendo ele sair do modo de ataque
	if(tempo_atq <= 0)
	{
		//mudando de estado
		estado = estado_parado;
		
		//resetar o tempo de ataque
		tempo_atq = duracao_atq;
	}
}
//definindo o estado unicial dele
estado = estado_parado;