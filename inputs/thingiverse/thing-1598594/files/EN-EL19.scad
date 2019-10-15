//preview[view:south,tilt:top]

//CUSTOMIZER VARIABLES

// Number of Batteries 
batteryCount = 4; // [1:12]

// Wall thickness
wallThickness = 1.5; // [1.0:Thin Wall 1.0mm,1.5:Lightweight Wall 1.5mm,2.0:Strong Wall 2.0mm,3.0:Thick Wall 3.0mm]

// Shorter than the battery, so you can get a finger grip.
height = 32.0; // [16:34]

//CUSTOMIZER VARIABLES END

/* [hidden] */

// These are the Dimensions of the 
// Nikon EN-EL19  Battery, they fit 
// Snugly w/o too much effort getting
// back out.
bW = 32;
bD = 6.5;



// Build a Single Holder
module batterySlot() {

	difference() {
	   cube( [bW + (wallThickness * 2 ), bD + (wallThickness * 2 ), height + wallThickness], center=true);
	
		translate([0,0, wallThickness])
	   cube( [ bW - bD, bD, height], center=true);
	
	   translate([+(bW / 2) - (bD/2), 0, wallThickness])
	   cylinder(h=height, r=(bD/2), $fn=100, center=true);
	
	   translate([-(bW / 2) + (bD/2), 0, wallThickness])
	   cylinder(h=height, r=(bD/2), $fn=100, center=true);
	
	}
}

// Build the Set
union() {

	for( a =[1:batteryCount]){
		echo (a);

		translate([0, ( bD + wallThickness ) * a, 0])
		batterySlot();
	}
}