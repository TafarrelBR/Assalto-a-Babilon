
distancia = 30;
vel = 2;

image_blend = c_green;

vai_para_player = function()
{
	if(object_exists(Obj_player))
	{
		//checando se player esta procimo de mim
		var _dist_player = point_distance(x, y, Obj_player.x, Obj_player.y);
		
		//achando a direção do player
		var _dir_player = point_direction(x, y, Obj_player.x, Obj_player.y);
		
		//se o player estiver proximo vou até ele
		if(_dist_player < distancia)
		{
			speed = vel;
			direction = _dir_player;
		}
		else
		{
			//o player esta longe de mim
			speed = 0;
		}
	}
}