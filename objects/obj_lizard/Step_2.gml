//movendo com base no velh e velv

//colisão horizontal
if(place_meeting(x + velh, y, obj_block))
{
	var _velh = sign(velh);
	//esquando eu n estiver colidindo um pixel na direção que estou indo
	while(!place_meeting(x + _velh, y, obj_block))
	{
		//eu me movo 1 pixel naquela direção
		x += _velh;
	}
	
	//eu ja movi tudo que eu tinha pra mover, agora estou colidindo
	//acabo com minha velocidade
	velh = 0;
	
}

//me movo
x += velh;

//colisão vertical
if(place_meeting(x, y + velv, obj_block))
{
	var _velv = sign(velv);
	//esquando eu n estiver colidindo um pixel na direção que estou indo
	while(!place_meeting(x, y + _velv, obj_block))
	{
		//eu me movo 1 pixel naquela direção
		y += _velv;
	}
	
	//eu ja movi tudo que eu tinha pra mover, agora estou colidindo
	//acabo com minha velocidade
	velv = 0;
}

//me movo
y += velv;