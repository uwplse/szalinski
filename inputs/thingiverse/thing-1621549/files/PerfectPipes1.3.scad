
pipeType = "straightPipe"; //[angledPipe:Right Angle Pipe, straightPipe:Straight Pipe, pipeConverter:Pipe Converter, pipeValve:Pipe Valve, halfPipe:Half Pipe]

/* [ Global ] */

//pipeProfile = "Round" //[]

totalPipeLength = 100;
pipeDiameter = 20;
pipeWallThickness = 8;

topPushFitLength = totalPipeLength*0.2;
bottomPushFitLength = totalPipeLength*0.2;

/* [ Angled Pipe ] */

angleDegrees = 90;

/* [ Converter Pipe ] */

upperDiameter = 50;
lowerDiameter = 20;


/* [ Advanced ] */


fitGapTolerance = 0.4;

topFitWallThickness = 4;
bottomFitWallThickness = 4;

overlap = 0.1;


//Responsible for generating the correct pipe based upon user selection
module thePlumber(){
    
//    lowerPushFit(pipeDiameter);
 
    
    if(pipeType == "straightPipe"){
        straightPipe();
    }
    if(pipeType == "angledPipe"){
        angledPipe();
    }
    if(pipeType == "pipeConverter"){
        pipeSizeConverter();
    }
    if(pipeType == "pipeValve"){
        pipeValve();
    }
    if(pipeType == "halfPipe"){
        halfPipe();
    }
}

module hollowCylinder(h, r1, r2, wallThickness, center){
        //Tests if center has been declaired, if it has not then default is false
        if(center == undef){
            center = false;
        }
        
        
        difference(){
            cylinder(h, r1, r2, center);
            translate([0,0,-0.1]){
                cylinder(h+2, r1-wallThickness, r2-wallThickness, center);
            }
        }
    }


module twoDHollowCircle(r1, r2, wallThickness){
    difference(){
        circle(r1, r2);
        circle(r1-wallThickness, r2-wallThickness);
    }
}

module lowerPushFit(diameter){
    
    if(diameter == undef){diameter = pipeDiameter;}
    
    hollowCylinder(
    bottomPushFitLength, 
    diameter,
    diameter,
    pipeWallThickness-bottomFitWallThickness-fitGapTolerance/2,
    false);
}



module upperPushFit(diameter){

    if(diameter == undef){diameter = pipeDiameter;}

    hollowCylinder(topPushFitLength, 
    diameter-bottomFitWallThickness-fitGapTolerance/2,
    diameter-bottomFitWallThickness-fitGapTolerance/2,
    pipeWallThickness-bottomFitWallThickness-fitGapTolerance/2,
    false
    );
}


module straightPipe(){
    
    inPipeLength = totalPipeLength-topPushFitLength-bottomPushFitLength;
    
    translate([0,0,inPipeLength/2]){
        upperPushFit(pipeDiameter);}
        
    hollowCylinder(inPipeLength,
    pipeDiameter, pipeDiameter, pipeWallThickness, true);
    
    translate([0, 0, -1*(inPipeLength/2)-bottomPushFitLength]){
        rotate([180,0,0]);
        lowerPushFit(pipeDiameter);}
}

module angledPipe(){
//    hollowCylinder(totalPipeLength*0.2, pipeDiameter, pipeDiameter, pipeWallThickness, false);
        rotate_extrude(angle=90, convexity=10)
        translate([20,0,0])
        twoDHollowCircle(pipeDiameter, pipeDiameter, pipeWallThickness);
   
}

module pipeSizeConverter(){
    hollowCylinder(totalPipeLength*0.6, lowerDiameter, upperDiameter, pipeWallThickness);
    
    translate([0,0,-bottomPushFitLength]){lowerPushFit(lowerDiameter);}
    translate([0,0,totalPipeLength*0.6]){upperPushFit(upperDiameter);}

}

module pipeValve(){
    
}


module halfPipe(){
    
}

thePlumber();