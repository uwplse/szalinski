// Author: Christian Petry
// Designed in Switzerland 2017
// Version: 1.4 (2017-12-12)

/* Version History
V1.0 (2017-11-05) initial version
- optimized for Taulman PCTPE

V1.1 (2017-11-05)
- increased air gap to 2 layers
- number of air gap layers now configurable
- fixed top width not scaling with case wall thickness
- increased cutout Z for left and right cutouts

V1.2 (2017-11-12)
- now optimized for Semiflex (Cheetah)
-- layerHeight 0.1->0.15 and other changes related to using softer material
- slightly increased bottom cutout Z
- top width and hight will now scale only 75% with wall thickness (was 100%)
- increased bottom thickness, so camera is better protected: 1.1 -> 1.8
- slightly decreased hingeXAdditional: 2.0 -> 1.75
- slightly decreased width of credit card pockets
- increased extraYOffsetPerPocket 1.5->2.5
- fixed airgapLayers not working for credit card pockets

V1.3 (2017-11-26)
- Fixed hinge Z was negative, so first layer was hinge only
- some changes to underside thickness and cutouts no longer go all the way down to z=0

V1.4 (2017-12-12)
- added engraved text
- Finetuning
-- standLayer 9 -> 7
-- decreased wall thicknesses for case by 0.3mm
-- reduced topZLayers and extraTopPocketLayer by 1
-- phoneDimensionAdditional X/Y/Z 0.00 -> -0.25
-- case_top_cutoff 0.45 -> 0.48;
*/

/*
Optmized for Semiflex (Cheetah)
For taulman PCTPE change following:
layerHeight: 0.1
standLayer: 5
caseSideThickness: 1.9
caseTopBottomThickness: 1.9
phoneDimensionAdditionalX: 0.1
phoneDimensionAdditionalY: 0.1
phoneDimensionAdditionalZ: 0.1
*/

/* [Main] */
layerHeight=0.15;
caseSideThickness=2.1;
caseTopBottomThickness=2.1;
caseUndersideThickness=2.1;
// position of the stand layer; -1=none
standLayer=7; // [-1:1:20]
// position of the extra pocket layer; 0=none
extraTopPocketLayer=6; // [0:1:20]
// number of credit card pockets; 0=none
numberCreditCardPockets=3; // [0:1:4]
// height of top without credit card pockets; 0=no top, i.e. bumper case
topZLayers=10; // [0:1:20]
// credit card pocket top thickness
creditCardPocketTopLayers=3; // [1:1:5]
// number of layers for air gap
airGapLayers=2; // [1:1:3]
// hinge thickness; 0=none
hingeZLayers=2; // [0:1:20]
// extra space for credit cards and money between phone and top
hingeAdditional=1.75;
// make additional space for phone, use i.e. to offset print precision issues. For very flexible materials you may want to use negative values
phoneDimensionAdditionalX=-0.25;
phoneDimensionAdditionalY=-0.25;
phoneDimensionAdditionalZ=-0.25;

// engraved text
engravedText="OnePlus";
engravedTextLayers=2;
engravedTextSize=8;
engravedTextSpacing=1.2;
engravedTextPosX=-68;
engravedTextPosY=-70;
engravedTextFont="Liberation Sans";

/* [Hidden] */
$fn=50;
phone=[75.2+phoneDimensionAdditionalX,153.0+phoneDimensionAdditionalY,7.8+phoneDimensionAdditionalZ]; // phone dimesions x,y,z

// --- cutouts ---
// volume and alert slider
volumeslider=[45-3,24,30];
posCutout1=[-36.5,-2,-1];
// power button
powerbutton=[15-3,24,30];
posCutout2=[23.5,-2,-1];
// bottom (usb+headphone+speaker)
bottomCutout=[40-3,28,30];
posCutout3=[0,-2,-1.2];
// camera
camera_loc=[0,57];
camera=[18,29,20];
camera_rounding=3;

// --- cutoffs ---
case_top_cutoff=0.48;
case_bottom_cutoff=1.7;

// --- phone and case spefific rounding ---
phone_edge=11;
phone_edge_r=37;
rounding=1.7;
s_scale=[3.5,3.5,1];
case_rounding=4;
case_rounding_sphere=2;

// case size offset x,y,z
caseWall=[caseSideThickness, 
caseTopBottomThickness, caseUndersideThickness+case_bottom_cutoff];

hingeX=phone[2]+caseWall[0]+caseWall[2]+hingeAdditional;
hingeWidth=hingeX+hingeAdditional;
hingeZ=hingeZLayers*layerHeight;

topZ=topZLayers*layerHeight;

OVERLAP=0.005;

function creditCardZ()=airGapLayers*layerHeight;

