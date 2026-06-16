/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//colide com o player, eu vou ser a arma dele, se ele n tem arma
//e se o tempo de tricar de arma esta zerado
if(other.arma == noone && delay_pega <= 0)
{
	other.arma = id;
	pai = other.id;
}