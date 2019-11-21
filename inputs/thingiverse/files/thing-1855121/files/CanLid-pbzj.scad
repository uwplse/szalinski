// DEFINED PARAMETERS
$fa=2;
$fs=.1;

ver="v0.5";
design=0; //display differently in design mode
// Can
canDiameter=61; // main part of the can
canLipDiameter=66;
canLipHeight=3; // not including any taper into the can
// Lid
lidWallThickness=2;
lidHandleRatio=0.5; // size relative to lid size
lidLipTaper=1; // r/Z
lidCanDTol=2;//
lidEntryExtraR=0;
lidLipCanLipZTol=-1;

// CALCULATED PARAMETERS
// Can
canLipThickness=(canLipDiameter-canDiameter)/2; // radially
// Lid
lidDiameter=canLipDiameter+2*lidWallThickness; 
lidLipHeight=2*canLipThickness/lidLipTaper;
lidCanLipZSpace=canLipHeight+lidLipCanLipZTol;
canHoleHeight=lidCanLipZSpace+lidLipHeight;
lidHeight=canHoleHeight+lidWallThickness;
lidEntryZ=-lidWallThickness/lidLipTaper-lidEntryExtraR/lidLipTaper;

difference(){
    rotate(a=[0,0,0]) {
        // basic lid shape
        translate([0,0,lidLipHeight])
            difference(){
                cylinder (h=lidHeight-lidLipHeight,d=lidDiameter);
                //translate([0,0,lidWallThickness])
                    cylinder(h=lidCanLipZSpace,d=canLipDiameter);
                translate([0,0,lidHeight])
                    linear_extrude(height=lidWallThickness,center=true)
                        text(text=ver,size=5,halign="center",valign="center");
            };

        // handle
        translate ([lidDiameter/2,0,canHoleHeight])
            cylinder (h=lidWallThickness,d=canDiameter*lidHandleRatio);
        
        // lip
        //translate([0,0,lidWallThickness+lidHeight-2+lipZAdjustment])
            rotate_extrude()
                polygon([
                    [lidDiameter/2,lidLipHeight], //outer,upper
                    [lidDiameter/2+lidEntryExtraR,lidEntryZ], //outer,lower
                    [canDiameter/2+lidCanDTol,lidLipHeight/2], //contact point
                    [canLipDiameter/2,lidLipHeight] //inner,upper
                ]);    
    }
    if(design==1)
        translate([0,0,-50])
            cube([99,99,99]);
}