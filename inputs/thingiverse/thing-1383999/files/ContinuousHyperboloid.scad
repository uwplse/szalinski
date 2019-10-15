// LIB
TAU = 360; //2.0 * PI;
function r2d(a) = 180 * a / PI;


// top and bottom radius
radius = 5.0; //[0.1:0.01:100.0]

// height
height = 15.0; //[0.1:0.01:100.0]

// touchpoints on top and bottom
notches = 15; //[3:1:100]

// higher numbers reduce density
// must be < notches / 2
skip_behind = 2; //[1:1:49]

// segment radius
segment_size = 0.05; //[0.05:0.01:2.0]


wind(radius,height,notches,segment_size, skip_behind);

module wind(radius = 5.0, height = 5.0, notches = 6.0, stickWidth = 0.1, skipBehind){


    r_sq = radius * radius;
    skip = (notches / 2) - skipBehind;
    skipAngle = TAU/2 - skipBehind*TAU/notches;
    
    // law of cosines
    chordLength = sqrt((r_sq + r_sq) - (2 * r_sq * cos(skipAngle)));
    length = sqrt((chordLength*chordLength) + (height*height));
    angleY = atan2(chordLength, height);
    //law of sines
    angleZ = asin(radius * sin(skipAngle) / chordLength);
    
    repeats = notches % 2 ? 0 : (notches / 2) - 2;
    
    for (j = [0:repeats]){
        for ( i = [0: notches*skip]){
            dir = i%2 ? -1 : 1;
            startPos = i%2 ? i : i-1;
            ratio = TAU/notches;
            position = startPos * ratio;
            rotate([0,0,(j * TAU / notches)]){
                translate([radius * cos(position),radius * sin(position), 0]){
                   rotate([0, 0,dir * angleZ]){
                        rotate([0,0,position]){
                            rotate([0,-angleY,0]){
                                cylinder(length, r=stickWidth, $fn = 20);
                            }
                        }
                    }
                }
            }
        }
    }
}


