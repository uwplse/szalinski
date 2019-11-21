/* [Basic] */
//The number of wires the bracket will hold
numWires = 2;           // [1:6]
//the thickness of the table (for a tight fit, make it a mm smaller)
tableThickness = 20;    // [1:100]
// the size of the gap provided for the wires
wireSize = 6;                  // [2:8]
// How far the bracket extends under and over the table
bracketDepth = 50;      // [20:100]
//the clearance for the wire to be put into the bracket.  This should be a bit less than the wire thickness so you can snap it in
wireClearanceVal = 2;   // [1:10]
//the thickness of the bracket.  increase for more durability.
bracketThickness = 6;   // [1:15]

/* [Advanced] */
//increase this to flatten the wire clip portion
scaleFactor = 1.5; //[1:.1:5]
//change the severity of the fillets
roundFactor = 1; //[0:.1:1.5]
//edit the angle of the clamp.  the angle helps to increate tension of the clamp.  higher values 
clampAngle = 4; //[0:.1:8]
//change to a non-zero value to customize the amount of extrusion.  If 0, the thickness is used.
customExtrusion = 0 ;//[0:20]

/* [Hidden] */ 
gap = tableThickness + bracketThickness;
wireClearance = wireClearanceVal + bracketThickness/2/scaleFactor;
r = wireSize;
linear_extrude(customExtrusion?customExtrusion:bracketThickness)
{
// Notify if build_vector will be used instead of input variables count, clip_diameter, and buffer!
difference()
    {
union(){
    //create table bracket
    rotate (-clampAngle) square([bracketThickness, bracketDepth], false);
    
    square([gap + bracketThickness, bracketThickness], false);
    translate ([gap, 0]) square([bracketThickness, bracketDepth], false);
    //connect bracket to wire loops
    translate ([gap + bracketThickness, bracketDepth - bracketThickness]) square([wireClearance, bracketThickness], false);
    
    //add inside corner rounds
    translate([bracketThickness,bracketThickness]) roundIn(4);
    translate([gap,bracketThickness]) roundIn(4);
    translate([gap,bracketThickness]) roundIn(4);
    translate([gap+bracketThickness, bracketDepth - bracketThickness]) roundIn(4);
}
 roundIn(8);
//create outside corner rounds
translate([gap+bracketThickness,0]) roundIn(8);
translate([gap,bracketDepth]) roundIn(8);
rotate (-clampAngle) translate([0,bracketDepth]) roundIn(4);
rotate (-clampAngle) translate([bracketThickness,bracketDepth]) roundIn(4);

//cleanup hack
translate([0,-1000])square(1000);
translate([-1000,0])square(1000);
translate([-1000,-1000])square(1000);
}

//create the wire clip loops
for (i = [ 0 : 1 : numWires-1 ])
{
    yOffset = -i*(r * 2 + bracketThickness);

    union()
    {
    translate ([gap + bracketThickness+wireClearance,bracketDepth-2*r-1.5*bracketThickness + yOffset ]) scale([1/scaleFactor,1.0]) circle (bracketThickness/2);
    difference() {
        
        translate ([gap + bracketThickness+wireClearance,bracketDepth-r-bracketThickness + yOffset]) scale([1/scaleFactor,1.0]) circle (r+bracketThickness);
        translate ([wireClearance,yOffset])square([gap + bracketThickness, bracketDepth], false);
        translate ([gap + bracketThickness + wireClearance,bracketDepth-r-bracketThickness + yOffset]) scale([1/scaleFactor,1.0]) circle (r);
        }   
    }
}
}

module roundIn(r)
{
    radius = r * roundFactor;  
    difference() {

            translate([-radius, -radius]) square([radius*2, radius*2]);
            translate([radius, radius])circle(r=radius);
            translate([-radius, radius])circle(r=radius);
            translate([radius, -radius])circle(r=radius);
            translate([-radius, -radius])circle(r=radius);
        }
}