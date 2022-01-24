
function Vec2(_x, _y) constructor {
	x = _x ?? 0;
	y = _y ?? 0;
	
	static draw = function(radius = 3){
		draw_circle(x, y, radius, false);
	}
	
	static distance = function(vec2){
		return sqrt( sqr(vec2.x - x) + sqr(vec2.y - y) ); 
	}
	
	static translate = function(_x, _y){
		x += _x;
		y += _y;
	}
}

function Vec2Color(_x, _y, color) : Vec2(_x, _y) constructor{
	draw_color = color;
	
	static draw = function(radius = 3){
		draw_circle_color(x, y, radius, draw_color, draw_color, false);
	}
}

