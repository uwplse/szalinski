/* [Global] */

// Which part would you like to see?
part = 5; // [1:Insole,2:Toe Cleat,3:Heel Cleat,4:Spike,5:All]
// Which foot would you like to see?
foot=0;//[0:Right,1:Left]

/* [Foot and Brace Dimensions] */

//Length from Toe to Heel(in)
Length_Foot=10.25;//[7:.25:14]

//Widest Part of Foot measured straight across(in)
Width_Foot=4.25;//[3:.25:5]

//Furthest distance between end of toe and line that defines widest part of foot (in)
Length_Toe=2.75;//[1.5:.25:3]

//Width of heel below ankle (in)
Width_Heel=2.75;//[1.5:.25:3.5]

//Height of big toe when flat(in)
Height_Toe=1;//[0:.25:2]

//Height to protusion of ankle(in)
Height_Ankle=3.5;//[2:.25:4]

//Distance from edge of big toe to top of toe arc(in)
Shift_Toe=1.5;//[0:.25:3]

//Distance from x center of heel to x center of widest part of foot(right)
Shift_Wide=.25;//[-1:.25:1]

//Location of outside protusion of ankle from back of heel(in)
Length_Ankle=1.75;//[1:.25:5]

//Distance from Bottom edge of the back support of Brace to ground(in)
Distance_Brace_Back=3;//[2:.25:4]

//Length of Bottom of Brace
Length_Brace_Bottom=3;//[1:.25:5]

//Distance from Heel to Nearest Edge of Brace Bottom
Distance_Brace_Bottom=2;//[2:.25:4]

//Thickness of Brace
Thickness_Brace=.03125;//[.03125:.03125:.125]
/* [Design Choices] */

//Thickness of Insole Desired(in)
Thickness_Insole=.0625;//[.03125:.03125:.125]

//Height desired past brace
Height_Overbrace=1;//[.5:.25:1.5]

//Height below brace to become bendy
Height_Underbrace=.5;//[0:.25:2]

//Angle of Support in the Heel
Angle_Support_Heel=45;//[0:5:60]

//Thickness of Heel Support
Thickness_Support_Heel=.125;//[.0625:.03125:.25]

//Width of Tongue for Heel
Width_Tongue_Heel=2;//[.5:.25:2.5]

//Thickness of Heel Tongue
Thickness_Tongue_Heel=.125;//[.03125:.03125:.125]

//Extra Length for Bottom Brace
Length_Overbottom=.5;//[0:.25:1]

//Thickness of Connector Walls
Thickness_Connector=.125;//[.0625,.0625,.25]

//Fillet radius of inner surface for heel support
Fillet_Heel=.125;//[.0625,.0625,.25]


//Thickness of Toe Cleat Desired(in)
Thickness_Toe=.125;//[.125:.03125:.25]

//Number of Cleat holes for Toe Area
Number_Cleat_Toe=5;//[1:1:7]

//Thickness of Heel Cleat Desired
Thickness_Heel=.125;//[.125:.03125:.25]

// Number of Cleat Holes for Heel Area
Number_Cleat_Heel=6;//[1:1:7]

//Distance between insole and heel cleat.
Distance_Heel_Insole=.0625;//[0,.03125,.2]

//Thickness of Heel Cleat Connector
Thickness_Heel_Connect=.0625;//[[0,.03125,.2]

Space_Heel=Distance_Heel_Insole+Thickness_Heel_Connect;

//Thickness of Overhange on Heel Connector Desired
Thickness_Overhang_Heel=.0625;//[0,.03125,.125]

/* [Toe Cleat Locations] */

//Cleat X Center Location from Big Toe Edge
X_TCleat1=0;//[.5:.25:4.5]
X_TCleat2=0;//[.5:.25:4.5]
X_TCleat3=0;//[.5:.25:4.5]
X_TCleat4=0;//[.5:.25:4.5]
X_TCleat5=0;//[.5:.25:4.5]
X_TCleat6=0;//[.5:.25:4.5]
X_TCleat7=0;//[.5:.25:4.5]


