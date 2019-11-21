//===========================================================================
// Cover For Cornelius Keg ball lock Disconnect
//
// This part was designed 24 November 1017 by Joe McKeown. 
// It's available under the terms of the Creative Commons CC-BY license 
// (https://creativecommons.org/licenses/by/3.0/).
// 
// History:
// V1.0 24 NOV 1017 First version
// V1.1 11 AUG 2018 Tightened tolerances for tighter fit.
// V1.2 22 SEP 2018 Made Tolerance customizable.
//===========================================================================
// preview[view:west, tilt:bottom diagonal]
// Text to be placed on top & back; prefix numbers with '\' on Customzer. Keep it simple; R,L for right/left or \1, \2, \3...
DisplayText="S";
// Height of the font to use
TextHeight=15; // [5:0.25:15]
// Width of Text. Note: Values larger than 17 make the top look funny
TextWidth=16; // [5:110]
// Font to use for Label. (Sorry Customizer doesn't offer a font picker.)
Font="Liberation Sans:style=Bold";
// Add extra margin if part from your printer is too tight. (Subtract if too loose)
ExtraMargin=0; // [-1:0.1:1]

/* [Hidden] */
TotalHeight=28;
Margin=1.5;
CapHeight=11.0;
StemHeight=18.0;
UpperD=24.5 + ExtraMargin; //25;
LowerD=18 + ExtraMargin; //18.5;
TransitionHeight=(UpperD-LowerD)*0.65;
LowerHeight=TotalHeight-TransitionHeight-CapHeight;
OuterDiameter = UpperD + (2*Margin);
BackerMax = UpperD / sqrt(2);
$fa=2;

//Show the Bottom and side
$vpr=([225,0,90]);
$vpt=([-TotalHeight/2,0,0]);
$vpd=140;



thing();
          
module thing(){
  difference(){
    union(){
      // raw cylinder
      cylinder(d=OuterDiameter, h=TotalHeight);
      // Block to receive lettering
      translate([-UpperD/2 - (1.5*Margin), -TextWidth/2, 0]){
        cube([2*Margin, TextWidth, TotalHeight]);
        //Along the top. This makes it really ugly if textWidth > OuterDiameter*sqrt(2)
        cube([UpperD, TextWidth, 2*Margin]);
      }
      // Add some extra thichness to the back label to imporve appearance and printablility.
      if (TextWidth > BackerMax)
        translate([-UpperD/2 - (1.5*Margin), -BackerMax/2, 0])
        cube([4*Margin, BackerMax, TotalHeight]);
      else
        translate([-UpperD/2 - (1.5*Margin), -TextWidth/2, 0])
        cube([4*Margin, TextWidth, TotalHeight]);
    }
    // remove the profile of the ball-lock
    translate([0, 0, 2*Margin])
      ballLockProfile();
    // remove some side to form a clip.
    color("green")
      translate([OuterDiameter/2 * sin(17), -OuterDiameter/2, 2*Margin])
        cube([OuterDiameter, OuterDiameter, TotalHeight]);  
    // engrave the text on the top.
    color("red")
      translate([-0.1 * TextHeight, 0, -0.01])
      linear_extrude(height = Margin)
        rotate(a=-90) mirror([1, 0, 0]) 
          text(DisplayText, size=TextHeight, 
                      valign="center", halign="center", font=Font );
    // engrave the text on the side.
    color("blue")
      translate([-OuterDiameter/2 - Margin/2 - 0.01, 0, TextHeight + Margin])
      rotate([90,180,90]) 
      linear_extrude(height = Margin)
        mirror([1, 0, 0]) 
          text(DisplayText, size=TextHeight, halign="center", font=Font );

  }
}

/*
The ballLockProfile module represents the profile of a Ball-lock corney keg quick-disconnect.
This is subtracted from the overall part.
*/
module ballLockProfile(){
  union() {
    cylinder(d=UpperD, h=CapHeight + 0.01);
    translate([0,0,CapHeight])
      cylinder(d1=UpperD, d2=LowerD, h=TransitionHeight + 0.01);
    translate([0,0,CapHeight+TransitionHeight])
      cylinder(d=LowerD, h=LowerHeight);
  }
}