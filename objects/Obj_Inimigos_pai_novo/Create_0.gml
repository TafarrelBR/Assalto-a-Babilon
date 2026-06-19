//variaveis comuns a todos os inimigos
vida_max = 1;
vida_atual = vida_max;

dano = false;

p_dir = 0;

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