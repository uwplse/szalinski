
// Height of the knob
height = 8; // [4:30]

// Approximate diameter of the knob
diameter = 30; // [15:60]

// Number of petals of the knob
numberOfPetals = 6; // [3:10]

// Radius of the corner rounding
roundingRadius = 2; // [0:10]

// Bulginess/smoothness of the petals
curvatureFactor = 0; // [-2:0.1:2]

$fn = 40*1;

flowerKnob(height, diameter, numberOfPetals, roundingRadius, curvatureFactor);
   
module flowerKnob(height, diameter, numberOfPetals = 6, roundingRadius = 2, curvatureFactor = 0) {
    
    ff = 0.01; //fudge factor
    
    
    chordAngle = 180 / numberOfPetals;
    halfChord = sin(chordAngle / 2) * diameter / 2;
    chordDistance = pow(diameter * diameter / 4 - halfChord * halfChord, 1/2);

    curvatureAngle = chordAngle * curvatureFactor;

    dentpetalAngle = 180 - chordAngle + curvatureAngle;
    dentPetalRadius = halfChord / sin(dentpetalAngle / 2);
    rawDentPetalDistance = pow(dentPetalRadius * dentPetalRadius - halfChord * halfChord, 1/2);
    dentPetalDistance = rawDentPetalDistance * (dentpetalAngle <= 180 ? 1 : -1);

    bumpPetalAngle = 180 - chordAngle - curvatureAngle;
    bumpPetalRadius = halfChord / sin(bumpPetalAngle / 2);
    rawBumpPetalDistance = pow(bumpPetalRadius * bumpPetalRadius - halfChord * halfChord, 1/2);
    bumpPetalDistance = rawBumpPetalDistance * (bumpPetalAngle <= 180 ? 1 : -1);

    module roundedRect() {
        difference() {
        
            square([bumpPetalRadius,height]);
     
            translate([bumpPetalRadius - roundingRadius, 0])
                difference() {
                    square(roundingRadius);
                    translate([0, roundingRadius])
                        circle(roundingRadius);  
                }
            
            translate([bumpPetalRadius - roundingRadius, height - roundingRadius])
                difference() {
                    square(roundingRadius);
                    circle(roundingRadius); 
            
                }
        }            
    }
    
    module hornedRect() {
        union() {
        
            square([dentPetalRadius,height]);
     
            translate([dentPetalRadius, 0])
                difference() {
                    square(roundingRadius);
                    translate([roundingRadius,roundingRadius])
                        circle(roundingRadius);  
                }
            
            translate([dentPetalRadius, height - roundingRadius])
                difference() {
                    square(roundingRadius);
                    translate([roundingRadius,0])
                        circle(roundingRadius); 
            
                }
                
            // ff
            translate([0, -ff])
                square([dentPetalRadius + roundingRadius,ff]);   
            translate([0, height])
                square([dentPetalRadius + roundingRadius,ff]); 
            
        }            
    }
    

    module bump() {
        
            rotate_extrude( convexity=10)
                roundedRect();
    }


    
    module dent() {
            rotate_extrude(convexity=10)
                    hornedRect();
    }
    
    
    difference() {
        union() { 
            cylinder(height,r=chordDistance+(dentPetalDistance+bumpPetalDistance)/2, $fn = numberOfPetals*2);
            
            for (i=[1:numberOfPetals])
                rotate([0, 0, chordAngle * 2 * i])
                    translate([chordDistance+bumpPetalDistance, 0, 0])
                        bump();
        }
        
        for (i=[1:numberOfPetals])
            rotate([0, 0, chordAngle * 2 * (i + 0.5)])
                translate([chordDistance+dentPetalDistance, 0, 0])
                    dent();
    }
}

