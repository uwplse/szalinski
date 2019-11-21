
width=75;
length=50;
height=10;

$fn=100;


difference(){
translate([-width/2,-length/2,0]) cube([width,length,height]);
translate([-(width-2)/2,-(length-2)/2,-1]) cube([width-2,length-2,2]);
translate([-(width-3)/2,-(length-3)/2,-1]) cube([width-3,length-3,height]);
}
