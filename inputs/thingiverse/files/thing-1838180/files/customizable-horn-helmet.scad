//Built-in constant that controlls the number of polygons
$fn=120;
//Diameter of the bowl part of the helmet
helmetD=60;
helmetR=helmetD/2;
//Width of the bands on the top of the helmet, around the base, and around the horns.
bandWidth=8;
//How far the bands raise from the surface
bandThickness=.2;
//Radius of the bumps along the bands
rivetSize = 1;
//Radius of the lips on the sides of the bands
bandBorderSize = 1;

//The horns follow a spiral shape. This controls the starting radius.
hornCurveMaxRadius = 30;
//This controls the end radius.
hornCurveMinRadius = 25;
//How much of a curve the helmet has. 1 is a full circle
hornCurveAmount = .3;
//Depth of the spiral the horn follows. 0 is a flat spiral
hornCurveHeight = 3;
//Starting thickness of the horn
hornMaxThickness = 8;
//Ending thickness of the horn
hornMinThickness = 0;
//Number of segments that make up the horn
hornCurveStages = 60;
//Position of the horns on the helmet
hornPosition = 20;
//Makes the horns tilt forward or backward
hornAngle = 10;  
//Hollows out the helmet, 
hollow=true;
//Thickness of the helmet, if hollow.
wallThickness = 2;
//cuts off part of bottom band for more build platform contact.
flatBottom=true;
    
/*
sin(a)=opp/hyp
a=asin(opp/hyp)
tan(a)=opp/adj

x^2+y^2=r^2
y^2=r^2-x^2
y=sqrt(r^2-x^2);
*/

difference(){
rotateCopy([0,0,90]){
rotate([90,0,0]){
cylinder(r=helmetR+bandThickness,h=bandWidth,center=true);
}}

translate([0,0,-helmetR])
cube([helmetD+bandThickness*2+1,helmetD+bandThickness*2+1,helmetD],center=true);
if(hollow==true){
        sphere(r=helmetR-wallThickness);
        
    }
}

for(i=[(360/24):360/24:360]){
    rotate(i)
    translate([helmetR+bandThickness,0,-bandWidth/2])
    sphere(r=rivetSize);
}


//rivets on top
rotateCopy([0,0,90])
for(i=[(360/24):360/24:180-360/24]){
    rotate([i,0,0])
    translate([0,helmetR+bandThickness,0])
    sphere(r=rivetSize);
}


//top band
rotate_extrude()
translate([helmetR+bandThickness,0,0])
rotate([0,0,90])
circle(r=bandBorderSize);

//bottom
difference(){
translate([0,0,-bandWidth]){
rotate_extrude()
translate([helmetR+bandThickness,0,0])
rotate([0,0,90])
circle(r=bandBorderSize);}

if(flatBottom==true){
translate([0,0,-helmetR-bandBorderSize-bandWidth])
cube([helmetD+4*bandBorderSize,helmetD+4*bandBorderSize,helmetD+2*bandBorderSize],center=true);
}

}



//middle part of band
difference(){
    translate([0,0,-bandWidth])
    cylinder(r=helmetR+bandThickness,h=bandWidth);

    if(hollow==true){
        translate([0,0,-bandWidth-1])
        cylinder(r=helmetR-wallThickness,h=bandWidth+2);
        
        
    }


}

mirrorCopy([0,1,0])
mirrorCopy([1,0,0]){

//the corner where the edges of the bands meet
difference(){
    intersection(){
        translate([bandWidth/2,0,0])
        rotate([90,0,90])
        band();
        
        translate([0,bandWidth/2,0])
        rotate([90,0,0])
        band();
        
        
    }
      //cuts off bottom
        translate([0,0,-helmetD])
        cube([helmetD*2,helmetD*2,helmetD*2],center=true);
}
difference(){
union(){
mirror([1,0,0])
rotate(90)
bandPart();
bandPart();
}
if(hollow==true){
        sphere(r=helmetR-wallThickness);
        
    }
}
}

