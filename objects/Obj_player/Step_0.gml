/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

depth = -bbox_bottom;

var up, down, left, right;

up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));

// direita e baixo, estão na frente para que estando apertado o resultado de 1 (1 - 0), caso contrario de -1 (0 - 1)
//velh = (right - left) * max_vel;

//velv = (down - up) * max_vel;

//ajustar o movimento
//descobrir que direção eu estou me movendo
//checando se o jogador esta apertando algo
if(up xor down or left xor right)
{
	move_dir = point_direction(0, 0, ( right-left ), (down - up));
	vel = max_vel;
}
else
{
	//reduz aos poucos a velocidade quando para
	vel = lerp(vel, 0, 0.1);
}

//com base na minha direção eu vou dar a minha velocidade
velh = lengthdir_x(vel, move_dir);
velv = lengthdir_y(vel, move_dir);

joga_arma();
efeito_dano();
olha_mouse();


