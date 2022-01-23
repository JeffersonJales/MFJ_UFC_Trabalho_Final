/// @description RANDOM POINTS + BOUDING 
for(var i = 0; i < draw_points_ind; i++){
	points_draw[i].draw();
}



if(bound_state == BOUNDING_STATE.CHECK_COLLISION){
	for(var f = 0; f < array_length(points_add); f++){
		points_add[f].draw();
	}
	
	bounding_form.draw();
}