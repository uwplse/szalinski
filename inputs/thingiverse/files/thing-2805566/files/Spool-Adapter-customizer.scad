/* [Dimensions] */

// Outside diameter
OD = 50;	// [12:100]
// Inside diameter
ID = 32;	// [8:50]
// Width at outside diameter
Width = 93; // [30:100]
// Width of flange
FlangeW = 2; // [0:5]
// Height of flange about outside diameter
FlangeR = 3; // [0:10]
// Rebate bore ID - Set to ID if no rebate needed
RebateD = 38; // [16:75]
// Rebate height at intersection with main ID
RebateH = 11; // [0:50]
// Width of internal webs and cylinder wall thicknesses
Web = 1.5; // [1:5]
// Quality of cylinders
Facets = 100; // [32:200]

/* [Hidden] */
$fn = Facets;
TaperH = (RebateD-ID)/2;
RebatePH = RebateH-TaperH;

spool ();

module spool () {
	difference() {
		union() {
			cylinder(d=OD+2*FlangeR,h=FlangeW);
			translate([0,0,FlangeW-0.1]) cylinder(d=OD,h=Width+0.1);
		}
		translate([0,0,-1]) cylinder(d=RebateD,h=RebatePH+1.01);
		translate([0,0,RebatePH]) cylinder(d1=RebateD,,d2=ID,h=TaperH);
		translate([0,0,TaperH-0.01]) cylinder(d=ID,h=Width+FlangeW+2);
			translate([0,0,-1]) difference() {
			cylinder(d=OD-2*Web,h=Width+FlangeW+2);
			translate([0,0,-1]) cylinder(d=RebateD+2*Web,h=RebatePH+Web+1.01);
			translate([0,0,RebatePH+Web]) cylinder(d1=RebateD+2*Web,d2=ID+2*Web,h=TaperH);
			translate([0,0,RebateH-0.01]) cylinder(d=ID+2*Web,h=Width+FlangeW+4);
			cube([110,Web,200],center=true);
			rotate([0,0,60]) cube([110,Web,200],center=true);
			rotate([0,0,120]) cube([110,Web,200],center=true);
		}
	}
}