/* A pair of replacements clamps to retain your Techzone Huxley
 *  bowden cable using pneumatic fast connectors.
 *
 * This use 1 module "hardware.scad" from the MCAD library that you can
 *  get from https://github.com/elmom/MCAD. It is looking for it in a MCAD folder.
 *
 * Usage :
 *  1) Print.
 *  2) Screw one 6-R1/8 straight connectors on each (easier to do it while the plastic is still hot).
 *  3) Attach to extruder and hot end.
 *  4) Plug in some PTFE tube (external diameter 6 mm).
 *
 * Copyright (C) 2011  Guy 'DeuxVis' P.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 * -- 
 *     DeuxVis - device@ymail.com */

use <MCAD/hardware.scad>

myrodsize = 10.5; //diameter of the threaded hole for air coupling INCLUDING THE THREAD THICKNESS
myrodpitch = 0.907; //not sure about that, so I suggest threading the coupling in while the clamps are still hot.
con_thr_h = 9; //length of the air coupling threaded part

tube_dia = 4.5; //filament passage
clamp_h = 21; //overall height of the central part
bolt_h = 9; //height of the 2 attachments cylinders
test = 0; //set to 1 to only print a test part of the air coupling thread

tube_ext_dia = myrodsize + 8;


module bowden_clamp( bolt_dia, bolt_to_center_left , bolt_to_center_right ) {
  bolt_ext_dia = bolt_dia + 10;
  huge = (bolt_to_center_left+bolt_to_center_right) * 2.0;
  a_left = atan(
    (bolt_to_center_left - (tube_ext_dia + bolt_ext_dia)/2.0)
    / (clamp_h - bolt_h - tube_ext_dia/8 - 2)
  );
  a_right = -atan(
    (bolt_to_center_right - (tube_ext_dia + bolt_ext_dia)/2.0)
    / (clamp_h - bolt_h - tube_ext_dia/8 - 2)
  );
  wing_left_x = bolt_to_center_left;
  wing_right_x = bolt_to_center_right;

  module attach() {
    difference() {
      cylinder( $fn=64, h=bolt_h, r=bolt_ext_dia/2.0);
      cylinder( $fn=32, h=bolt_h, r=bolt_dia/2.0);
    }
  }

  difference() {
    union() {
      //clamp cylinder
      difference() {
        union() {
          //funnel for filament easy entrance
          translate( [0, 0, tube_dia/2.0] ) difference() {
            rotate_extrude( convexity=10, $fn=32 ) translate( [tube_dia, 0, 0] ) circle( r=tube_dia/2.0, $fn=32 );
            translate( [0, 0, 10] ) cube( 20, true );
            translate( [0, 0, -tube_dia] ) difference() {
              cylinder( r=tube_dia*2.0, h=tube_dia );
              cylinder( r=tube_dia, h=tube_dia, $fn=32 );
            }
          }
          translate( [0, 0, tube_dia/2.0] ) {
            cylinder( $fn=92, h=clamp_h-tube_ext_dia/4.0-tube_dia/2.0 , r=tube_ext_dia/2.0 );
          }
          difference() {
            cylinder( $fn=92, h=tube_dia/2.0 , r=tube_ext_dia/2.0 );
            cylinder( $fn=32, h=tube_dia/2.0 , r=tube_dia-0.1 );
          }
          difference() {
            translate( [0, 0, clamp_h-tube_ext_dia/4.0] ) {
              scale( [1, 1, .66] ) {
                sphere( $fn=64, r=tube_ext_dia/2.0 );
              }
            }
            translate( [0, 0, huge/2.0+clamp_h] ) { cube( [huge, huge, huge], true ); }
          }
        }
        cylinder( $fn=48, h=clamp_h, r=tube_dia/2.0 );
      }

      //left attachment
      translate( [-bolt_to_center_left, 0, 0] ) { attach(); }
      //left wing
      difference() {
        translate( [-bolt_to_center_left+bolt_ext_dia/2, 0, bolt_h] ) {
          rotate( a=a_left, v=[0, 1, 0] ) {	
            translate( [wing_left_x/2, 0, 0] ) {
              cube( [wing_left_x, bolt_ext_dia/2.0, clamp_h*2.0], true );
            }
          }
        }
        translate( [0, 0, -huge/2.0] ) { cube( [huge, huge, huge], true ); }
        translate( [0, 0, huge/2.0+clamp_h-tube_ext_dia/4.0] ) { cube( [huge, huge, huge], true ); }
        translate( [huge/2.0-tube_ext_dia/4.0, 0, 0] ) { cube( [huge, huge, huge], true ); }
        translate( [-huge/2.0-bolt_to_center_left+bolt_ext_dia/3.0, 0, 0] ) { cube( [huge, huge, huge], true ); }
      }

      //right attachment
      translate( [bolt_to_center_right, 0, 0] ) { attach(); }
      //right wing
      difference() {
        translate( [bolt_to_center_right-bolt_ext_dia/2, 0, bolt_h] ) {
          rotate( a=a_right, v=[0, 1, 0] ) {
            translate( [-wing_right_x/2, 0, 0] ) {
              cube( [wing_right_x, bolt_ext_dia/2.0, clamp_h*2.0], true );
            }
          }
        }
        translate( [0, 0, -huge/2.0] ) { cube( [huge, huge, huge], true ); }
        translate( [0, 0, huge/2.0+clamp_h-tube_ext_dia/4.0] ) { cube( [huge, huge, huge], true ); }
        translate( [-huge/2.0+tube_ext_dia/4.0, 0, 0] ) { cube( [huge, huge, huge], true ); }
        translate( [huge/2.0+bolt_to_center_right-bolt_ext_dia/3.0, 0, 0] ) { cube( [huge, huge, huge], true ); }
      }
    }
    
    //threaded hole for air coupling.
    translate( [0, 0, clamp_h-con_thr_h/2.0] ) rod( con_thr_h, true, renderrodthreads=true, rodsize=myrodsize, rodpitch=myrodpitch );

    //test only prints the part needed to test the thread
    if (test == 1) {
      translate( [0, 0, -huge/2.0 - (con_thr_h + 1) + clamp_h] ) { cube( [huge, huge, huge], true ); }
    }
  }
}



if (test == 1) {
    bowden_clamp( 4.3, 22.5, 28.5 );
} else {
  //hotend side clamp
  translate( [0, -20, 0] ) { rotate( [0, 0, 180] ) { bowden_clamp( 3.4, 30, 30 ); } }

  //extruder side clamp
  bowden_clamp( 4.3, 22.5, 28.5 );
}

