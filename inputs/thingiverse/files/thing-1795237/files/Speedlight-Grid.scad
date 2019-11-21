//////////////////////
/// Thing: Customizable Grid for Canon Speedlight
/// For use with http://www.thingiverse.com/thing:1185771 (Canon Speedlite 600EX-RT - CGprods KIT)
/// Author: Kim Quermann
/// Creative Commons - Attribution - just provide cedit to this thing
//////////////////////


/////////////////////
/// Change these Parameters
/////////////////////
twoSidedHole = "yes";
hexRadius=7.5;
showHexRadiusAsLabel = "no";

////////////////////
/// Nothing to change for Speedlight
////////////////////
outerWidth = 125;
outerHeight = 75;
outerRadius = outerHeight/2;
baseHeight = 10;
innerWidth = 75;
innerHeight = 53; // maybe 47 
holeDiameter = 6.5;
holeDepth = 3.15;
holeDistance = 6+0.5*holeDiameter;
hexBorderWidth=0.31; // be careful with this value. For too little value, the grid will not be printed. Min Value: 0.29 for shell thickness 1.5 in Cura

yStepHeight=2*sqrt(3/4*hexRadius*hexRadius);
xStepWidth=2*hexRadius*0.75;


///////////////
// RENDER

union(){
    
    difference(){
    linear_extrude( height = baseHeight)
        assembledGrid();
    linear_extrude(height = holeDepth)
        magnetHoles();
    if (twoSidedHole == "yes"){
        translate([0,0,baseHeight-holeDepth]) linear_extrude(height = holeDepth)
        magnetHoles();
        }  
    }
    
    if(showHexRadiusAsLabel == "yes"){
    rotate(a=[90,0,0])
    translate([5,5,0])
    linear_extrude(height = 1.5){
        text(text = str(hexRadius, " mm"), font = "Liberation Sans", size = 7, valign = "center");
    }
}
}
   



//////////////
// MODULES

module assembledGrid(){
    union(){
        baseShape();

        // Gesamt: outerWidth
        // Mittelpunkt(X):  (outerWidth-2*outerRadius)*0,5
        // mesh muss 0.5*Meshbreite nach links vom Mittelpunkt
        
       translate([outerRadius-(outerWidth-innerWidth),(outerHeight-innerHeight)/2]) mesh();
        }
    }

module baseShape(){
    difference(){
        union(){
            square([outerWidth-2*outerRadius,outerHeight]);
            translate([0,outerRadius,0]) circle(r=outerRadius, $fn=50);
            translate([outerWidth-2*outerRadius,outerRadius,0]) circle(r=outerRadius, $fn=50);
        }
        translate([outerRadius-(outerWidth-innerWidth),(outerHeight-innerHeight)/2])
        innerShape();
    }
}
module innerShape(add=0){
    square([innerWidth+add,innerHeight+add]);
    }
module magnetHoles(){
    translate([-outerRadius + holeDistance, outerRadius, 0]) circle(d=holeDiameter, $fn=50);
    translate([outerWidth-outerRadius-holeDistance, outerRadius,0]) circle(d=holeDiameter, $fn=50);
    }
    
module hex(x,y){
    
    
//    // Example mesh
//    hex(0*xStepWidth, 0*yStepHeight);
//    hex(1*xStepWidth, 0*yStepHeight + 0.5*yStepHeight);
//    hex(2*xStepWidth, 0*yStepHeight);
//    hex(3*xStepWidth, 0*yStepHeight + 0.5*yStepHeight);
//    hex(4*xStepWidth, 0*yStepHeight);
//    hex(5*xStepWidth, 0*yStepHeight + 0.5*yStepHeight);
//    hex(6*xStepWidth, 0*yStepHeight);
//    hex(7*xStepWidth, 0*yStepHeight + 0.5*yStepHeight);
//    // second row
//    hex(0*xStepWidth, 1*yStepHeight);
//    hex(1*xStepWidth, 1*yStepHeight +0.5*yStepHeight);
//    hex(2*xStepWidth, 1*yStepHeight);
//    hex(3*xStepWidth, 1*yStepHeight + 0.5*yStepHeight);
//    hex(4*xStepWidth, 1*yStepHeight);
//    hex(5*xStepWidth, 1*yStepHeight +0.5*yStepHeight);
//    hex(6*xStepWidth, 1*yStepHeight);
//    hex(7*xStepWidth, 1*yStepHeight + 0.5*yStepHeight);
//    // third row
//    hex(0*xStepWidth, 2*yStepHeight);
//    hex(1*xStepWidth, 2*yStepHeight +0.5*yStepHeight);
//    hex(2*xStepWidth, 2*yStepHeight);
//    hex(3*xStepWidth, 2*yStepHeight + 0.5*yStepHeight);
//    hex(4*xStepWidth, 2*yStepHeight);
//    hex(5*xStepWidth, 2*yStepHeight +0.5*yStepHeight);
//    hex(6*xStepWidth, 2*yStepHeight);
//    hex(7*xStepWidth, 2*yStepHeight + 0.5*yStepHeight);
    
    
	difference(){
		translate([x,y,0]) 
		circle(r=(hexRadius+hexBorderWidth), $fn=6);	
		translate([x,y,0]) 
		circle(r=(hexRadius-hexBorderWidth), $fn=6);
	}
}    
    
module mesh(){   
    xSteps = innerWidth / xStepWidth;
    ySteps = innerHeight / yStepHeight;
    intersection(){
        for (yi=[0:1:ySteps])
            for(xi=[0:1:xSteps]){
                hex(xi*xStepWidth,yi*yStepHeight+( xi%2==0?0:0.5*yStepHeight ));
            }
        innerShape();
    }
}

