//Petal Length (in mm)
petal_length = 100; // [50:150]

//Petal Width (in mm)
petal_width = 60; // [30:130]

//Number of Petals
no_of_petals = 7; // [3:12]

//Petal Spacing from center (in mm)
petal_spacing = 0; // [-20:50]

//Flower Center (in mm) (should bigger number than Petal Spacing)
center = 9; // [0:50]

//Angle to Rotate (in degrees)
twist = 90; // [0:720]

//Vase Height (in mm)
height = 80; // [0:720]

//Flower size increase (2 = 200%)
scale = 2; // [1:4]

/* Advanced Settings */

//Double Twist (opposite rotation) 
anti = "no"; // [yes, no]

//Layer Height (in mm)
layerheight = .24; // [0.2, 0.24, 0.5, 1, 2, 5, 10]

/* [Hidden] */

$fs=0.8; // def 1, 0.2 is high res
$fa=4;//def 12, 3 is very nice

slices = height/layerheight;

module petal() {
	translate([-((petal_length/10)+petal_spacing),0,0]) scale([(petal_length/petal_width),1,1]) circle(5);	
}

module flower() {
	for(p = [0:no_of_petals]) { 
		rotate([0,0,p*(360/no_of_petals)]) petal();
	}
	circle(center);
}

module vase(twist){
	linear_extrude(
		height = height, 
		center = true, 
		convexity = 10, 
		twist = twist, 
		scale=scale, 
		slices=slices){
			flower();
	}
}

vase(twist);

if (anti == "yes") {
	vase(-twist);
}

