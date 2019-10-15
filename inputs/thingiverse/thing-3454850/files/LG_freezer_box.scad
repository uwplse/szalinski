width = 245;
height1 = 150;
height2 = 200;
depth = 150;
wall = 3;
angle = 25;

handle = [90,30];

difference() {
    cube([width,depth,height2]);
    translate([0,-1,height1]) rotate([0,-angle,0]) cube([width/cos(angle),depth+2,height2]);
    translate([wall,wall,wall]) cube([width-2*wall,depth-2*wall,height2]);
    translate([-1,(depth-handle[0])/2,(height1-handle[1])/2]) cube([wall+2,handle[0],handle[1]]);
}
