//print time on the 20mm risers was /insane/ so I'm going for something simpler
//that's right, M3 washers

//sized for M3 screws
screw = 3.6; //.6 for slop
// a 5015 blower fan is, as you might expect, 15mm thick
height = 16; 
//length of wings (measured from center)
wing = 12;
//number of wings
sides = 2; //[0,1,2]
$fn = 1*8;

union(){
    rotate_extrude(angle=360)
    translate ([0.5*screw, 0])
    square ([screw, height]);
    
    if (sides > 1){
        translate ([-(0.5*screw)-wing, -screw, 0])
        cube ([wing, 2*screw, height]);
    }
    
    if (sides > 0){
        translate ([0.5*screw, -screw, 0])
        cube ([wing, 2*screw, height]);
    }
}
