// Brian Button V 0.91
// Copyright 2018 Brian Palmer
// http://www.thingiverse.com/thing:3237565
// V 0.90 first release. basic button and bezel are customizable.
// V 0.91 - Fixed a bunch of things including button travel
// V 0.92 - Fixed print mode to correctly flip parts upside down. Tweaked default slide and clip parameter values. Added some airspace equal to bezelButtonClearance around clip lip ledge.

// Released under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// https://creativecommons.org/licenses/by-nc-sa/4.0/

/* [General Parameters] */

//Choose which part to create.  Best practice is to set all settings, and then generate each part, one by one.  
part = "both"; //[ bezel:Button Bezel, button:Button, both:Button and Bezel]  

/* [Preview Settings] */

//Enable to preview all parts together!  KEEP THIS OFF in order to create individual printable parts.
preview = 1;//[0:Print,1:Preview] 
//Explode parts apart to see them individually better.  Only relevant when previewing.
explodedView = 1; //[0:Normal,1:Exploded] 

/* [Bezel] */
// The bezel of course should be longer and wider than the button itself.
bezelLength=200; 
bezelWidth=70;
bezelHeight=25;
bezelCornerRadious=10;
// Amount of air space between the button and the bezel.
bezelButtonClearance=.7; 

/* [Button] */
buttonLength=140;
buttonWidth=40;
buttonHeight=40;
buttonRadious=7;
// The amount the button can travel before hitting the slide stops.
buttonMaxPushDistance=8;

/* [Button Clips] */
// Clips need to flex a little during install button into the bezel. 
// 0 = no clips
// width of 4 button clips. Should be less than button height.
clipWidth=10;
// thickness of clip leg. Keep this thin so it can flex a little during assembly. 
clipDepth=6;
// length of clip leg. the longer the more flexible the clip.
clipHeight=25;
// This is amount of air space between clip and button side
clipButtonClearance=1.5;
// length of clip foot. Keeps button from popping out of bezel. Should be greater than clipButtonClearance.
clipOverhang=3; 

/* [Slides] */
// 0 = no slide
slideWidth=4;
slideDepth=5; 

/* [Hidden] */
// some parameter validation/limiting
bezelR = (bezelCornerRadious > bezelWidth/2) ? bezelWidth/2 : bezelCornerRadious;
echo ("bezelCornerRadious:", bezelCornerRadious);
qtrBezelDim=[bezelLength/2, bezelWidth/2, bezelHeight];
btnRadious = (buttonRadious > buttonWidth/2) ? buttonWidth/2 : buttonRadious;
echo ("btnRadious:", btnRadious);
// todo: add more validation

qtrBtnDim=[buttonLength/2, buttonWidth/2, buttonHeight]; 
slideCutout=[slideWidth, slideDepth, bezelHeight];
clipCutout=[clipWidth+(clipButtonClearance*2), clipDepth+clipOverhang*1.45, clipHeight - .25];
clipLeg=[clipWidth, clipDepth, clipHeight];
// generate some shortcuts for the 3 evenly spaced work positions
OneEigthbuttonLength = buttonLength/8;
xPosition1 = OneEigthbuttonLength;
xPosition2 = OneEigthbuttonLength * 2;
xPosition3 = OneEigthbuttonLength * 3;

// do it!
main();

module main(){
	
    if(preview==1) { // only supports viewing both parts
        createBezel();
        if (explodedView==1) 
            translate([0,0, buttonHeight+40]) createButton();
        else
            createButton();
    } else { // print mode flips parts upside down and spaces them out when both are being printed.
        
        if (part=="button") {
            translate([0,0,buttonHeight]) rotate([180,0,0]) createButton();
        } else {
            translate([0,buttonWidth+120,+bezelHeight]) rotate([180,0,0]) createBezel();
            if (part=="both") {
               translate([0,0,buttonHeight]) rotate([180,0,0]) createButton();
            }
        }
    }
}

module createBezel() {
    // create upper right 1/4 of the bezel
    qtrBezel(qtrBezelDim, bezelCornerRadious);
    // create lower right q of the button. colors are for debugging only
    mirror([0,1,0]) qtrBezel(qtrBezelDim, bezelCornerRadious); 
    // upper left 1/4 of the button
    // color("Green",0.5) 
    mirror([1,0,0]) qtrBezel(qtrBezelDim, bezelCornerRadious); 
    // lower left 1/4 of the button
    // color("Purple",0.5)
    mirror([1,0,0]) mirror([0,1,0]) qtrBezel(qtrBezelDim, bezelCornerRadious); 
}
module createButton() {
    // create upper right 1/4 of the button
    qtrBtn(qtrBtnDim, btnRadious); 

    // create lower right 1/4 of the button
    //c olor("Blue",0.5) 
    mirror([0,1,0]) qtrBtn(qtrBtnDim, btnRadious); 
    // upper left 1/4 of the button
    // color("Green",0.5) 
    mirror([1,0,0]) qtrBtn(qtrBtnDim, btnRadious); 
    // lower left 1/4 of the button
    // color("Purple",0.5) 
    mirror([1,0,0]) mirror([0,1,0]) qtrBtn(qtrBtnDim, btnRadious);     
}

