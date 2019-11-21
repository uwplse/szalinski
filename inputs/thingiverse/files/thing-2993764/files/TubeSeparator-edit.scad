
//Number of tubes to hold
tubeCount = 3;
//Diameter of tubes it will hold
tubeDiameter = 4.7625;
//Distance between each tube
tubeSeparation = 19;
//Wall thickness used for the clips
clipThickness = 2;  
//Determines how easy it is to insert or remove the cable.  190-330 are pragmatic limits
EnclosedAngle = 260;  
$fs=.5;
$fa=20;


//NOTE:Multiplying by 1 prevents values from being editable in Thingiverse customizer.
$in=25.4*1;
$demoMode = 0*1;
//Originally for 3/16 brake tube, parametric for any parrallel cables or tubes
if ($demoMode>0){
    vals=[
            [tubeCount, tubeDiameter, tubeSeparation, clipThickness],
            [2, 3/16*$in, 1.5*$in, 1.6], 
            [2, 3/16*$in, 2*$in], 
            [3, .19*$in, .5*$in], 
            [4, 5/16*$in, 3/4*$in], 
            [4, 5/16*$in, 3/4*$in], 
            [4, 7/16*$in, 3/4*$in]
            ];
    for(i=[0:len(vals)-1])
        translate([0,30*i,0])
            TubeSeparator(vals[i][0], vals[i][1], vals[i][2], len(vals[i]>3)?vals[i][3]:2);
} else
    TubeSeparator(tubeCount, tubeDiameter, tubeSeparation, clipThickness);


module TubeSeparator(tubes, diameter, separation, wallThickness=2){
    height=6;
    intersection(){
        //NOTE: rounded with bit of flatness on base for printing without supports
        translate([-separation,-diameter,-.75] )
            cube([(separation+diameter)*tubes, diameter*2, height]);
        union(){
            //Clips
            for(i=[0:tubes-1])
                translate([separation*i,0,0])
                    TubeClip(diameter, height, wallThickness);
            //Center rib
            for(i=[1:tubes-1])
                translate([ (i-.5)*separation,0,height/2-.75])
                    cube([separation-diameter-wallThickness,wallThickness,height], center=true);
        
            //Back rib
            translate([0,-diameter/2-wallThickness,-.75])
                translate([0,1,wallThickness/2-.25])
                minkowski(){
                    cube([separation*(tubes-1), wallThickness<=2 ? .001: wallThickness-2, height-1.75]);
                    sphere(1);
                }
        }
    }

}

module TubeClip(diameter, height, wallThickness){
    rotate([0,0,(360-EnclosedAngle)/2 + 90])
        minkowski() {
            rotate_extrude2(angle=EnclosedAngle, convexity=5)
                translate([diameter/2+ wallThickness/2,0,-.25])
                    square([.01, height-wallThickness+.25]);
            sphere(wallThickness/2);
        }
}

// older versions of OpenSCAD do not support "angle" parameter for rotate_extrude
// this module provides that capability even when using older versions (such as thingiverse customizer)
module rotate_extrude2(angle, convexity, size=3000) {

    module angle_cut(angle=90,size=1000) {
        x = size*cos(angle/2);
        y = size*sin(angle/2);
        translate([0,0,-size])
        linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
    }

    // support for angle parameter in rotate_extrude was added after release 2015.03
    // Thingiverse customizer is still on 2015.03
        rotate([0,0,angle/2]) difference() {
            rotate_extrude(convexity=convexity) children();
            angle_cut(angle, size);
        }
}

