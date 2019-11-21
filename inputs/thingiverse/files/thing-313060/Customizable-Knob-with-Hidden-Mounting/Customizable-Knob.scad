/* [Basic] */
// Diameter of the knob
knobDia = 50;  // [30:150]
// Thickness of the knob
knobDepth = 12; // [5:25]

// Diameter of the base
baseDia = 36;  // [20:100]
// Thickness of the base
baseDepth = 10; // [0:25]
// How rounded should the knob be?
roundnessPercentage = 65; // [0:400]


/* [Screw] */
// Width of the head (+ a little margin so you can get it in)
screwHead = 8.5;
// Thickness of the stem of the screw
screwDia = 3.5;
// How deep should the screw hole be? (should be > baseDepth)
screwDepth = 8; // 

/* [Advanced] */
// Accuracy multiplier, higher = slower = more accuracy
acc = 2; // [1:3]


/* [Hidden] */
roundness = roundnessPercentage / 100;
xTranslate = (knobDia/2)-(knobDepth*roundness/2);
screwDisplacement = baseDia/2 - (1.5*screwHead + 1.5);

// Accuracy multiplier
fnScrew = acc * 16;
fnBase = acc * 60;
fnCircle = acc * 70;
fnExtrude = acc * 100;

module knob() {
	rotate_extrude($fn = fnExtrude) {
		union() {  
			translate([xTranslate, knobDepth/2, 0]) scale([roundness, 1,1]) 
				circle(r = knobDepth/2, $fn= fnCircle);
		}
		square([xTranslate,knobDepth]);
	}
}


module base() {
	difference() {
		cylinder(r = baseDia/2, h = baseDepth + knobDepth/2,$fn = fnBase);
	}
}

module screwHole() {
	cylinder(r = screwHead/2, h = screwDepth,$fn = fnScrew);
	translate([screwHead,0,0]) cylinder(r = screwDia/2, h = screwDepth/2,$fn = fnScrew);
	translate([0,-screwDia/2,0]) cube([screwHead,screwDia,screwDepth/2]);
	intersection() {
		translate([0,0,0]) rotate([45,-5,0]) cube([screwHead*1.6,screwHead*1.5,screwHead*1.5]);
		union() {
			translate([screwHead,0,0]) cylinder(r = screwHead/2, h = screwDepth,$fn = fnScrew);
			translate([0,-screwHead/2,0]) cube([screwHead,screwHead,screwDepth]);
		}
	}
}

module render() {
	translate([0,0,baseDepth+knobDepth]) rotate([180,0,0]){
		difference() {
			union() {
				translate([0,0,baseDepth]) knob();
				base();
			}
			translate([screwDisplacement,0, -0.02]) screwHole();
		}	
	}
}

//screwHole();

render();