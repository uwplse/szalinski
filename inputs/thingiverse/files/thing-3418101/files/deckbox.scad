// ### Start of Customization spots ###

/* [Objects] */
generateBox = true;
generateLid = true;

/* [Card Type] */
// Type of seelves
cardType = "FFG Yellow"; // [Dragon Shield Standard,Ultra Pro Mini American,FFG Yellow]
verticalOrientation = false;
doubleSleeved = false;

// Number of cards for each compartment
compartiments = [25,20,20,25,10]; //[1:999]
// ^ set to a vector of 5 elements to force customizer to use a text box

//Thickness of the walls
wall = 2.5; // Between 2 and 4

/* [Lid] */

linesOfText = ["Damage", "Stun", "Power", "Ember"];
textsize = 6.5; // The size of this text [0.1:.1:99]
spaceBetweenLines = 7.5; // extra space between each line
flexibleClips = true;

/* [Logo] */
logoName = "keyforge"; // [bos_logo,deather_eater,deathly_hallows,Harry_Potter_HP,keyforge,ministry_of_magic]
logoFile = str(logoName,".dxf"); 
logoWidth = 53;
logoHieght = 30;
spaceUnderLogo = 4;

/* [KeyForge Windows] */
// The kind of window you want
windowStyle = 0; // [0:None, 1:Three Holes, 2:Big Window]
// Adjust the window showing the house logos
windowPosition = 18;

// Card thickness. (standard dragon shield MTG sleeve with card)
cardT = doubleSleeved ? 0.71 : 0.61;

// ### End of Customization spots ###
// Change things below here at your own risk

module logo() {
  logoPath = str("./logos/",logoFile);
  translate([middleOfBox - (logoWidth / 2), 1, spaceUnderLogo])
  resize([logoWidth, 2, logoHieght])
  rotate([90, 0, 0])
  linear_extrude(height = 2)
  import (logoPath);
}

// Availabe Card Types [width, height]
dragonShieldStandard = [67.5,93.4];
ultraProMiniAmerican = [45.2,68.2];
ffgYellow = [45.2,68.3];

cardSelection = cardType == "Dragon Shield Standard" ? dragonShieldStandard :
    cardType == "Ultra Pro Mini American" ? ultraProMiniAmerican :
    cardType == "FFG Yellow" ? ffgYellow :
    [0,0];

trueCardHieght = cardSelection[0];
trueCardWidth = cardSelection[1];
cardW = verticalOrientation ? trueCardHieght : trueCardWidth;
cardH = verticalOrientation ? trueCardWidth : trueCardHieght;
tolerance = 1 + 0; // '+ 0' to ensure it's excluded from Customizer
nComps = len(compartiments);
sizes = compartiments * cardT;
totalDepth = sum(sizes) + wall * nComps + wall + tolerance * nComps;
innerDepth = totalDepth - wall * 2;

totalBoxWidth = cardW + wall * 2;
middleOfBox = totalBoxWidth / 2;

// MAIN

if (generateBox) {
    deckbox();
}
if (generateLid) {
    lid();
}

// MODULES
module lidPunchOut(xOffset, yOffset, zOffset){
    union() {
        difference(){
          translate([wall + xOffset, yOffset - 1, wall + zOffset])
          cube([cardW, totalDepth + 2, wall * 1 + 1]);

          translate([(wall * 0.83) + xOffset, (wall / 2)+ yOffset, zOffset + wall * 1.5])
          sphere(r = wall / 3);

          translate([(cardW + wall * 1.17) + xOffset, (wall / 2) + yOffset, zOffset + wall * 1.5])
          sphere(r = wall / 3);

        }

        translate([(wall / 2) + xOffset, wall + yOffset, wall + zOffset])
        rotate([0, 27, 0])
        cube([wall, totalDepth + 2, wall * 2]);

        translate([(cardW + wall * 1.5) + xOffset, totalDepth + wall + yOffset, wall + zOffset])
        rotate([0, 27, 180])
        cube([wall, totalDepth, wall * 2]);
    }
}

