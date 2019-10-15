thickness = 2.54;
show_nuts_bar = false;
show_spacers = false;
show_plate = false;
only_nuts_bar=show_nuts_bar && !show_spacers && !show_plate;
only_spacers=show_spacers && !show_nuts_plate && !show_plate;
$fn=16;

if (only_nuts_bar) 
   translate([-5,-15,-thickness]) nuts_bar();
else {
   if (only_spacers) {
       spacers();
   }
   else if (show_plate) {
       rotate([0,180,0]) {
           difference() {
                plate();
                // left cut
                translate([0,19,0]) cylinder(d=15.6,h=thickness);
                //  bolts holes
                translate([10,60,0]) cylinder(d=3.5,h=thickness);
                translate([48,60,0]) cylinder(d=3.5,h=thickness);
                //nuts holes
                 translate([10,20,0])  cylinder(d=3.5,h=thickness);
            translate([19.5,20,0])  cylinder(d=3.5,h=thickness);
                translate([31,20,0]) cylinder(d=3.5,h=thickness);
                translate([40.5,20,0]) cylinder(d=3.5,h=thickness);
           }
            sensor_guides();
            if (show_nuts_bar) 
                nuts_bar();
            if (show_spacers) {
                translate([10,60,thickness]) spacer();
                translate([48,60,thickness]) spacer();
            }

        }
       
    }
}


module plate() {
    translate([4,4,0])
    minkowski() {
        cube([50,78,thickness/2]);
        cylinder(d=8,h=thickness/2);
    }
}

module nuts_bar() {
    translate([0,0,thickness])
    difference() {
        
        translate([5,15,0]) cube([40.5,10,thickness]);
         translate([0,19,0]) cylinder(d=15.6,h=thickness);           
         translate([10,20,0])  cylinder(d=3.5,h=thickness);
        translate([19.5,20,0])  cylinder(d=6.6,h=thickness,$fn=6);
        translate([31,20,0])  cylinder(d=6.6,h=thickness,$fn=6);
        translate([40.5,20,0])  cylinder(d=3.5,h=thickness);
    }
}

module sensor_guides() {
    translate([13.75,0,-thickness]) cube([2,35,thickness]);
    translate([34.75,0,-thickness]) cube([2,35,thickness]);
}

module spacer() {
    difference() {
        cylinder(d=5.5,h=20.5);
        cylinder(d=3.5,h=20.5);
    }
}

module spacers() {
    spacer();
    translate([8.5,0,0]) spacer();
}