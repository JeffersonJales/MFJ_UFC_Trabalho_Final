/// @description INIT

keyboard_choose = function(){
	if(keyboard_check_released(ord("1"))) room_goto(rm_bounding_point);
	if(keyboard_check_released(ord("2"))) room_goto(rm_collision_test);
}