use <utils/build_plate.scad>
//use <build_plate.scad>

/* [Test Pattern] */
// (mm)
bed_size=150;
// (mm)
layer_size=0.2;
orientation_box="yes"; // [yes,no]

half=bed_size/2;

// preview[view:south, tilt:top]

/* [Print Bed Setup] */
//for display only, doesn't contribute to final object
build_plate_selector = -1; //[-1: None, 0:Replicator 2,1: Replicator,2:Thingomatic,100:Printrbot,101:Printrbot+,102:Printrbot Simple:103:Printrbot Simple XL,104:Ultimaker,105:Ultimaker 2,106:Solidoodle,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; 

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; 

bps=build_plate_selector<100?build_plate_selector:3;

// strange way OpenSCAD handles variables
// requires this strangeness
// To add more printers, add them
// to the selector above -- I started
// at 100 to avoid future updates
// to build_plate library
// Then add a bpmx line and a bpmy line
// that looks like the below
// Don't forget the last line needs to
// stay the last line (100;)
bpmx=build_plate_selector==3?build_plate_manual_x:
     build_plate_selector==100?100: //pb
     build_plate_selector==101?200: //pb+
     build_plate_selector==102?100: //pb simple
     build_plate_selector==103?185: // pb simple xl
		build_plate_selector==104?210:  // ultimaker
		build_plate_selector==105?230:  // ultimaker2
	  build_plate_selector==106?150:  // solidoodle
100;

bpmy=build_plate_selector==3?build_plate_manual_y:
     build_plate_selector==100?100:  //pb
     build_plate_selector==101?200:  //pb+
     build_plate_selector==102?100:  //pb simple
     build_plate_selector==103?100:  //pb simple xl
		build_plate_selector==104?210:   //ultimaker
		build_plate_selector==105?225:   //ultimaker2
	 	build_plate_selector==106?150:   // solidoodle
100;


if (build_plate_selector!=-1) build_plate(bps,bpmx,bpmy);

hyp=sqrt(bed_size*bed_size*2);
union() {
translate([-half,-half,0]) cube([bed_size,2,layer_size]);
translate([-half,half,0]) cube([bed_size+1,2,layer_size]);
translate([-half,-half,0]) cube([2,bed_size,layer_size]);
translate([half,-half,0]) cube([2,bed_size+2,layer_size]);
translate([-half,0,0]) cube([bed_size,2,layer_size]);
translate([0,-half,0]) cube([2,bed_size+2,layer_size]);
translate([half,-half,0]) rotate([0,0,45]) cube([2,hyp,layer_size]);
translate([-half,-half,0]) rotate([0,0,-45]) cube([2,hyp,layer_size]);
if (orientation_box=="yes") cube([10,10,layer_size]);
}