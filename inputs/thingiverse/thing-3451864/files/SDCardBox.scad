//===========================================================================
//
// SD card holder
//
// Minimalist case for SD card storage.
//
// This part was designed 24 Feburary 2019 by Joe McKeown. 
// It's available under the terms of the Creative Commons CC-BY license 
// (https://creativecommons.org/licenses/by/3.0/).
// 
// History:
// V1.0 24 Fev 2019 First version
//===========================================================================

// Number of cards to hold
num=15;
// tolerance between parts (increase if too tight)
margin = 0.2; // [0.1:0.1:1.0]

/* [Hidden] */
pitch=2.9+margin;

boxX=26;
boxY=(num+1)*pitch;

module SDBlank(pos=[0,0,0], orientation=[0,0,0], margin=0){
  translate(pos) translate([0,0,(32+margin)/2]) rotate(orientation)
  cube([24+margin, 2.2+margin, 32.1+margin],true);
}


module box(){
  difference(){
    translate([0,boxY/2,12.5])
      cube([26, boxY, 25],true);
    for( y = [pitch:pitch:pitch*num+0.1] )
      SDBlank(pos=[0,y,1], margin=margin);
  }
}

module lid(){
  translate([0,(boxY+4)/2,0])
  difference(){
    translate([0,0,17])
      cube([boxX+4, boxY+4, 34],true);
    translate([0,0,21])
      cube([boxX+margin*2, boxY-2+margin*2, 40],true);
    translate([0,0,29])
      cube([boxX+margin*2, boxY+margin*2, 40],true);
    translate([0,0,34])
      rotate([0,90,0])
        cylinder(d=30, h=boxX*2, center=true);
  }
}


sep= boxX/2+2;
translate([-sep,0,0])
box();

translate([ sep,0,0])
lid();
