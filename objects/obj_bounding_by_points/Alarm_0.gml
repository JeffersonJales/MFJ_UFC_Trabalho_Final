/// @description ADD POINT TO DRAW
points_draw[draw_points_ind] = points[draw_points_ind];

if(++draw_points_ind < points_to_generate) alarm[0] = add_point_draw_time;
else bound_state = BOUNDING_STATE.CHECK_COLLISION;