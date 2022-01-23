/// @description DRAW TEXT
if(bound_state == BOUNDING_STATE.CHECK_COLLISION){
	if(point_collision)
		draw_text(global.window.center_x, 20, "O mouse está DENTRO do envoltório");
	else
		draw_text(global.window.center_x, 20, "O mouse está FORA do envoltório");
}
