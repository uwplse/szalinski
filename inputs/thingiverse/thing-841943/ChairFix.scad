//Clip Height
height=30;
//Cylinder diameter
diameter=29;
//Clip Thickness
thickness=5;
//Roundness
$fn=50;

difference(){
    cylinder(d=diameter+(thickness*2),h=height);
    translate([0,0,-1]){cylinder(d=diameter,h=height+2);}
    translate([0,0,-1])cube([diameter+(thickness*2),diameter+(thickness*2),height+2]);
}
translate([(diameter+(thickness*2))/2,0,0])cylinder(d=thickness*2,h=height);
translate([0,(diameter+(thickness*2))/2,0])cylinder(d=thickness*2,h=height);

//color("grey")translate([0,0,-5])cylinder(d=diameter,h=height+10);