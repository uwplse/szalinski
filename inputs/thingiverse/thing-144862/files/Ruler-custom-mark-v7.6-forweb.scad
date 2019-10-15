//VERY customizable ruler by Mark G. Peeters (original file by Stu121) 
//v7.6 is for raised text and sunken rule markings
//if you are using openSCAD then you are cool, and make sure you have downloaded "Write.scad" from here http://www.thingiverse.com/thing:16193 and save it in your libraries directory


use<write/Write.scad>

//NOTE: ALL units are in millimeters (mm) even font sizes
RulerText="Mark <3 RUSH";

//don't make ruler longer than your print bed,also the "measurable scale lenght" is less because the scale starts and stops 3mm before each end
RulerLength=76;//[10:300]

//- the part with numbers and letters. NOTE: ruler total width = RulerWidth + BevelWidth
RulerWidth=20;//[15:35]

//- the part with the lines on it
BevelWidth=5;//[3:10]

//size for the letters and numbers-still in millimeters
FontSize=8;
NumberSize=5;

// how tall are letters and numbers , suggest this is a mulitple of layer thickness that will be used for slicing
TextHeight=.6;

// radius for key chain hole, 2.2mm seems good, zero for no hole
HoleRadius = 2.2;

/* [Advanced] */

//- thickness of the ruler body- NOTE! RulerHeight>=BevelHeight !! you will not see letters or rulings if you make the BevelHeight larger that the ruler body. they can be equal.
RulerHeight=3;//[1:7]

//- thickness of scale side of ruler. NOTE! must be less than or equal to RulerHeight!! ALSO make sure BevelHeight>LineDepth or else you will get a comb edge ruler
BevelHeight=1;//[1:7]

//how deep are lines into ruler body, suggest mulitple of layer's thickness used for slicing NOTE: if you do not want a comb then make sure BevelHeight>LineDepth so lines don't cut thought bottom of bevel
LineDepth=0.4;

//how wide are lines into ruler body, consider just a tiny bit bigger the Nozzle diameter
LineWidth=.5;//[.2,.3,.4,.5,.6]

//for centering text side to side, this is starting x displacement from edge, make zero for flush with side edge
TextX=2;

//for centering text up and down, this is starting y displacement from top, make zero for flush with top, negative for over top, it can look cool if you don't go crazy
TextY=2;

//use to center the numbers over the rule lines
NumberOffset=2;//[0:3] 


/* [Hidden] */

difference(){
hull(){
//make ruler top part - box
translate([0,0,0]) cube([RulerLength,RulerWidth,RulerHeight]);

//make ruler bottom part - bevel
translate([0,-BevelWidth,0])  cube([RulerLength,1,BevelHeight]);
//beveled bottom half

}

//major lines one per cm, starting $ Stopping 3mm from end
for (i=[0:10:(RulerLength-6)]){  
translate([i+3,-BevelWidth,BevelHeight-LineDepth]) rotate([atan((RulerHeight-BevelHeight)/BevelWidth),0,0]) cube([LineWidth,BevelWidth,LineDepth+0.2]);
}
//minor lines one per mm
for (i=[0:1:RulerLength-6]){   //embosed ruler lines
translate([i+3,-BevelWidth,BevelHeight-LineDepth]) rotate([atan((RulerHeight-BevelHeight)/BevelWidth),0,0]) cube([LineWidth,(BevelWidth/2),LineDepth]);
}
//add key hole ring
translate([(RulerLength)-(HoleRadius*1.5),(RulerWidth-(HoleRadius*1.5)),-1]) cylinder(h=RulerHeight+2,r=HoleRadius);

}

// write the numbers above markings on the ruler
for (i=[10:10:RulerLength-6]){
if (i > 99){
translate([i+NumberOffset-2,1,RulerHeight]) write(str(i/10),h=NumberSize,t=TextHeight); 
}
else
translate([i+NumberOffset,1,RulerHeight]) write(str(i/10),h=NumberSize,t=TextHeight); 
}
translate([1,1,RulerHeight]) write("cm",h=NumberSize,t=TextHeight); 
//add personalized text
translate([TextX,(RulerWidth-FontSize)-TextY,0])  write(RulerText,h=FontSize,t=TextHeight+RulerHeight);


