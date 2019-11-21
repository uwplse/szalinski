Base_Height=2.5;
Base_Radius=25;
Wing_Height=2.5;
Wing_Length=20;
Wing_Width=5;
Sensor_Width=8;
Sensor_Height=4;

Top_Inner_Radius=20;
Bot_Inner_Radius=15;
Sensor_Area_Radius=10;

Sensor_Hole_X=3.25;
Sensor_Hole_Y=2.25;
Sensor_Hole_R=.5;

Wire_Hole_R=1.25;

difference(){

difference(){

union(){

difference(){

union(){

rotate([0,0,240])translate([Base_Radius-Wing_Width,-Wing_Width/2,Base_Height])cube([Wing_Length,Wing_Width,Wing_Height]);

rotate([0,0,120])translate([Base_Radius-Wing_Width,-Wing_Width/2,Base_Height])cube([Wing_Length,Wing_Width,Wing_Height]);

translate([Base_Radius-Wing_Width,-Wing_Width/2,Base_Height])cube([Wing_Length,Wing_Width,Wing_Height]);

cylinder(Base_Height+Wing_Height,Base_Radius,Base_Radius);

}

union(){

translate([0,0,Base_Height])cylinder(Wing_Height,Bot_Inner_Radius,Top_Inner_Radius);

translate([0,0,Base_Height+Wing_Height])cylinder(1,Top_Inner_Radius,Top_Inner_Radius);

}

}

translate([0,0,Base_Height])cylinder(Sensor_Height,Sensor_Area_Radius,Sensor_Area_Radius);

}

translate([-Sensor_Width/2,-Sensor_Width/2,Base_Height])cube([Sensor_Width,Sensor_Width,Sensor_Height+1]);

}

union(){

translate([Sensor_Hole_X,Sensor_Hole_Y,-1])cylinder(Base_Height+2,Sensor_Hole_R,Sensor_Hole_R);

translate([Sensor_Hole_X,-Sensor_Hole_Y,-1])cylinder(Base_Height+2,Sensor_Hole_R,Sensor_Hole_R);

translate([-Sensor_Hole_X,Sensor_Hole_Y,-1])cylinder(Base_Height+2,Sensor_Hole_R,Sensor_Hole_R);

translate([-Sensor_Hole_X,-Sensor_Hole_Y,-1])cylinder(Base_Height+2,Sensor_Hole_R,Sensor_Hole_R);

rotate([0,0,240])translate([Bot_Inner_Radius/2+Sensor_Area_Radius/2,0,-1])cylinder(Base_Height+2,Wire_Hole_R,Wire_Hole_R);

rotate([0,0,120])translate([Bot_Inner_Radius/2+Sensor_Area_Radius/2,0,-1])cylinder(Base_Height+2,Wire_Hole_R,Wire_Hole_R);

translate([Bot_Inner_Radius/2+Sensor_Area_Radius/2,0,-1])cylinder(Base_Height+2,Wire_Hole_R,Wire_Hole_R);

}

}