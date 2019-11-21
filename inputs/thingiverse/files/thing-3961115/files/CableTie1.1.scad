//Customizable Cable Tie
// V1.1 2019-11-08
// - added HookLocation Parameter for Clip-On Style. This allow the hook to be placed on back of clip instead of the top. 
// V1.0 2019-11-07
// This file is licensed under the following license:
// https://creativecommons.org/licenses/by-nc-nd/3.0/legalcode
// https://creativecommons.org/licenses/by-nc-nd/3.0/
// (c) 2019 Rainer Schlosshan

// 

// The style of cable tie
Style=3;// [0:Simple,1:Simple with double hook height (dual Wind),2:LoopEnd,3:Clip-On End]
// The total length of the cable tie
length=70;
// total number of holes
HoleCount=13;
// the band thickness
thickness=1;//[0.5,0.6,0.8,1.0,1.2,1.4,1.6,1.8,2.0]
/* [Clip On Settings] */
//The Diameter of the Cable to clip-on to
CableDia=3.7; 
// Hook location
HookLocation=0;//[0:Top,1:Back]

// Create disc to help with bed adhesion
AddAdhesionDisc=0;//[0:No,1:Yes]
/* [Loop End Settings] */

// Create additional Holes to allow fixing it to a cable
//LoopEnd=2;//[0:No,1:Additional Holes on the End,2:Increase LockPinSize to allow Double Lock]
// Number Of Holes in LoopEnd
LoopEndCount=3;


/* [Advanced Settings] */
// the total width of the cable tie
width=10    ;


// width of each hole
HoleWidth=6;
// length of each hole
HoleLength=2.1  ;

// distance between holes
HoleDistance=2.1;
// total tolerance to allow easier fit
FitTolerance=0.4;

// radius used to round the corners of the band
radius=2;