module window() {
  if (windowStyle == 1) { // 3 round holes
    // left house
    translate([middleOfBox - 20, -1, windowPosition + 5])
    rotate([-90, 0, 0])
    cylinder(h = wall * 2, d1 = 20, d2 = 16);

    // middle house
    translate([middleOfBox, -1, windowPosition]) rotate([-90, 0, 0])
    cylinder(h = wall * 2, d1 = 20, d2 = 16);

    // right house
    translate([middleOfBox + 20, -1, windowPosition + 5]) rotate([-90, 0, 0])
    cylinder(h = wall * 2, d1 = 20, d2 = 16);
  } else if (windowStyle == 2) {
    hull() { // 1 big hole
      // left house
      translate([middleOfBox - 20, -1, windowPosition + 5])
      rotate([-90, 0, 0])
      cylinder(h = wall * 2, d1 = 20, d2 = 16);

      // middle house
      translate([middleOfBox, -1, windowPosition])
      rotate([-90, 0, 0])
      cylinder(h = wall * 2, d1 = 20, d2 = 16);

      // right house
      translate([middleOfBox + 20, -1, windowPosition + 5])
      rotate([-90, 0, 0])
      cylinder(h = wall * 2, d1 = 20, d2 = 16);
    }
  }
}



module lid() {
  margin = 0.2;
  translate([totalBoxWidth + 5, 0, 0])
  difference(){
    translate([wall / 2, wall, 0])
    minkowski(){
      cube([cardW - margin, innerDepth, wall - 1 - margin]);
      cylinder(r = wall, h = 1);
    }

    cube([wall / 2, wall, wall]);

    translate([wall * 0.5, wall / 2, wall / 2])
    sphere(r = wall / 3);

    translate([-wall - 0.4, 0, 0])
    rotate([0, 27, 0])
    cube([wall, totalDepth, wall * 2]);

    translate([cardW + wall / 2 - margin, 0, 0])
    cube([wall / 2, wall, wall]);

    translate([cardW + wall * 0.5 - margin, wall / 2, wall / 2])
    sphere(r = wall / 3);

    translate([totalBoxWidth + 0.4 - margin, totalDepth, 0])
    rotate([0, 27, 180])
    cube([wall, totalDepth, wall * 2]);
    
    engravingZHieght = wall - 1;
    lidYCenterLine = (totalDepth) / 2;
    lidXCenterLine = (cardW + wall - margin) / 2;
    numberOfLines = len(linesOfText);
    
    lastLineBelowMid = floor(numberOfLines / 2);
    firstLineAboveMid = ceil(numberOfLines / 2);
    
    spacePerLine = spaceBetweenLines + textsize;
    
    centerAdjustement = (lastLineBelowMid + 1 == firstLineAboveMid) ?
        spacePerLine : spacePerLine / 2;
        
    for( lineIndex = [0 : numberOfLines - 1 ]){
        if ( lineIndex < lastLineBelowMid ) {
            linesBelowCenter = (lastLineBelowMid - lineIndex) - 1;
            translate([lidXCenterLine, lidYCenterLine - centerAdjustement - (linesBelowCenter * spacePerLine), wall - 1])
            linear_extrude(height = 1.3){
              text(linesOfText[lineIndex], halign = "center", valign = "center", size = textsize, font="Arial:style=Bold");
            }
        } else if ( lineIndex >= firstLineAboveMid) {
            linesAboveCenter = lineIndex - firstLineAboveMid;
            translate([lidXCenterLine, lidYCenterLine + centerAdjustement + linesAboveCenter * spacePerLine, wall - 1])
            linear_extrude(height = 1.3){
              text(linesOfText[lineIndex], halign = "center", valign = "center", size = textsize, font="Arial:style=Bold");
            }
        } else {
            translate([lidXCenterLine, lidYCenterLine, wall - 1])
            linear_extrude(height = 1.3){
              text(linesOfText[lineIndex], halign = "center", valign = "center", size = textsize, font="Arial:style=Bold");
            }
        }
    }
    
    if(flexibleClips){
      translate([wall, 0, 0])
      cube([1, 8, wall + 1]);

      translate([cardW - margin - 1, 0, 0])
      cube([1, 8, wall + 1]);
    }
  }
}

module deckbox(){
  difference(){
    union(){
      translate([wall, wall, 0])
      minkowski(){
        cube([cardW, innerDepth, cardH + wall - 1]);
        cylinder(r = wall, h = 1);
      }
      
      difference(){
        translate([wall, wall, wall + cardH])
        minkowski(){
          cube([cardW, innerDepth, wall - 1]);
          cylinder(r = wall, h = 1);
        }
        lidPunchOut(0, 0, cardH);
    }
    }

    // Top holes to pull cards out
    translate([middleOfBox, -1, cardH + wall])
    rotate([-90, 0, 0])
    cylinder(h = totalDepth + 2, d = 20);

    for(i = [0 : (nComps - 1)]){
      translate([wall, sum(sizes, 0, i) + (i * wall) + wall + i * tolerance, wall])
      cube([cardW, sizes[i] + tolerance, cardH + 1]);
    }

    logo();
    window();
  }
}

function sum(array, from = 0, to = 2000000000) = (from < to  && from < len(array) ? array[from] + sum(array, from + 1, to) : 0);
