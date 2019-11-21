/*
 *      Template for round corners.
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

use <write/Write.scad>

/* Start of customizer header */

/* [Model parameters] */

// (in millimeters)
Corner_radius=25;

// or leave blank for no inscription
Inscription="25 mm";

Inscription_font="write/Letters.dxf";//["write/orbitron.dxf":Orbitron,"write/Letters.dxf":Letters,]

// [mm]
Height_of_the_walls=10;

// [mm]
Wall_thickness=2.14;

// preview[view:north east, tilt:bottom diagonal]

/* [Hidden] */
// End of Customizer header

R=Corner_radius;
t=Wall_thickness;
h=Height_of_the_walls;
txt=Inscription;

$fn=120;

module round_edge_cut(){
  intersection(){
    difference(){
      cylinder(r=R,h=t);
      cylinder(r2=R,r1=R-t/2,h=t);
    }
    translate([-R,-R,0])
      cube([R,R,t]);
  }
}

difference(){

  // Main body
  cube([2*R,2*R,h]);
  translate([t,t,t])
    cube([2*R,2*R,h]);

  // center marker hole
  translate([R+t,R+t,-0.01])
    cylinder(r2=1.5/2,r1=1.5/2+t/2,h=t+0.02);

  // Round corner cut
  translate([t,t,-h/2])
  difference(){
    cube([R,R,2*h]);
    translate([R,R,-1])
      cylinder(r=R,h=2*h+2);
  }
  translate([R+t-0.01,R+t-0.01,0])
  round_edge_cut();

  // Corner walls cut
  translate([-0.01,-0.01,-1])
  difference(){
    cube([R+t+R/5,R+t+R/5,h+1+0.01]);
    translate([t+0.02,t+0.02,-1])
      cube([R+t+R/5,R+t+R/5,h+2+0.01]);
  }

  // Inscription
  translate([R,R/2+R/5,-0.01])
    rotate([180,0,0])
    write(txt,font=Inscription_font,center=true,h=R/3,t=t);
}
