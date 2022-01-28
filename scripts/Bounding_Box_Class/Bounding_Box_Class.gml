function BoudingAbstract() constructor{
	bouding_type = BOUNDING_TYPE.AABB;
	
	static draw = function(){}
	static point_inside = function(vec2){ return false }
	static fit = function(vec2_arr){}
}

function AABB() constructor{
	p_left = new Vec2(0,0);
	p_rigth = new Vec2(0,0);
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
		
		p_left = new Vec2(_min_x, _min_y);
		p_rigth = new Vec2(_max_x, _max_y);
	}
	
	static draw = function(){
		draw_circle_color( (p_left.x + p_rigth.x) / 2, (p_left.y + p_rigth.y) / 2, 2,  c_yellow, c_yellow, false);	
		draw_rectangle_color(p_left.x, p_left.y, p_rigth.x, p_rigth.y, draw_color, draw_color, draw_color, draw_color, true);	
	}
	
	static point_inside = function(vec2){
		return vec2.x >= p_left.x && vec2.x <= p_rigth.x &&
					 vec2.y >= p_left.y && vec2.y <= p_rigth.y;
	}
	
	static create = function(_x, _y, width, height){
		p_left = new Vec2(_x, _y);
		p_rigth = new Vec2(_x + width, _y + height);
	}
	
	static translate = function(_x, _y){
		show_debug_message("Breaks Bellow");

		p_left.x += _x;
		p_rigth.x += _x;
		p_left.y += _y;
		p_rigth.y += _y;
		show_debug_message("Breaks Up");

	}
}

function Circle_BB() constructor{
	center = new Vec2(50, 50);
	radius = 1;
	radius_sqr = 1
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
			_center = new Vec2(	irandom_range(_aabb.p_left.x, _aabb.p_rigth.x), 
													irandom_range(_aabb.p_left.y, _aabb.p_rigth.y));
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
		radius_sqr = sqr(r);
	}
	
	static translate = function(_x, _y){
		center.x += _x;
		center.y += _y;
	}
}
	
function OBB() constructor {
	center = new Vec2(0, 0);
	lenghts = new Vec2(0, 0); // Len X Len Y
	points = undefined; 
	angle = 0;
	
	vec_u = new Vec2(0, 0); // VETOR DIREÇÃO NORMALIZADO
	vec_v = new Vec2(0, 0); // NORMAL DE U
	
	bouding_type = BOUNDING_TYPE.OBB;
	draw_color = c_yellow;

	static draw = function(){
		draw_circle_color(center.x, center.y, 2, c_yellow, c_yellow, false);
		
		var _vec_u = vec_u.mult(lenghts.x);
		var _vec_v = vec_v.mult(lenghts.y);
		draw_set_color(c_green);
		draw_arrow(center.x, center.y, center.x + _vec_u.x, center.y + _vec_u.y, 20);
		draw_set_color(c_red);
		draw_arrow(center.x, center.y, center.x + _vec_v.x, center.y + _vec_v.y, 20);
		draw_set_color(c_white);

		if(points != undefined){
			draw_line_color(points[0].x, points[0].y, points[1].x, points[1].y, draw_color, draw_color);
			draw_line_color(points[1].x, points[1].y, points[2].x, points[2].y, draw_color, draw_color);
			draw_line_color(points[2].x, points[2].y, points[3].x, points[3].y, draw_color, draw_color);
			draw_line_color(points[3].x, points[3].y, points[0].x, points[0].y, draw_color, draw_color);
		}
	}
	
	static point_inside = function(vec2){ 
		vec2 = vec2.minus(center);
		
		var _proj = vec_u.mult(vec2.x).add( vec_v.mult(vec2.y)).add(center)
		
		return	_proj.x >= center.x - lenghts.x && _proj.x <= center.x + lenghts.x &&
						_proj.y >= center.y - lenghts.y && _proj.y <= center.y + lenghts.y;
	}
	
	static fit = function(vec2_arr, ang = irandom(359)){
		vec_u = new Vec2(lengthdir_x(1, ang), lengthdir_y(1, ang));
		vec_v = vec_u.normal();
		ap = vec2_arr;
		angle = ang;
		
		var _pu = [infinity, -infinity]
		var _pv = [infinity, -infinity]
		
		for(var i = 0; i < array_length(vec2_arr); i++){
			var _p = ap[i];
			var _dot_u = vec_u.dot(_p);
			var _dot_v = vec_v.dot(_p);
			
			_pu[0] = min(_pu[0], _dot_u);
			_pu[1] = max(_pu[1], _dot_u);
		
			_pv[0] = min(_pv[0], _dot_v);
			_pv[1] = max(_pv[1], _dot_v);
		}
		
		var _uc =		( _pu[0] + _pu[1] ) * 0.5;
		var _vc =		( _pv[0] + _pv[1] ) * 0.5;
		
		center = vec_u.mult(_uc).add( vec_v.mult(_vc));
		
		lenghts.x = ( _pu[1] - _pu[0] ) * 0.5;
		lenghts.y = ( _pv[1] - _pv[0] ) * 0.5;
	
		points = array_create(4);
		points[0] = vec_u.mult(lenghts.x).add( vec_v.mult(lenghts.y)).add(center);
		points[1] = vec_u.mult(-lenghts.x).add( vec_v.mult(lenghts.y)).add(center);
		points[2] = vec_u.mult(-lenghts.x).add( vec_v.mult(-lenghts.y)).add(center);
		points[3] = vec_u.mult(lenghts.x).add( vec_v.mult(-lenghts.y)).add(center);
		
	}
	
	static create = function(_x, _y, len_x, len_y, ang){
		center = new Vec2(_x, _y);
		lenghts = new Vec2(len_x, len_y);
		angle = ang;
		vec_u = new Vec2(lengthdir_x(1, ang), lengthdir_y(1, ang));
		vec_v = vec_u.normal();
		
		points = array_create(4);
		points[0] = vec_u.mult(lenghts.x).add( vec_v.mult(lenghts.y)).add(center);
		points[1] = vec_u.mult(-lenghts.x).add( vec_v.mult(lenghts.y)).add(center);
		points[2] = vec_u.mult(-lenghts.x).add( vec_v.mult(-lenghts.y)).add(center);
		points[3] = vec_u.mult(lenghts.x).add( vec_v.mult(-lenghts.y)).add(center);
	}
	
	static translate = function(_x, _y){
		center.translate(_x, _y);
		for(var i = 0; i < array_length(points); i++){
			points[i].translate(_x, _y);	
		}
	}
}

