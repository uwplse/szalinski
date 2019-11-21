//////////////////////////
// Customizable settings
//////////////////////////


// Diameter of the hole on the bottom (in mm).
HoleDiameter = 6.275;

// Depth of the hole in the bottom (in mm).  If you want the hole to go all the way through then set this to a number larger than the total height of the object.
HoleDepth = 25;

// If you want a D-shaped hole, set this to the thickness of the flat side (in mm).  Larger values for the flat make the hole smaller.
HoleFlatThickness = 1.25;

// Height (in mm).  If dome cap is selected, it is not included in height.  The shaft length is also not counted.
KnobHeight = 20;

// Diameter of base of round part of knob (in mm).  (Knurled ridges are not included in this measurement.)
KnobDiameter = 60;

// Shape of top of knob.  "Recessed" type can be painted.
CapType = 2;	// [0:Flat, 1:Recessed, 2:Dome]

// Do you want a large timer-knob style pointer?
TimerKnob=0;	// [0:No, 1:Yes]

// Percentage of divot on the top to indicate direction?
Pointer1 = 20;	 // [0:100]

// Divot Depth;
DivotDepth = 0;

// Amount of flatness of side opposite pointer (0 for None) Incompatible with TimerKnob
FlatSide = 2;

// Degrees to rotate D hole
DRotate = 45; // [0:100]

//Recess in bottom of knob (set to depth to 0 for None)
RecessDepth = 10;
RecessInnerRadius = 12;
RecessOuterRadius = 20;

// Would you like a line (pointer) on the front to indicate direction?
Pointer2 = 1;	// [0:No, 1:Yes]

// Do you want finger ridges around the knob?
Knurled = 0;	// [0:No, 1:Yes]

// 0 = A cylindrical knob, any other value will taper the knob.
TaperPercentage = 0; // [0:0%, 10:10%, 20:20%, 30:30%, 40:40%, 50:50%]

// Width of "dial" ring (in mm).  Set to zero if you don't want the ring.
RingWidth = 0;

// The number of markings on the dial.  Set to zero if you don't want markings.  (RingWidth must be non-zero.)
RingMarkings = 10;

// diameter of the hole for the setscrew (in mm).  If you don't need a hole, set this to zero.
ScrewHoleDiameter = 3;

// Length of the shaft on the bottom of the knob (in mm).  If you don't want a shaft, set this value to zero.
ShaftLength = 15;

// Diameter of the shaft on the bottom of the knob (in mm).  (ShaftLength must be non-zero.)
ShaftDiameter = 12;

// Percentage of shaft to "notch"  It can be used for a press-on type knob (rather than using a setscrew).  (ShaftLength must be non-zero.)
NotchedShaft = 80;


//////////////////////////
//Advanced settings
//////////////////////////

RingThickness = 5*1;
DivotDepth = 1.5*1;
MarkingWidth = 1.5*1;
DistanceBetweenKnurls = 3*1;
TimerKnobConst = 1.8*1;



//////////////////////////
//Calculations
//////////////////////////

PI=3.14159265*1;
KnobMajorRadius = KnobDiameter/2;
KnobMinorRadius = KnobDiameter/2 * (1 - TaperPercentage/100);
KnobRadius = KnobMinorRadius + (KnobMajorRadius-KnobMinorRadius)/2;
KnobCircumference = PI*KnobDiameter;
Knurls = round(KnobCircumference/DistanceBetweenKnurls);
Divot=CapType;

TaperAngle=asin(KnobHeight / (sqrt(pow(KnobHeight, 2) +
		pow(KnobMajorRadius-KnobMinorRadius,2)))) - 90;

DivotRadius = KnobMinorRadius*.3;