//Cleat Y Center Location from Tallest Toe
Y_TCleat1=0;//[.5:.25:4.5]
Y_TCleat2=0;//[.5:.25:4.5]
Y_TCleat3=0;//[.5:.25:4.5]
Y_TCleat4=0;//[.5:.25:4.5]
Y_TCleat5=0;//[.5:.25:4.5]
Y_TCleat6=0;//[.5:.25:4.5]
Y_TCleat7=0;//[.5:.25:4.5]


/* [Heel Cleat Locations] */

//Heel Cleat X Center Location from Big Toe Side of Heel
X_HCleat1=0;//[.5:.25:3]
X_HCleat2=0;//[.5:.25:3]
X_HCleat3=0;//[.5:.25:3]
X_HCleat4=0;//[.5:.25:3]
X_HCleat5=0;//[.5:.25:3]
X_HCleat6=0;//[.5:.25:3]
X_HCleat7=0;//[.5:.25:3]

//Heel Cleat Y Center Location from Heel
Y_HCleat1=0;//[.5:.25:12]
Y_HCleat2=0;//[.5:.25:12]
Y_HCleat3=0;//[.5:.25:12]
Y_HCleat4=0;//[.5:.25:12]
Y_HCleat5=0;//[.5:.25:12]
Y_HCleat6=0;//[.5:.25:12]
Y_HCleat7=0;//[.5:.25:12]


/* [Cleat Spike Design] */
//Width of Spike Connection
Width_Internal_Spike=.25;//[.25]

//Thickness of Spike Connection
Thickness_Internal_Spike=.03125;//[.03125]

//Thickness of Cleat before image
Thickness_Cleat_Min=.0625;//[.03125:.03125:.125]

Height_Cleat=.5;//[0:.25:1]
Width_Cleat=.5;//[.5:.125:2]
image_file = "image-surface.dat"; // [image_surface:100x100] 

print_part();

module print_part() {
	if (part == 1) {
		mirror([foot,0,0])
		Insole();
	} else if (part == 2) {
mirror([foot,0,0])
		ToeCleat();
	} else if (part == 3) {
mirror([foot,0,0])
		HeelCleat();
} else if (part == 4) {
mirror([foot,0,0])
		Spike();
	} else {
mirror([foot,0,0])
		all();
	}
}

module all(){
	Insole();
	ToeCleat();
	HeelCleat();
	Spike();
}

