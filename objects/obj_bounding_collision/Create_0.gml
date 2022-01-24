/// @description INIT
enum COLLISION { NOONE, AABB_AABB, AABB_CIRCLE, CIRCLE_CIRCLE, __COUNT }
collision_teste = COLLISION.NOONE;

enum COLLISION_CHECK_STATE { CHOOSE_COLLISION, HANDLE_COLLISION, DRAGING_PRIMITIVE }
collision_state = COLLISION_CHECK_STATE.CHOOSE_COLLISION;

bounding_areas = array_create(2, undefined);

input_choose = function(){
	
	if(keyboard_check_pressed(ord("1")))			collision_teste = COLLISION.AABB_AABB;
	else if(keyboard_check_pressed(ord("2"))) collision_teste = COLLISION.AABB_CIRCLE;
	else if(keyboard_check_pressed(ord("3"))) collision_teste = COLLISION.CIRCLE_CIRCLE;
	
	if(collision_teste != COLLISION.NOONE){
		collision_state = COLLISION_CHECK_STATE.HANDLE_COLLISION;
			
		var _center_x = room_width / 2 ;
		var _center_y = room_height / 2 ;
		
		switch(collision_teste){
			case COLLISION.AABB_AABB: 
				bounding_areas[0] = new AABB();  
				bounding_areas[1] = new AABB();
				
				bounding_areas[0].create(_center_x - 150, _center_y, irr(50,125), irr(50, 125));
				bounding_areas[1].create(_center_x + 150, _center_y, irr(50,125), irr(50, 125));
			break;
			
			case COLLISION.AABB_CIRCLE:
				bounding_areas[0] = new AABB();  
				bounding_areas[1] = new Circle_BB();
				
				bounding_areas[0].create(_center_x - 150, _center_y, irr(50,125), irr(50, 125));
				bounding_areas[1].create(_center_x + 150, _center_y, irr(50, 75));
			break;
			
			case COLLISION.CIRCLE_CIRCLE:
				bounding_areas[0] = new Circle_BB();  
				bounding_areas[1] = new Circle_BB();
				
				bounding_areas[0].create(_center_x - 150, _center_y, irr(50, 75));
				bounding_areas[1].create(_center_x + 150, _center_y, irr(50, 75));
			break;
		}
	}
}

mouse_image = function(){
	var _vec2 = new Vec2(mouse_x, mouse_y);
	var _inside = bounding_areas[0].point_inside(_vec2) || 
								bounding_areas[1].point_inside(_vec2);

	if(_inside) window_set_cursor(cr_drag)
	else 	window_set_cursor(cr_default);

}


draging_primitive = undefined;
draging_point = undefined;

start_drag = function(){
	if(collision_state != COLLISION_CHECK_STATE.HANDLE_COLLISION) return; 
	
	var _vec2 = new Vec2(mouse_x, mouse_y);
	var _inside_a = bounding_areas[0].point_inside(_vec2);
	var _inside_b = bounding_areas[1].point_inside(_vec2);

	if(_inside_a || _inside_b){ 
		collision_state = COLLISION_CHECK_STATE.DRAGING_PRIMITIVE;
		draging_point = _vec2;
		window_set_cursor(cr_size_all);

		if(_inside_a) draging_primitive = bounding_areas[0];
		else draging_primitive = bounding_areas[1];
	}
}

drag_primitive = function(){
	if(mouse_x != draging_point.x || mouse_y != draging_point.y){
		var _x = mouse_x - draging_point.x;
		var _y = mouse_y - draging_point.y;
		
		draging_point = new Vec2(mouse_x, mouse_y);
		draging_primitive.translate(_x, _y);
	}
}

stop_drag = function(){
	if(collision_state == COLLISION_CHECK_STATE.DRAGING_PRIMITIVE)
		collision_state = COLLISION_CHECK_STATE.HANDLE_COLLISION;
}


/// COLLISION
bouding_collision = false;

collision_test = function(){
	switch(collision_teste){
		case COLLISION.AABB_AABB:			
			bouding_collision = AABB_overlap_AABB(bounding_areas[0], bounding_areas[1]); 
		break;
		
		case COLLISION.AABB_CIRCLE:		
			bouding_collision = AABB_overlap_Circle(bounding_areas[0], bounding_areas[1]); 
		break;
		
		case COLLISION.CIRCLE_CIRCLE: 
			bouding_collision = Circle_overlap_Circle(bounding_areas[0], bounding_areas[1]); 
		break;
	}
	
	if(bouding_collision) {
		bounding_areas[0].draw_color = c_red;	
		bounding_areas[1].draw_color = c_red;	
	}
	else {
		bounding_areas[0].draw_color = c_yellow;	
		bounding_areas[1].draw_color = c_yellow;	
	}
	
}


