height = 13;
width=50;
wall=7;
wall_height=10;

difference() {
cube([width, width, height+wall_height]);
translate([wall, wall, height])
    cube([width-wall*2, width-wall*2, wall_height+1]);
}