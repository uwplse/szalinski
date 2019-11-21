//SimpleAngleBase V2 by Mark Tabije on 10/2/2016
//  for use with the Wasabi Miniature Wargame 
//  see Thingiverse for licensing information.
//    http://www.thingiverse.com/thing:1802234


//Level is represented by vertical Bars (Hero has no bars).
level = 5; //[0:5]

//Ability is epresented by a Triange = Range, Square = Direct, Circle = Sneak
ability = "Direct"; // [Range, Direct, Sneak]

//Top Diameter in mm
top = 30;

//Bottom Diameter in mm (recommend at least 6mm bigger than Top)
bottom = 36;

//Thickness of the Base in mm
thickness = 4; 

//Advanced Setting - Angle between Level Bars (tipically 20)
angleBar = 20;


cylinder(h=thickness,r1=bottom/2,r2=top/2);

//Level 1
if(level >= 1)
    translate([-1,-bottom/2,0])cube([3,bottom,thickness]);

//Level 2
if(level >= 2)
    rotate([0,0,-(angleBar)])translate([-1,-bottom/2,0])cube([3,bottom,thickness]);

//Level 3
if(level >= 3)
    rotate([0,0,-(angleBar*2)])translate([-1,-bottom/2,0])cube([3,bottom,thickness]);

//Level 4
if(level >= 4)
    rotate([0,0,-(angleBar*3)])translate([-1,-bottom/2,0])cube([3,bottom,thickness]);

//Level 5
if(level >= 5)
    rotate([0,0,-(angleBar*4)])translate([-1,-bottom/2,0])cube([3,bottom,thickness]);

//Range - Triangle
if(ability == "Range")
    rotate([90,0,45])translate([0,0,-(bottom+2)/2])linear_extrude(height=bottom+2)polygon([[-(thickness-1),0],[thickness-1,0],[0,thickness]]);

//Direct - Square
if(ability == "Direct")
    rotate([0,0,45])translate([-(thickness/2),-(bottom+2)/2,0])cube([thickness,bottom+2,thickness]);

//Sneak - Circle
if(ability == "Sneak")
    rotate([90,0,45])translate([0,thickness/2,-(bottom+2)/2])cylinder(h=bottom+2,r=thickness/2);