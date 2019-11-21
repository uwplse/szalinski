poly = [[[-1,1],[1,1],[1,-1],[-1,-1]],[[0,1,2,3]]]; //[draw_polygon:100x100]

//Cutter size (mm)
size = 30;
//Round edges of cutter?
rounded = "true"; // [false,true]
Brounded = (rounded == "true");
//width of cookie cutter body (mm)
width = 1.5;
//total height of the cookie cutter (mm)
height = 12.0;
//width of bottom flange (mm)
flangeWidth = 4.0;
//height of bottom border (mm)
flangeHeight = 1.2;
//arc segments/precision
$fn = 40; // [1:100]

function bounds(pts) =
    let (xs = [ for (i=[0:len(pts)-1]) pts[i][0] ], ys = [ for (i=[0:len(pts)-1]) pts[i][1] ])
	[ [min(xs), min(ys)], [max(xs), max(ys)] ];

module shape() {
	b = bounds(poly[0]);
	h = b[1][1] - b[0][1];
	w = b[1][0] - b[0][0];
	scale([size/max(h,w),size/max(h,w),1])
	translate([-b[0][0], -b[0][1]])
	polygon(poly[0], poly[1]);
}

difference(){
    if (Brounded) { //which offset style to use?
        linear_extrude(flangeHeight) offset(flangeWidth) shape(); //flange on top
        linear_extrude(height) offset(width) shape();             //outer edge of cutter
    } else {
        linear_extrude(flangeHeight) offset(delta=flangeWidth) shape(); //flange on top
        linear_extrude(height) offset(delta=width) shape();             //outer edge of cutter
    }
    translate([0,0,-0.1]) linear_extrude(height+0.2) shape(); //offset to subtract well
}
