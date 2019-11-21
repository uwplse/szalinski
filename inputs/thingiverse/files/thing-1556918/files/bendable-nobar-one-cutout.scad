include <new-chain.scad>

$width  = 22.44;
$length = 26.3;
$lkeep  = 4.5;
$height = 13.29;

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
