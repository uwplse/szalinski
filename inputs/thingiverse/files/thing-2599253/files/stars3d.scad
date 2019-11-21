

/*[ Star  variables ]*/
//  number of points
NumberOfPoints =7; // [3:100]

//  length of points
LengthOfPoints =20; // [1:100]

//  outside diameter of star
TotalDiameterOfStar =50; // [10:200]

//  outside point roundness / height
OutsidePointRoundnessHeight =1; // [.1:50]

//  middle point roudness / height
MiddlepointRoudness =.1; // [.1:100]

//  center point height
centerpointHeight =1; // [.1:100]

// Do you want the bottom cut flat?
flatBottom="flat"; // ["flat","round"]

if(flatBottom == "flat"){
    difference(){
        star3d(NumberOfPoints
            ,LengthOfPoints
            ,TotalDiameterOfStar
            ,OutsidePointRoundnessHeight
            ,MiddlepointRoudness
            ,centerpointHeight);
        translate([0,0,-50])cube([TotalDiameterOfStar*3,TotalDiameterOfStar*3,100],true);
}
}else{
    star3d(NumberOfPoints
    ,LengthOfPoints
    ,TotalDiameterOfStar
    ,OutsidePointRoundnessHeight
    ,MiddlepointRoudness
    ,centerpointHeight);
}

module star3d(points, pointLEngth,totaldiameter, pointroundness = 1,MiddlepointRoudness = .1,centerPointHeight = 1){
    innerpointPosition = (360/points)/2;
    for(i=[0:points]){
        outerpointPosistion = (i*360)/points;
       hull(){
    rotate([0,0,outerpointPosistion])
            translate([totaldiameter,0,0])
                sphere(pointroundness,true);
    rotate([0,0,outerpointPosistion+ innerpointPosition])
            translate([totaldiameter-pointLEngth,0,0])
                sphere(MiddlepointRoudness,true);
     rotate([0,0,outerpointPosistion- innerpointPosition])
            translate([totaldiameter-pointLEngth,0,0])
                sphere(MiddlepointRoudness,true);
           sphere(centerPointHeight,true);
        }
        
    }
}