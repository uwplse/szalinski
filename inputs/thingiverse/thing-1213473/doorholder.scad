$fn=30;
length=40;
a1=20;
a2=26;
thick=5;
hole=5; //mounting holes diameter

//hook
rotate([90,0,0]) {
    //mounting plate
    difference() {
        cube([a2,a1,thick]);
        translate([a2/3,hole,-thick/4])
        cylinder(thick*2,hole/2,hole/2);
        translate([a2/3,a1-hole,-thick/4])
        cylinder(thick*2,hole/2,hole/2);
    }
    //up
    translate([a2-thick,0,0]) {
        cube([thick,a1,length]);
        //edge
        movex=sqrt(2*thick)/2;
        translate([movex,0,length-thick]) {
            rotate([0,45,0]) {
                cube([thick,a1,thick]);
            }
        }
    }
}


//retaining plate
translate([-a2-10,0,0]) {
    difference() {
        cube([a2,a1,thick]);
        translate([a2/3,hole,-2])
        cylinder(thick*2,hole/2,hole/2);
        translate([a2/3,a1-hole,-2])
        cylinder(thick*2,hole/2,hole/2);
    }
}

