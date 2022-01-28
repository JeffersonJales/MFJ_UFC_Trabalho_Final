
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
	
	static translate_v = function(vec2){
		add(vec2);
	}
	
	static normalize = function(){
		var _len = length();
		return new Vec2(x / _len, y / _len);
	}
	
	static length = function(){
		return sqrt(sqr(x) + sqr(y));	
	}
	
	static normal = function(){
		return new Vec2(y, -x);
	}
	
	static dot = function(vec2){
		return x * vec2.x + y * vec2.y; //  dot_product(x, y, vec2.x, vec2.y);	
	}
	
	static mult = function(scalar){
		return new Vec2(x * scalar, y * scalar);
	}
	
	static add = function(vec2){
		return new Vec2(x + vec2.x, y + vec2.y);
	}
	
	static minus = function(vec2){
		return new Vec2(x - vec2.x, y - vec2.y);
	}
}

function Vec2Color(_x, _y, color) : Vec2(_x, _y) constructor{
	draw_color = color;
	
	static draw = function(radius = 3){
		draw_circle_color(x, y, radius, draw_color, draw_color, false);
	}
}

