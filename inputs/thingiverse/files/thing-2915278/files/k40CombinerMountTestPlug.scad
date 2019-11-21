// red dot laser and IR laser combiner mount Test Plug for K40 laser cutters
// by DOug LaRue
//
// MCAD package source: https://github.com/elmom/MCAD
include <MCAD/regular_shapes.scad>;


/* [Hidden] */
laserBeamOD=2;
largeBeamHoleOD=49.8;  // measured
holeFlangeW=5;
holePlugH=3;
combinerOD=25;
combinerMountH=5.5;  // total height of mount
combinerMountOD=28;  // outside of metal mount
combinerMountFlangeOD=40;  // outside of metal mount flange
//combinerMountFlangeOD=37;  // smaller mount - outside of metal mount flange
combinerMountFlangeH=2;
combinerMountOpeningOD=22.5; // visible usable area
$fn=30;


/* [Beam Exit X, measured from Left] */
beamExitX=33.3; // /*[15:45]*/
/* [Beam Exit Y, measured from Bottom] */
beamExitY=23.4; // /*[40:-40]*/




union(){ //flange

difference() {
    cylinder(r=largeBeamHoleOD/2, h=holePlugH, center=false);
    translate([largeBeamHoleOD/2-beamExitX,beamExitY-largeBeamHoleOD/2,0]) cylinder(r=laserBeamOD/2, h=15, center=false);
    #translate([largeBeamHoleOD/2-beamExitX,beamExitY-largeBeamHoleOD/2,holePlugH-2]) cylinder(r=combinerMountOD/2, h=2, center=false);
}

difference() { // flange ring
    cylinder(r=holeFlangeW+largeBeamHoleOD/2, h=1, center=false);
    cylinder(r=largeBeamHoleOD/2-1, h=holePlugH, center=false);
    //flange holes lower and left
    #translate([0,holeFlangeW/2-(holeFlangeW+largeBeamHoleOD/2),0]) cylinder(r=1,h=15,center=false);
    #translate([holeFlangeW/2-(holeFlangeW+largeBeamHoleOD/2),0,0]) cylinder(r=1,h=15,center=false);
    //flange holes upper and right    
    #translate([0,(holeFlangeW+largeBeamHoleOD/2)-holeFlangeW/2,0]) cylinder(r=1,h=15,center=false);
    #translate([(holeFlangeW+largeBeamHoleOD/2)-holeFlangeW/2,0,0]) cylinder(r=1,h=15,center=false);
}

}