function AABB_overlap_AABB(aabb_1, aabb_2){
	if(
		aabb_1.p_rigth.x < aabb_2.p_left.x ||
		aabb_1.p_rigth.y < aabb_2.p_left.y ||
		aabb_1.p_left.x > aabb_2.p_rigth.x ||
		aabb_1.p_left.y > aabb_2.p_rigth.y 
	)
		return false;
	
	return true;
}

function Circle_overlap_Circle(circle_1, circle_2){
	var _dist = circle_1.center.distance(circle_2.center);
	return _dist <= circle_1.radius + circle_2.radius; 
}

function AABB_overlap_Circle(aabb, circle){
	var _c = circle.center;
	var _r2 = sqr(circle.radius);
	var _d2 = 0;
	
	if(_c.x <= aabb.p_left.x) _d2 += sqr(_c.x - aabb.p_left.x);
	else if(_c.x >= aabb.p_rigth.x) _d2 += sqr(_c.x - aabb.p_rigth.x);
	
	if(_c.y <= aabb.p_left.y) _d2 += sqr(_c.y - aabb.p_left.y);
	else if(_c.y >= aabb.p_rigth.y) _d2 += sqr(_c.y - aabb.p_rigth.y);
	
	return _r2 >= _d2;
}
	
function OBB_overlap_OBB(obb1, obb2){
	return false;
}

function OBB_overlap_AABB(obb, aabb){
	return false;
}

function OBB_overlap_Circle(obb, circle){
	var _c = circle.center.minus(obb.center);
	var _c2 = new Vec2(_c.dot(obb.vec_u), _c.dot(obb.vec_v));
	var _len = obb.lenghts;
	
	var _r2 = sqr(circle.radius);
	var _d2 = 0;
	
	if(_c2.x < -_len.x) _d2 += sqr(_c2.x + _len.x);
	else if(_c2.x > _len.x) _d2 += sqr(_c2.x - _len.x);
	
	if(_c2.y < -_len.y) _d2 += sqr(_c2.y + _len.y);
	else if(_c2.y > _len.y) _d2 += sqr(_c2.y - _len.y);
	
	return _r2 >= _d2;
}
	