threeUHeight = 133.35; //overall 3u height, provided for reference
panelOuterHeight =128.5;
panelInnerHeight = 110; //rail clearance = ~11.675mm, top and bottom

railDistance = 122.5; //center-to-center rail distance
railThickness = 11;//The overall thickness of the rails. Assumes mount hoiles are centered within the rail.

railDepth = 47.65; //How deep your rails are, front to back. 
minimumModuleDepth = 32;//Ensures a minimum depth. If less than the railDepth, uses railDepth instead

bracketScrewHoleDiameter = 6.1; //The diameter of the bracket screw; defaults to typical m6 diameter (6.1)
bracketNutOffset = 23.5;//Assuming you are using https://www.thingiverse.com/thing:2489238, this value will be one half the rail depth
bracketThickness = 12;

extraBracketHeight =0; //A little extra depth added to the bottom of the bracket for more clearance;

tiers = 2;//supports one or two tiers at the moment. I'll bet you'd have a hard time fitting a three-tier rack end on your print bed anyway. Values over 2 will assume you meant to type 2. Values under one will assume 1.

tierOneAngle = 39; //The angle of the first tier
tierTwoAngle =62.5; //The angle of the second tier

module testBracket(){
	translate([0,((railDepth)*sin(tierOneAngle)/sin(90)),0]){
rotate([tierOneAngle,0,0]){
translate([-400,0,0]){
cube([400,railThickness,railDepth]);
}
}}
}

rackEnd();

module rackEnd()
{

tierOneBaseHeight = (((railDepth > minimumModuleDepth ? railDepth : minimumModuleDepth)*sin(90-tierOneAngle))/sin(90));

tierTwoBaseHeight = (((railDepth > minimumModuleDepth ? railDepth : minimumModuleDepth)*sin(90-tierTwoAngle))/sin(90));

difference(){
union(){
bracket(tierOneAngle,tierOneBaseHeight);

if(tiers>1){
hyp = railDistance+railThickness;

tierOneFrontDepth = getTriangleSideLength(tierOneAngle,hyp);

translate([0,tierOneFrontDepth+0,0]){
	bracket(tierTwoAngle, getTriangleSideLength(90-tierOneAngle,hyp)+tierOneBaseHeight);
}
}
}

//The tier one mount holes are often obstructed by the bottom corner of tier2, so re-diff them to avoid a whole lotta math
translate([0,0,tierOneBaseHeight]){
rotate([tierOneAngle,0,0]){
bracketHoles();
}}
}

}
module bracket(baseAngle, baseHeight)
{
intersection(){

echo(baseHeight);

    difference(){
union(){



cube([bracketThickness,totalSlopeDepth(baseAngle,railDistance+railThickness),baseHeight]);

translate([0,0,baseHeight]){
    slopeByAngle(baseAngle, railDistance+railThickness, bracketThickness);
    }
}

translate([0,0,baseHeight]){
rotate([baseAngle,0,0]){
bracketHoles();
}
}
}

hyp = railDistance+railThickness;
slopeApex = getTriangleSideLength(90-baseAngle,hyp);
backDepth = getTriangleSideLength(90-baseAngle,(railDepth>minimumModuleDepth?railDepth:minimumModuleDepth));

translate([-1,0,0]){
cube([bracketThickness+2,getTriangleSideLength(baseAngle,hyp)+backDepth,baseHeight+slopeApex]);
}}
}

module bracketHoles(){
    translate([0,railThickness/2,-bracketNutOffset]){
    bracketHole();
    translate([0,railDistance,0]){
        bracketHole();
        }
    }
}
module bracketHole(){
    rotate([0,90,0]){
    cylinder(r=bracketScrewHoleDiameter/2,h = bracketThickness*3, center=true);
    }
}


module slope(length,width,height)
{
	polyhedron(
               points=[[0,0,0], [length,0,0], [length,width,0], [0,width,0], [0,width,height], [length,width,height]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

function getTriangleSideLength(angle, hyp) = (hyp*sin(90-angle));

function totalSlopeDepth(angle,hypotenuse) =
(getTriangleSideLength(angle,hypotenuse)/sin(90))+
	(((hypotenuse*sin(angle))/sin(90)*sin(angle))/sin(90-angle));

module slopeByAngle(angle, sideLength, thickness)
{
	angleOne = angle;
	angleTwo = 90 - angleOne;

	depth = (sideLength*sin(angleTwo))/sin(90);
	height = (sideLength*sin(angleOne))/sin(90);


	slope(thickness,depth,height);
	
	depth2 =(height*sin(-angleOne))/sin(angleTwo);

translate([0,totalSlopeDepth(angle,sideLength),0])
{
rotate([0,0,0]){
		slope(thickness,depth2,height);
}
}
}
