// preview[view:south, tilt:top diagonal]

//*********Declaration of customization variables************

//What outer diameter should the large opening have?
Large_End_Diameter = 60;

//What outer diameter should the small opening have?
Small_End_Diameter = 10;

//How thick should the walls be?
Wall_Thickness = 1; // [1:5]

//What's the overall height of the funnel?
Funnel_Height = 40;

//How tall should the band on the top be before the funnel begins?
Top_Band = 5;

//How long should the spout on the bottom be after the funnel ends?
Bottom_Spout_Length = 10;

//**********Assignment of customization vars to original scad vars***

spout_or = Small_End_Diameter/2;  //outer radius of bottom opening / spout
wall = Wall_Thickness; //wall thickness
flare_percentage = Large_End_Diameter / Small_End_Diameter * 100; // ratio of funnel opening (top) to spout (bottom), expressed as percentage
height = Funnel_Height; //total height
bottom_band=Bottom_Spout_Length;

res = 100/2; //resolution for cylinders
plane = 0.01/1;

//**********calculated variables*******************

spout_ir = spout_or - wall;
top_or = spout_or*flare_percentage/100;
top_ir = top_or - wall;

h1 = bottom_band;
h2 = height - Top_Band;
funnel_rise = height - bottom_band - Top_Band;
hi_adjust_ang = atan((top_or-spout_or)/funnel_rise)/2;
hi_adjust = wall*tan(hi_adjust_ang);

//**********begin build****************************

translate([0,0,height])mirror([0,0,1])difference(){

//**********outer shape****************************

union(){

cylinder(h=bottom_band,r=spout_or,$fn=res);
translate([0,0,h1])cylinder(h=funnel_rise,r1=spout_or,r2=top_or,$fn=res);
translate([0,0,h2])cylinder(h=Top_Band,r=top_or,$fn=res);

}

//**********inner shape****************************

union(){

cylinder(h=bottom_band+plane+hi_adjust,r=spout_ir,$fn=res);
translate([0,0,h1+hi_adjust])cylinder(h=funnel_rise,r1=spout_ir,r2=top_ir,$fn=res);
translate([0,0,h2+hi_adjust-plane])cylinder(h=Top_Band+hi_adjust+plane,r=top_ir,$fn=res);

//cube([top_or+1,top_or+1,height+1]); //cut for inspection of inner geometry

}

}
