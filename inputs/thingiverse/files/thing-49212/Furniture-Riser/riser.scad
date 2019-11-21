/* Furniture leg riser
 * Copyright 2013, Robert Carlsen
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

// riser for furniture legs
// all measurements in mm
// adopted for Thingiverse Customizer

// not used for the Customizer
// clearance for Mint robot with our couch:
//couchHeightFront =  15;
//couchBaseWidth = 75;
//tvBaseWidth = 48;


// Height of the riser
platformHeight = 15; 

// Width of the riser platform
platformWidth = 48;

// How much the base flares out for stability
baseFlare = 10;
baseWidth = platformWidth+baseFlare;

// Lip height around the platform
lipHeight = 5; // [0:10]

// Thickness of the lip at the top
lipWidth = 1; // [0:10]

// Include stress relief channels on the first few layers?
useStressRelief = "Yes"; // [Yes,No]

// sanity checking...just make sure the platform will be the correct size
//cube([platformWidth, platformWidth, 2], center=true);

// this is the riser
module riser(_platformSize, _baseSize, _height, _lipHeight, _lipWidth) {

  // calculate the sizes needed for the pyramid
  // since we're faking the cube with a cylinder, find the chord length
  _baseRadius=radiusFromChord(_baseSize);
  _platformRadius=radiusFromChord(_platformSize);

  difference() {
    rotate([0,0,45])
    difference() {
      cylinder(h=_height+_lipHeight, r1=_baseRadius+_lipWidth, r2=_platformRadius+_lipWidth, $fn=4);
      translate([0,0,_height+0.1])

      // the platform is just a regular cube subtracted from the pyramid
      rotate([0,0,45])
      translate([0,0,_lipHeight/2])
      cube([_platformSize,_platformSize,_lipHeight],center=true);
    }

    // carves out channels on the bottom of the riser to
    // minimize curling of the cooling ABS.
    // you can likely disable these if using PLA:
    if(useStressRelief == "Yes") {
      stressRelief(_baseRadius);
      rotate([0,0,90])
      stressRelief(_baseRadius);
    }
  }
}

// need to carve stress relief in the bottom
// or the plastic will warp and pull up the
// build plate while cooling.
module stressRelief(_baseSize) {
  rotate([90,0,0])
  for (x = [-_baseSize/2 : _baseSize/2 : _baseSize/2])
  {
      translate([x, 0, 0])
      // using a low res cylinder is a poor-man's teardrop
      cylinder(h=_baseSize*1.38, r=1, center=true,$fn=8);
  }
}

function radiusFromChord(_chordLength) = pow(pow(_chordLength/2,2)+pow(_chordLength/2,2), 0.5);

// generate the riser using the above module(s):
riser(platformWidth, baseWidth, platformHeight, lipHeight, lipWidth);


