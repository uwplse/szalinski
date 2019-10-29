/*
copyright 2016 überhack

Customizable SD card holder by uberhack is licensed under the Attribution - Non-Commercial - Share Alike license.

Have fun =)
*/

rows = 2;
cols = 10;
height = 25;
radius = 2.5;
tolerance = 0.2;

$fn=50/1;

// card size 32.0 × 24.0 × 2.1 mm
sd_card_holder();


module sd_card_holder(){
cardx = 24;
cardy = 2.1;
cardz = 32;

    difference(){
        hull(){
            cylinder(r=radius, h=height);
            translate([0,cols*10,0])
            cylinder(r=radius, h=height);
            translate([rows*(radius*2+cardx+tolerance)-radius,cols*10,0])
            cylinder(r=radius, h=height);
            translate([rows*(radius*2+cardx+tolerance)-radius,0,0])
            cylinder(r=radius, h=height);
        }

        for (r = [0:1:rows-1]){
            for (c = [0:1:cols-1]){
                translate([r*(radius*2+cardx+tolerance),radius+(c*10),10])
                cube([cardx+tolerance,cardy+tolerance,cardz+tolerance]);
            }
        }
    }
}

