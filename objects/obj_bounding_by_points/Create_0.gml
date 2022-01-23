/// @description INIT

enum BOUNDING_STATE { DRAW_POINTS, CHECK_COLLISION }
bound_state = BOUNDING_STATE.DRAW_POINTS;

/// GENERATE POINTS ON RANDOM PLACES ON THE ROOM
points_to_generate = RANDOM_VECTOR_NUM;
points = array_create(points_to_generate);

for(var i = 0; i < points_to_generate; i++){
	points[i] = create_random_point();
}

/// DRAWING POINTS 
points_draw = array_create(points_to_generate);
draw_points_ind = 0;

add_point_draw_time = 5;
alarm[0] = add_point_draw_time;

/// CHECK IF HAVE COLLISION
point_collision = false;

bounding_form = undefined;

switch(bounding_by){
	case BOUNDING_TYPE.CIRCLE:	bounding_form = new Circle_BB(points); break;
	case BOUNDING_TYPE.AABB:		bounding_form = new AABB(points); break;
	case BOUNDING_TYPE.OBB:			bounding_form = new Circle_BB(points); break;
}