// Created by TheVisad @ HNGamers 

// These options allow you to build an assembly
// Minimum needed is 0.02 to ensure properly punched holes. 
holeCreationOffset=0.05; 
//Whether to enable the creation of the carraige assembly (use this to create individual parts)
createcarraigeassembly=0; //[0:1]
//Whether to enable a 3 or 4 wheel gantry system 
enableFourWheels= 1; //[0:1]
// Whether to enable the fake bearing in the assembly (visual only)
enableBearing=1; //[0:1]
//Whether to enable the fake wheel in the assembly
enableWheel=1; //[0:1]
//Whether the wheel system should use Misumi rail style wheels (pending)
enableMisumiWheel= 0; //[0:1]
//Whether to enable the fake extrusion in the assembly or for printing
enableFakeExtrusion= 1; //[0:1]
//Whether to enable the gantry plate for printing purposes
enableGantryPlate=1; //[0:1]
//Whether to enable the captive nuts in the gantry plate for mounting purposes
enableGantryPlateRecessedNuts=1; //[0:1]
//Whether to enable the offset gantry plate similar to OpenBuilds designs (pending)
enableOffsetGantry=0; //[0:1]
//Whether to enable the wheel spacers for the assembly (visual only)
enableSpacers=1; //[0:1]
//Whether to enable the wheel bolts in the assembly (visual only)
enableSpacerBolts=1; //[0:1]
//Whether to enable the eccentric spacers in the assembly (not recommended to be used in place of steel spacers)
enableEccentricSpacers=1; //[0:1]
//Whether to enable the spacers in the assembly (not recommended to be used in place of steel spacers)
enableWheelSpacers=1; //[0:1]
//Whether to enable Misumi extrusion or Open V extrusion
enableVExtrusion=1; //[0:1]
//Whether to enable Open V Rails for attaching to Misumi extrusion
enableOpenBuildsVRail=1; // [0:1]

//These options allow you to build the units individually
//This option allows the building of one vrail
enableOpenBuildsVRailBuild=0; // [0:1]
//This option allows the building of one wheel spacer
enableWheelSpacersBuild=0; // [0:1]
//This option allows the building of one eccentric spacer
enableEccentricSpacersBuild=0; // [0:1]
//This option allows the building of one spacer bolt
enableSpacerBoltsBuild=0; // [0:1]
//This option allows the building of one standard spacer
enableSpacersBuild=0; // [0:1]
//This option allows the building of one extrusion (use with enableVExtrusion to switch between extrusion types)
enableFakeExtrusionBuild=0; // [0:1]
//This option allows the building of one gantry plate
enableGantryPlateBuild=1; // [0:1]
//This option allows the building of one wheel
enableWheelBuild=0; // [0:1]
//This option allows the building of one bearing (fake)
enableBearingBuild=0; // [0:1]

//M3 Nut diameter from point to point
m3NutDiameter=6.01;
//M3 Nut height 
m3NutHeight=2.4;
//The amount of offset to apply to system for using Misumi rail systems
misumiWheelOffset=.75;
// The diameter of the recessed hole for the bolts to allow them to sit down into the gantry. This needs enough room to swivel around the axis to allow tigheting the wheel.
recessedEccentricBoltholeDiameter=12;
// The diameter of the recessed hole for the bolts to allow them to sit down into the gantry. This is the stationary wheel. 
recessedBoltholeDiameter=10.10;
//This is the inner diameter of the eccentricSpacer's insert.
eccentricSpacerIDDiameter=5;
//This is the outer diameter of the eccentricSpacer's insert.
eccentricSpacerODDiameter=7.14;
//This is the height of the eccentricSpacer's insert.
eccentricSpacerHeight=2.50;
//This is the offset from center for the eccentric nut
eccentricOffset=0.79;
// The Diameter of the slanted upper portion of the wheel. mini:12.21, standard:18.75
bearingShelf=12.21;
//Bearing OD mini:10,standard:16
bearingOD=10;
//Bearing ID mini:5,standard:5
bearingID=5;
//How tall the bearing is mini:4.2,standard:5
bearingHeight=4.2;
//The wheels OD mini:15.23,standard:23.90
wheelOD=15.28;
//The wheels ID mini:9.974,standard:16
wheelID=9.974;
//mini:8.8,standard:10.23
wheelHeight=9;
// The interior raised portion of the wheel that rides inside the track mini:5.78,standard:5.89
wheelShoulderThickness=5.78;
// The diameter of the low profile screw head for the carraige wheel mounts
m5LowProfileScrewHeadDiameter=9.2;
// The diameter of the low profile screw for the carraige wheel mounts
m5LowProfileScrewScrewDiameter=5;
// The height of the low profile screw head for the carraige wheel mounts
m5LowProfileScrewHeadHeight=1.5;
// The length of the low profile screw for the carraige wheel mounts
m5LowProfileScrewLength=25;
// Bolt hole sizes for the belt or delta carraige connector
carraigePlateMount=20;
// The width of the extrusion, currently only works with standard rails.
extrusionWidth=20; 
// How long the fake extrusion is
extrusionLength=200;
// The gap inside the extrusion, this is where the wheel rides
extrusionGap=6;
// How thick the carraie mount is 
gantryThickness=8;
// The radius of the bolt holes for the carraige mount
boltHolesRadius=1.35;
// The radius of the bolt holes for the wheel mount
wheelHolesRadius=1.2;
// How hight the spacer is
spacerHeight=6;
// The spacers OD 
spacerOD=10;
// The spacers ID
spacerID=5.1;
// Not recommended to change this as this is the data for the wheels
numberOfSides=360;


//Change nothing under this, these are adjustments and settings that make sure all the sizes are properly configured. Changing these settings could lead to the articles not working properly.

