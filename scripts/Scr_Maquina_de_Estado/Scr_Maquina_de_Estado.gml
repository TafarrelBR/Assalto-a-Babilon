//inicia o estado
function novo_estado() constructor
{
	//inicia estado
	static inicia = function()
	{
		
	}
	
	//roda estado
	static roda = function()
	{
		
	}
	
	//finaliza o estado
	static finaliza = function()
	{
		
	}
}

//Funções para gerencias a maquina de estados

//Iniciando o estado
function inicia_estado(_estado)
{
	//Pegando op estado que passei
	estado_atual = _estado;
	
	//iniciando o estado que passe
	estado_atual.inicia();
}

//Rodando o estado
function roda_estado()
{
	//rodando meu estado atual
	estado_atual.roda();
}
//Mudando de estado