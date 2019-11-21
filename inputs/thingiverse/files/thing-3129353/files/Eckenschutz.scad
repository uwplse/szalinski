$fn = 64;
radius = 5;
width = 40;
InnerHeight = 16;

difference() {
    hull() {
			translate ([width/2, 0, -InnerHeight/2]) sphere(r=radius); 
			translate ([-width/2, 0, -InnerHeight/2]) sphere(r=radius);
			translate ([0, width/2, -InnerHeight/2]) sphere(r=radius); 
			
			translate ([width/2, 0, InnerHeight/2]) sphere(r=radius); 
			translate ([-width/2, 0, InnerHeight/2]) sphere(r=radius);
			translate ([0, width/2, InnerHeight/2]) sphere(r=radius); 
    }
		
    rotate([0, 0, 45]) translate([-width/2+width/2*sin(45), -width/2+width/2*sin(45), 0]) cube([width, width, InnerHeight], center=true);
    translate([0, -(width/2)-radius+radius/5*2, 0]) cube([width*1.41, width, InnerHeight+2*radius], center=true);
}
