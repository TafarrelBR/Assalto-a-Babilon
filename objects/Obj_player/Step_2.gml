/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
//Sistema de Colizão Horizontal
var _velh = sign(velh);

//deixar velh positivo
repeat(abs(velh))
{
	//Vai ser repetido igual a velh
	//checar se espaço que vou mover, tem algo
	if(place_meeting(x + _velh,y,obj_block))
	{
		//O que fazer quando colide
		velh = 0;
	}
	else // se n colidir anda
	{
		x += _velh;
	}
}

var _velv = sign(velv);
repeat(abs(velv))
{
	//Vai ser repetido igual a velh
	//checar se espaço que vou mover, tem algo
	if(place_meeting(x,y + _velv,obj_block))
	{
		//O que fazer quando colide
		velv = 0;
	}
	else // se n colidir anda
	{
		y += _velv;
	}
}

usar_arma();