module bandPart(){
    difference(){
            //puts band in position
            translate([bandWidth/2,0,0])
            rotate([90,0,90])
            band();

            //cuts off side
            translate([0,-helmetD+bandWidth/2,-1])
            cube([helmetD,helmetD,helmetD]);
        
            //cuts off bottom
            translate([0,0,-helmetD])
            cube([helmetD*2,helmetD*2,helmetD*2],center=true);
    }
}



module band(){
rotate_extrude()
translate([sqrt(pow(helmetR,2)-pow(bandWidth/2,2)),0,0])
rotate([0,0,90])
circle(r=bandBorderSize);
}


difference(){
sphere(r=helmetR);
translate([0,0,-helmetR/2-1])
cube([helmetD+1,helmetD+1,helmetR+2],center=true);
    if(hollow==true){
        sphere(r=helmetR-wallThickness);
        
    }
}

mirrorCopy([1,0,0])
rotate([-90+hornAngle,hornPosition,0])
rotate([0,0,90])
translate([-hornCurveMaxRadius,sqrt(pow(helmetR,2)-pow(hornMaxThickness/2,2)    )+bandWidth,0])
union(){
horn(
r1 = hornCurveMaxRadius,
r2 = hornCurveMinRadius,
   
rotations = hornCurveAmount,
height = hornCurveHeight,
stages = hornCurveStages,
subR1 = hornMaxThickness,
subR2 = hornMinThickness);


for(i=[360/12:360/12:360]){
    translate([hornCurveMaxRadius,-bandWidth/2,0])
    rotate([0,i,0])
    translate([0,0,hornMaxThickness+bandThickness])
    sphere(r=rivetSize); 
}


//horn coupler band
translate([hornCurveMaxRadius,0,0])
rotate([90,0,0])
cylinder(r=hornMaxThickness+bandThickness,h=bandWidth);

//ring where horn meets helmet
translate([hornCurveMaxRadius,-bandWidth,0])
rotate([90,0,0])
rotate_extrude()
translate([hornMaxThickness,0,0])
circle(r=bandBorderSize);

//ring at base of horn
translate([hornCurveMaxRadius,0,0])
rotate([90,0,0])
rotate_extrude()
translate([hornMaxThickness,0,0])
circle(r=bandBorderSize);

}




module horn(r1 = 30,
r2 = 10,
rotations = .8,
height = 50,
stages = 60,
subR1 = 5,
subR2 = 1){

stepSize = rotations*360/stages;
endDegree = rotations*360 - 1*stepSize;
for(i=[0:stepSize:endDegree]){
    
    
    hull(){
    rotate(i)
    translate([rFromDegree(i),0,zFromDegree(i)])
    disc(r=subRFromDegree(i));
    
    rotate(i+stepSize)
    translate([rFromDegree(i+stepSize),0,zFromDegree(i+stepSize)])
    disc(r=subRFromDegree(i+stepSize));
    }
    
    
}

function rFromDegree(degree)= 
    let(
        totalDegrees = 360*rotations,
        percentOfRotation = degree/totalDegrees,
        displacement = (r1-r2)*percentOfRotation,
        currentR = r1-displacement
    )currentR;
    
function subRFromDegree(degree)= 
    let(
        totalDegrees = 360*rotations,
        percentOfRotation = degree/totalDegrees,
        displacement = (subR1-subR2)*percentOfRotation,
        currentR = subR1-displacement
    )currentR;

function zFromDegree(degree)=
    let(
        totalDegrees = 360*rotations,
        percentOfRotation = degree/totalDegrees,
        currentZ = height*percentOfRotation
    )currentZ;
    
module disc(r=1){
    
    rotate([90,0,0])
    linear_extrude(.0001)
    circle(r=r);  
}
   }

module mirrorCopy(vector){
   children();
    mirror(vector)
    children();
   
} 
module rotateCopy(vector){
    children();
    rotate(vector)
    children();
}