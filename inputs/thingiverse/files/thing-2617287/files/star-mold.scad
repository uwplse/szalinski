//How Much cornser should your star have?
corners=5; //[3:1:32]

// What should the raduis of the stars 'body' be?
ri=10; //[0:0.1:500]

// What should the radius of the stars tips be?
ro=20; //[0:0.1:500]

// How high shoild your star be?
h=10;  //[0:0.1:500]

// How much of the stars height should be rounded?
roundness=.2; //[0:0.01:1]

// Would you like to get a mold or the star?
// Use to preview the positive.
mold="no"; //[no,yes]

// How thick should the mold be (relative to the star it self)?
mold_padding=0.1; //[0.05:0.05:1]

// $fn, how detailed should the rounding be?
fn=64; //[16:1:256]

$fn=fn;



module Star(points, outer, inner) {
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	increment = 360/points;
	union() {
		for (p = [0 : points-1]) {
			assign(	x_outer = x(outer, increment * p),
					y_outer = y(outer, increment * p),
					x_inner = x(inner, (increment * p) + (increment/2)),
					y_inner = y(inner, (increment * p) + (increment/2)),
					x_next  = x(outer, increment * (p+1)),
					y_next  = y(outer, increment * (p+1))) {
				polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
			}
		}
	}
}


module star(){
  render()intersection(){
    linear_extrude(h)Star(corners,ri,ro);
    union(){
      cylinder(r=ro,h=h*(1-roundness));
      translate([0,0,h*(1-roundness)])scale([ro,ro,h*roundness])sphere(r=1);
    }
  }
}

if(mold=="yes"){
    render()rotate([180,0,0])difference(){
      scale([1+mold_padding,1+mold_padding,1+mold_padding])star(roundness=0);
      star();
    }    
  
}else{
  star();
}
