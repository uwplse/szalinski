//tapered hole for testing ultimaker PLA shrinkage
$fa=0.3;
$fs=0.3;
//Diameter of the hole
hole_diameter=6.45;//[6.3,6.35,6.4,6.45,6.5,6.55]
//Distance from the cube walls to the edge of the hole
x_axis_offest=4;//[2,4]
//Height of the part
hole_height=4;//[2,3,4,5]
//Tamper height
hole_taper=1;//[0.6,1,1.2]
test_hole(diameter=hole_diameter,xoffset=x_axis_offest,height=hole_height,taper=hole_taper);

module test_hole(diameter,xoffset,height,taper)
difference(){
    cube([diameter+xoffset,diameter+xoffset,height],center=true);
    translate([0,0,-(height/2+.1)])
    cylinder(d1=diameter+1.2,d2=diameter,h=taper);
    cylinder(d=diameter,h=height+xoffset/2,center=true);
     translate([0,0,height/2+.1-taper])
    cylinder(d1=diameter,d2=diameter+1.2,h=taper);
}
