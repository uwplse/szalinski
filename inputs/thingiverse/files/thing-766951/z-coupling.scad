// adjusted for 5mm -> 6.35mm coupling
// made it a bit longer for possibly better z-wobble fighting
// rounded corners

$fn = 40;

// diameter of z lead screw
studding_dia = 6.35;
// diameter of motor axis
shaft_dia = 5.0;

// asymmetric axis. You can try values like 0.0, 0.1, 0.3, 0.5
asym = 0.0;  

holeX = 10.5;
holeY = 6.5;

holeR = 3.4 / 2;
nutR = 3.25;
nutH = 3;
boltheadR = 3;

height = 35;
width = 23;
thickness = 8;


module rounded_cube(x, y, z, r) {
	translate([r, r, 0])
	minkowski() {
		cylinder(r=r, h=1);
		cube([x - 2*r, y - 2*r, z-1]);
	}
}

module coupling(c){
    union(){
        difference(){
            //cube(size = [height,width,thickness], center = true);
			  translate([-height/2, -width/2, -thickness/2])
			  rounded_cube(height, width, thickness, 5);

            if(c==1){
                //slot
            	*cube(size = [2,40,30], center = true);
                
                //nut holes
            	translate([ holeX,  holeY, nutH/2 - 4.01]) cylinder(h = nutH, r=nutR, $fn=6, center=true);
            	translate([ holeX, -holeY, nutH/2 - 4.01]) cylinder(h = nutH, r=nutR, $fn=6, center=true);
            	translate([-holeX,  holeY, nutH/2 - 4.01]) cylinder(h = nutH, r=nutR, $fn=6, center=true);
            	translate([-holeX, -holeY, nutH/2 - 4.01]) cylinder(h = nutH, r=nutR, $fn=6, center=true);
            }
            if(c==0){
                //slot
            	*cube(size = [2,40,30], center = true);
                
                //nut holes
            	translate([ holeX,  holeY, nutH/2 - 5.01]) cylinder(h = nutH, r=boltheadR, $fn=60, center=true);
            	translate([ holeX, -holeY, nutH/2 - 5.01]) cylinder(h = nutH, r=boltheadR, $fn=60, center=true);
            	translate([-holeX,  holeY, nutH/2 - 5.01]) cylinder(h = nutH, r=boltheadR, $fn=60, center=true);
            	translate([-holeX, -holeY, nutH/2 - 5.01]) cylinder(h = nutH, r=boltheadR, $fn=60, center=true);
            }
			

            //shaft groves
			  if (c == 0) {
            translate([ -160, -asym, 4.5]) rotate([0,90,0]) cylinder(h = 160, r=studding_dia / 2, $fn=16);
			  }
			  if (c == 1) {
            translate([ -160, asym, 4.5]) rotate([0,90,0]) cylinder(h = 160, r=studding_dia / 2, $fn=16);
			  }

            translate([-0.5, 0, 4.5]) rotate([0,90,0]) cylinder(h = 160, r=shaft_dia / 2,    $fn=16);

            //screw holes
            translate([ holeX,  holeY, -10]) cylinder(h = 20, r=holeR, $fn=16);
            translate([ holeX, -holeY, -10]) cylinder(h = 20, r=holeR, $fn=16);
            translate([-holeX,  holeY, -10]) cylinder(h = 20, r=holeR, $fn=16);
            translate([-holeX, -holeY, -10]) cylinder(h = 20, r=holeR, $fn=16);
        }
        if(c==1){
            // bridge
        	translate([ holeX,  holeY, nutH-4]) cylinder(h = 0.4, r=nutR+0.1, $fn=6, center=true);
        	translate([ holeX, -holeY, nutH-4]) cylinder(h = 0.4, r=nutR+0.1, $fn=6, center=true);
        	translate([-holeX,  holeY, nutH-4]) cylinder(h = 0.4, r=nutR+0.1, $fn=6, center=true);
        	translate([-holeX, -holeY, nutH-4]) cylinder(h = 0.4, r=nutR+0.1, $fn=6, center=true);
        }
        if(c==0){
            // bridge
        	translate([ holeX,  holeY, nutH-5]) cylinder(h = 0.4, r=nutR+0.1, $fn=6, center=true);
        	translate([ holeX, -holeY, nutH-5]) cylinder(h = 0.4, r=nutR+0.1, $fn=6, center=true);
        	translate([-holeX,  holeY, nutH-5]) cylinder(h = 0.4, r=nutR+0.1, $fn=6, center=true);
        	translate([-holeX, -holeY, nutH-5]) cylinder(h = 0.4, r=nutR+0.1, $fn=6, center=true);
        }
    }
}

translate([0, 14, 0]) coupling(c=0);
translate([0, -14, 0]) rotate([0,0,180]) coupling(c=1);