module qtrBtn(qtrBtnDim, btnRadious) {

    difference() {        
        qtrCube(qtrBtnDim, btnRadious);
        
        if (slideWidth > 0)
        {
            // Y side slide cutout
            translate([qtrBtnDim.x,-(slideCutout.x/2),0]) rotate([0,0,90]) cube(slideCutout, center=false);
            // 1st  x slide cutout (only half of X is needed)
            translate([-(slideCutout.x/2),qtrBtnDim.y-slideCutout.y,0]) cube(slideCutout, center=false);
            // 2nd X slide cutout
            translate([xPosition2-(slideCutout.x/2),qtrBtnDim.y-slideCutout.y,0]) cube(slideCutout, center=false);
        }
        
        if (clipWidth > 0)
        {
            // 1st clip cutout
            translate([xPosition1-(clipCutout.x/2),qtrBtnDim.y-clipCutout.y,0]) cube(clipCutout, center=false);
            // 2nd clip cutout
            translate([xPosition3-(clipCutout.x/2),qtrBtnDim.y-clipCutout.y,0]) cube(clipCutout, center=false);
        }
    }
    
    // 1st clip leg 
    translate([xPosition1,qtrBtnDim.y-clipLeg.y,0]) makeclip(clipLeg, clipOverhang);        
   // 2nd clip leg 
    translate([xPosition3,qtrBtnDim.y-clipLeg.y,0]) makeclip(clipLeg, clipOverhang);    
    
}

module qtrBezel(qtrBezelDim, bezelCornerRadious) {
   
    difference() {
        difference() {
            //  outer edge of bezel
            qtrCube(qtrBezelDim, bezelCornerRadious);
            // use button dims and bezel height to create a slightly larger button hole
            qtrCube(3dOffset(qtrBtnDim,[bezelButtonClearance, bezelButtonClearance,-(qtrBtnDim.z) + qtrBezelDim.z]), btnRadious);
        }
        if (clipWidth > 0)
        {
            // use button dims to create clip stop ledge. hardcoded t0 be 1.5 times the clipDepth.
            qtrCube(3dOffset(qtrBtnDim,[0,clipOverhang+bezelButtonClearance,-qtrBtnDim.z + (clipDepth * 1.5)]), btnRadious);
        }
    }
 
    // button slides built into bezel
    if (slideWidth > 0)
    {
        // Y side slide 
        halfSizeSlideDim = 3dOffset(slideCutout,[-((slideCutout.x/2)+bezelButtonClearance),clipOverhang+(bezelButtonClearance*3),-buttonMaxPushDistance]);
        translate([qtrBtnDim.x+slideCutout.y,0,0]) rotate([0,0,90]) cube(halfSizeSlideDim, center=false);

        // 1st x slide (only half of X is needed)
        translate([0,qtrBtnDim.y+bezelButtonClearance-slideCutout.y,0]) cube(halfSizeSlideDim, center=false);

        // 2nd X slide
        xSlideDim = 3dOffset(slideCutout,[-(bezelButtonClearance*2),clipOverhang,-buttonMaxPushDistance]);
        translate([xPosition2-(slideCutout.x/2)+bezelButtonClearance,qtrBtnDim.y-slideCutout.y+bezelButtonClearance,0]) cube(xSlideDim, center=false);
    }
    
    echo ("x:", 3dOffset(qtrBtnDim,[clipOverhang,clipOverhang,0]).x,
          "y:", 3dOffset(qtrBtnDim,[clipOverhang,clipOverhang,0]).y,
          "z:", 3dOffset(qtrBtnDim,[clipOverhang,clipOverhang,(qtrBtnDim.z*-1) + 7.5]).z);
}

module qtrCube(cubeDim, cornerRadious) {
    // main button cube - if no radious specified, just use with a simple cube
    if (cornerRadious <= 0) {
        cube(cubeDim, center=false);
    } else { // radiused corners requires hulling 3 cubes and 1 cylinder
        hull() {
            // 3 square corners
            cube([1,1,cubeDim.z], center=false);
            translate([cubeDim.x-1, 0, 0]) cube([1,1,cubeDim.z], center=false);
            translate([0, cubeDim.y-1, 0]) cube([1,1,cubeDim.z], center=false);
            // radius the far corner
            translate([cubeDim.x-cornerRadious,cubeDim.y-cornerRadious,0]) cylinder(r=cornerRadious,h=cubeDim.z);
        }
    }
}

function 3dOffset(orig, modifier) = [orig.x + modifier.x, orig.y + modifier.y, orig.z + modifier.z];

/// returns a rectangle with a beveled hook on the end
module makeclip(c, hookSize) {
clip =[
    [0,0],                      //1
    [0,c.z],                    //2
    [c.y,c.z],                  //3
    [c.y,c.y*1.5],              //4 note multiplier of 1.5 hardcoded vert in the foot tip
    [c.y+hookSize,c.y*1.5],     //5
    [c.y+hookSize,c.y],         //6
    [c.y,0]                     //7
    ];
        
    rotate([0,90,0]) rotate([0,0,90]) linear_extrude(height = c.x, center = true, convexity = 10, twist = 0, slices = 1, scale = 1.0, $fn = 16) 
    {
        polygon(clip);
    }
  
}