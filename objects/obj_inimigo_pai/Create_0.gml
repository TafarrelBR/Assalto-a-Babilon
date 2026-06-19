//variaveis comuns a todos os inimigos
vida_max = 1;
vida_atual = vida_max;

dano = false;

p_dir = 0;

// criando metodo de levar dano
//metodo leva_dano(dano)
leva_dano = function(_dano)
{
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