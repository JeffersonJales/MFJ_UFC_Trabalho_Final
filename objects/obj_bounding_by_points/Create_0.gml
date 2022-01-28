/// @description INIT

enum BOUNDING_STATE { SELECET_FORM, DRAW_POINTS, CHECK_COLLISION }
bound_state = BOUNDING_STATE.SELECET_FORM;

/// GENERATE POINTS ON RANDOM PLACES ON THE ROOM
points_to_generate = RANDOM_VECTOR_NUM;
points = array_create(points_to_generate);

random_angle = irandom(359);
for(var i = 0; i < points_to_generate; i++){
	points[i] = create_random_point();
}

/// DRAWING POINTS 
add_point_draw_time = 5;
points_draw = array_create(points_to_generate);
draw_points_ind = 0;


add_point = function(){
	array_push(points_add, add_point_mouse(bounding_form))
}

add_point_vec = function(vec2_c){
	array_push(points_add, vec2_c);
}

/// ADD NEW POINTS
points_add = [];

/// CHECK IF HAVE COLLISION
bounding_form = undefined;

select_form_input = function(){
	if(keyboard_check_pressed(ord("1"))) bounding_form = new AABB();	
	else if(keyboard_check_pressed(ord("2"))) bounding_form = new OBB();	
	else if(keyboard_check_pressed(ord("3"))) bounding_form = new Circle_BB();	

	if(bounding_form != undefined){
		bound_state = BOUNDING_STATE.DRAW_POINTS;
		bounding_form.fit(points);
		alarm[0] = add_point_draw_time;
	}
}
