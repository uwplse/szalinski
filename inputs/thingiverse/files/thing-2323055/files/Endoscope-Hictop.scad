// Endoscope holder for Hictop 3DP-17
// Should work on other models of Hictop printers and other printers with the same extruder system.


difference(){
    union(){
        // base
        cube([40,8,5.5],true);
        // holder tube
        translate([0,7,0])
            rotate([45,0,0])
                cylinder(30,d=7.5,true,$fn=200);
        // base<>holder support
        translate([0,0,2.5])
            cylinder(5,d1=11,d2=6,true,$fn=200);
        difference(){
            // retention blocks
            union(){
                translate([.5,-5,15])
                    rotate([90,315,90])
                       minkowski() {
                           cube([10,5,1],false);
                           cylinder(r=1,h=1,$fn=200);
}
                translate([-2.5,-5,15])
                    rotate([90,315,90])
                       minkowski() {
                           cube([10,5,1],false);
                           cylinder(r=1,h=1,$fn=200);
}
            }
            //screw holes
            translate([-3,-1.5,22])
                rotate([0,90,0])
                    cylinder(6,d=3,true,$fn=200);

        }

    }
    // clear spaces
    union() {
        // holder center - want it a little longer than the tube
        translate([0,7,0])
            rotate([45,0,0])
                cylinder(31,d=5.5,true,$fn=200); 
        // expansion slot
        translate([0,11,0])
            rotate([45,0,0])
                cube([1,2,70],true);
    }
    // carve out end of tube
    translate([0,8,-5])
        cylinder(20,d=8,true,$fn=200);
    // recessed screw holes for base
    union(){
        translate([16,0,-4])
            cylinder(3,d=4,true,$fn=200);
        translate([16,0,-1])
            cylinder(5,d=6,true,$fn=200);
        translate([-16,0,-4])
            cylinder(3,d=4,true,$fn=200);
        translate([-16,0,-1])
            cylinder(5,d=6,true,$fn=200);
    }
    // Carve out fan area
    translate([0,-15,-4])
        cylinder(9.5,d1=40,d2=25,true,$fn=200);
}

    
