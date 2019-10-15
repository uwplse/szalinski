//Inner Diameter
innerDiameter=90; // diameter in mm
innerRadius=innerDiameter/2;

//Wall thickness
wall = 2; //wall thickness in mm

//Height 
height=22; // height in mm, must be greater than 15.

difference(){
union(){
    difference(){
    cylinder(r=innerRadius+wall,h=height);
    cylinder(r=innerRadius,h=height);
    };
    for (i=[0:3])
        rotate(i*90)
    translate([innerRadius-5,0,0])cube([5,5,10]);
}
union(){
translate([-innerRadius*1.1,innerRadius*1.1,0])
rotate([45,90,0])
    scale([1.5,1,1])cylinder(r=10,h=innerRadius*3);
 translate([innerRadius*1.1,innerRadius*1.1,0])
rotate([180-45,90,0])
    scale([1.5,1,1])cylinder(r=10,h=innerRadius*3);
}   
}
