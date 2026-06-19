// Inherit the parent event
event_inherited();

//ele é mais rapido me movendo
estado_movendo.roda = function()
{
	hspeed = (keyboard_check(vk_right) - keyboard_check(vk_left)) * 2;
	
	if(hspeed == 0)
	{
		muda_estado(estado_diminui);
	}
}