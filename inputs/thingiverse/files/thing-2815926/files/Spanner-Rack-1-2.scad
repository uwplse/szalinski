/*
 Customizable Spanner / Wrench Rack
 https://www.thingiverse.com/thing:2815926
 
 By Mr Jan Bassett
 Version 1.2
 
 Changelog
 v1.2 - Modified angle limits to allow the spanners to lean either way
 v1.1 - Added a factor to increase large slot heigth from base
 v1.0 - Original published design
 
 My uses         Small         Large
					W   H  L    W    H   L   Slots  Angle  Space  Factor
	11 slot -  4.5  8  65  7.0  15  105    11     30     10    1.75
	 9 slot -  3.5  7  60  6.5  13   85     9    -30     10    1.75

 */
 
 /* [Dimensions of Smallest and Largest Spanners] */
	// Wigth of smallest spanner slot
	SmallSpannerWidth = 3.5; // [3:8]
	// Height of smallest spanner slot
	SmallSpannerHeight = 7; // [5:12]
	// Support width for smallest spanner	
	SmallSpannerLength = 60; // [40:100]
	// Wigth of largest spanner slot
	LargeSpannerWidth = 6.5; // [5:10]
	// Height of largest spanner slot
	LargeSpannerHeight = 13; // [7:20]
	// Support width for largest spanner
	LargeSpannerLength = 85; // [60:150]
	
/* [Slot Details] */
	// Numner of No_of_Slots / Spanners
	No_of_Slots = 9; // [1:20]
	// Angle of No_of_Slots
	SlotAngle = -30;  // [-45:45]
	// Slot spacing
	SlotSpacing = 10;  // [5:15]
	// Rail height factor (mulitplier of SmallSpannerHeight and LargeSpannerHeight
	RailHeightFactor = 1.75; // [1.25:2.25]
	
	// Quality
	Quality = 60; // [20:200]
	
/* [Hidden */
	$fn = Quality;
	
	RailHS = RailHeightFactor*SmallSpannerHeight;	// Height of rail at small end
	RailHL = RailHeightFactor*LargeSpannerHeight;	// Height of rail at large end

	StepW = (LargeSpannerWidth-SmallSpannerWidth)/(No_of_Slots-1);	// Step in width between each spanner slot
	StepH = (RailHL-RailHS)/(No_of_Slots-1);	// Step in height between each spanner slot
	
	RailL = ((SmallSpannerWidth+LargeSpannerWidth)/2+SlotSpacing)*(No_of_Slots+1);
	SlotCOL = LargeSpannerLength+10;	// Length for slot cut out parts

rack();

module rack() {
	difference() {
		union() {
			// Rails
			hull() {
				translate([RailL/2,-(SmallSpannerLength/2)+(SmallSpannerWidth/2),0]) union() {
					cylinder(r=SmallSpannerWidth,h=RailHS-SmallSpannerWidth);
					translate([0,0,RailHS-SmallSpannerWidth/2+-.01]) sphere(r=SmallSpannerWidth);
				}
				translate([-RailL/2,-(LargeSpannerLength/2)+(SmallSpannerWidth/2),0]) union() {
					cylinder(r=SmallSpannerWidth,h=RailHL-SmallSpannerWidth);
					translate([0,0,RailHL-SmallSpannerWidth/2+-.01]) sphere(r=SmallSpannerWidth);
				}
			}
			hull() {
				translate([RailL/2,(SmallSpannerLength/2)-(SmallSpannerWidth/2),0]) union() {
					cylinder(r=SmallSpannerWidth,h=RailHS-SmallSpannerWidth);
					translate([0,0,RailHS-SmallSpannerWidth/2+-.01]) sphere(r=SmallSpannerWidth);
				}
				translate([-RailL/2,(LargeSpannerLength/2)-(SmallSpannerWidth/2),0]) union() {
					cylinder(r=SmallSpannerWidth,h=RailHL-SmallSpannerWidth);
					translate([0,0,RailHL-SmallSpannerWidth/2+-.01]) sphere(r=SmallSpannerWidth);
				}
			}
			// Cross bars
			BridgeSW=SmallSpannerLength-SmallSpannerWidth+((1/No_of_Slots)*(LargeSpannerLength-SmallSpannerLength));
			translate([(RailL/2)-(1/No_of_Slots)*RailL,0.1,1.5]) hull() {
				translate([0,BridgeSW/2,0]) cube([10,0.1,3],center=true);
				translate([0,-BridgeSW/2,0]) cube([10,0.1,3],center=true);
			}
			BridgeLW=LargeSpannerLength---((1/No_of_Slots)*(LargeSpannerLength-SmallSpannerLength));
			translate([-((RailL/2)-(1/No_of_Slots)*RailL),0.1,1.5]) hull() {
				translate([0,BridgeLW/2,0]) cube([10,0.1,3],center=true);
				translate([0,-BridgeLW/2,0]) cube([10,0.1,3],center=true);
			}
			if (RailL>99) {
				BridgeMW=SmallSpannerLength+((LargeSpannerLength-SmallSpannerLength)/2)-(SmallSpannerWidth+(LargeSpannerWidth-SmallSpannerWidth));
				translate([0,0.1,1.5]) hull() {
					translate([0,BridgeMW/2,0]) cube([10,0.1,3],center=true);
					translate([0,-BridgeMW/2,0]) cube([10,0.1,3],center=true);
				}
			}
		}
		for (Slot=[1:No_of_Slots]) {
			SlotW = (Slot-1)*StepW+SmallSpannerWidth;
			SlotAngleW = ((SlotW-SmallSpannerWidth)/2)+SmallSpannerWidth;
			SlotH = (Slot-1)*StepH+SmallSpannerHeight;
			SlotHO = (RailL/2)-((Slot-0.25)*(SlotSpacing+SlotAngleW))-(sin(SlotAngle)*SlotH);
			SlotHP = SlotHO-(Slot-1)*(SlotAngleW+SlotSpacing);
			SlotVO = ((Slot-1)*1.25*StepH)+(RailHS+(3/4*SmallSpannerWidth));
			SlotVP = SlotVO;
			translate([SlotHO,0,SlotVO]) rotate([0,-SlotAngle,0]) hull() {
				rotate([90,0,0]) cylinder(d=SlotW,h=SlotCOL,center=true);
				translate([0,0,-SlotH]) rotate([90,0,0]) cylinder(d=SlotW,h=SlotCOL,center=true);
			}
		}
	}
}