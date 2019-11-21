//Filament Spool Boss

//-----------------------------------
//Amend these two variables to suit your spool and axle rod
spool_hole_diameter=74;
axle_diameter=8;
//-----------------------------------
//Adjust axle_hole_play variable to fine tune the fit on the axle ie. 0.25 will increase the size of the hole by 0.5mm
axle_hole_play=0.25;
//-----------------------------------


spool_hole_rad=spool_hole_diameter/2;
axle_rad=axle_diameter/2+axle_hole_play;

$fn=180; 

difference() {
    cylinder(r=spool_hole_rad+4, h=3); 
    cylinder(r=axle_rad, h=3);
    
    for( i=[1:1:6]) {
        rotate([0, 0, i*360/6]) hole();
        }
}

module hole() {
    hull() {
        translate([axle_rad+4,0,0]) {
            cylinder(r=1.5, h=3);
        }
            translate([spool_hole_rad-7.5,0,0]) {
            cylinder(r=5, h=3);
        }
    }
}


    translate([0,0,3]) {
        difference() {
            cylinder(r=spool_hole_rad, h=10);
            cylinder(r=spool_hole_rad-2.5, h=11);
        }
    }

difference() {
    cylinder(r=axle_rad+2.5, h=13); 
    cylinder(r=axle_rad, h=13);
}