//Width of the VRail
openVrailWidth=19.529;
openVrailLength=extrusionLength;
openVrailHeight=2.375;
openVrailLipWidth=4.790;
openVrailLipLength=extrusionLength;
openVrailLipHeight=2.967;
openVRailHoleWidth=5;
openVRailHoleHeight=11;
openVRailHoleCenter=50;
m3NutRadius=m3NutDiameter/2;
extrusionVDepthOffset=1.3;
bearingODRadius=bearingOD/2;
bearingIDRadius=bearingID/2;
bearingShelfRadius=bearingShelf/2;
wheelFudge = 1/cos(180/360);
wheelBearingOffset=(wheelHeight-(bearingHeight*2))/2;
wheelShoulderOffset=wheelOD-bearingShelf;
wheelODRadius=wheelOD/2;
wheelIDRadius=wheelID/2;
spacerODRadius=spacerOD/2;
spacerIDRadius=spacerID/2;
eceentricSpacerInsertODRadius=eccentricSpacerODDiameter/2;
eceentricSpacerInsertIDRadius=eccentricSpacerIDDiameter/2;
m5LowProfileScrewHeadRadius=m5LowProfileScrewHeadDiameter/2;
m5LowProfileScrewScrewRadius=m5LowProfileScrewScrewDiameter/2;
wheelXOffset=15.9;
wheelYOffset=15;
carraigeWidth=(wheelODRadius * 2) + (extrusionWidth * 1.5) + 2;
carraigeHeight=(wheelODRadius * 2) + (extrusionWidth * 1.5) + 2;
variableone = extrusionLength / openVRailHoleCenter;
vwheeloffset=(extrusionWidth /2) + (openVrailLipWidth/2);

module vrail(){
    difference(){
        union(){
            cube([openVrailWidth, openVrailLength, openVrailHeight], center=true);
            //translate([0,0,0]) cube([openVrailWidth, openVrailLength, openVrailLipWidth], center=true);
            //translate([(openVrailWidth/2) + (openVrailHeight/2),0,-1.125]) rotate(a=90, v=[1,0,0]) cylinder_outer(extrusionLength ,openVrailHeight/2 + .20,3); 
            difference(){
                translate([(openVrailWidth/2) + (openVrailHeight/2) + .25,0,-1.125]) cube([openVrailLipHeight, openVrailLipLength, openVrailLipWidth], center=true);
                translate([(openVrailWidth/2) + (openVrailHeight/2),0,-4.4]) rotate(a=45, v=[0,1,0])  cube([openVrailLipHeight, openVrailLipLength + holeCreationOffset, openVrailLipWidth * 2], center=true);
                translate([(openVrailWidth/2) + (openVrailHeight/2),0,2.08]) rotate(a=-45, v=[0,1,0])  cube([openVrailLipHeight, openVrailLipLength + holeCreationOffset, openVrailLipWidth * 2], center=true);
            }
        }
        translate([(openVrailWidth/2) + openVrailHeight * 1.9,0,-.875]) cube([openVrailHeight , extrusionLength+ holeCreationOffset, openVrailHeight*2], center=true);

        for ( variableone = [1 : variableone] ) 
        {

         echo (variableone);
           if (variableone == 1){
               variablethree=openVRailHoleCenter-25;
               echo (variablethree);
               translate([0,-(extrusionLength/2) + variablethree,0]) roundCornersCube(openVRailHoleHeight,openVRailHoleWidth,openVrailHeight + holeCreationOffset,3);
           } else {
               variablethree=variableone*openVRailHoleCenter-25;
               echo (variablethree);
               translate([0,-(extrusionLength/2) +variablethree,0])roundCornersCube(openVRailHoleHeight,openVRailHoleWidth,openVrailHeight + holeCreationOffset,3);
           }
        }
    }
}


module extrusion(){
    interiorHeight=0;
    interiorShelfHeight=0;
    interiorShelfWidth=0;
    interiorVWidthLower=5.68;
    interiorVWidthLowerWidth=4;
    interiorVWidthLowerHeight=5.68;
    interiorVThickness=1.8;
    interiorVLipOverHang=2.113;
    interiorVWidthUpper=6.773 + 1.8;
    interiorVWidth=6.773 + 2.113 + 2.113;
    interiorVLipHeight=1.639;
    holeRadius=2.1;
    angleVRail=90;
    interiorVRecess=10-interiorVThickness;
    interiorVWidthTest=(10-4.51) * 2;
    interiorOffset=(20-7.64)/2 +.4;
    interiorHoleOffset=(20-7.64)/2 +1.6;
    misumiInteriorLipHeight=.2;
    misumiInteriorLipWidth=13;
    interiorMisumiRecess=10-2;
    misumiInteriorOffset=((20-8)/2);
    misumiRailCutoutOffset=-.75;
        
