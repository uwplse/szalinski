
start=1680;
step=-150;
stones=10;

stone_width=22;
stone_height=10;
stone_depth=5;

module stone(value) {
    translate([0,0,stone_height/2])
    rotate([90,0,0])
    union() {
        translate ([-(stone_width-0.4)/2,stone_height/2-0.125,0.125])
            cube([stone_width-0.4, 0.25, stone_depth-0.25]);
        translate ([-stone_width/2,-(stone_height-0.25)/2,0])
            cube([stone_width, stone_height-0.25, stone_depth]);
        translate([8, 0, 2]);
            linear_extrude(stone_depth+0.25)
                resize([stone_width-2,stone_height-2,0])
                text(str(value), size = 1.5, halign="center", valign="center");
    }
}

for ( i = [0 : stones-1]){
    translate([0, 0, i*stone_height])
    stone(start+i*step);
}
