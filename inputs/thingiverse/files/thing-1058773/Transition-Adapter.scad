//All measurements are in millimeters.

//Size of larger tube?
tube_1 = 33.7; //[13.8:BT-5, 18.7:BT-20, 24.8:BT-50, 33.7:BT-55, 34.2:BT-56, 41.6:BT-60, 56.3:BT-70, 66.04:BT-80, 100:BT-101]

//Size of smaller tube?
tube_2 = 13.8; //[13.8:BT-5, 18.7:BT-20, 24.8:BT-50, 33.7:BT-55, 34.2:BT-56, 41.6:BT-60, 56.3:BT-70, 66.04:BT-80, 100:BT-101]

//How long do you want the taper to be?
taper_length = 25;

//Diameter of the hole through the center?  Use "0" for no hole.  Must be smaller than diameter of the small tube.
hole = 0;

wall_1 = tube_1 == 13.8 || tube_1 == 18.7 || tube_1 == 24.8 ? 0.33 : 0.53;

wall_2 = tube_2 == 13.8 || tube_2 == 18.7 || tube_2 == 24.8 ? 0.33 : 0.53;

difference(){

union(){
    
cylinder(h=taper_length, r1=tube_1/2, r2=tube_2/2, center=false, $fn=100);

translate([0,0,taper_length]) cylinder(h=12.7,r=tube_2/2-wall_2, center=false, $fn=100);

translate([0,0,-12.7]) cylinder(h=12.7,r=tube_1/2-wall_1, center=false, $fn=100);
}

translate([0,0,-12.7]) cylinder(h=taper_length+25.4, r=hole/2, center=false, $fn=100);    
}