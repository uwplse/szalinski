//Flare Width
flare_w=90;
//Flare Height
flare_h=20;
//Sun Radius
sun_r=47.5;
//Glasses Width
glasses_w=25;
//Glasses Height
glasses_h=glasses_w/2;
//Glasses Depth
glasses_d=35;
//Glasses Nose Pice Width
glasses_nose_w=20;
//Glasses Nose Pice Height
glasses_nose_h=5;
//Mouth Height
mouth_h=15;
//Mouth Radius
mouth_r=35;
//Bolt Cap Diameter
B=25;
//Bolt Cap Height
h=8;
//Bolt Length
l=69.5;
//Bolt Diameter
d=11;
//Resolution
$fn=100;
//Smile Reducer
smile_cube_sub=2*mouth_r;
//Cube for Flattening Bottom Surface
flat_bottom=200;
module sun_base(){union(){cube([flare_w,flare_w,flare_h],center=true);rotate([0,0,45])cube([flare_w,flare_w,flare_h],center=true);rotate([0,0,22.5])cube([flare_w,flare_w,flare_h],center=true);rotate([0,0,67.5])cube([flare_w,flare_w,flare_h],center=true);sphere(sun_r,$fn=100);};};
module sun_base_rounded(){minkowski(){sun_base();sphere(3);};};
module glasses(){union(){translate([-22,0,0])cube([glasses_w,glasses_h,glasses_d],center=true);cube([glasses_nose_w,glasses_nose_h,glasses_d],center=true);translate([22,0,0])cube([glasses_w,glasses_h,glasses_d],center=true);translate([-22,-6.25,0])cylinder(h=glasses_d,r=glasses_w/2,center=true);translate([22,-6.25,0])cylinder(h=glasses_d,r=glasses_w/2,center=true);};};
module glasses_rounded(){minkowski(){glasses();sphere(2);};};
module smile(){difference(){cylinder(h=mouth_h,r=mouth_r,center=true);translate([0,25,0])cube([smile_cube_sub,smile_cube_sub,smile_cube_sub],center=true);cylinder(h=mouth_h+10,r=mouth_r-10,center=true);};};
module smile_rounded(){minkowski(){smile();sphere(3);};};
module bolt(){union(){translate([0,0,l-0.1])cylinder(h=h,r=B/2);cylinder(h=l,r=d/2);}};
module sun(){union(){sun_base_rounded();translate([0,20,30])glasses_rounded();translate([0,-2,35])rotate([7,0,0])smile_rounded();};};
module sun_final(){difference(){sun();translate([0,0,-26.5])bolt();translate([0,0,-100])cube([flat_bottom,flat_bottom,flat_bottom],center=true);};};
sun_final();