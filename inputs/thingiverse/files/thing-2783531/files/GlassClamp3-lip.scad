/**
 * Author: Randy Willard <Randyrw>
 * Description: Bibo Heated Bed Glass Holder
 * Date Created: 2/4/2018 
 */
// All Default settings are the settings I am using on my Bibo printer
// Which is using original glass, aluminum plate and original glass holder parts(screws, nut, washer.
// It does not look like the holes in the aluminum plate are that accurate so you may need to play with the ScrewXPos and the ScrewYpos.   With the screw in and on the plate it should not wiggle much or at all. My right one does not wiggle at all and the left one wiggles less tha 1/32 inch.
// Too much play and the plunger screw will not be long enough to press against the glass to hold it down.
// I found if I have the screw too tight it may cause the glass to lift.
// 150  resolution lower number will compile quicker higher will probably better to a point
$fn=150;
Version="Clmp3 V2";  // Version will be written on Backside
//Is this the Left or Right Clamp?
LeftOrRight="Left";  //Left:Right
//Version
VersionTxt=str(LeftOrRight," ",Version);
font = "Liberation Sans";
//Settings 
fonts="Basic";
letter_size = 3;
letter_height = .5;
//Debugging 0-NoBuild 1-Build Clamp
buildClamp=1;
//Numeric sizes are aproximately in mm, Overall clamp size
ClampHeight = 7.2; // [4:10]
ClampWidth = 33.5; // [4:40]
ClampLength = 30; // [4:40]
//aluminumn bed cutout Pos
AlumCutX=20; //[.5:4]
AlumCutY=15; //[.5:4]
//aluminumn bed cutout depth
AlumCutDepth=1.2; //[.5:4]
// Allow Alum Cornerslop
AlumSlopXY=5; //[.5:6]
//Screw Size to attach to bed
ScrewSize=3.5; // [2.5:5] 
HeadSize=6.5;     //  [4:8]
CounterSinkDepth=1.5; //[.1:3]
//ScrewHole Offset X
ScrewXPos=2.5;   //[.1:10]
ScrewYPos=-2.5;   //[.1:10]
GlassThickness=3; //  [0:6]
//Glass Lip will help keep alum plate and glass together 
//Use Glass Lip?   0-No or 1-Yes
GlassLip=1  ;     // [0:1]
//Lip to hold glass down
GlassLipX=3;      //[0:6]
GlassLipY=3;      //[0:6]
//CutOut for glass
GlassCutOutX=20;  //[5:30]
GlassCutOutY=8;   //[5:30]
//Plunger is the Screw,Washer,Spring and nut that press against glass to hold in place.
PlungerOffsetX=8;  //[6:15]
PlungerOffsetY=44;  //[30:50]
PlungerScrew=3;  //[2:5]
PlungerWasherDiameter=7.8;
PlungerWasherThick=1.3;
PlungerSpringDiameter=5.5;
PlungerSpringLength=8;
PlungerNutDiameter=5.1;
PlungerNutThick=2.5;
PlungerDepth=3.5;      //[.1:6]
PlungerDepthStep=.5;  //[.1:1]
//Write most Settings on top of clamp.
WriteSettings=1;  //0-No 1-Yes
//
if (LeftOrRight=="Right") {
    mirror([1,0,0]) {
    LClamp(1) ;
    }
} else {
    LClamp(1);
}
module LClamp(size) {
    if (buildClamp==1) {
        difference(){  //settings
        difference(){  //Version
        difference(){
        rotate(a=180,v=[1,0,0]){
        difference(){
        difference(){            
        difference(){
        difference(){
        difference(){
            cube([ClampLength,ClampWidth,ClampHeight]); //MainPiece
            if (GlassLip==1 ){
                cube([GlassCutOutX,GlassCutOutY,GlassThickness+AlumCutDepth]);  //GlassCutOut
                cube([GlassCutOutX-GlassLipX,GlassCutOutY-GlassLipY,ClampHeight]);//GlassCutOutlip
            }else{
                cube([GlassCutOutX,GlassCutOutY,ClampHeight]);  //GlassCutOut
           //cube([GlassCutOutX-GlassLipX,GlassCutOutY-GlassLipY,ClampHeight]);  //GlassCutOut lip
            }
        }
        cube([AlumCutX,AlumCutY,AlumCutDepth]);  //AlumBedCutOut
        }
        translate([GlassCutOutX-ScrewXPos,10-ScrewYPos,0]) {
            cylinder(r=ScrewSize/2, h=ClampHeight,$fn=50);
            translate([0,0,ClampHeight-CounterSinkDepth]) {    
                cylinder(r=HeadSize/2, h=CounterSinkDepth,$fn=50); //ScrewHole and countersink
            }
        }
        }
        translate([AlumCutX-AlumSlopXY/4,AlumCutY-AlumSlopXY/4,0]) {    
            cylinder(r=AlumSlopXY/2, h=AlumCutDepth,$fn=50); //ScrewHole and countersink
        }
        }
        for (i = [0:PlungerDepthStep:PlungerDepth]) {
            translate([PlungerOffsetX,PlungerOffsetY,i]) {
                plunger(1) ;
            }
        }
        }
        }
        }
        writeVersion(1);
        }
        buildSettingsTxt(WriteSettings);
    }
    }
}  // end LClamp
module buildSettingsTxt(WriteSettings) {
   if (WriteSettings==1) {
    xx="x";
    letterdepth=.5;
    s=2.4 ; //size
    //wVx=6 ;
    if (LeftOrRight=="Left") {
        wVx=5;
        l=str("Clamp=",ClampHeight,xx,ClampWidth,xx,ClampLength );
        writeSettings(l,s,wVx,0,letterdepth);

        ll=str("AlumCut=",AlumCutX,xx,AlumCutY,xx,AlumCutDepth,xx,AlumSlopXY);
        writeSettings(ll,s,wVx,2,letterdepth);

        //lll=str("Screw=",ScrewSize,xx,HeadSize,xx,CounterSinkDepth,xx,ScrewXPos,xx,ScrewYPos);
        lll=str("Screw=",ScrewXPos,xx,ScrewYPos);
        writeSettings(lll,s,wVx,6,letterdepth);

        llll=str("GlassCut=",GlassCutOutX,xx,GlassCutOutY);
        writeSettings(llll,s,wVx,8,letterdepth);

        lllllll=str("Plngr3=",PlungerOffsetX,xx,PlungerOffsetY);
        writeSettings(lllllll,s,wVx,10,letterdepth);
        }
    if (LeftOrRight=="Right") {
    wVx=6;
    l=str("Clamp=",ClampHeight,xx,ClampWidth,xx,ClampLength );
    writeSettings(l,s,wVx,0,letterdepth);

    ll=str("AlumCut=",AlumCutX,xx,AlumCutY,xx,AlumCutDepth,xx,AlumSlopXY);
    writeSettings(ll,s,wVx,2,letterdepth);
    lll=str("Screw=",ScrewXPos,xx,ScrewYPos);
    writeSettings(lll,s,wVx,6,letterdepth);
    llll=str("GlassCut=",GlassCutOutX,xx,GlassCutOutY);
    writeSettings(llll,s,wVx,8,letterdepth);
    lllllll=str("Plngr3=",PlungerOffsetX,xx,PlungerOffsetY);
    writeSettings(lllllll,s,wVx,10,letterdepth);
    }
}
    }
