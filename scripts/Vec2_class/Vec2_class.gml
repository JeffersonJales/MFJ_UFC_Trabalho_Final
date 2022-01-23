
function Vec2() constructor {
	x = argument[0] ?? 0;
	y = argument[1] ?? 0;
	
	static draw = function(radius = 3){
		draw_circle(x, y, radius, false);
	}
	
	static distance = function(vec2){
		return sqrt( sqr(vec2.x - x) + sqr(vec2.y - y) ); 
	}
}