module Insole(){

union(){
translate([0,0,Thickness_Insole/2])
linear_extrude(height = Thickness_Insole, center = true, convexity = 10, twist = 0)
difference(){
union(){
polygon(points=[[-Width_Heel/2,Length_Ankle],[Width_Heel/2,Length_Ankle],[Width_Heel/2,Distance_Brace_Bottom+Length_Brace_Bottom+Length_Overbottom],[Shift_Wide+Width_Foot/2,Length_Foot-Length_Toe],[Shift_Wide-Width_Foot/2,Length_Foot-Length_Toe],[-Width_Heel/2,Distance_Brace_Back+Length_Brace_Bottom]],paths=[[0,1,2,3,4,5]]);

translate([0,Length_Ankle,0])
scale([1,2*Length_Ankle/Width_Heel,1])
circle(Width_Heel/2, $fn=50);

translate([Shift_Wide-Width_Foot/2+Shift_Toe,Length_Foot-Length_Toe,0])
difference(){
scale([Shift_Toe/Length_Toe,1,1])
circle(Length_Toe, $fn=50);
translate([Width_Foot,0,0])
square([Width_Foot*2,Length_Toe*2],center = true);
};//end of difference

translate([Shift_Wide-Width_Foot/2+Shift_Toe,Length_Foot-Length_Toe,0])
difference(){
scale([(Width_Foot-Shift_Toe)/Length_Toe,1,1])
circle(Length_Toe, $fn=50);
translate([-Width_Foot,0,0])
square([Width_Foot*2,Length_Toe*2],center = true);
};//end of difference

};//end of union

};//end of difference
translate([0,Length_Ankle,0])
scale([Width_Heel/(Length_Ankle*2),1,1])
rotate([180,0,0])
difference(){
rotate_extrude(convexity = 10,$fn=50)

translate([Length_Ankle-Fillet_Heel,0,0])
rotate([0,0,-90])
square([Thickness_Insole+Distance_Brace_Back-Height_Underbrace,Thickness_Support_Heel+Fillet_Heel], center=false);


union(){
rotate_extrude(convexity = 10,$fn=50)

translate([Length_Ankle-Fillet_Heel,-Fillet_Heel-Thickness_Insole,0])
rotate([0,0,-90])
square([Fillet_Heel+Distance_Brace_Back,Fillet_Heel],center=false);

rotate_extrude(convexity = 10,$fn=50)

translate([Length_Ankle-Fillet_Heel,-Fillet_Heel-Thickness_Insole,0])
rotate([0,0,-90])
circle(Fillet_Heel, $fn=50);

};//end of union

translate([0,-(Length_Ankle+Thickness_Support_Heel)/2,-(Thickness_Insole+Distance_Brace_Back)/2])
cube([(Length_Ankle+Thickness_Support_Heel)*2,Length_Ankle+Thickness_Support_Heel,Thickness_Insole+Distance_Brace_Back],center=true);

rotate([180+Angle_Support_Heel,0,0])
translate([-Length_Ankle-Thickness_Support_Heel,0,0])
cube([(Length_Ankle+Thickness_Support_Heel)*2,Length_Ankle+Distance_Brace_Back,(Length_Ankle+Thickness_Support_Heel)*2]);

};//end of difference

translate([0,Length_Ankle,Distance_Brace_Back])
scale([Width_Heel/Length_Ankle/2,1,1])
difference(){

rotate_extrude(convexity = 10,$fn=50)
translate([Length_Ankle,0,0])
rotate([0,0,-90])
square([Distance_Brace_Back,Thickness_Tongue_Heel], center=false);

translate([0,+Length_Ankle+Thickness_Tongue_Heel,-Distance_Brace_Back/2])
cube([(Length_Ankle+Thickness_Tongue_Heel)*2,(Length_Ankle+Thickness_Tongue_Heel)*2,Distance_Brace_Back+1],center=true);

translate([Width_Tongue_Heel/2-Length_Ankle*2,0,-Distance_Brace_Back/2])
cube([(Length_Ankle+Thickness_Tongue_Heel)*2,(Length_Ankle+Thickness_Tongue_Heel)*2,Distance_Brace_Back+1],center=true);

translate([-Width_Tongue_Heel/2+Length_Ankle*2,0,-Distance_Brace_Back/2])
cube([(Length_Ankle+Thickness_Tongue_Heel)*2,(Length_Ankle+Thickness_Tongue_Heel)*2,Distance_Brace_Back+1],center=true);
};//end of difference
};;//end of union


}//end of insole


module ToeCleat(){

difference(){
translate([0,0,-Thickness_Insole/2])
linear_extrude(height = Thickness_Heel, center = true, convexity = 10, twist = 0)
union(){
translate([Shift_Wide-Width_Foot/2+Shift_Toe,Length_Foot-Length_Toe,0])
difference(){
scale([Shift_Toe/Length_Toe,1,1])
circle(Length_Toe, $fn=50);
translate([Width_Foot,0,0])
square([Width_Foot*2,Length_Toe*2],center = true);
};//end of difference

translate([Shift_Wide-Width_Foot/2+Shift_Toe,Length_Foot-Length_Toe,0])
difference(){
scale([(Width_Foot-Shift_Toe)/Length_Toe,1,1])
circle(Length_Toe, $fn=50);
translate([-Width_Foot,0,0])
square([Width_Foot*2,Length_Toe*2],center = true);
};//end of difference

};//end of union

translate([Shift_Wide,-Length_Toe/2+Length_Foot-Length_Toe,0])
cube([Width_Foot+2,Length_Toe+1,Thickness_Heel+2],center=true);

for ( i = [1 : 5] )
{
cube([1]);
}

}//End of Difference

}//End of Toe

