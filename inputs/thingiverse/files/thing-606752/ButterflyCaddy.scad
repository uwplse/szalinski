
number_of_handsets = 3;
handset_width = 52;  // default: 52
handset_depth = 22;  // default: 22
cradle_depth = 30;   // default: 30

wall_thickness = 3;

for(i=[1:number_of_handsets]) {
    translate([i*(handset_width+wall_thickness*2),0,0]) handset(i);
}

module handset() {
    handset_cradle();
    powersupply_support();
    cradle_base();
}

module handset_cradle(i) {
    
    difference() {
        union() {
            cube([handset_width+wall_thickness*2, handset_depth+wall_thickness*2, cradle_depth+wall_thickness], center=true);
        }
        union() {
            // rounded fillet of the backside of the cradle.
            hull() {
                translate([-handset_width/2+5,handset_depth/2-5,wall_thickness/2]) 
                        cylinder(r=5,h=cradle_depth, center=true);
                translate([handset_width/2-5,handset_depth/2-5,wall_thickness/2]) 
                        cylinder(r=5,h=cradle_depth, center=true);
            }
            translate([0,-2.5,wall_thickness/2]) cube([handset_width, handset_depth-5, cradle_depth], center=true);
            hull() {
                // 20mm lip at the bottom is not parameterized, nor is the 10mm radius of the knockout.
                rotate([90,0,0]) translate([-handset_width/2+10,-cradle_depth/2+20,handset_depth/2]) 
                        cylinder(r=10,h=handset_depth, center=true);
                rotate([90,0,0]) translate([handset_width/2-10,-cradle_depth/2+20,handset_depth/2]) 
                        cylinder(r=10,h=handset_depth, center=true);
            }
            translate([0,-handset_depth/2,20]) 
                        cube([handset_width,handset_depth,cradle_depth],center=true);
            translate([0,  5.5, -((cradle_depth+wall_thickness)/2)+wall_thickness]) cube([18,14,wall_thickness*2], center=true);
            translate([0, -5.5, -((cradle_depth+wall_thickness)/2)+wall_thickness]) cube([18,14,wall_thickness*2], center=true);
        }
    }
}

module powersupply_support(i) {
    difference() {
        union(){
            translate([0,-5.5,-20-((cradle_depth+wall_thickness)/2)+wall_thickness]) cube([18,14,40], center=true);
        }
        union() {
            translate([0, -5.5, -10-((cradle_depth+wall_thickness)/2)+wall_thickness]) cube([15,10,20], center=true);
            translate([0, -5.5, -20-((cradle_depth+wall_thickness)/2)+wall_thickness]) cylinder(r=5,h=40, center=true);
            translate([0, -5.5+5, -20-((cradle_depth+wall_thickness)/2)+wall_thickness]) cube([3,4,40],   center=true);
            translate([0, -5.5+5, -30-((cradle_depth+wall_thickness)/2)+wall_thickness]) cube([8,4,20],   center=true);
        }
    }
}

module cradle_base(i) {
    difference() {
        union() {
            translate([0,0,-20-((cradle_depth+wall_thickness)/2)+wall_thickness]) cube([handset_width+wall_thickness*2, handset_depth+wall_thickness*2, 40], center=true);
        }
        union() {
            translate([0,0,-20-((cradle_depth+wall_thickness)/2)+wall_thickness]) cube([handset_width, handset_depth, 40], center=true);
            translate([0,(handset_depth+wall_thickness*2)/2,-(cradle_depth+wall_thickness)/2-35]) cube([3,wall_thickness*2,10],center=true);
        }
    }
} 

