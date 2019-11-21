// preview[view:south, tilt:top diagonal]

//*********Declaration of customization variables************

//What outer diameter should the large opening have?
Large_End_Diameter = 100;

//What outer diameter should the small opening have?
Small_End_Diameter = 20;

//How thick should the walls be?
Wall_Thickness = 2; // [1:5]

//What's the overall height of the funnel?
Funnel_Height = 100;

//How tall should the band on the top be before the funnel begins?
Top_Band = 10;

//How long should the spout on the bottom be after the funnel ends?
Bottom_Spout_Length = 5;

//How much offset between the middle of the top and bottom of the funnel?
Offset = 30;

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
skew=Offset/funnel_rise;

//**********begin build****************************

translate([0,0,height])mirror([0,0,1])
//union()
//{
//difference(){
//}
difference(){

//**********outer shape****************************

union(){

translate([-Offset,0,0])cylinder(h=bottom_band,r=spout_or,$fn=res);
translate([0,0,h1])
translate([0,0,funnel_rise])
multmatrix(m = [ [1, 0, skew , 0],
                 [0, 1, 0, 0],
                 [0, 0, 1, 0],
                 [0, 0, 0,  1]
               ])
translate([0,0,-funnel_rise])
cylinder(h=funnel_rise,r1=spout_or,r2=top_or,$fn=res);

translate([0,0,h2])cylinder(h=Top_Band,r=top_or,$fn=res);

}

//**********inner shape****************************

union(){

translate([-Offset,0,0])cylinder(h=bottom_band+plane+hi_adjust,r=spout_ir,$fn=res);
translate([0,0,h1+hi_adjust])
translate([0,0,funnel_rise])
multmatrix(m = [ [1, 0, skew , 0],
                 [0, 1, 0, 0],
                 [0, 0, 1, 0],
                 [0, 0, 0,  1]
               ])
translate([0,0,-funnel_rise]){
cylinder(h=funnel_rise,r1=spout_ir,r2=top_ir,$fn=res);
}
translate([0,0,h2])cylinder(h=Top_Band+hi_adjust+plane,r=top_ir,$fn=res);
//translate([-2*Large_End_Diameter,0,0])cube([4*Large_End_Diameter,Large_End_Diameter,Funnel_Height]); //cut for inspection of inner geometry


}
}


