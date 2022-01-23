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


enum BOUNDING_TYPE { AABB, OBB, CIRCLE, __COUNT }
global.bounding_type_text = array_create(BOUNDING_TYPE.__COUNT);
global.bounding_type_text[BOUNDING_TYPE.AABB] = "AABB";
global.bounding_type_text[BOUNDING_TYPE.OBB] = "OBB";
global.bounding_type_text[BOUNDING_TYPE.CIRCLE] = "Círculo";

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

function add_point_mouse(bounding_area){
	var _vec2 = new Vec2Color(mouse_x, mouse_y, c_white);
	var _inside = bounding_area.point_inside(_vec2);
	
	if(_inside) _vec2.draw_color = c_lime;
	else _vec2.draw_color = c_red;
	
	return _vec2;
}