creditCardSpace=[65.4,75]; // x in mm, y in mm
bottomThickness=0;
creditCardPocketSeam=1;
seamTopPocket=1.5;
creditCardPocketTop=layerHeight*creditCardPocketTopLayers;
zOffset=0+creditCardZ()+creditCardPocketTop;
creditCardPocketsStartOffset=2;
creditCardPocketYOffsetPerPocket=19;
creditCardPocketHeight=bottomThickness+creditCardZ()+creditCardPocketTop;
extraYOffsetPerPocket=2.5;


difference(){
    bumper();
    standCutout();
}


if (topZLayers > 0){
    hinge();
    difference(){
        top();
        extraTopPocket();
        translate([0,0,-OVERLAP])
        engravedText();
    }

    if (numberCreditCardPockets > 0){
        translate([0,creditCardPocketsStartOffset,0])
        creditCardPockets();
    }
}

module bumper(){
    translate([0,0,-case_bottom_cutoff])
    difference(){
        difference(){
            resize(newsize=[phone[0]+2*caseWall[0],phone[1]+2*caseWall[1],phone[2]+caseWall[2]])
            phone();
            
            translate([0,0,phone[2]+caseWall[2]+10/2-case_top_cutoff])
            cube([phone[0]*2,phone[1]*2,10], center=true);
            
            translate([0,0,-10/2+case_bottom_cutoff])
            cube([phone[0]*2,phone[1]*2,10], center=true);
        }
        translate([0,0,caseWall[2]])
        union(){
            phone();
            phone_cutouts();
        }
    }
}

module standCutout(){
    sizeFactor=2;
    color([1,0,0])
    translate([-phone[0]/2*sizeFactor,-phone[1]/2*sizeFactor,(standLayer-1)*layerHeight])
    cube([sizeFactor*phone[0]/2,sizeFactor*phone[1],airGapLayers*layerHeight]);
}

module extraTopPocket(){
    zOffset=(airGapLayers*layerHeight)/topZ;
    color([1,0,0])
    scale([1,(phone[1]-2*seamTopPocket)/phone[1],1])
    translate([seamTopPocket,0,(extraTopPocketLayer-1)*layerHeight])
    scale([1,(phone[1]-2*seamTopPocket)/phone[1],zOffset])
    top();
}

module top(){
    scaleSizeWithWallThicknessFactor=0.75;
    translate([-1.5*phone[0]-hingeX+case_rounding-scaleSizeWithWallThicknessFactor*caseWall[0],-phone[1]/2+1.5*case_rounding-scaleSizeWithWallThicknessFactor*caseWall[1],0])
    difference(){
        minkowski(){
            cube([phone[0]-2*1.5*case_rounding-case_rounding_sphere+2*scaleSizeWithWallThicknessFactor*caseWall[0],phone[1]-2*1.5*case_rounding+2*scaleSizeWithWallThicknessFactor*caseWall[1],topZ]);
            cylinder(r=case_rounding*1.5,h=case_rounding);
        }
        translate([-case_rounding*1.5-OVERLAP/2,-case_rounding*1.5-OVERLAP/2,topZ])
        cube([phone[0]+OVERLAP+case_rounding_sphere+caseWall[0],phone[1]+OVERLAP+2*caseWall[1],100]);
    }
}

module creditCardPockets(){    
      translate([-phone[0]-hingeWidth-caseWall[0]/2,-phone[1]/2+creditCardSpace[0]/2+creditCardPocketSeam+case_rounding,topZ])
      {
      for (i=[1:numberCreditCardPockets]){
        creditCardPocket(i,numberCreditCardPockets);
      }
      }
}

module creditCardPocket(pocketNumber,totalNumber){
    yOffset=(totalNumber-pocketNumber)*creditCardPocketYOffsetPerPocket;
    extraYOffset=(totalNumber-pocketNumber)*extraYOffsetPerPocket;
    zOffset=(pocketNumber-1)*creditCardPocketHeight+creditCardPocketHeight/2;
    
    translate([0,yOffset/2+totalNumber/2*extraYOffsetPerPocket-extraYOffset/2,zOffset]){
        cube([creditCardSpace[0]+extraYOffset,creditCardSpace[1]+yOffset,bottomThickness], center=true);
        
        difference(){
            cube([creditCardSpace[0]+extraYOffset,creditCardSpace[1]+yOffset,creditCardPocketHeight], center=true);
            
        translate([0,creditCardPocketSeam+yOffset/2,bottomThickness-(creditCardPocketHeight-creditCardZ())/2])
            cube([creditCardSpace[0]-2*creditCardPocketSeam,creditCardSpace[1]-creditCardPocketSeam,creditCardZ()+OVERLAP], center=true);
        }
    }
}

module hinge(){
    color([1,1,0])
    translate([-phone[0]/2-hingeWidth/2,0,hingeZ/2])
    cube([hingeX+hingeAdditional+2*case_rounding+caseWall[0],phone[1]+2*caseWall[1]-case_rounding,hingeZ], center=true);
}

