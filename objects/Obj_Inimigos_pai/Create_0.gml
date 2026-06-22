//variaveis comuns a todos os inimigos
vida_max = 1;
vida_atual = vida_max;

velh = 0;
velv = 0;

dano = false;

alvo = noone;
alvo_dir = 0;
p_dir = 0;

sat = 0;

//timer do dano
dano_timer = 0;
tempo_dano = room_speed / 4;
timer_de_dano = tempo_dano;

//variaveis do meu loot
//chance de dropar
chance = 100;

//valor do loot
valor = 1;

estado_parado = new novo_estado();
estado_passeando = new novo_estado();
estado_persegue = new novo_estado();
estado_prepara_ataque = new novo_estado();
estado_ataque = new novo_estado();
estado_dano = new novo_estado();
estado_morto = new novo_estado();

estado_parado.roda = function()
{
	tempo_estado--;
	timer_estado = irandom(tempo_estado);
	if(timer_estado == tempo_estado or tempo_estado <= 0)
	{
		//vou checar qual estado devo ir
		muda_estado(estado_passeando);
		tempo_estado = room_speed * 10;
	}
	
	alvo = campo_visao(larg_visao, sprite_height * alt_visao, xscale);
	
	//se eu tenho um alvo, eu o sigo
	if(alvo)
	{
		muda_estado(estado_persegue);
	}
}

estado_persegue.roda = function()
{
	if(instance_exists(alvo))
	{
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
			muda_estado(estado_prepara_ataque);
		}
		
		//se o alvo esta muito longe eu desisto
		if(_dist > larg_visao * 2)
		{
			alvo = noone; 
		}
	}
	else //n tenho alvo
	{
		muda_estado(estado_parado);	
	}
}

estado_passeando.roda = function()
{
	tempo_estado--;
	timer_estado = irandom(tempo_estado);
	if(timer_estado == tempo_estado or tempo_estado <= 0)
	{
		//vou checar qual estado devo ir
		muda_estado(estado_parado);
		tempo_estado = room_speed * 10;
	}
	
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
		muda_estado(estado_persegue);
	}	
}

estado_morto.inicia = function()
{
	image_speed = 0;
	velh = 0;
	velv = 0;
}

estado_morto.roda = function()
{
	image_alpha -= .03;
		
	if(image_alpha <= 0 )
	{
		instance_destroy();
		//dropando meu loot
		droppar_loot();
	}
}

droppar_loot = function(_chance = 100, _valor = 1)
{
	//checar se posso criar loot
	//criando valor entra 0 e 100
	var _valor_chance = random(100);
	if (_chance > _valor_chance)
	{
		//criando o loot
		var _loot = instance_create_layer(x, y, "tiros", obj_loot);
		_loot.image_xscale = .2;
		_loot.image_yscale = .2;
	}
	else
	{
		
	}
}

// criando metodo de levar dano
//metodo leva_dano(dano)
leva_dano = function(_dano)
{
	muda_estado(estado_dano);
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

//metodo de campo de visão
campo_visao = function(_largura, _altura, _xscale)
{
	var _x1, _y1, _x2, _y2;
	_x1 = x;
	_y1 = y + _altura / 2 - sprite_height /2;
	_x2 = _x1 + _largura * _xscale;
	_y2 = _y1 - _altura;
	// desenhando o meu quadrado
	draw_rectangle(_x1, _y1, _x2, _y2, false);
	
	//checando se o jogador esta no campo de visão
	var _alvo = collision_rectangle(_x1, _y1, _x2, _y2, Obj_player, 0, 1);
	
	return _alvo;
}

inicia_estado(estado_parado);