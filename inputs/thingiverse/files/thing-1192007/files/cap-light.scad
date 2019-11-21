//
//  design by egil kvaleberg, 4 january 2016
//
//  cap for trailer position light
//

// diameter of outside rim
major_dia = 46.0;
// diameter of body
minor_dia = 42.0;
// thickness of rim;
rim = 2.75;

// height of body
bodyheight = 18.0;
// body chamfer
chamfer = 7.0;

// should be thin to increase amount of light
wall = 1.0;
supportwall = 0.7;
// you probably want to make this thin to increase amount of light it lets through
roof = 0.45;

/* [Hidden] */
d=0.01;


difference() {
    union() {
        cylinder(d=major_dia, h=rim, $fn=120);
        translate([0, 0, rim-d]) cylinder(d=minor_dia, h=rim+d, $fn=120);
        translate([0, 0, 2*rim-d]) cylinder(d1=minor_dia,  d2=minor_dia-chamfer*0.5, h=bodyheight-chamfer+d, $fn=120);
        translate([0, 0, 2*rim+bodyheight-chamfer-d]) cylinder(d1=minor_dia-chamfer*0.5, d2=minor_dia-chamfer*0.5-chamfer*2, h=chamfer+d, $fn=120);
    }
    difference () {
        union() {
            translate([0, 0, -d]) cylinder(d=minor_dia-2*wall, h=rim+2*d, $fn=120);
            translate([0, 0, rim-d]) cylinder(d=minor_dia-2*wall, h=rim+d, $fn=120);
            translate([0, 0, 2*rim-d]) cylinder(d1=minor_dia-2*wall,  d2=minor_dia-chamfer*0.5-2*wall, h=bodyheight-chamfer+d, $fn=120);
            translate([0, 0, 2*rim+bodyheight-chamfer-d]) 
                cylinder(d1=minor_dia-chamfer*0.5-2*wall, d2=minor_dia-chamfer*0.5-chamfer*2-2*wall, h=chamfer+d-roof, $fn=120);
        }  
        union() { // internal walls supporting roof and walls
            for (a = [0:45:180-d]) rotate([0, 0, a]) {
                difference () { 
                    translate([-minor_dia/2,-supportwall/2,0]) cube(size=[minor_dia, supportwall, 2*rim+bodyheight-chamfer]);
                    union () {
                        translate([0, 0, -d]) cylinder(d1=minor_dia-2*wall, d2=minor_dia-2*wall-2*3*roof, h=2*rim+2*d, $fn=120);
                        translate([0,0,2*rim-d]) cylinder(d1=minor_dia-2*wall-2*3*roof, d2=minor_dia-chamfer*0.5-2*wall-2*3*roof, h=bodyheight-chamfer+2*d, $fn=120);
                    }
                }
                translate([0, 0, 2*rim+bodyheight-chamfer]) { 
                    difference () { 
                        translate([-minor_dia/2,-supportwall/2,0]) cube(size=[minor_dia, supportwall, chamfer]);
                        translate([0,0,-d]) cylinder(d1=minor_dia-chamfer*0.5-2*wall-2*3*roof, d2=minor_dia-chamfer*0.5-chamfer*2-2*wall-2*3*roof, h=chamfer+d-roof, $fn=120);
                    }
                    translate([-minor_dia/2,-supportwall/2,chamfer-roof-(roof*(a==0 ? 4 : 3))]) cube(size=[minor_dia, supportwall, chamfer]);
                }
            }
        }
    }
}