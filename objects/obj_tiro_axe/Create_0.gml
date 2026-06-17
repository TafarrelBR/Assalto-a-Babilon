event_inherited();

espera = room_speed * .5;
vel = 0;
rot = -10;

atirado = function()
{
	image_angle += rot;
	//checar se eu tenho que esperar
	if(espera > 0)
	{
		//diminuindo o valor da espera
		espera--;
		
		//checando se tenho velocidade
		if(speed !=0)
		{
			vel = speed;
			speed = 0;
		}
	}
	
	//terminei de esperar, posso me mover
	else
	{
		speed = vel; 
	}
}