module phone(){
    translate([-phone[0]/2,phone[1]/2,0])
    rotate([0,0,-90])
	difference()
	{
		intersection()
		{
			translate(
				[rounding*(s_scale[0]),
				rounding*(s_scale[1]),
				0])						
			minkowski()
			{
				cube([phone[1]-2*rounding*s_scale[0],
					phone[0]-2*rounding*s_scale[1],
					phone[2]-rounding*s_scale[2]]);
                
				scale(s_scale)
				difference()
				{
					sphere(rounding);
					translate([-rounding,-rounding,-2*rounding])
					cube(2*rounding);
				}
			}
			
			translate([0,phone[0]/2,phone[2]/2])
				scale([1,1,0.3])
					rotate(90,[0,1,0])
						cylinder(phone[1],d=phone[0], $fn=$fn*3);
		
			translate([phone[1]/2,0,phone[2]/2])
				scale([1,1,0.25])
					rotate(-90,[1,0,0])
						cylinder(phone[0],d=phone[1], $fn=$fn*3);

		}
		// bottom edge roundings
		for (i = [-1:2:1])
		{
			translate([-1,
				phone_edge*-i+phone[0]*(i/2+0.5),
				phone_edge_r-0.001])
				rotate(90,[0,1,0])
					rotate(-45+i*45,[0,0,1])
						difference()
						{
				cube([phone_edge_r, phone_edge_r, phone[1]+2]);
				cylinder(phone[1]+2,r=phone_edge_r, $fn=$fn*3);
						}
		}
	}
}

module phone_cutouts(){
	// camera
	translate([camera_loc[0], camera_loc[1], -camera_loc[2]+camera_rounding])
	minkowski()
	{
		cube([camera[0]-2*camera_rounding,
			camera[1]-2*camera_rounding,
			camera[2]], center=true);
		difference()
		{
			sphere(r=camera_rounding);
			translate([-camera_rounding,-camera_rounding,0])
				cube(2*camera_rounding);
		}
	}	

        phone_cutout_helper("LEFT",posCutout1,volumeslider);
            
        phone_cutout_helper("RIGHT",posCutout2,powerbutton);
        
        phone_cutout_helper("BOTTOM",posCutout3,bottomCutout);
}

// phoneSideAlias=LEFT/RIGHT/TOP/BOTTOM/UPPER/UNDER
// posVector=[x,y,z]
// sizeVector=[width,height,depth]
module phone_cutout_helper(phoneSideAlias,posVector,sizeVector){
    dZ=sizeVector[1]/2; // default Z offset
    if (phoneSideAlias=="LEFT"){
        offsetVector=[-phone[0]/2-posVector[1],-posVector[0],dZ+posVector[2]];
        rotateVector=[-90,0,90];
        phone_cutout(sizeVector,offsetVector,rotateVector);
    } else if (phoneSideAlias=="RIGHT"){
        offsetVector=[phone[0]/2+posVector[1],posVector[0],dZ+posVector[2]];
        rotateVector=[90,0,90];
        phone_cutout(sizeVector,offsetVector,rotateVector);
    } else if (phoneSideAlias=="TOP"){  
        // TODO
    } else if (phoneSideAlias=="BOTTOM"){
        offsetVector=[posVector[0],-phone[1]/2-posVector[1],dZ+posVector[2]];
        rotateVector=[90,0,0];
        phone_cutout(sizeVector,offsetVector,rotateVector);
    } else if (phoneSideAlias=="UPPER"){
        // TODO
    } else if (phoneSideAlias=="UNDER"){
        offsetVector=[posVector[0],phone[1]/2+posVector[1],dZ+posVector[2]];
        rotateVector=[0,180,90];
        phone_cutout(sizeVector,offsetVector,rotateVector);
    }
}

// sizeVector=[width,height,depth]
module phone_cutout(sizeVector,offsetVector,rotateVector){
    color([1,0,0])
    translate([offsetVector[0],offsetVector[1],offsetVector[2]])
    rotate([rotateVector[0],rotateVector[1],rotateVector[2]])
    translate([-sizeVector[0]/2+sizeVector[1]/6,0,0])
			hull()
			{
					cylinder(d=sizeVector[1],h=sizeVector[2]);
				translate([sizeVector[0]-sizeVector[1]/3,0,0])
					cylinder(d=sizeVector[1],h=sizeVector[2]);
			}
}

module engravedText(){ 
    color([1,0,0])
    translate ([engravedTextPosX,engravedTextPosY,engravedTextLayers*layerHeight])
    rotate ([0,180,0])
    linear_extrude(engravedTextLayers*layerHeight)
        text(engravedText, font = engravedTextFont, size = engravedTextSize, spacing = engravedTextSpacing );
}