// by tinaw 2016-06

module stencil() {
difference() {

//STENCIL
stencil_width = 75; // stencil_width = width of stencil in mm
stencil_height = 77; // stencil_height = height of stencil in mm
margin_left = 17; // left margin
margin_right = 10; // right margin
margin_top = 10; // top margin
margin_bottom = 10; // bottom margin

square(size = [stencil_width, stencil_height], center = false);


//LINES
spacing = 6; // space between lines in mm
line_length_auto = stencil_width - margin_left - margin_right - spacing*1.4;
line_length = line_length_auto; // line_length = length of lines, centered between icons
line_count_auto = round((stencil_height - margin_top - margin_bottom)/spacing); // maximum number of lines
line_count = line_count_auto; // line_count = number of lines with boxes 



for ( lines = [ 0 : line_count ] ) {
  translate ( [ (margin_left + spacing*0.7), margin_bottom + spacing/2 + spacing  * (lines-1), 0 ] ) {
    square(size = [line_length, 1.2], center = false); // line slot
  }
}


// STARS bottom left
points = 5; // points = number of points (minimum 3)
outer = spacing*0.65; // outer  = radius to outer points. 0.65 makes stars not fully close, but make for better shapes when drawn from
inner = outer/2 ; // inner  = radius to inner points

for ( stars = [ 1: round(line_count/2) ] ) {
  translate ( [ margin_left, margin_bottom + spacing  * (stars-1), 0 ] ) {
  Star(points, outer, inner);
  }
}


// HEARTS top left
heartsize = spacing*0.9; // heartsize = height of finished heart
for ( stars = [ round(line_count/2)+1 : line_count ] ) {

  translate ( [ margin_left, margin_bottom + spacing  * (stars-1), 0 ] ) {
    heart(heartsize);
  }
}



// CIRCLES bottom right, 
radius = spacing*0.42; // radius = circle radius
x_position = stencil_width - margin_right;

for ( circles = [ 1 : round(line_count/2) ] ) {
  translate ( [ x_position, margin_bottom + spacing  * (circles-1), 0 ] ) {
  circle(radius);
  }
}

// SQUARES top right
square_side = spacing*0.75; // square_side = square side
x_position = stencil_width - margin_right;

for ( squares = [ round(line_count/2)+1 : line_count ] ) {
  translate ( [ x_position, margin_bottom + spacing  * (squares-1), 0 ] ) {
  square(size = square_side, center = true);
  }
}

}
}

// anoved Star module, https://gist.github.com/anoved/9622826
module Star(points, outer, inner) {
	
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	
	// angular width of each pie slice of the star
	increment = 360/points;
	
	union() {
		for (p = [0 : points-1]) {
			
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p

                    x_outer = x(outer, increment * p);
					y_outer = y(outer, increment * p);
					x_inner = x(inner, (increment * p) + (increment/2));
					y_inner = y(inner, (increment * p) + (increment/2));
					x_next  = x(outer, increment * (p+1));
					y_next  = y(outer, increment * (p+1));
            {
                rotate(-18) {
				polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
			}}
		}
	}
}


module heart(heartsize) {
resize([heartsize,0,0], auto=true) {
        translate([0,-7]) {
                rotate(a=(45)) {
            union() {
                square(10,10);
                translate([10/2,10,0]) circle(10/2);
                translate([10,10/2,0]) circle(10/2);
                }
            }
        }
    }

}


module punch(){
w = 3.5/2;
union(){
intersection(){
translate([4,4,0]){
circle(r=4,$fn=100);
}

polygon([[-1,4],[-1,8],[8,8],[8,4]]);
}

polygon([[4-w,0],[4-w,4],[4+w,4],[4+w,0]]);
}
}


module punches(offset,count){
	spacing = 25;
	c = count;
	o = offset;

	for ( punches = [ 1 : c ] ) {
	 	translate ( [ o + spacing * (punches-1), 0, -1 ] ) {
    	punch();
  		}
	}
}



difference() {

  linear_extrude(height = 0.4, center = true, convexity = 10, twist = 0) stencil();

      linear_extrude(height = 0.5, center = true, convexity = 10, twist = 0) rotate (270) mirror(1,0,1)  punches(10,7); // comment this for no circa holes


 }