module writeSettings(t,s,x,y,z){ // Write Settings on clamp
    //letter_height
    translate([ClampLength+.1-(s+(y*s)),(-AlumCutY*2)+x-8,-ClampHeight+z]) {
    rotate(a=180,v=[1,1,0]){
        Text(t,s);
    }
    }
}
module writeVersion(z){ //Write Version on Clamp
    //letter_height
    translate([ClampLength+.1-letter_height,-ClampWidth/2,-ClampHeight/2]) {
    rotate(a=270,v=[0,1,0]){
    rotate(a=180,v=[0,0,1]){
    rotate(a=180,v=[1,1,0]){
        Version(VersionTxt);
    }
    }
    }
    }
}
module plunger(Size) {
    PlungerDepth=15;
    rotate(a=90,v=[1,0,0]){
    cylinder(r=PlungerScrew/2,h=40); //plungerScrew
    translate([0,0,PlungerDepth]) {  //washer
    cylinder(r=PlungerWasherDiameter/2,h=PlungerWasherThick); 
    }
    translate([0,0,PlungerDepth+PlungerWasherThick]) {  //spring
    cylinder(r=PlungerSpringDiameter/2,h=PlungerSpringLength); 
    }
    translate([0,0,PlungerDepth+PlungerWasherThick+PlungerSpringLength]) {
    hexagon(PlungerNutDiameter, PlungerNutThick);
    }
    }
}
// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
module Version(l) {  //Display Version Center
	linear_extrude(height = letter_height) {
             if (LeftOrRight=="Right") {
            mirror([1,0,0]) {   
		text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
            }} else {
        text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);        
            }	
        }
}
module Text(l,size) {  //Used to Display Settings
	linear_extrude(height = letter_height) {
        if (LeftOrRight=="Right") {
            mirror([1,0,0]) {
                text(l, size, font = fonts, halign = "right", valign = "top", $fn = 16);
            }
        } else {
            text(l, size, font = fonts, halign = "left", valign = "top", $fn = 16);
        }
    }
}