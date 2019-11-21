/*
 *      Customazable tool clamp.
 *	
 * Copyright (C) 2013 Mikhail Basov <RepRap[at]Basov[dot]net>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License,
 * LGPL version 2.1, or (at your option) any later version of the GPL.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 *		2013. License, GPL v2 or later
 */

Tool_diameter=25.7;

Wall_thickness=3;

//( example:  top and simple = 0, bottom = Wall_thikness )
Horizontall_wall_thickness=3;

//( recommended:  Wall_thikness + 1 )
Mount_thickness=4;

//( recommended: Tools_diameter - 2*1.5 )
Clamp_gap_wide=22.7;

//( example: top = Tools_diameter * 2, bottom = Tools_diameter * 2, simple =  Tools_diameter)
Stand_hight=51.4;
//( use 3 for M3 screw or 3mm screw-nail)
Mount_hole_metric=3;

// preview[view:south west, tilt:top diagonal]

/* [Hidden] */
// End of Customizer header

$fn=120;

DO=Tool_diameter;		// Tool out diameter
WT=Wall_thickness;		// Wall thikness
MT=Mount_thickness;		// Mount thikness
HW=Horizontall_wall_thickness;	// Horizintall wall
CHW=Clamp_gap_wide;		// Clamp gap(hole?) wide
SH=Stand_hight;			// Stand hight
MHM=Mount_hole_metric;		// Mount hole metric

module Mx_DIN963(h=20,M=3){
  cylinder(r=M/2,h=h);
  cylinder(r1=M,r2=M/2,h=M/2);
  translate([0,0,-2*M+0.01])
  cylinder(r=M,h=2*M);
}

module clamp(do,wt,mt,hw,sh,chw,mhm){
  //  
  // do - internal whole diameter
  // wt - wall thikness
  // mt - mount thikness
  // hw - horizontall wall
  // sh - stand high
  // chw - clamp hole(gap?) wide
  // mhm - mount hole metric
  //
  so=do+wt*2;
  difference(){
    union(){
      cylinder(r=so/2,h=do);
      translate([-so/4,do/2,0])
        cube([so/2,mt,sh]);
    }
    translate([0,0,hw-0.1])
      cylinder(r=do/2,h=3*do);
    if(chw==do){
      translate([-(chw)/2,-do,hw-0.1])
        cube([chw,do,3*do]);
    } else {
      translate([0,-sqrt(2)*do-(sqrt(pow(do/2,2)-pow(chw/2,2))-chw/2),hw-0.1])
        rotate([0,0,45])
          cube([do,do,3*do]);
    }
    for(hh=[0.5*do, 1.5*do]){
      translate([0,do/2,hh])
        rotate([-90,0,0])
          Mx_DIN963(M=mhm);
    }
  }
}

clamp(do=DO,wt=WT,mt=MT,hw=HW,sh=SH,chw=CHW,mhm=MHM);
