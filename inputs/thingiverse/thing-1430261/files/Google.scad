//Fan Size
size = 120;
//Distance between fan mounting holes
hole_spacing = 105;
//Rounded corner radius
corner_radius = 10;
//Thickness of outside plate
thickness = 2;
//Should match the thickness of the filter
stand_off_length = 5;
//Mounting hole size
screw_size = 4.5;


$filtersize=size+5;
$c = sqrt($filtersize*$filtersize*2);
$standoffwidth = screw_size+6;
$screwoffset = (size-hole_spacing)/2;
difference(){
    union(){
        cube([size,size,thickness+stand_off_length]);
    }
    translate([$screwoffset,$screwoffset,-1])
    cylinder(thickness+stand_off_length+2,screw_size/2,screw_size/2,$fn=100);
    translate([$screwoffset+hole_spacing,$screwoffset,-1])
    cylinder(thickness+stand_off_length+2,screw_size/2,screw_size/2,$fn=100);
    translate([$screwoffset,$screwoffset+hole_spacing,-1])
    cylinder(thickness+stand_off_length+2,screw_size/2,screw_size/2,$fn=100);
    translate([$screwoffset+hole_spacing,$screwoffset+hole_spacing,-1])
    cylinder(thickness+stand_off_length+2,screw_size/2,screw_size/2,$fn=100);
    translate([size/2,-1*($c-size)/2,thickness])
    rotate([0,0,45])
    cube([$filtersize,$filtersize*2,thickness+stand_off_length]);
    translate([0,size*.5,-1])
    rotate([0,0,45])
    cube([size,size,thickness+stand_off_length+2]);
    
    translate ([size,0,0])
	translate ([-corner_radius,corner_radius,-1])
	difference () {
		translate ([0,-corner_radius*2,0])
		cube ([corner_radius*2,corner_radius*2,thickness+stand_off_length+2]);
		cylinder (r=corner_radius,h=thickness+stand_off_length+2,$fn=100);
	}
    
    translate ([size,size,0])
	translate ([-corner_radius,-corner_radius,-1])
	difference () {
		cube ([corner_radius*2,corner_radius*2,thickness+stand_off_length+2]);
		cylinder (r=corner_radius,h=thickness+stand_off_length+2,$fn=100);
	}
    	translate ([corner_radius,corner_radius,-1])
	difference () {
		translate ([-corner_radius*2,-corner_radius*2,0])
		cube ([corner_radius*2,corner_radius*2,thickness+stand_off_length+2]);
		cylinder (r=corner_radius,h=thickness+stand_off_length+2,$fn=100);
	}

    
}
translate([size/2,size/2,0])
cylinder(thickness,size/2,size/2,$fn=100);

