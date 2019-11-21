/*//////////////////////////////////////////////////////////////////
//Author: Konkop (Bryon Wheeler)
//Curtain rod ends for angled walls
//all settings in mm
//////////////////////////////////////////////////////////////////

10/01/2015 - Designed and printed 
12/31/2016 - Made configurable

*/

////////// - Curtain Rod parameters - /////////////

//to print left, right or middle go to the bottom
/* [Curtain Rod dimensions] */
// Rod Inner Diameter
  RodInnerD        = 20.23;  
// Rod Outer Diameter   
  RodOuterDiam = 26; 
// Base Height   
  baseHeight = 5; 
// Rod Distance from the Wall   
  RodDistFromWall = 40; 
// Screw Diameter   
  screwDiam = 5; 
// String Hole Diameter   
  stringholeDiam = 5; 
// Center Mount Thickness   
cntrMntThickness = 10;


//Quality Settings
$fn = 0;
$fa = 1;
$fs = .2;

module rodend(CutStringHole,PoletoLeft){
    //Arm plus string hole
    difference(){
        //arm
        //cylinder(RodInnerD+RodDistFromWall,d = RodInnerD);
        translate([0,0,(RodInnerD+RodDistFromWall)/2])
        cube([RodInnerD,RodInnerD,RodInnerD+RodDistFromWall],true);

        //string hole
        if(CutStringHole==true){
            rotate([90,0,0])
            translate([0,baseHeight+((RodDistFromWall-baseHeight) /2),-RodInnerD/2])
            union(){
                cylinder(RodInnerD*5,d = stringholeDiam);
                cylinder(stringholeDiam*1,d=stringholeDiam*3,d2=stringholeDiam);
                translate([0,0,RodInnerD])
                rotate([0,180,0])
                cylinder(stringholeDiam*1,d=stringholeDiam*3,d2=stringholeDiam);
            }
        }
    }


    //Rod holder
    translate([0,0,RodInnerD/2+RodDistFromWall])
    rotate([90,0,0])
    cylinder(RodInnerD*3,d = RodInnerD);



    //base
    difference(){
        difference(){
            cylinder(baseHeight, d=RodInnerD * 2.7);
            
            if(PoletoLeft==true){
            //Pole to left
                translate([RodInnerD*.5,-RodInnerD*1.5,0])
                cube([RodInnerD,RodInnerD * 4,5],false);
            }else{
            //pole to the right
                translate([-RodInnerD*1.5,-RodInnerD*1.5,0])
                cube([RodInnerD,RodInnerD * 4,5],false);
            }
        }

        //screw holes 
        union(){
            translate([RodInnerD*.8,0,0])
            cylinder(baseHeight,d=screwDiam,d=screwDiam);
            
            translate([RodInnerD*-.8,0,0])
            cylinder(baseHeight,d=screwDiam,d=screwDiam);

            
            translate([0,RodInnerD*.8,0])
            cylinder(baseHeight,d=screwDiam,d=screwDiam);
        }
    }
}

module centermount(){
    //base plate
    difference(){
        translate([-RodOuterDiam*.4,0,0])
        cube([RodOuterDiam*2.8,cntrMntThickness,baseHeight]);

        union(){
        translate([-RodOuterDiam*.2,cntrMntThickness/2,0])
        cylinder(baseHeight,d=screwDiam,d=screwDiam,false);
            
        translate([RodOuterDiam*2.2,cntrMntThickness/2,0])
        cylinder(baseHeight,d=screwDiam,d=screwDiam,false);
        }
    }

    //pole holder
    difference(){
    difference(){
        hull(){
            cube([RodOuterDiam*2,cntrMntThickness,baseHeight]);


            translate([RodOuterDiam/1.3,cntrMntThickness,RodDistFromWall+RodOuterDiam])
            rotate([90,0,0])
            cylinder(cntrMntThickness,d = RodOuterDiam+baseHeight*3);
         
        }
        
        
        translate([RodOuterDiam/1.3,cntrMntThickness+1,RodDistFromWall+RodOuterDiam])
        rotate([90,0,0])
        cylinder(cntrMntThickness*1.5,d = RodOuterDiam); 
    }

    translate([baseHeight,0,RodDistFromWall+RodOuterDiam-baseHeight])
    cube([cntrMntThickness,cntrMntThickness,cntrMntThickness]);
    }
}

//right side rod
translate([1,0,(RodInnerD/2)])
rotate([0,90,0])
rodend(false,true);

//left side rod
translate([-1,0,(RodInnerD/2)])
rotate([0,-90,0])
rodend(false,false);

//Center mount
translate([-25,-40,0])
centermount();