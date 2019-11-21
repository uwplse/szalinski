include <new-chain.scad>

$width  = 22.44;
$length = 26.3;
$lkeep  = 4.5;
$height = 13.29;

/*
    translate([0,0,$height/2])
    difference() {
        //translate([0,0,-$height])
        //cube([$width,$length,$height]);
        //difference() {
            translate([$width, 0, 0]) rotate([0, 180, 0])
            nobar_chain();
            translate([0,0,-$height/2])
            #cube([$width*2, $length, $height/2]);
            translate([0,$lkeep,-$height])
            #cube([$width*2, $length-$lkeep, $height/2]);
        //}
    }
*/

union() {
    difference() {
        nobar_chain();
        translate([-$width/2,0,0])
        #cube([$width*2, $lkeep, $height/2+.5]);
    }
    translate([0,0,$height/2+.5])
    rotate([180,180,180]) import_stl("bendable_nobar_one_cutout_fixed.stl");
}