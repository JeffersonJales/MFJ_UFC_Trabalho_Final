function BoudingAbstract() constructor{
	bouding_type = BOUNDING_TYPE.AABB;
	
	static draw = function(){}
	static point_inside = function(vec2){ return false }
	static fit = function(vec2_arr){}
}

function AABB() constructor{
	p_min = new Vec2(0,0);
	p_max = new Vec2(0,0);
	bounding_type = BOUNDING_TYPE.AABB;
	draw_color = c_yellow;
	
	static fit = function(vec2_arr){
		var _len = array_length(vec2_arr);
		
		var _min_x = vec2_arr[0].x;
		var _max_x = vec2_arr[0].x;

		var _min_y = vec2_arr[0].y;
		var _max_y = vec2_arr[0].y;

		var _point;
		for(var i = 1; i < _len; i++){
			_point = vec2_arr[i];
			
			if(_min_x > _point.x) _min_x = _point.x;
			else if(_max_x < _point.x) _max_x = _point.x;
			
			if(_min_y > _point.y) _min_y = _point.y;
			else if(_max_y < _point.y) _max_y = _point.y;
		}
		
		p_min = new Vec2(_min_x, _min_y);
		p_max = new Vec2(_max_x, _max_y);
	}
	
	static draw = function(){
		draw_circle_color( (p_min.x + p_max.x) / 2, (p_min.y + p_max.y) / 2, 2,  c_yellow, c_yellow, false);	
		draw_rectangle_color(p_min.x, p_min.y, p_max.x, p_max.y, draw_color, draw_color, draw_color, draw_color, true);	
	}
	
	static point_inside = function(vec2){
		return vec2.x >= p_min.x && vec2.x <= p_max.x &&
					 vec2.y >= p_min.y && vec2.y <= p_max.y;
	}
	
	static create = function(_x, _y, width, height){
		p_min = new Vec2(_x, _y);
		p_max = new Vec2(_x + width, _y + height);
	}
	
	static translate = function(_x, _y){
		show_debug_message("Breaks Bellow");

		p_min.x += _x;
		p_max.x += _x;
		p_min.y += _y;
		p_max.y += _y;
		show_debug_message("Breaks Up");

	}
}

function Circle_BB() constructor{
	center = new Vec2(50, 50);
	radius = 1;
	bounding_type = BOUNDING_TYPE.CIRCLE;
	draw_color = c_yellow;
	
	static draw = function(){
		draw_circle_color(center.x, center.y, 2, c_yellow, c_yellow, false);
		draw_circle_color(center.x, center.y, radius, draw_color, draw_color, true);
	}
	
	static point_inside = function(vec2){
		return center.distance(vec2) <= radius;
	}
	
	static fit = function(points_arr){
		var _atempts = 20;
		var _aabb = new AABB();
		_aabb.fit(points_arr);
		
		var _len = array_length(points_arr);
		var _r = 0, _center, _dist;  
		
		var _best_center, _best_radius = room_width + room_height;
		
		for(var i = 0; i < _atempts; i++){
			_center = new Vec2(	irandom_range(_aabb.p_min.x, _aabb.p_max.x), 
													irandom_range(_aabb.p_min.y, _aabb.p_max.y));
			_r = 0;
			
			/// PEGAR MAIOR RAIO
			for(var f = 0; f < _len; f++){
				_dist = _center.distance(points_arr[f]);
				if(_r < _dist) _r = _dist;
			}
			
			/// CASO MAIOR RAIO SEJA MENOR QUE RAIO 
			if(_r < _best_radius){
				_best_center = _center;
				_best_radius = _r;
			}
		}
		
		
		radius = _best_radius;
		center = _best_center;
	}
		
	static create = function(x, y, r){
		center = new Vec2(x, y);
		radius = r;	
	}
	
	static translate = function(_x, _y){
		center.x += _x;
		center.y += _y;
	}
}
	
function AABB_overlap_AABB(aabb_1, aabb_2){
	if(
		aabb_1.p_max.x < aabb_2.p_min.x ||
		aabb_1.p_max.y < aabb_2.p_min.y ||
		aabb_1.p_min.x > aabb_2.p_max.x ||
		aabb_1.p_min.y > aabb_2.p_max.y 
	)
		return false;
	
	return true;
}

function Circle_overlap_Circle(circle_1, circle_2){
	var _dist = circle_1.center.distance(circle_2.center);
	return _dist <= circle_1.radius + circle_2.radius; 
}

function AABB_overlap_Circle(aabb, circle){
	
}