        if (enableVExtrusion==1){
                union(){
                    difference(){
                    cube([extrusionWidth, extrusionLength, extrusionWidth], center=true);
                    hull() union(){
                        translate([-(interiorVThickness/2) + (interiorOffset) ,0,0]) cube([interiorVWidthLowerWidth/2, extrusionLength +holeCreationOffset , interiorVWidthLowerHeight], center=true);
                        translate([interiorVRecess,0,0]) cube([interiorVLipHeight, extrusionLength +holeCreationOffset , interiorVWidthTest], center=true); //right cutout
                    }
                    hull() union(){
                        translate([(interiorVThickness/2) - interiorOffset,0,0]) cube([interiorVWidthLowerWidth/2, extrusionLength +holeCreationOffset, interiorVWidthLowerHeight], center=true);
                        translate([-interiorVRecess,0,0]) cube([interiorVLipHeight, extrusionLength +holeCreationOffset,interiorVWidthTest ], center=true);//left cutout
                    }
                    hull() union(){
                        translate([0,0,-(interiorVThickness/2) + interiorOffset]) cube([interiorVWidthLowerHeight, extrusionLength +holeCreationOffset, interiorVWidthLowerWidth/2], center=true);
                        translate([0,0,interiorVRecess]) cube([interiorVWidthTest, extrusionLength +holeCreationOffset, interiorVLipHeight], center=true);//top cutout
                    } 
                    hull() union(){
                        translate([0,0,(interiorVThickness/2) - interiorOffset ]) cube([interiorVWidthLowerHeight, extrusionLength +holeCreationOffset, interiorVWidthLowerWidth/2], center=true);
                        translate([0,0,-interiorVRecess]) cube([interiorVWidthTest, extrusionLength +holeCreationOffset, interiorVLipHeight], center=true);//bottom cutout
                    }
                 
                    rotate(a=45, v=[0,1,0]) translate([-(interiorVThickness/2) - interiorVWidthLower - interiorVThickness,0,-(interiorVThickness/2) - interiorVWidthLower - interiorVThickness]) cube([interiorVWidthUpper, extrusionLength +holeCreationOffset , interiorVWidthUpper], center=true);
                    rotate(a=45, v=[0,1,0]) translate([(interiorVThickness/2) + interiorVWidthLower + interiorVThickness,0,-(interiorVThickness/2) - interiorVWidthLower - interiorVThickness]) cube([interiorVWidthUpper, extrusionLength +holeCreationOffset , interiorVWidthUpper], center=true);

                    rotate(a=45, v=[0,1,0]) translate([-(interiorVThickness/2) - interiorVWidthLower - interiorVThickness,0,(interiorVThickness/2) + interiorVWidthLower + interiorVThickness]) cube([interiorVWidthUpper, extrusionLength +holeCreationOffset , interiorVWidthUpper], center=true);

                    rotate(a=45, v=[0,1,0]) translate([(interiorVThickness/2) + interiorVWidthLower + interiorVThickness,0,(interiorVThickness/2) + interiorVWidthLower + interiorVThickness]) cube([interiorVWidthUpper, extrusionLength +holeCreationOffset , interiorVWidthUpper], center=true);
                rotate(a=90, v=[1,0,0]) translate([interiorHoleOffset,interiorHoleOffset,0]) cylinder_outer(extrusionLength +holeCreationOffset,.75,4); 
                rotate(a=90, v=[1,0,0]) translate([-interiorHoleOffset,interiorHoleOffset,0]) cylinder_outer(extrusionLength +holeCreationOffset,.75,4);   
                rotate(a=90, v=[1,0,0]) translate([interiorHoleOffset,-interiorHoleOffset,0]) cylinder_outer(extrusionLength +holeCreationOffset,.75,4);   
                rotate(a=90, v=[1,0,0]) translate([-interiorHoleOffset,-interiorHoleOffset,0]) cylinder_outer(extrusionLength +holeCreationOffset,.75,4);    


                    rotate(a=[90,0,0]) cylinder_outer(extrusionLength +holeCreationOffset,holeRadius,180);
                    
                    }
            }
        } else {
        
        difference(){
            cube([extrusionWidth, extrusionLength, extrusionWidth], center=true);
            
            hull(){
                translate([misumiInteriorOffset,0,0]) cube([extrusionGap/2, extrusionLength + holeCreationOffset, extrusionGap], center=true); // Left Hole
                translate([interiorMisumiRecess,0,0]) cube([misumiInteriorLipHeight, extrusionLength +holeCreationOffset , misumiInteriorLipWidth], center=true); //Left cutout
            }
            translate([misumiInteriorOffset + 2,0,0]) cube([extrusionGap, extrusionLength + holeCreationOffset, extrusionGap], center=true); // Left Hole exterior cutout
            
            hull(){
                translate([-misumiInteriorOffset,0,0]) cube([extrusionGap/2, extrusionLength + holeCreationOffset, extrusionGap], center=true); //Right Hole
                translate([-interiorMisumiRecess,0,0]) cube([misumiInteriorLipHeight, extrusionLength +holeCreationOffset,misumiInteriorLipWidth ], center=true);//Right cutout
            }
            translate([-misumiInteriorOffset-2,0,0]) cube([extrusionGap, extrusionLength + holeCreationOffset, extrusionGap], center=true); //Right Hole exterior cutout
            hull(){
            
                translate([0,0,misumiInteriorOffset]) cube([extrusionGap, extrusionLength + holeCreationOffset, extrusionGap/2], center=true); //Top Hole
                translate([0,0,interiorMisumiRecess]) cube([misumiInteriorLipWidth, extrusionLength +holeCreationOffset, misumiInteriorLipHeight], center=true);//Top cutout 
                
            }
            translate([0,0,misumiInteriorOffset+2]) cube([extrusionGap, extrusionLength + holeCreationOffset, extrusionGap], center=true); //Top Hole exterior cutout
            hull(){
                translate([0,0,-misumiInteriorOffset]) cube([extrusionGap, extrusionLength + holeCreationOffset, extrusionGap/2], center=true);  //Bottom Hole
                translate([0,0,-interiorMisumiRecess]) cube([misumiInteriorLipWidth, extrusionLength +holeCreationOffset, misumiInteriorLipHeight], center=true);//Bottom cutout 
            }
            translate([0,0,-misumiInteriorOffset-2]) cube([extrusionGap, extrusionLength + holeCreationOffset, extrusionGap], center=true);  //Bottom Hole exterior cutout
            rotate(a=[90,0,0]) cylinder_outer(extrusionLength +holeCreationOffset,holeRadius,180);
            
            
        rotate(a=45, v=[0,1,0]) translate([-(interiorVThickness/2) - interiorVWidthLower - interiorVThickness + misumiRailCutoutOffset,0,-(interiorVThickness/2) - interiorVWidthLower - interiorVThickness +misumiRailCutoutOffset]) cube([interiorVWidthUpper, extrusionLength +holeCreationOffset , interiorVWidthUpper], center=true);
            
        rotate(a=45, v=[0,1,0]) translate([(interiorVThickness/2) + interiorVWidthLower + interiorVThickness - misumiRailCutoutOffset,0,-(interiorVThickness/2) - interiorVWidthLower - interiorVThickness + misumiRailCutoutOffset]) cube([interiorVWidthUpper, extrusionLength +holeCreationOffset , interiorVWidthUpper], center=true);

        rotate(a=45, v=[0,1,0]) translate([-(interiorVThickness/2) - interiorVWidthLower - interiorVThickness + misumiRailCutoutOffset,0,(interiorVThickness/2) + interiorVWidthLower + interiorVThickness - misumiRailCutoutOffset]) cube([interiorVWidthUpper, extrusionLength +holeCreationOffset , interiorVWidthUpper], center=true);

        rotate(a=45, v=[0,1,0]) translate([(interiorVThickness/2) + interiorVWidthLower + interiorVThickness - misumiRailCutoutOffset,0,(interiorVThickness/2) + interiorVWidthLower + interiorVThickness - misumiRailCutoutOffset]) cube([interiorVWidthUpper, extrusionLength +holeCreationOffset , interiorVWidthUpper], center=true);
        }
    } 
}