module HeelCleat() {
translate([0,0,-Thickness_Heel/2-Distance_Heel_Insole])
difference(){

union(){
translate([0,0,Thickness_Insole+Thickness_Overhang_Heel+2*Distance_Heel_Insole])
difference(){
linear_extrude(height = Thickness_Insole+Thickness_Heel+2*Distance_Heel_Insole+Thickness_Overhang_Heel, center = true, convexity = 10, twist = 0)
union(){
polygon(points=[[-Width_Heel/2-Space_Heel,Length_Ankle],[Width_Heel/2+Space_Heel,Length_Ankle],[Width_Heel/2+Space_Heel,Distance_Brace_Bottom+Length_Brace_Bottom+Length_Overbottom],[Shift_Wide+Width_Foot/2+Space_Heel,Length_Foot-Length_Toe],[Shift_Wide-Width_Foot/2-Space_Heel,Length_Foot-Length_Toe],[-Width_Heel/2-Space_Heel,Distance_Brace_Back+Length_Brace_Bottom]],paths=[[0,1,2,3,4,5]]);


translate([0,Length_Ankle,0])
scale([1,2*(Length_Ankle+Thickness_Support_Heel+Space_Heel)/(Width_Heel+2*Thickness_Support_Heel+2*Space_Heel),1])
circle(Width_Heel/2+Thickness_Support_Heel+Space_Heel, $fn=50);


translate([Shift_Wide-Width_Foot/2+Shift_Toe,Length_Foot-Length_Toe,0])
difference(){
scale([(Shift_Toe+Space_Heel)/(Length_Toe+Space_Heel),1,1])
circle(Length_Toe+Space_Heel, $fn=50);
translate([Width_Foot,0,0])
square([(Width_Foot)*2,(Length_Toe)*2],center = true);
};//end of difference

translate([Shift_Wide-Width_Foot/2+Shift_Toe,Length_Foot-Length_Toe,0])
difference(){
scale([(Width_Foot-Shift_Toe+Space_Heel)/(Length_Toe+Space_Heel),1,1])
circle((Length_Toe+Space_Heel), $fn=50);
translate([-Width_Foot,0,0])
square([(Width_Foot)*2,(Length_Toe)*2],center = true);
};//end of difference

};//end of union


linear_extrude(height =Thickness_Insole+Thickness_Heel+2*Distance_Heel_Insole+Thickness_Overhang_Heel+2, center = true, convexity = 10, twist = 0)
union(){
polygon(points=[[-Width_Heel/2,Length_Ankle],[Width_Heel/2,Length_Ankle],[Width_Heel/2,Distance_Brace_Bottom+Length_Brace_Bottom+Length_Overbottom],[Shift_Wide+Width_Foot/2,Length_Foot-Length_Toe],[Shift_Wide-Width_Foot/2,Length_Foot-Length_Toe],[-Width_Heel/2,Distance_Brace_Back+Length_Brace_Bottom]],paths=[[0,1,2,3,4,5]]);


translate([0,Length_Ankle,0])
scale([1,2*(Length_Ankle+Thickness_Support_Heel)/(Width_Heel+2*Thickness_Support_Heel),1])
circle(Width_Heel/2+Thickness_Support_Heel, $fn=50);


translate([Shift_Wide-Width_Foot/2+Shift_Toe,Length_Foot-Length_Toe,0])
difference(){
scale([(Shift_Toe)/(Length_Toe),1,1])
circle(Length_Toe, $fn=50);
translate([Width_Foot,0,0])
square([(Width_Foot)*2,(Length_Toe)*2],center = true);
};//end of difference

translate([Shift_Wide-Width_Foot/2+Shift_Toe,Length_Foot-Length_Toe,0])
difference(){
scale([(Width_Foot-Shift_Toe)/(Length_Toe),1,1])
circle((Length_Toe), $fn=50);
translate([-Width_Foot,0,0])
square([(Width_Foot)*2,(Length_Toe)*2],center = true);
};//end of difference

};//end of union

};//end of difference*layer2

linear_extrude(height = Thickness_Heel, center = true, convexity = 10, twist = 0)
union(){
polygon(points=[[-Width_Heel/2-Space_Heel,Length_Ankle],[Width_Heel/2+Space_Heel,Length_Ankle],[Width_Heel/2+Space_Heel,Distance_Brace_Bottom+Length_Brace_Bottom+Length_Overbottom],[Shift_Wide+Width_Foot/2+Space_Heel,Length_Foot-Length_Toe],[Shift_Wide-Width_Foot/2-Space_Heel,Length_Foot-Length_Toe],[-Width_Heel/2-Space_Heel,Distance_Brace_Back+Length_Brace_Bottom]],paths=[[0,1,2,3,4,5]]);


translate([0,Length_Ankle,0])
scale([1,2*(Length_Ankle+Thickness_Support_Heel+Space_Heel)/(Width_Heel+2*Thickness_Support_Heel+2*Space_Heel),1])
circle(Width_Heel/2+Thickness_Support_Heel+Space_Heel, $fn=50);


translate([Shift_Wide-Width_Foot/2+Shift_Toe,Length_Foot-Length_Toe,0])
difference(){
scale([(Shift_Toe+Space_Heel)/(Length_Toe+Space_Heel),1,1])
circle(Length_Toe+Space_Heel, $fn=50);
translate([Width_Foot,0,0])
square([(Width_Foot)*2,(Length_Toe)*2],center = true);
};//end of difference

translate([Shift_Wide-Width_Foot/2+Shift_Toe,Length_Foot-Length_Toe,0])
difference(){
scale([(Width_Foot-Shift_Toe+Space_Heel)/(Length_Toe+Space_Heel),1,1])
circle((Length_Toe+Space_Heel), $fn=50);
translate([-Width_Foot,0,0])
square([(Width_Foot)*2,(Length_Toe)*2],center = true);
};//end of difference

};//end of union
};//end of union
translate([0,Length_Brace_Bottom/2+Distance_Brace_Bottom,Thickness_Brace/2+(Thickness_Insole+Thickness_Overhang_Heel+2*Distance_Heel_Insole)/2+1])
cube([Width_Heel+2,Length_Brace_Bottom,Thickness_Brace+Thickness_Insole+Thickness_Overhang_Heel+2*Distance_Heel_Insole+2],center=true);

translate([Shift_Wide,Length_Foot-Length_Toe+Length_Toe/2+1,0])
cube([Width_Foot+2,Length_Toe+2,Thickness_Heel+Thickness_Brace+Thickness_Insole+Thickness_Overhang_Heel+2*Distance_Heel_Insole+2],center=true);

};//end of difference

}


module Spike() {


union(){

translate([0,0,Thickness_Toe/2+Height_Cleat+Thickness_Cleat_Min])
difference(){
cube([Width_Internal_Spike,Width_Internal_Spike,Thickness_Toe],center=true);
cube([Width_Internal_Spike-Thickness_Internal_Spike,Width_Internal_Spike-Thickness_Internal_Spike,Thickness_Toe+2],center=true);

};//End of Difference
translate([0,0,Height_Cleat])
rotate([0,180,0])
difference(){
scale([Width_Cleat/100,Width_Cleat/100,Height_Cleat])
surface(file=image_file, center=true, convexity=5);
translate([0,0,-Height_Cleat/2-Thickness_Cleat_Min])
cube([Width_Cleat,Width_Cleat,Height_Cleat],center=true);
};//End of Difference
};//End of Union


}//End of Spike



// TO MM