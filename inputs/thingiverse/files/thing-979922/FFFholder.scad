//Length of hook to hang spool on.
tube_length = 80;
//Diameter of spool holder
tube_diameter = 40;
//Size of spool retaining lip. Don't go too big or your spool won't fit over it.
lip_size = 4;
//Cut short some for easy printing with no support
cut_support = 15; 
//Thickness of the wall in the back of your printer.  Use 8 for flashforge.
hanger_gap = 8;  
//Thickness of hanger structure.  
structure_thickness = 4;
//Overall width of hanger
hanger_width = 50;  
/* [Hidden] */
hanger_gap_height = 15;
fillet_radius = 2;
tube_radius = tube_diameter/2;

difference() {
//transform for printing bed
translate([0, 30,hanger_width/2 - cut_support ])
rotate([0,90,0])
union() {
	$fn=60;
	translate([-hanger_width/2,structure_thickness+hanger_gap,50/2-hanger_gap_height])
	difference() {
		union() {
			translate([0,-hanger_gap,3]) //cube([50,structure_thickness+hanger_gap,40-3]);
			h_rounded_cube([50,structure_thickness+hanger_gap,40-3],2);
			translate([0,-hanger_gap,-50+hanger_gap_height]) mirror([0,1,0])
				cube([50,structure_thickness,50]);
		}
		mirror([0,1,0]) translate([-1,0,15]) 
			h_rounded_cube([hanger_width+2,10,30],fillet_radius);
		mirror([0,1,0]) translate([-1,0,-10]) 
			h_rounded_cube([hanger_width+2,hanger_gap,15-structure_thickness+10],fillet_radius);
	}
	//tube
	difference() {
		union() {
			rotate([90,0,0]) cylinder(h=tube_length, r=tube_radius);
			rotate([90,0,0]) cylinder(h=10, r1=tube_radius+lip_size, r2=tube_radius);
			translate([0,-tube_length,0]) rotate([-90,0,0]) 
				cylinder(h=5, r=tube_radius+lip_size);
		}
		rotate([90,0,0]) cylinder(h=tube_length+1, r=tube_radius-structure_thickness);
		translate([-500,-500])mirror([0,0,1])cube([1000,1000,1000]);
	}
	//make ribs on the center for support in the direction of gravity.
	intersection() {
		rotate([90,0,0]) cylinder(h=tube_length, r=tube_radius);
		union() {
			for(i = [-40:5:40]) {
				rotate([90,0,0]) translate([-1+i,0,0]) cube([2,100,100]);
			} 
			translate([-hanger_width/2,-tube_length,0])
				cube([hanger_width,tube_length,structure_thickness]);
		}
	}
}
translate([-500,-500,-1000])
cube([1000, 1000, 1000]);
}


module h_rounded_cube(xyz,r,$fn=30) {
	x = xyz[2];
	y = xyz[1];
	z = xyz[0];
	translate([z,0])
	rotate([0,-90,0])
	translate([r,r])
	hull() {
		cylinder(h=z,r=r);
		translate([0,y-2*r])
		cylinder(h=z,r=r);
		translate([x-2*r,0])
		cylinder(h=z,r=r);
		translate([x-2*r,y-2*r])
		cylinder(h=z,r=r);
	}
}