difference() {
union() {
    translate([0, 0, (ShaftLength==0)? 0 : ShaftLength-0.001])
    difference() {
	union() { // Primary knob cylinder
	    cylinder(h=KnobHeight, r1=KnobMajorRadius, r2=KnobMinorRadius,
		$fn=50);
	    
	    
	    if (Knurled)
	    for (i=[0 : Knurls-1])
	    rotate([0, 0, i * (360/Knurls)])
	    translate([KnobRadius, 0, KnobHeight/2])
	    rotate([0, TaperAngle, 0]) rotate([0, 0, 45])
	    cube([2, 2, KnobHeight+.001], center=true);
	    
 	    if (RingMarkings>0)
	    for (i=[0 : RingMarkings-1])
	    rotate([0, 0, i * (360/RingMarkings)])
	    translate([KnobMajorRadius + RingWidth/2, 0, 1])
	    cube([RingWidth*.5, MarkingWidth, 2], center=true);		
	    
	    if (Pointer2==1)
	    translate([KnobRadius, 0, KnobHeight/2-2])
	    rotate([0, TaperAngle, 0])
	    cube([8, 3, KnobHeight], center=true);		
	    
	    if (RingWidth>0)
	    translate([0, 0, RingThickness/2])
	    cylinder(r1=KnobMajorRadius + RingWidth, r2=KnobMinorRadius,
		h=RingThickness, $fn=50, center=true);
	    
	    if (Divot==2)
	    translate([0, 0, KnobHeight])
	    difference()
	    {
		scale([1, 1, 0.5])
		sphere(r=KnobMinorRadius, $fn=50, center=true);
		
		translate([0, 0, 0-(KnobMinorRadius+.001)])
		cube([KnobMinorRadius*2.5, KnobMinorRadius*2.5,
			KnobMinorRadius*2], center=true);
	    }
	    
	    if (TimerKnob==1) intersection()
	    {
		translate([0, 0, 0-(KnobDiameter*TimerKnobConst) + KnobHeight])
		sphere(r=KnobDiameter*TimerKnobConst, $fn=50, center=true);		
		
		translate([0-(KnobDiameter*TimerKnobConst)*0.1, 0,
			KnobHeight/2])
		scale([1, 0.5, 1])
		cylinder(h=KnobHeight, r=(KnobDiameter*TimerKnobConst) *
		    0.8, $fn=3, center=true);
	    }
	}
	
	// Pointer1: Offset hemispherical divot
	if (Pointer1 > 0)
	translate([KnobMinorRadius*.55, 0, KnobHeight + DivotRadius*((100.0 - Pointer1)/100)])
	sphere(r=DivotRadius, $fn=40);
	
	// Flat side:
	if (TimerKnob == 0 && FlatSide > 0)
	translate([-KnobMajorRadius+FlatSide-50, 0, KnobHeight / 2.0])
	cube([100,100,KnobHeight*2], center=true, $fn=40);
	
	// Divot1: Centered cylindrical divot
	if (Divot==1)
	translate([0, 0, KnobHeight])
	cylinder(h=DivotDepth*2, r=KnobMinorRadius-1.5, $fn=50,
	    center=true);
	
	if (RecessDepth > 0) 
	difference() 
	{
	    cylinder(h=RecessDepth*2, r=RecessOuterRadius,
		$fn=50,center=true);
	    cylinder(h=RecessDepth*2, r=RecessInnerRadius);
	    
	}
		
	// Make sure bottom ends at z=0
	translate([0, 0, -10])
	cube([(KnobMajorRadius+RingWidth) * 3,
		(KnobMajorRadius+RingWidth) * 3, 20], center=true);
	
	}
	//Add in shaft
	rotate([0,0,DRotate])
	if (ShaftLength>0)
	difference() {
	    translate([0, 0, ShaftLength/2])
	    cylinder(h=ShaftLength, r=ShaftDiameter/2, $fn=20,
		center=true);
	    if (NotchedShaft > 0) {
		cube([HoleDiameter/2, ShaftDiameter*2, ShaftLength*2*(NotchedShaft/100.0)],
		    center=true);
	    }
	}
    }
    //subtract out hole
    rotate([0,0,DRotate])
    translate([0, 0, HoleDepth/2 - 0.001])
    difference()
    {
	cylinder(r=HoleDiameter/2, h=HoleDepth, $fn=20,
	    center=true);
	// Flat for D-shaped hole
	translate([(0-HoleDiameter)+HoleFlatThickness, 0, 0])
	cube([HoleDiameter, HoleDiameter, HoleDepth+.001],
	    center=true);
    }

    // Hole for setscrew
    if (ScrewHoleDiameter>0)
    rotate([0,0,DRotate])
    translate([0 - (KnobMajorRadius+RingWidth+1)/2, 0,
	    HoleDepth/2])
    rotate([0, 90, 0])
    cylinder(h=(KnobMajorRadius+RingWidth+1),
	r=ScrewHoleDiameter/2, $fn=20, center=true);
}    

    

