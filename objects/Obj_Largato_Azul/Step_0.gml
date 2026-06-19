estado();

//arrumando minha profundidade	
depth = -bbox_bottom;

if(dano)
{
	// se eu tomei dano
	//aumento o timer
	dano_timer++;
	
	//resetando o timer se chegou no limite
	if(dano_timer > tempo_dano)
	{
		dano_timer = 0;
		dano = false;
	}
}