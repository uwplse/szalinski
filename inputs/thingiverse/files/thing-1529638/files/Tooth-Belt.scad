//Number of facets
$fn=100;
//belt length in mm
length = 200;
//belt height in mm
height = 6;
//belt thickness in mm
thickness = 0.6;
//tooth base width in mm
toothBaseWidth = 1.0;
//tooth tip width in mm
toothTipWidth = 0.95;
//tooth length in mm
toothLength = 1.0;
//tooth spacing in mm
toothSpacing = 1.2;
//tooth and belt overlap
toothOverlap = 0.1;

createTread = 1;//[0:No tread,1:Tread]

//create tread every x teeth
treadModule = 4;
//tread base width in mm
treadBaseWidth = 0.94;
//tread tip width in mm
treadTipWidth = 0.94;
//tread length in mm
treadLength = 0.94;
//tread skew
treadTwist = 5;
//tread and belt overlap
treadOverlap = 0.2;

/* [Hidden] */

pi=3.1415923;

number_teeth = floor(length / (toothBaseWidth + toothSpacing));
adjusted_length = number_teeth *  (toothBaseWidth + toothSpacing);
tooth_angle = 360 / number_teeth;
belt_radius = adjusted_length/pi/2;

union() {
body();
teeth();
if (createTread==1) tread();
echo ("Belt diameter is ", belt_radius*2);
}


module body() {
	translate([0,0,height/2])
	difference (){
		cylinder(r=belt_radius+thickness, h=height, center=true);
      cylinder(r=belt_radius, h=height*2, center=true);
	}
}

module teeth() {
	linear_extrude(height) {
	for(i=[1:number_teeth]) 
			rotate([0,0,i*tooth_angle])
			translate([0,belt_radius,0]) {
				//linear_extrude(height)
				polygon([[-toothBaseWidth/2,toothOverlap],[toothBaseWidth/2,toothOverlap],
			  				[toothTipWidth/2,-toothLength],[-toothTipWidth/2,-toothLength]]);
				}
	}
}

module tread() {
	translate([0,0,height/2])
	{
		half_tread();
		mirror ([0,0,1])
		half_tread();
	}
}

module half_tread() {
	linear_extrude(height/2, twist=treadTwist) {
	for(i=[1:number_teeth/treadModule]) 
			rotate([0,0,i*tooth_angle*treadModule])
			translate([0,belt_radius + thickness,0]) {
				//linear_extrude(height)
				polygon([[-treadBaseWidth/2,-treadOverlap],[treadBaseWidth/2,-treadOverlap],
			  				[treadTipWidth/2,treadLength],[-treadTipWidth/2,treadLength]]);
				}
	}
}