/// INIT GLOBAL AND MACROS 

draw_set_font(fnt_arial);

global.window = {
	center_x : display_get_gui_width() * 0.5,
	center_y : display_get_gui_height() * 0.5,
	width : display_get_gui_width(),
	height : display_get_gui_height(),
}


#macro RANDOM_VECTOS_MIN 10
#macro RANDOM_VECTOS_MAX 30
#macro RANDOM_VECTOR_NUM irandom_range(RANDOM_VECTOS_MIN, RANDOM_VECTOS_MAX)

#macro RANDOM_AREA_XSTART room_width	* 0.5  
#macro RANDOM_AREA_YSTART room_height * 0.5  

#macro RANDOM_AREA_WIDTH  irandom_range(room_width  * 0.1, room_width * 0.3)
#macro RANDOM_AREA_HEIGHT irandom_range(room_height * 0.1, room_height * 0.25)


enum BOUNDING_TYPE { AABB, OBB, CIRCLE }

function create_random_point(){
	var _x = irandom_range(RANDOM_AREA_XSTART - RANDOM_AREA_WIDTH, RANDOM_AREA_XSTART + RANDOM_AREA_WIDTH);
	var _y = irandom_range(RANDOM_AREA_YSTART - RANDOM_AREA_HEIGHT, RANDOM_AREA_YSTART + RANDOM_AREA_HEIGHT)
	
	return new Vec2(_x, _y);
}


/// ----- OTHER FUNCTIONS (CONTROL)
function inputs(){
	if(keyboard_check_pressed(vk_space))	
		room_restart();
}

