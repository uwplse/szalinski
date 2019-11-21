// [ Units ]
mm=25.4; //[25.4:Inches, 1:mm]
// [ Top ]
// The diameter of the top, usually has to fit inside some kind of recess
topDiameter=0.44;
topThickness=0.1;
//[ Plug ]
cylDiameter=0.26;
fatDiameter=0.291;
cylLength=0.71;
// [ extension]
smallDiameter=0.165;
smallLength=0.5;

//[ hidden ]
$fn=30;
small=0.01; // a small offset to make sure that the components overlap

union()
{
    // the base
	cylinder(d = topDiameter*mm, h = topThickness*mm+small);
    top1=topThickness*mm;
    
    // the cylinder which is the actual plug
	translate( [0, 0, top1] ) cylinder(d=cylDiameter*mm, h = cylLength*mm+small);
    top2=top1+cylLength*mm;
    
    // the fat part of the plug, shaped like a stretched out sphere
	translate( [0, 0, top2-cylLength*mm*0.35] ) scale([1,1,2.1])sphere(d = fatDiameter*mm);
    
    // the narrowing at a 45 degree angle
    translate( [0, 0, top2 ] ) cylinder(r1=cylDiameter*mm/2, r2=smallDiameter*mm/2, h = (cylDiameter-smallDiameter)*mm/2+small);
    top3=top2+(cylDiameter-smallDiameter)*mm/2;
    
    // the small diameter piece
    translate( [0, 0, top3] ) cylinder(d=smallDiameter*mm, h = smallLength*mm+small);
    top4=top3+smallLength*mm;
    
    // a round end
    translate([0,0,top4]) sphere(d=smallDiameter*mm*1.1);
}