$fn=120;
difference(){
    union(){
        // ====================the positives
        roundedRect([width,length,thickness],radius);
       
           
        if (Style==2){
            // The extension of the band for the loop End
            translate([0,length-2*radius,0])
                roundedRect([width,HoleLength*LoopEndCount+HoleDistance*(LoopEndCount+2),thickness],radius);
             //Pin with increased height
              translate([width/2,length-HoleLength*3,thickness])createPin(
                pinX=HoleWidth-FitTolerance
                ,pinY=HoleLength-FitTolerance
                //,pinSize=PinSize-FitTolerance/2
                ,height=(thickness+FitTolerance)*2);
        }
        if (Style==1){
            //Pin with increased height (for Winding 2x )
              translate([width/2,length-HoleLength*2,thickness])createPin(
                pinX=HoleWidth-FitTolerance
                ,pinY=HoleLength-FitTolerance
                //,pinSize=PinSize-FitTolerance/2
                ,height=(thickness+FitTolerance)*2);
            
        }
        if (Style==0){
            //Pin with standard height (no loop)
              translate([width/2,length-HoleLength*2,thickness])createPin(
                pinX=HoleWidth-FitTolerance
                ,pinY=HoleLength-FitTolerance
                //,pinSize=PinSize-FitTolerance/2
                ,height=thickness+FitTolerance);
            
        }
        
        if (Style==3){ // Clip-On 
            // Cylinder for cable clipon
            translate([0,length-CableDia/2-CableDia/4,thickness+CableDia/2+CableDia/4])
                rotate([0,90,0])cylinder(r=CableDia/2+CableDia/4,h=width);
            translate([0,length-CableDia*1.5,thickness])roundedRect([width,CableDia*1.5,CableDia*1.5/2],radius);
            //Pin with standard height (no loop)
            if (HookLocation==0) { // Hook on top
                // cube for bottom half
                translate([0,length-CableDia*1.5,thickness])
                    roundedRect([width,CableDia*1.5,CableDia*1.5],radius);
   
                translate([width/2,length-CableDia/2-CableDia/4,thickness+CableDia+CableDia/2])
                    createPin(
                        pinX=HoleWidth-FitTolerance
                        ,pinY=HoleLength-FitTolerance
                        ,height=thickness+FitTolerance);
            }
            if (HookLocation==1) { // hook on backside
                // cube for bottom half
                translate([0,length-CableDia*1.5,thickness])
                    roundedRect([width,CableDia*1.5,CableDia*1.5/2],radius);
   
                translate([width/2,length,(HoleLength-FitTolerance)/2])
                    rotate([-90,0,0])createPin(
                        pinX=HoleWidth-FitTolerance
                        ,pinY=HoleLength-FitTolerance
                        ,height=thickness+FitTolerance);
            }
            
            if (AddAdhesionDisc==1){
                // create Adhesion helper disc
                translate([-width*.25,length-CableDia*0.5-0.5,0])roundedRect([width*1.5,width *0.75,0.15],radius);
            }
            
        }
            
        
    }
    // ========================the negatives
    
    //translate([width/2-PinSize/2,PinSize,-0.01])createHoles([PinSize+FitTolerance/2,PinSize+FitTolerance/2,width+1],count=HoleCount,distance=HoleDistance);
    translate([width/2-HoleWidth/2,HoleLength,-0.01])createHoles(
        [HoleWidth+FitTolerance/2
        ,HoleLength+FitTolerance/2
        ,thickness+1]
        ,count=HoleCount
        ,distance=HoleDistance);
    if (Style==2){
        translate([width/2-HoleWidth/2,length-radius,-0.01])
            createHoles(
                [HoleWidth+FitTolerance/2
                ,HoleLength+FitTolerance/2
                ,thickness+1]
                ,count=LoopEndCount
                ,distance=HoleDistance);
     }
     if (Style==3){
            // Cylinder for cable clipon
            translate([0,length-CableDia/2-CableDia/4,thickness+CableDia/2+CableDia/4])
                rotate([0,90,0])
                translate([0,0,-0.01])
                cylinder(r=CableDia/2,h=width+0.02);
          //cutout opening in cable clip
          translate([-0.01,length-CableDia/2-CableDia/4-0.5,-0.01])
            cube([width+0.02,1,CableDia+thickness]);
            
            
     }
       
}
module createHoles(size=[2,6,3], count=5,distance=5){
    _x=size[0];
    _y=size[1];
    _z=size[2];
    
    echo("X=",_x);
    echo("Y=",_y);
    echo("Z=",_z);
    for ( i = [0 : count-1] ){
        translate([0,(_y+distance)*i,0])cube(size);
        
    }
}

module createPin(pinX=2,pinY=4,pinSize=2,height=5){
    translate([0,0,height/2])cube([pinX,pinY,height],center=true);
    
PinOverhang=1.1;//height/1.5;
PinOverhangHeight=1.5;//height/1;
CubePoints = [
  [  0,  0,  0 ],  //0
  [ pinX,  0,  0 ],  //1
  [ pinX,  pinY,  0 ],  //2
  [  0,  pinY,  0 ],  //3
  [  0,  -PinOverhang,  PinOverhangHeight ],  //4
  [ pinX,  -PinOverhang,  PinOverhangHeight ],  //5!
  [ pinX,  pinY-PinOverhang,  PinOverhangHeight /2],  //6!
  [  0,  pinY-PinOverhang,  PinOverhangHeight /2]]; //7
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
    translate([-pinX/2,-pinY/2,height])polyhedron( CubePoints, CubeFaces );
 
}

module roundedRect(size, radius)
{
    x = size[0];
    y = size[1];
    z = size[2];
    r=(radius==0?0.01:radius);
    linear_extrude(height=z)
    hull()
    {
        translate([r, r, 0])
        circle(r=r);
    
        translate([x-r,r, 0])
        circle(r=r);
        
        translate([x-r,y-r, 0])
        circle(r=r);
        
        translate([r,y-r, 0])
        circle(r=r);
    }
}
