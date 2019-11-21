/*[ Star  variables ]*/
//  number of points
NumberOfPoints =7; // [3:100]

//  length of points
LengthOfPoints =10; // [1:100]

//  outside diameter of star
TotalDiameterOfStar =50; // [10:200]

//  outside point roundness 
OutsidePointRoundnessHeight =.1; // [.1:50]

/*[ Star  extrution variables ]*/
//  Height 0f star
extrudeHeight = 1; // [1:500]

// Star convexity
starConvexity = 0;

//star twist
starTwist = 0; // [-500:500]

// how smooth do you want the sides
starSlices = 50; // [1:50]

// star scale ( the bottom will be the normal size and the top of the extrution will get bigget by this part)
starScale = 1; // [1:.2:5]


linear_extrude(height = extrudeHeight, center = false, convexity = 10, twist = starTwist, slices = starSlices, scale = starScale)
star2d(NumberOfPoints,LengthOfPoints,TotalDiameterOfStar,OutsidePointRoundnessHeight);

module star2d(points, pointLEngth,totaldiameter,OutsidePointRoundnessHeight = .1, MiddlepointRoudness = .1){
    innerpointPosition = (360/points)/2;
    for(i=[0:points]){
        outerpointPosistion = (i*360)/points;
       hull(){
    rotate([0,0,outerpointPosistion])
            translate([totaldiameter,0,0])
                circle(OutsidePointRoundnessHeight,true);
    rotate([0,0,outerpointPosistion+ innerpointPosition])
            translate([totaldiameter-pointLEngth,0,0])
                circle(MiddlepointRoudness,true);
     rotate([0,0,outerpointPosistion- innerpointPosition])
            translate([totaldiameter-pointLEngth,0,0])
                circle(MiddlepointRoudness,true);
        }
    }
    circle(totaldiameter-pointLEngth, true);
}

