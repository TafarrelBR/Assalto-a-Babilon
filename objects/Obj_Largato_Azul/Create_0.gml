//herdando as informações do meu pai
event_inherited();

//ajustando a minha vida
vida_max = 3;
vida_atual = vida_max;

tempo_estado = room_speed * 10;
timer_estado = 0;

destino_x = x;
destino_y = y;
vel = 1;

tempo_morte = room_speed;

duracao_atq = 0.5;
tempo_atq = duracao_atq;

//timer do dano
dano_timer = 0;
tempo_dano = room_speed / 4;
timer_de_dano = tempo_dano;

sprite = sprite_index;
xscale = 1;
yscale = 1;

desenhar_sprite = function()
{
	draw_sprite_ext(sprite, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}

desenha_sombra = function()
{
	draw_sprite_ext(spr_sombra, 0, x, y, .3, .3, 0, c_white, 0.25);
}

//metodo dele parado
estado_parado.inicia = function()
{
	velv =0;
	velh = 0;
	sprite = Spr_lagarto_azul_parado;
	image_blend = c_white;
}

estado_passeando.inicia = function()
{
	//definindo a sprite
	sprite = Spr_lagarto_azul_correndo;
}

//estado de perseguição
estado_persegue.inicia = function()
{
	//usando a sprite certa
	sprite = Spr_lagarto_azul_correndo;
}

//estado de preparação de ataque
estado_prepara_ataque.inicia = function()
{
	sprite = Spr_lagarto_azul_apanhando;
}
estado_prepara_ataque.roda = function()
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
		muda_estado(estado_ataque);
		alvo_dir = point_direction(x, y, alvo.x, alvo.y);
		sat = 0;
		image_speed = 1;
	}
}

//estado de ataque
estado_ataque.roda = function()
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
		velh = 0;
		velv = 0;
		//mudando de estado
		muda_estado(estado_parado);
		
		//resetar o tempo de ataque
		tempo_atq = duracao_atq;
	}
}

estado_dano.inicia = function()
{	
	sprite = Spr_lagarto_azul_apanhando;
}

estado_dano.roda = function()
{
	timer_de_dano --;
	
	//sendo empurrado para tras
	velh = lengthdir_x(1, p_dir);
	velv = lengthdir_y(1, p_dir);
	
	if(timer_de_dano <= 0)
	{
		//checando se devo morrer
		if(vida_atual <= 0)
		{
			muda_estado(estado_morto);
		}
		else
		{
			// se n morreu vem para ca
			muda_estado(estado_parado);
		
			//resetando o timer_dano
			timer_de_dano = tempo_dano;
		}
	
	}
}

inicia_estado(estado_parado);