/////////////////////////////////////
// VARIABLES

/* [Faceplate] */

//Width of Faceplace
faceWidth = 34;

//Height of Faceplate
faceHeight = 20;

//Thickness of Front Panel
faceDepth = 3;

/* [Ultrasonic Sensor] */

//Diameter of "Eyes" (Makeblock 17.1)
eyeDiameter = 17.1;

//Distance Between Centers of "Eyes" (Makeblock 32.25)
eyeCentersDistance = 32.25;

//Thickness of the attached Circuitboard (Makeblock 2)
eyeBoardThickness = 2;

/* [Middle] */

//Height from Bottom of Faceplate to bottom of Bracket (Makeblock at least 24)
middleHeight = 24;

//Percentage of connection of the middle to the bottom
middleBottomPercentage = .75; //[.50:.01:1.00]

/* [Servo Bracket] */

//Depth of Servo (Makeblock 13)
servoDepth = 13;

//Width of space between bottom brackets(Makeblock 23.1)
servoWidth = 23.1;

//Height/Thickness of lower side brackets
bracketHeight = 3;

//Width of the lower side brackets (Makeblock 5)
bracketWidth = 5;

//Diameter of Screw Holes (Makeblock 2)
screwDiameter = 2.0;


/* [Hidden] */
servoTopHeight = 15;


/////////////////////////////////////
// CONSTANTS

bracketTotalWidth = servoWidth + bracketWidth*2;

bracketLCenterX = 0 - ((bracketTotalWidth/2))+ bracketWidth/2;
bracketRCenterX = 0 + ((bracketTotalWidth/2))- bracketWidth/2;

bracketCenterY = servoDepth/2;

/////////////////////////////////////
// RENDERS
rotate ([90,0,0])
{
translate ([0,-(faceDepth/2)-eyeBoardThickness,middleHeight+(faceHeight/2)]) face();

rotate ([90,0,0]) translate([0-(bracketTotalWidth/2),0,eyeBoardThickness]) middle();

translate ([0,0,(servoTopHeight/2)]) lowerBracket();
}
/////////////////////////////////////
// MODULES

module middle()
{
    linear_extrude(height = faceDepth)
    polygon(points=[[(bracketTotalWidth-(bracketTotalWidth*middleBottomPercentage)),0],[-(faceWidth-bracketTotalWidth)/2,middleHeight],[bracketTotalWidth+(faceWidth-bracketTotalWidth)/2,middleHeight],[(bracketTotalWidth-(1-middleBottomPercentage)*bracketTotalWidth),0]]);
}

module screw()
{
    cylinder (h = bracketHeight*2, r=screwDiameter/2, center = true, $fn=50);
}

module lowerBracket()
{
    difference()
    {
    
        difference()
        {
        
        difference(){
    
            translate ([
                0,
                servoDepth-((servoDepth+faceDepth+eyeBoardThickness)/2),
                (0-(servoTopHeight/2))+ (bracketHeight/2)])
            cube([
                servoWidth + bracketWidth*2,
                servoDepth+faceDepth+eyeBoardThickness,
                bracketHeight], center = true);
            
    
          translate ([0,(servoDepth/2),0])
            servoTop();
    
    

        }  
      translate ([bracketLCenterX,bracketCenterY,(0-(servoTopHeight/2))+ (bracketHeight/2)]) screw();  
        
    }
    translate ([bracketRCenterX,bracketCenterY,(0-(servoTopHeight/2))+ (bracketHeight/2)]) screw();
    }
}

module servoTop()
{
    cube([servoWidth,servoDepth+.01,servoTopHeight+.01], center = true);
}
module face()
{
    difference()
    {
        difference()
        {
            cube([faceWidth,faceDepth,faceHeight], center = true);    
            translate ([-(eyeCentersDistance/2),faceDepth,0]) eyeHole();
            //translate ([0-(eyeCentersDistance/2),15,faceHeight/2]) eyeHole();
        }
    
        translate ([(eyeCentersDistance/2),faceDepth,0]) eyeHole();
    }
}


module eyeHole()
{
    rotate([90,0,0])
    linear_extrude( height = faceDepth*2)
    circle(d=eyeDiameter,$fn=50, center = true);
}