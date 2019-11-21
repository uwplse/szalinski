Color_Red=240; // [0:255]
Color_Green=10; // [0:255]
Color_Blue=10; // [0:255]
Color_Alpha=.9; // [0:.1:.9]
Crown_Height=19.2; // [14:.1:19.2]
Pavilion_Depth=41.5; // [40:.1:43.4]
Table_Diameter=56.1; // [53:.1:59]
Crown_Angle=41.1; // [34:.1:41.1]
Pavilion_Angle=39.7; // [39.7:.1:41.7]
//$vpr=[60,0,30];
//$vpd=67;

color([Color_Red/255,Color_Green/255,Color_Blue/255,Color_Alpha])difference(){
translate([0,0,-.00001])cylinder(d=10,h=7,$fn=16*3);
//Table
translate([-6,-6,Crown_Height/10+.9+Pavilion_Depth/10])cube(12);
//Crown
//Kite Fasets
for(i=[0:7])
rotate([0,0,i*45])translate([-6,Table_Diameter/20,Crown_Height/10+.9+Pavilion_Depth/10])rotate([Crown_Angle-90])cube(12);
//star Fasets
for(i=[0:7])
rotate([0,0,i*45+22.5])translate([-6,Table_Diameter/20*cos(22.5),Crown_Height/10+.9+Pavilion_Depth/10])rotate([Crown_Angle-73])cube(12);
//Upper Girdle Fasets
for(j=[-1,1])for(i=[0:7])
rotate([0,0,i*45+j*6])
translate([0,-5,Pavilion_Depth/10+.2689])
rotate([100.66+Crown_Angle,0,0])translate([-6,0,-12])cube(12);
//culet
translate([0,0,-1])cube(2,true);

//Pavilion
//Main Facets
for(i=[0:7])
rotate([0,0,i*45])
translate([0,-5,Pavilion_Depth/10])
rotate([-Pavilion_Angle,0,0])translate([-6,0,-12])cube(12);
//Lower Girdle Facets
for(j=[-1,1])for(i=[0:7])
rotate([0,0,i*45+j*6])
translate([0,-5,Pavilion_Depth/10+.0235])
rotate([-Pavilion_Angle-1,0,0])translate([-6,0,-12])cube(12);
}

