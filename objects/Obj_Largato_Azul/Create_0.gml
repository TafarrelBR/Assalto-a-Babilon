//herdando as informações do meu pai
event_inherited();

//ajustando a minha vida
vida_max = 3;
vida_atual = vida_max;

estado = noone;
tempo_estado = room_speed * 10;
timer_estado = 0;

sat = 0;

destino_x = x;
destino_y = y;

velh = 0;
velv = 0;
vel = 1;

tempo_morte = room_speed;

alvo = noone;
alvo_dir = 0;
duracao_atq = 0.5;
tempo_atq = duracao_atq;

//timer do dano
dano_timer = 0;
tempo_dano = room_speed / 4;
timer_de_dano = tempo_dano;

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
	
	sprite = Spr_lagarto_azul_parado;
	image_blend = c_white;
	
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
	sprite = Spr_lagarto_azul_correndo;
	
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
	sprite = Spr_lagarto_azul_correndo;
	
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
	
	sprite = Spr_lagarto_azul_parado;
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

estado_dano = function()
{
	timer_de_dano --;
	
	sprite = Spr_lagarto_azul_apanhando;
	
	//sendo empurrado para tras
	velh = lengthdir_x(1, p_dir);
	velv = lengthdir_y(1, p_dir);
	
	if(timer_de_dano <= 0)
	{
		//checando se devo morrer
		if(vida_atual <= 0)
		{
			estado = estado_morto;
		}
		else
		{
			// se n morreu vem para ca
			estado = estado_parado;
		
			//resetando o timer_dano
			timer_de_dano = tempo_dano;
		}
	
	}	
}

estado_morto = function()
{	
	image_alpha -= .03;
	
	image_speed = 0;
	velh = 0;
	velv = 0;
	
	if(image_alpha <= 0 )
	{
		instance_destroy();
		//dropando meu loot
		droppar_loot();
	}
}

leva_dano = function(_dano)
{
	if(estado != estado_morto)
	{
		estado = estado_dano;
	
		//perdendo vida
		//se levou dano, mas o dano n esta definido, estão tomo1 de dano
		if(_dano == undefined)
		{
			vida_atual -= 1;
		}
		else // caso contrario eu perco vida igual ao dano
		{
			vida_atual -= _dano;
		}
	
		//vou avisar que ele tomou dano
		dano = true;
	}
}
//definindo o estado unicial dele
estado = estado_parado;