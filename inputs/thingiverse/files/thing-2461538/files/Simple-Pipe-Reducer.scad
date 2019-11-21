//Simple Pipe Reducer
//Copyright Paul Beyleveld
//31 Jul 2017
//This is a customizable reducer designed to be used for basic 3d printed pipe reducers. 


// Specify inner or outer diameters for collets.
Type = "one"; // [one:Inner to Inner,two:Inner to Outer,three:Outer to Outer]

// Set wall thicknes (provides steps for 0.4mm extruder size)
Wall_Thickness = 1.6; // [1.2:0.4:8]

// Specify the diameter of the first collet (mm)?
Collet_A_Diameter = 30; 

// Specify the height of the first collet(mm)?
Collet_A_Height = 18; 

// Specify the desired height of the reducer (mm)?
Reducer_Height = 15; 

// Specify the diameter of the second collet (mm)?
Collet_B_Diameter = 40; 
// Specify the height of the second collet (mm)?
Collet_B_Height = 18; 

/* [Hidden] */
fine = 250;

color("SteelBlue") { draw_reducer(); }

module draw_reducer() {
	if (Type == "one") {
		one();
	} else if (Type == "two") {
		two();
	} else if (Type == "three") {
		three();
	} else {
		one();
	}
}

//Inner to Inner - set inner diameter on both sides
module one() {
    
    difference () {
        union() {
            //Draw collet A
            cylinder (h = Collet_A_Height, d = Collet_A_Diameter+Wall_Thickness, center = false, , $fn=fine);
            // Draw reducer and move up by collet A height    
            translate([0,0,Collet_A_Height]) { cylinder(h = Reducer_Height, d1 = Collet_A_Diameter+Wall_Thickness, d2 = Collet_B_Diameter+Wall_Thickness, center = false, $fn=fine); }
            // Draw collet B and move up by collet A and reducer height 
            translate([0,0,Collet_A_Height+Reducer_Height]) { cylinder (h = Collet_B_Height, d = Collet_B_Diameter+Wall_Thickness, center = false, $fn=fine); }
        }
        
        union() {
            //Draw pipe cutout
            translate([0,0,-1]) { cylinder (h = Collet_A_Height+1.1, d = Collet_A_Diameter, center = false, $fn=fine); }
            translate([0,0,Collet_A_Height]) { cylinder(h = Reducer_Height, d1 = Collet_A_Diameter, d2 = Collet_B_Diameter, center = false, $fn=fine); }
            translate([0,0,Collet_A_Height+Reducer_Height-0.1]) { cylinder (h = Collet_B_Height+1.1, d = Collet_B_Diameter, center = false, $fn=fine); }
        }
    }
    
}

//Inner to Outer - set inner diameter on one side and outer diameter on the other
module two() {
    
   difference () {
        union() {
            //Draw collet A
            cylinder (h = Collet_A_Height, d = Collet_A_Diameter+Wall_Thickness, center = false, , $fn=fine);
            // Draw reducer and move up by collet A height    
            translate([0,0,Collet_A_Height]) { cylinder(h = Reducer_Height, d1 = Collet_A_Diameter+Wall_Thickness, d2 = Collet_B_Diameter, center = false, $fn=fine); }
            // Draw collet B and move up by collet A and reducer height 
            translate([0,0,Collet_A_Height+Reducer_Height]) { cylinder (h = Collet_B_Height, d = Collet_B_Diameter, center = false, $fn=fine); }
        }
        
        union() {
            //Draw pipe cutout
            translate([0,0,-1]) { cylinder (h = Collet_A_Height+1.1, d = Collet_A_Diameter, center = false, $fn=fine); }
            translate([0,0,Collet_A_Height]) { cylinder(h = Reducer_Height, d1 = Collet_A_Diameter, d2 = Collet_B_Diameter-Wall_Thickness, center = false, $fn=fine); }
            translate([0,0,Collet_A_Height+Reducer_Height-0.1]) { cylinder (h = Collet_B_Height+1.1, d = Collet_B_Diameter-Wall_Thickness, center = false, $fn=fine); }
        }
    }

}

//Outer to Outer - set outer diameter on both sides
module three() {
    
   difference () {
        union() {
            //Draw collet A
            cylinder (h = Collet_A_Height, d = Collet_A_Diameter, center = false, , $fn=fine);
            // Draw reducer and move up by collet A height    
            translate([0,0,Collet_A_Height]) { cylinder(h = Reducer_Height, d1 = Collet_A_Diameter, d2 = Collet_B_Diameter, center = false, $fn=fine); }
            // Draw collet B and move up by collet A and reducer height 
            translate([0,0,Collet_A_Height+Reducer_Height]) { cylinder (h = Collet_B_Height, d = Collet_B_Diameter, center = false, $fn=fine); }
        }
        
        union() {
            //Draw pipe cutout
            translate([0,0,-1]) { cylinder (h = Collet_A_Height+1.1, d = Collet_A_Diameter-Wall_Thickness, center = false, $fn=fine); }
            translate([0,0,Collet_A_Height]) { cylinder(h = Reducer_Height, d1 = Collet_A_Diameter-Wall_Thickness, d2 = Collet_B_Diameter-Wall_Thickness, center = false, $fn=fine); }
            translate([0,0,Collet_A_Height+Reducer_Height-0.1]) { cylinder (h = Collet_B_Height+1.1, d = Collet_B_Diameter-Wall_Thickness, center = false, $fn=fine); }
        }
    }    
    
}