module eccentricSpacers(){
    difference(){
        union(){
            translate([0,0,0 ]) rotate(a=[0,0,90]) cylinder_outer(spacerHeight,spacerODRadius,6);
            translate([0,0,(spacerHeight/2) + (eccentricSpacerHeight/2) ]) rotate(a=[0,0,90]) cylinder_outer(eccentricSpacerHeight,eceentricSpacerInsertODRadius,numberOfSides); // insert
        }
        union(){
            
                translate([0,- eccentricOffset,eccentricSpacerHeight/2 ]) rotate(a=[0,0,90]) cylinder_outer(spacerHeight + eccentricSpacerHeight + holeCreationOffset,eceentricSpacerInsertIDRadius,numberOfSides);
                translate([0,- eccentricOffset,eccentricSpacerHeight/2 ]) rotate(a=[0,0,90]) cylinder_outer(spacerHeight + eccentricSpacerHeight + holeCreationOffset,eceentricSpacerInsertIDRadius,numberOfSides);

        }
    }
}

        
module spacerbolts(){
    union(){
    translate([0,0,0]) rotate(a=[0,0,90]) cylinder_outer(m5LowProfileScrewHeadHeight + m5LowProfileScrewLength,m5LowProfileScrewScrewRadius,numberOfSides);
        difference(){
        translate([0,0,(m5LowProfileScrewLength/2) + (m5LowProfileScrewHeadHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m5LowProfileScrewHeadHeight,m5LowProfileScrewHeadRadius,numberOfSides);
        translate([0,0,(m5LowProfileScrewLength/2) + m5LowProfileScrewHeadHeight]) rotate(a=[0,0,90]) cylinder_outer(m5LowProfileScrewHeadHeight + holeCreationOffset,m5LowProfileScrewHeadRadius / 4,6);
        }
    }
}

module gantryPlate(){
        if (enableOpenBuildsVRail==1 || enableVExtrusion==0){
            echo("true!");
            
            echo(wheelXOffset+misumiWheelOffset);
            echo(wheelYOffset+misumiWheelOffset);
        union() difference(){
            //translate([0,0,1 + (extrusionWidth/2) + (gantryThickness/2)]) cube([carraigeWidth, carraigeHeight, gantryThickness], center=true); 
            
            // the plate itself
            translate([0,0,0]) roundCornersCube(carraigeWidth, carraigeHeight, gantryThickness,3);
            
            if (enableOffsetGantry==1){
                // bolt holes for the delta carraige 
                translate([-carraigePlateMount/2,0,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([carraigePlateMount/2,0,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([0,-carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([0,carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);

                if (enableGantryPlateRecessedNuts==1)
                {
                    // recessed nut holes for the delta carraige mounting 
                    translate([-carraigePlateMount/2,0,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([carraigePlateMount/2,0,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([0,-carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([0,carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);

                }
            } else {

                // bolt holes for the delta carraige 
                translate([-carraigePlateMount/2,-carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([-carraigePlateMount/2,carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([carraigePlateMount/2,-carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([carraigePlateMount/2,carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);

                if (enableGantryPlateRecessedNuts==1)
                {
                    // recessed nut holes for the delta carraige mounting 
                    translate([-carraigePlateMount/2,-carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([-carraigePlateMount/2,carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([carraigePlateMount/2,-carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([carraigePlateMount/2,carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);

                }       

            }
            
         //bolt holes for the wheels 
         translate([wheelXOffset+misumiWheelOffset,wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,m5LowProfileScrewScrewRadius,numberOfSides);
        translate([wheelXOffset+misumiWheelOffset,-wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,m5LowProfileScrewScrewRadius,numberOfSides);
        
         if (enableFourWheels==1){
             translate([-wheelXOffset-misumiWheelOffset,wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,m5LowProfileScrewScrewRadius,numberOfSides);
             translate([-wheelXOffset-misumiWheelOffset,-wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,m5LowProfileScrewScrewRadius,numberOfSides);
         } else {
             translate([-wheelXOffset-misumiWheelOffset,0,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,m5LowProfileScrewScrewRadius * 1.5,numberOfSides);
         }
         
         // recessed bolt holes for the wheels   
         translate([wheelXOffset+misumiWheelOffset,wheelYOffset,(gantryThickness/2)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness / 2,m5LowProfileScrewHeadRadius + holeCreationOffset,numberOfSides); // recessed bolt holes
        translate([wheelXOffset+misumiWheelOffset,-wheelYOffset,(gantryThickness/2)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness / 2,m5LowProfileScrewHeadRadius + holeCreationOffset,numberOfSides);// recessed bolt holes
         if (enableFourWheels==1){
             translate([-wheelXOffset-misumiWheelOffset,wheelYOffset,(gantryThickness/2)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness / 2,m5LowProfileScrewHeadRadius + holeCreationOffset+1.25,numberOfSides);//recessed hole
             translate([-wheelXOffset-misumiWheelOffset,-wheelYOffset,(gantryThickness/2)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness / 2,m5LowProfileScrewHeadRadius + holeCreationOffset+1.25,numberOfSides);//recessed hole
             
             //eccentric spacer holes
             translate([-wheelXOffset-misumiWheelOffset,wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,eceentricSpacerInsertODRadius,numberOfSides);
             translate([-wheelXOffset-misumiWheelOffset,-wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,eceentricSpacerInsertODRadius,numberOfSides);
         } else {
            translate([-wheelXOffset-misumiWheelOffset,0,1 + (extrusionWidth/2) + (gantryThickness)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness / 2,boltHolesRadius * 2,numberOfSides);
             
             //eccentric spacer holes
             translate([-wheelXOffset-misumiWheelOffset,0,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,eceentricSpacerInsertODRadius,numberOfSides);
             translate([-wheelXOffset-misumiWheelOffset,0,(gantryThickness/2)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness / 2,m5LowProfileScrewHeadRadius + holeCreationOffset+1.25,numberOfSides);
             
         }
         
            
        
        }
    } else {
              union() difference(){
            //translate([0,0,1 + (extrusionWidth/2) + (gantryThickness/2)]) cube([carraigeWidth, carraigeHeight, gantryThickness], center=true); 
            
            // the plate itself
            translate([0,0,0]) roundCornersCube(carraigeWidth, carraigeHeight, gantryThickness,3);
            if (enableOffsetGantry==1){
                // bolt holes for the delta carraige 
                translate([-carraigePlateMount/2,0,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([carraigePlateMount/2,0,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([0,-carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([0,carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);

                if (enableGantryPlateRecessedNuts==1)
                {
                    // recessed nut holes for the delta carraige mounting 
                    translate([-carraigePlateMount/2,0,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([carraigePlateMount/2,0,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([0,-carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([0,carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);

                }
            } else {

                // bolt holes for the delta carraige 
                translate([-carraigePlateMount/2,-carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([-carraigePlateMount/2,carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([carraigePlateMount/2,-carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);
                translate([carraigePlateMount/2,carraigePlateMount/2,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,boltHolesRadius,numberOfSides);

                if (enableGantryPlateRecessedNuts==1)
                {
                    // recessed nut holes for the delta carraige mounting 
                    translate([-carraigePlateMount/2,-carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([-carraigePlateMount/2,carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([carraigePlateMount/2,-carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);
                    translate([carraigePlateMount/2,carraigePlateMount/2,(-gantryThickness/2) + (m3NutHeight/2)]) rotate(a=[0,0,90]) cylinder_outer(m3NutHeight+ holeCreationOffset,m3NutRadius,6);

                }       

            }
         //bolt holes for the wheels 
         translate([wheelXOffset,wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,m5LowProfileScrewScrewRadius,numberOfSides);
        translate([wheelXOffset,-wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,m5LowProfileScrewScrewRadius,numberOfSides);
        
         if (enableFourWheels==1){
             translate([-wheelXOffset,wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,m5LowProfileScrewScrewRadius,numberOfSides);
             translate([-wheelXOffset,-wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,m5LowProfileScrewScrewRadius,numberOfSides);
         } else {
             translate([-wheelXOffset,0,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,m5LowProfileScrewScrewRadius * 1.5,numberOfSides);
         }

         // recessed bolt holes for the wheels   
         translate([wheelXOffset,wheelYOffset,(gantryThickness/2)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness ,recessedBoltholeDiameter/2 ,numberOfSides); // recessed bolt holes
       translate([wheelXOffset,-wheelYOffset,(gantryThickness/2)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness,recessedBoltholeDiameter /2  ,numberOfSides);// eccentric recessed bolt holes top right
         if (enableFourWheels==1){
             translate([-wheelXOffset,wheelYOffset,(gantryThickness/2)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness,recessedEccentricBoltholeDiameter/2,numberOfSides);//recessed hole
           translate([-wheelXOffset,-wheelYOffset,(gantryThickness/2)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness,recessedEccentricBoltholeDiameter/2,numberOfSides);//eccentric recessed bolt holes bottom right
             
             //eccentric spacer holes
             translate([-wheelXOffset,wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,eceentricSpacerInsertODRadius,numberOfSides);
             translate([-wheelXOffset,-wheelYOffset,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,eceentricSpacerInsertODRadius,numberOfSides);
         } else {
            translate([-wheelXOffset,0,1 + (extrusionWidth/2) + (gantryThickness)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness / 2,boltHolesRadius * 2,numberOfSides);
             
             //eccentric spacer holes
             translate([-wheelXOffset,0,0]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness + holeCreationOffset,eceentricSpacerInsertODRadius,numberOfSides);
             translate([-wheelXOffset,0,(gantryThickness/2)]) rotate(a=[0,0,90]) cylinder_outer(gantryThickness,m5LowProfileScrewHeadRadius + holeCreationOffset+ 1.25,numberOfSides);
             
         }
         
            
        
        }  
        
        
        }

}



module wheelspacers(){
    difference(){
         rotate(a=[0,0,90]) cylinder_outer(.5,spacerODRadius,numberOfSides);
        rotate(a=[0,0,90]) cylinder_outer(.5+ holeCreationOffset,spacerIDRadius,numberOfSides);
    }
}

module spacers(){
            difference(){
            rotate(a=[0,0,90]) cylinder_outer(spacerHeight,spacerODRadius,numberOfSides);
            rotate(a=[0,0,90]) cylinder_outer(spacerHeight+ holeCreationOffset,spacerIDRadius,numberOfSides);
        }
}



module bearings(){

        difference(){
            color([1,0,1]) cylinder_outer(bearingHeight,bearingODRadius,numberOfSides);
            color([1,0,1]) cylinder_outer(bearingHeight+holeCreationOffset,bearingIDRadius,numberOfSides);
        } //bearing top
}


module wheels(){
    
    if (enableMisumiWheel==1){
        
    } else {                
        if(enableOpenBuildsVRail==1){
            union(){
                difference(){
                    translate([0,0,wheelHeight/4]) hull() union(){
                        cylinder_outer(.25,wheelODRadius,numberOfSides);//wheel inner track
                        cylinder_outer(wheelHeight/2,bearingShelfRadius,numberOfSides);//wheel outer track
                    }

                    cylinder_outer((wheelHeight+holeCreationOffset),wheelIDRadius,numberOfSides); //Hole in the wheel
                }
                difference(){
                    translate([0,0,-wheelHeight/4])hull() union(){
                        cylinder_outer(.25,wheelODRadius,numberOfSides);//wheel inner track
                        cylinder_outer(wheelHeight/2,bearingShelfRadius,numberOfSides);//wheel outer track
                    }
                    cylinder_outer((wheelHeight+holeCreationOffset),wheelIDRadius,numberOfSides); //Hole in the wheel
                }
            }
        } else {
            difference(){
                hull() union(){
                    cylinder_outer(wheelShoulderThickness,wheelODRadius,numberOfSides);//wheel inner track
                    cylinder_outer(wheelHeight,bearingShelfRadius,numberOfSides);//wheel outer track
                }
                cylinder_outer((wheelHeight+holeCreationOffset),wheelIDRadius,numberOfSides); //Hole in the wheel
            }
        }
    }
    
}


module carraigeassembly(){

    if (enableWheel==1){
            if (enableFourWheels==1){
                if (enableVExtrusion==1){
                    translate([wheelXOffset ,wheelYOffset,0]) wheels();
                    translate([wheelXOffset ,-wheelYOffset ,0]) wheels();
                    translate([-wheelXOffset ,wheelYOffset,0]) wheels();
                    translate([-wheelXOffset,-wheelYOffset ,0]) wheels();
                } else {
                    if(enableOpenBuildsVRail==1){
                        translate([wheelXOffset + misumiWheelOffset,wheelYOffset ,  vwheeloffset ]) wheels();
                        translate([wheelXOffset + misumiWheelOffset,-wheelYOffset ,vwheeloffset]) wheels();
                        translate([-wheelXOffset - misumiWheelOffset,wheelYOffset ,vwheeloffset]) wheels();
                        translate([-wheelXOffset - misumiWheelOffset,-wheelYOffset ,vwheeloffset]) wheels();
                    } else {
                        translate([wheelXOffset + misumiWheelOffset,wheelYOffset,0]) wheels();
                        translate([wheelXOffset + misumiWheelOffset,-wheelYOffset ,0]) wheels();
                        translate([-wheelXOffset - misumiWheelOffset,wheelYOffset ,0]) wheels();
                        translate([-wheelXOffset - misumiWheelOffset,-wheelYOffset ,0]) wheels();
                    }
                }
            } else 
            {
                if (enableVExtrusion==1){
                    translate([wheelXOffset ,wheelYOffset,0]) wheels();
                    translate([wheelXOffset,-wheelYOffset,0]) wheels();
                    translate([0,-wheelYOffset,0]) wheels();
                } else {
                    if(enableOpenBuildsVRail==1){
                        translate([wheelXOffset + misumiWheelOffset ,wheelYOffset,vwheeloffset]) wheels();
                        translate([wheelXOffset + misumiWheelOffset ,-wheelYOffset ,vwheeloffset]) wheels();
                        translate([0,-wheelXOffset - misumiWheelOffset,vwheeloffset]) wheels(); 
                    } else {
                        translate([wheelXOffset + misumiWheelOffset ,wheelYOffset,0]) wheels();
                        translate([wheelXOffset + misumiWheelOffset ,-wheelYOffset ,0]) wheels();
                        translate([0,-wheelXOffset - misumiWheelOffset,0]) wheels();
                    }
                }
            }
    }
    
    if (enableBearing==1){
            if (enableOpenBuildsVRail==1 || enableVExtrusion==0){
                if(enableVExtrusion==0){
                                    echo ("true!!!");
            translate([wheelXOffset+ misumiWheelOffset,wheelYOffset,bearingHeight/2+wheelBearingOffset]) color([1,0,1]) bearings();
            translate([wheelXOffset+ misumiWheelOffset,wheelYOffset,-bearingHeight/2-wheelBearingOffset]) color([1,0,1]) bearings();
            translate([wheelXOffset+ misumiWheelOffset,-wheelYOffset,bearingHeight/2+wheelBearingOffset]) color([1,0,1]) bearings();
            translate([wheelXOffset+ misumiWheelOffset,-wheelYOffset,-bearingHeight/2-wheelBearingOffset]) color([1,0,1]) bearings();
            if (enableFourWheels==1){
                translate([-wheelXOffset- misumiWheelOffset,wheelYOffset,bearingHeight/2+wheelBearingOffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset- misumiWheelOffset,wheelYOffset,-bearingHeight/2-wheelBearingOffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset- misumiWheelOffset,-wheelYOffset,bearingHeight/2+wheelBearingOffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset- misumiWheelOffset,-wheelYOffset,-bearingHeight/2-wheelBearingOffset]) color([1,0,1]) bearings();
            } else {
                translate([-wheelXOffset- misumiWheelOffset,0,bearingHeight/2+wheelBearingOffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset- misumiWheelOffset,0,bearingHeight/2-wheelBearingOffset]) color([1,0,1]) bearings();
            }
                    } else {
                echo ("true!!");
            translate([wheelXOffset+ misumiWheelOffset,wheelYOffset,bearingHeight/2+wheelBearingOffset + vwheeloffset]) color([1,0,1]) bearings();
            translate([wheelXOffset+ misumiWheelOffset,wheelYOffset,-bearingHeight/2-wheelBearingOffset+ vwheeloffset]) color([1,0,1]) bearings();
            translate([wheelXOffset+ misumiWheelOffset,-wheelYOffset,bearingHeight/2+wheelBearingOffset+ vwheeloffset]) color([1,0,1]) bearings();
            translate([wheelXOffset+ misumiWheelOffset,-wheelYOffset,-bearingHeight/2-wheelBearingOffset + vwheeloffset]) color([1,0,1]) bearings();
            if (enableFourWheels==1){
                translate([-wheelXOffset- misumiWheelOffset,wheelYOffset,bearingHeight/2+wheelBearingOffset +vwheeloffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset- misumiWheelOffset,wheelYOffset,-bearingHeight/2-wheelBearingOffset +vwheeloffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset- misumiWheelOffset,-wheelYOffset,bearingHeight/2+wheelBearingOffset +vwheeloffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset- misumiWheelOffset,-wheelYOffset,-bearingHeight/2-wheelBearingOffset +vwheeloffset]) color([1,0,1]) bearings();
            } else {
                translate([-wheelXOffset- misumiWheelOffset,0,bearingHeight/2+wheelBearingOffset +vwheeloffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset- misumiWheelOffset,0,-bearingHeight/2-wheelBearingOffset + vwheeloffset]) color([1,0,1]) bearings();
            }
        }
        } else {
            translate([wheelXOffset,wheelYOffset,bearingHeight/2+wheelBearingOffset]) color([1,0,1]) bearings();
            translate([wheelXOffset,wheelYOffset,-bearingHeight/2-wheelBearingOffset]) color([1,0,1]) bearings();
            translate([wheelXOffset,-wheelYOffset,bearingHeight/2+wheelBearingOffset]) color([1,0,1]) bearings();
            translate([wheelXOffset,-wheelYOffset,-bearingHeight/2-wheelBearingOffset]) color([1,0,1]) bearings();
            if (enableFourWheels==1){
                translate([-wheelXOffset,wheelYOffset,bearingHeight/2+wheelBearingOffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset,wheelYOffset,-bearingHeight/2-wheelBearingOffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset,-wheelYOffset,bearingHeight/2+wheelBearingOffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset,-wheelYOffset,-bearingHeight/2-wheelBearingOffset]) color([1,0,1]) bearings();
            } else {
                translate([-wheelXOffset,0,bearingHeight/2+wheelBearingOffset]) color([1,0,1]) bearings();
                translate([-wheelXOffset,0,-bearingHeight/2-wheelBearingOffset]) color([1,0,1]) bearings();
            }
        }
    }       

    
    if (enableFakeExtrusion==1){
        extrusion();
    }
    
    
    if (enableGantryPlate==1){
        if (enableOpenBuildsVRail==1){
            translate([0,0,1 + (extrusionWidth/2) + (gantryThickness/2) + vwheeloffset]) gantryPlate();
        } else {
            translate([0,0,1 + (extrusionWidth/2) + (gantryThickness/2)]) gantryPlate();
        }
    }
   
    if (enableSpacers==1){
        if (enableOpenBuildsVRail==1  || enableVExtrusion==0 ){
            if(enableVExtrusion==0){
            
            translate([wheelXOffset+misumiWheelOffset,-wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) +1 ]) rotate(a=[0,0,90]) spacers();
            translate([wheelXOffset+misumiWheelOffset,wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) +1 ]) rotate(a=[0,0,90]) spacers();
            } else {
                translate([wheelXOffset+misumiWheelOffset,-wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) + 1 +vwheeloffset]) rotate(a=[0,0,90]) spacers();
                translate([wheelXOffset+misumiWheelOffset,wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) + 1 +vwheeloffset ]) rotate(a=[0,0,90]) spacers();
                }
            
        } else {
            translate([wheelXOffset,wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) + 1 ]) rotate(a=[0,0,90]) spacers();
            translate([wheelXOffset,-wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) + 1 ]) rotate(a=[0,0,90]) spacers();
        }
    }
    
     
    if (enableEccentricSpacers==1){
        if (enableOpenBuildsVRail==1  || enableVExtrusion==0 ){
            
            if(enableVExtrusion==0){
            if (enableFourWheels==1){
                translate([-wheelXOffset - eccentricOffset -misumiWheelOffset,wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) + 1 ]) eccentricSpacers();
                translate([-wheelXOffset - eccentricOffset-misumiWheelOffset,-wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) + 1 ]) rotate(a=[0,0,90]) eccentricSpacers();
            } else {
                translate([-wheelXOffset - eccentricOffset-misumiWheelOffset,0,(extrusionWidth/2) - (spacerHeight/2) + 1  ]) rotate(a=[0,0,90]) eccentricSpacers();
            }
        } else {
                        if (enableFourWheels==1){
                translate([-wheelXOffset - eccentricOffset -misumiWheelOffset,wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) + 1+vwheeloffset ]) eccentricSpacers();
                translate([-wheelXOffset - eccentricOffset-misumiWheelOffset,-wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) + 1 +vwheeloffset]) rotate(a=[0,0,90]) eccentricSpacers();
            } else {
                translate([-wheelXOffset - eccentricOffset-misumiWheelOffset,0,(extrusionWidth/2) - (spacerHeight/2) + 1 + vwheeloffset ]) rotate(a=[0,0,90]) eccentricSpacers();
            }
            
            }
        } else {
                if (enableFourWheels==1){
                    translate([-wheelXOffset - eccentricOffset,wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) + 1 ]) eccentricSpacers();
                    translate([-wheelXOffset - eccentricOffset,-wheelYOffset,(extrusionWidth/2) - (spacerHeight/2) + 1 ]) rotate(a=[0,0,90]) eccentricSpacers();
                } else {
                    translate([-wheelXOffset - eccentricOffset,0,(extrusionWidth/2) - (spacerHeight/2) + 1 ]) rotate(a=[0,0,90]) eccentricSpacers();
                }
            }
    }
    
    if (enableWheelSpacers==1){
        if (enableOpenBuildsVRail==1  || enableVExtrusion==0 ){
            if(enableVExtrusion==0){
                translate([wheelXOffset+misumiWheelOffset,wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset]) rotate(a=[0,0,90]) wheelspacers();
                translate([wheelXOffset+misumiWheelOffset,-wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset]) rotate(a=[0,0,90]) wheelspacers();
                
                if (enableFourWheels==1 && enableEccentricSpacers==1){
                    translate([-wheelXOffset-misumiWheelOffset,wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset]) rotate(a=[0,0,90]) wheelspacers();
                    translate([-wheelXOffset-misumiWheelOffset,-wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset]) rotate(a=[0,0,90]) wheelspacers();
                } else {
                    if (enableEccentricSpacers==1){
                        translate([-wheelXOffset-misumiWheelOffset,0,(wheelHeight/2) + .25 + holeCreationOffset]) rotate(a=[0,0,90]) wheelspacers();
                    }
                }
        } else {
                            translate([wheelXOffset+misumiWheelOffset,wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset+vwheeloffset]) rotate(a=[0,0,90]) wheelspacers();
                translate([wheelXOffset+misumiWheelOffset,-wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset+vwheeloffset]) rotate(a=[0,0,90]) wheelspacers();
                
                if (enableFourWheels==1 && enableEccentricSpacers==1){
                    translate([-wheelXOffset-misumiWheelOffset,wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset+vwheeloffset]) rotate(a=[0,0,90]) wheelspacers();
                    translate([-wheelXOffset-misumiWheelOffset,-wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset+vwheeloffset]) rotate(a=[0,0,90]) wheelspacers();
                } else {
                    if (enableEccentricSpacers==1){
                        translate([-wheelXOffset-misumiWheelOffset,0,(wheelHeight/2) + .25 + holeCreationOffset+vwheeloffset]) rotate(a=[0,0,90]) wheelspacers();
                    }
                }
            
            }
        } else {
                translate([wheelXOffset,wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset]) rotate(a=[0,0,90]) wheelspacers();
                translate([wheelXOffset,-wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset]) rotate(a=[0,0,90]) wheelspacers();
                
                if (enableFourWheels==1 && enableEccentricSpacers==1){
                    translate([-wheelXOffset,wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset]) rotate(a=[0,0,90]) wheelspacers();
                    translate([-wheelXOffset,-wheelYOffset,(wheelHeight/2) + .25 + holeCreationOffset]) rotate(a=[0,0,90]) wheelspacers();
                } else {
                    if (enableEccentricSpacers==1){
                        translate([-wheelXOffset,0,(wheelHeight/2) + .25 + holeCreationOffset]) rotate(a=[0,0,90]) wheelspacers();
                    }
                }
            }
    }

    if (enableSpacerBolts==1){
        if(enableVExtrusion==0){
            if (enableOpenBuildsVRail==1  || enableVExtrusion==0 ){
                translate([wheelXOffset+misumiWheelOffset,wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                translate([wheelXOffset+misumiWheelOffset,-wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                if (enableFourWheels==1){
                translate([-wheelXOffset-misumiWheelOffset,wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                translate([-wheelXOffset-misumiWheelOffset,-wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                } else {
                translate([-wheelXOffset-misumiWheelOffset,0,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)+vwheeloffset]) rotate(a=[0,0,90]) spacerbolts();
            }
            } else {
                        translate([wheelXOffset,wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                translate([wheelXOffset,-wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                if (enableFourWheels==1){
                translate([-wheelXOffset,wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                translate([-wheelXOffset,-wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                } else {
                translate([-wheelXOffset,0,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
            }    
                }
            
        } else {
            
                        if (enableOpenBuildsVRail==1  || enableVExtrusion==0 ){
                translate([wheelXOffset+misumiWheelOffset,wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)+vwheeloffset]) rotate(a=[0,0,90]) spacerbolts();
                translate([wheelXOffset+misumiWheelOffset,-wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)+vwheeloffset]) rotate(a=[0,0,90]) spacerbolts();
                if (enableFourWheels==1){
                translate([-wheelXOffset-misumiWheelOffset,wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)+vwheeloffset]) rotate(a=[0,0,90]) spacerbolts();
                translate([-wheelXOffset-misumiWheelOffset,-wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)+vwheeloffset]) rotate(a=[0,0,90]) spacerbolts();
                } else {
                translate([-wheelXOffset-misumiWheelOffset,0,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)+vwheeloffset]) rotate(a=[0,0,90]) spacerbolts();
            }
            } else {
                        translate([wheelXOffset,wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                translate([wheelXOffset,-wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                if (enableFourWheels==1){
                translate([-wheelXOffset,wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                translate([-wheelXOffset,-wheelYOffset,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
                } else {
                translate([-wheelXOffset,0,((m5LowProfileScrewLength + m5LowProfileScrewHeadHeight)/2) - (wheelHeight/2) - (gantryThickness/2)]) rotate(a=[0,0,90]) spacerbolts();
            }    
                }


            }
    }
    
    if (enableOpenBuildsVRail==1) {
        translate([0,0,(extrusionWidth/2) + 1]) rotate(a=[0,180,0]) vrail();
        translate([0,0,(extrusionWidth/2)+ openVrailHeight + 1]) vrail();
    }
}



module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn, center = true);
}
   
module cylinder_outerdual(height,radius,radiustwo,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r1=radius*fudge,r2=radiustwo*fudge,$fn=fn, center = true);
}
   
module cylinder_mid(height,radius,fn){
   fudge = (1+1/cos(180/fn))/2;
   cylinder(h=height,r=radius*fudge,$fn=fn, center = true);
}
   
module createMeniscus(h,radius) {// This module creates the shape that needs to be substracted from a cube to make its corners rounded.
    difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
       translate([radius/2+0.1,radius/2+0.1,0]){
          cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
       }

       cylinder(h=h+0.2,r=radius,$fn = 25,center=true);
    }
}

module roundCornersCube(x,y,z,r){  // Now we just substract the shape we have created in the four corners
    difference(){
       cube([x,y,z], center=true);

    translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
          rotate(0){  
             createMeniscus(z,r); // And substract the meniscus
          }
       }
       translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
          rotate(90){
             createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
          }
       }
          translate([-x/2+r,-y/2+r]){ // ... 
          rotate(180){
             createMeniscus(z,r);
          }
       }
          translate([x/2-r,-y/2+r]){
          rotate(270){
             createMeniscus(z,r);
          }
       }
    }
}

if(createcarraigeassembly==1){
    carraigeassembly();
} else{
    if(enableBearingBuild==1) {bearings();}
    if(enableWheelBuild==1) {wheels();}
    if(enableFakeExtrusionBuild==1) {extrusion();}
    if(enableGantryPlateBuild==1) {gantryPlate();}
    if(enableSpacersBuild==1) {spacers();}
    if(enableSpacerBoltsBuild==1) {spacerbolts();}
    if(enableEccentricSpacersBuild==1) {eccentricSpacers();}
    if(enableWheelSpacersBuild==1) {wheelspacers();}
    if(enableOpenBuildsVRailBuild==1) {vrail();}
}