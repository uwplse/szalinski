$fs = 1 * 1; // Times one to hide them from Customizer
mm = 25.4 * 1; // Times one to hide them from Customizer

// Parametric values for Thingiverse Customizer

// Nut / bolt size, 1/4"-1/2" SAE, M5-M12 metric
size = 1; // [1:1/4",2:5/16",3:3/8",4:7/16",5:1/2",6:M5,7:M6,8:M8,9:M10,10:M12]

// Nubs
nubs = 3; // [1:6]

// Knob Outer Radius (mm)
knob_outer_radius = 25; //[10:75]

// Hub Radius (mm)
hub_radius = 12; // [10:75]

// Outer Radius of Nubs (mm)
handle_outer_radius = 8; // [0:50]

// Inner Radius of Nubs (defines taper)
handle_inner_radius = 5; // [0:50]

// Knob Thickness (mm)
handle_thickness = 8; // [1:25]

// Chamfer (mm)
handle_chamfer = 1.5; // [0:0.5:5]

// Boss Thickness (mm)
boss_thickness = 1; // [0:0.5:25]

// Boss Radius (mm)
boss_radius = 9; // [0:75]

// Boss Chamfer (mm)
boss_chamfer = 1; // [0:0.5:10]

// Slop (mm)
slop = 0; // [-2:0.1:2]

nut_rad = 0.505 * mm / 2;
nut_height = 7/32 * mm;
thread_rad = 0.25 * mm / 2;

module knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness) {
    translate([0,0,-0.5]) cylinder(r = nut_rad + slop, h = nut_height + slop + 0.5, $fn = 6);
    translate([0,0,-0.5]) cylinder(r = thread_rad + slop, h = handle_thickness + boss_thickness + 1);
}

difference(){ // for when we remove the 
    union(){
        translate([0, 0, handle_chamfer]) minkowski(){
            linear_extrude(height = handle_thickness - (handle_chamfer * 2)) {
                offset(r = -1 * 3) {
                    union() {
                        for (rot = [0:nubs - 1]) {
                            rotate([0, 0, rot * 360 / nubs])
                            hull() {
                                translate([knob_outer_radius - handle_inner_radius, 0, 0]) circle(r = handle_outer_radius);
                                circle(r = handle_inner_radius);
                            }
                        }
                        circle(r =  hub_radius);
                    }
                }
            }
            union (){  // basically a vertical cone and an upside-down cone, to make the chamfer.
                cylinder(r1 = handle_chamfer, r2 = 0, h = handle_chamfer);
                rotate([180, 0, 0]) cylinder(r1 = handle_chamfer, r2 = 0, h = handle_chamfer);
            }
        }
        translate([0, 0, handle_thickness]) cylinder(r = boss_radius, h = (boss_thickness - boss_chamfer));
        translate([0, 0, handle_thickness + (boss_thickness - boss_chamfer)]) cylinder(r1 = boss_radius, r2 = (boss_radius - boss_chamfer), h = boss_chamfer);
    }
        
    if (size == 1) { // 1/4"
        nut_rad = 0.505 * mm / 2;
        nut_height = 7/32 * mm;
        thread_rad = 0.25 * mm / 2;
        knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness);
    }
    
    if (size == 2) { // 5/16"
        nut_rad = 0.577 * mm / 2;
        nut_height = 17/64 * mm;
        thread_rad = 0.3125 * mm / 2;
        knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness);
    }

    if (size == 3) { // 3/8"
        nut_rad = 0.650 * mm / 2;
        nut_height = 21/64 * mm;
        thread_rad = 0.375 * mm / 2;
        knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness);
    }
    
    if (size == 4) { // 7/16"
        nut_rad = 0.794 * mm / 2;
        nut_height = 3/8 * mm;
        thread_rad = 0.4375 * mm / 2;
        knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness);
    }
 
    if (size == 5) { // 1/2"
        nut_rad = 0.866 * mm / 2;
        nut_height = 7/16 * mm;
        thread_rad = 0.5 * mm / 2;
        knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness);
    }

    if (size == 6) { // M5
        nut_rad = 9.24 / 2;
        nut_height = 3.65;
        thread_rad = 2.5;
        knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness);
    }

    if (size == 7) { // M6
        nut_rad = 11.55 / 2;
        nut_height = 4.15;
        thread_rad = 5;
        knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness);
    }

    if (size == 8) { // M8
        nut_rad = 15.01 / 2;
        nut_height = 5.5;
        thread_rad = 4;
        knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness);
    }

    if (size == 9) { // M10
        nut_rad = 18.48 / 2;
        nut_height = 6.63;
        thread_rad = 5;
        knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness);
    }

    if (size == 10) { // M12
        nut_rad = 20.78 / 2;
        nut_height = 7.76;
        thread_rad = 6;
        knockout(nut_rad, slop, nut_height, thread_rad, handle_thickness, boss_thickness);
    }
}

//#translate([0, 0, -10]) cylinder(r=0.505 / 2 * mm, h = 30);
