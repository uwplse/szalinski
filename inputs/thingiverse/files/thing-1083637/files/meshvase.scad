// LIB
TAU = 360; //2.0 * PI;
function r2d(a) = 180 * a / PI;



// choose the frequency that basket segments form a complete revolution. Effects inner radius.
mode = "basket6"; //[basket4, basket6]

// top and bottom radius
radius = 5.0; //[0.1:0.01:100.0]

// height
height = 5.0; //[0.1:0.01:100.0]

// density of segments (use multiples of 4 for basket4 use multiples of 6 for basket6
density = 48; //[4:2:100]

// segment radius
segment_size = 0.1; //[0.05:0.01:10.0]

if (mode == "basket4"){
    basket4(radius,height,density,segment_size);
} else if (mode == "basket6"){
    basket6(radius,height,density,segment_size);
}

module basket4(radius = 5.0, height = 5.0, numSticks = 48.0, stickWidth = 0.1){

    chordLength = sqrt((radius*radius) + (radius*radius));
    length = sqrt((chordLength*chordLength)  +(height*height));
    angleY = atan2(chordLength, height);
    angleZ = atan2(radius, radius);


    for( i = [0:numSticks]){
        dir = i%2 ? -1 : 1;
        startPos = i%2 ? i : i-1;
        ratio = TAU/numSticks;
        position = startPos * ratio;
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

module basket6(radius = 5.0, height = 5.0, numSticks = 48.0, stickWidth = 0.1){

    r_sq = radius * radius;
    // law of cosines
    chordLength = sqrt((r_sq + r_sq) - (2 * r_sq * cos(TAU / 3)));
    length = sqrt((chordLength*chordLength) + (height*height));
    
    angleY = atan2(chordLength, height);
    angleZ = 30;


    for( i = [0:numSticks]){
        dir = i%2 ? -1 : 1;
        startPos = i%2 ? i : i-1;
        ratio = TAU/numSticks;
        position = startPos * ratio;
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


