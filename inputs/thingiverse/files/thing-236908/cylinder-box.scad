//Author: Devin Grady
//License: CC BY 3.0 US ( http://creativecommons.org/licenses/by/3.0/us/ )

//Inner radius (open space in interior)
radius = 10; 

//Inner height (open space in interior)
height = 10; 

//Maximum wall thickness; will be cut into to fit lid.
wall = 2; 

//Fit tolerance parameter.
tolerance = .3; 

module cylinder_box(r=radius, h=height, w=wall, tol=tolerance){
	difference(){
		cylinder(r=r,h=h+w+tol);
		translate([0,0,w])cylinder(r=r-w, h = h+w+2*tol);
		translate([0,0,h])cylinder_lid(r=r,w=w, tol = 0);
		translate([w,0,h])cylinder_lid(r=r,w=w, tol = 0);
		translate([r/4, -r, h])cube([2*r, 2*r, r]);
	}
}
module cylinder_lid(r=radius, w=wall, tol = tolerance){
	hull(){difference(){
		cylinder(r=r-w/2, h=w-tol);
		translate([0,0,-tol])rotate_extrude()translate([r-w/2,0,0])rotate([0,0,45])square(r);
	}}
}


translate([-1.1*radius,0,0])cylinder_box();
translate([1.1*radius,0,0])cylinder_lid();