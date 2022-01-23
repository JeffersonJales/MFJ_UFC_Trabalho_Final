function BoudingAbstract(vec2_arr) constructor{
	bouding_type = BOUNDING_TYPE.AABB;
	
	static draw = function(){}
	static point_inside = function(vec2){ return false }
	
	static fit = function(vec2_arr){}
	
	fit(vec2_arr);
}


function AABB(vec2_arr) constructor{
	p_min = new Vec2(0,0);
	p_max = new Vec2(0,0);
	bouding_type = BOUNDING_TYPE.AABB;

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
		draw_rectangle(p_min.x, p_min.y, p_max.x, p_max.y, true);	
	}
	
	static point_inside = function(vec2){
		return vec2.x >= p_min.x && vec2.x <= p_max.x &&
					 vec2.y >= p_min.y && vec2.y <= p_max.y;
	}
	
	fit(vec2_arr);
	
}

function Circle_BB(points_arr) constructor{
	center = new Vec2(0, 0);
	radius = 1;
	BOUNDING_TYPE = BOUNDING_TYPE.CIRCLE;
	
	static draw = function(){
		draw_circle(center.x, center.y, radius, true);
	}
	
	static point_inside = function(vec2){
		return center.distance(vec2) <= radius;
	}
	
	/// GERA UM PONTO ALEATÓRIO QUE SERÁ O CENTRO. 
	/// PEGA O PONTO MAIS DISTANCE. A DISTANCIA ENTRE ESSES DOIS PONTOS É O RAIO.
	/// SALVAR O CENTRO EM QUE O RAIO FOR O MENOR.
	
	static fit = function(points_arr){
		var _aabb = new AABB(points_arr);
		
		var _len = array_length(points_arr);
		var _r = 0, _center, _dist;  
		var _best_center, _best_radius;
		
		for(var i = 0; i < _len; i++){
			_center = points_arr[i];
			
			for(var f = 0; f < _len; f++){
				_dist = _center.distance(points_arr[f]);	
				if(_dist != 0 && _dist > _r){
					_best_center = _center;
					_best_radius = _dist;
				}
			}
			
		}
		
		radius = _best_radius;
		center = _best_center;
	}
	
	fit(points_arr);
}