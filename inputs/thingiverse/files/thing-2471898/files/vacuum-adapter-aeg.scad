// outer diameter of the tube. usefull values are 38, 35, 32
outer_diameter = 35;

/* [Hidden] */
tube_height = 50;
aeg_width = 41.8;
aeg_depth = 15.5;
aeg_height = 60;

difference() {
    // the thing
    union() {
        // upper part
        translate([0,0,50+tube_height]) {
            // to aeg
            difference() {
                cube([aeg_width, aeg_depth, aeg_height], center=true);
                // cut top
                translate([0,0,30]) rotate([45,0,0]) cube([2*aeg_width,20,50], center=true);
                // cut sides
                translate([-25,-3,-10]) cube([5.5, 3, 50]);
                translate([25-5.5,-3,-10]) cube([5.5, 3, 50]);
            }
            // sealing top & bottom
            translate([0,0,-20]) difference() {
                union() {
                    // top
                    translate([-50,aeg_depth/2,-95]) cube([100, 4, 100]);
                    // bottom
                    translate([0,-aeg_depth/2-4,-80]) rotate([90,0,0]) cylinder(r=100, h=8, center=true, $fn=200);
                }
                translate([-aeg_width/2-50,0,0]) cube([100, 100, 500], center=true);
                translate([+aeg_width/2+50,0,0]) cube([100, 100, 500], center=true);
                translate([0,0,-105]) cube([500, 100, 200], center=true);
            }
            // sealing side
            translate([0,0,-25]) difference() {
                union() {
                    translate([aeg_width/2+2,-2,22.5/2]) cube([4, aeg_depth+12, 23], center=true);
                    translate([-aeg_width/2-2,-2,22.5/2]) cube([4, aeg_depth+12, 23], center=true);
                }
                translate([0,0,17]) rotate([-32,0,0]) translate([-50,-50,0]) cube([100, 100, 100]);
            }
        }
        // tube
        union() {
            cylinder(r1=outer_diameter/2, r2=outer_diameter/2+1, h=tube_height*0.6, $fn=50);
            hull() {
                translate([0,0,tube_height*0.6]) cylinder(r=outer_diameter/2+1, h=tube_height*0.4, $fn=50);
                translate([0,-2,tube_height+20]) cube([aeg_width+8, aeg_depth+12, 10], center=true);
            }
        }
    }
    
    // cut...
    translate([0,0,-10]) cylinder(r=outer_diameter/2-2.5, h=tube_height+10, $fn=50);
    translate([0,0,tube_height]) cylinder(r1=outer_diameter/2-3, r2=5, h=20, $fn=50);
    translate([0,0,tube_height+90/2]) cube([aeg_width-6, 15.5-6, 90], center=true);
}

translate([0,-15.4,30+tube_height]) rotate([90,0,0]) linear_extrude(height = 1) {
       text(text = str(outer_diameter), halign = "center");
}