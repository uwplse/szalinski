/*
 *      Customazable screwless fan grill.
 *
 * Based on work which is copyright (C) 2013 Mikhail Basov <RepRap[at]Basov[dot]net>
 * Modified March 2014 by Dale Price <daprice[at]mac[dot]com> to include pins for screwless installation
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

/* Start of customizer header */

/* [Grill] */

// Number of rings
Number_of_rings=5; // [1:15]

// Smooth ring or segments
Ring_or_segment=1; //[0:Segment,1:Ring]

Drop_or_ring=0;    //[0:Ring,1:TearDrop]

Solid_center=0;    //[1:Solid,0:Hole]

/* [Dimemsions] */

External_dimension=120;

Rods_and_rings_wide=2.13;

Thickness_of_the_plate=1.75;

/* [Mount] */

Mount_type = "pins"; // [pins,holes]

/* [Pin Mount] */

// Applicable if you selected the "pins" mount type

Pin_height = 4;

Pin_diameter = 4.5;

Pin_lip_height = 1.5;

Pin_lip_thickness = 0.3;

/* [Hole Mount] */

// Applicable if you selected the "holes" mount type

Distance_between_mounting_holes=104.6;

Mounting_screw_thread_diameter=4.8;

// To make cylindrical mount holes set this parameter same as Mounting Screw Thread Diameter.
Head_diameter_mounting_screw=6.5;

Height_of_the_cone_mounting_screw=1.9;

// preview[view:south west, tilt:top]

/* [Hidden] */
/* End of customizer header */

include <pins/pins.scad>

size=External_dimension;
mount=Distance_between_mounting_holes;
m_od=Head_diameter_mounting_screw;
m_id=Mounting_screw_thread_diameter;
m_h=Height_of_the_cone_mounting_screw;       
g_wide=Rods_and_rings_wide;   
thick=Thickness_of_the_plate;

pin_h = Pin_height;
pin_r = Pin_diameter/2;
pin_lh = Pin_lip_height;
pin_lt = Pin_lip_thickness;

/*
    Grill parameters
*/
num=Number_of_rings;         // number of tear drop rings
smooth=Ring_or_segment;   // tear drop rings smooth 
tear_drop=Drop_or_ring;// tear drop or simple ring
s_center=Solid_center; //make center solid

/* 
    120 mm fan dimensions 
size=120;      // external dimension
mount=104.6;   // distance between centers of 
               // mounting holes on one side of
m_od=6.5;      // outer diameter of the screw head
m_id=4.8;      // thread diameter mounting screw
m_h=1.9;       // mount screw height of the cone 
g_wide=2.13;   // 0.37 - extrusion wide, 
               // 0.354 - extrusion distance
               // 6 - number of threads in two perimeters
               // 0.37*(1+(0.354/0.37)*(6-1))=
               //  =2.13999999999999999998
thick=m_h+0.5; // 0.5 is height of 1-st and second layer
*/

/* 
    20 mm fan dimensions !!! EARLY DRAFT !!!
size=20;       // external dimension
mount=15;      // distance between centers of 
               // mounting holes on one side of
m_od=1.5;      // outer diameter of the screw head
m_id=0.8;      // thread diameter mounting screw
m_h=0.4;       // mount screw height of the cone 
g_wide=1.078;  // 0.37 - extrusion wide, 
               // 0.354 - extrusion distance
               // 3 - number of threads in one perimeter
               // 0.37*(1+(0.354/0.37)*(3-1))=
               //  =1.07799999999999999999
thick=m_h+0.5; // 0.5 is height of 1-st and second layer
*/


// calculated constants
step=size/(num+1);
id=size-(g_wide*2);
sq2=sqrt(2);

// variables initialization
small_road=0;
large_i_drop=0;

// modules
module tear_drop(r=10, h=2, s=true){
  union(){
    if(s){
      assign (s_fact=120)
        cylinder(r=r,h=h,$fn=s_fact);
    } else {
      assign (s_fact=12)
        cylinder(r=r,h=h,$fn=s_fact);
    }
    if(tear_drop)
      cube([r,r,h]);
  }
}

module tear_drop_ring(od=10,t=1,ht=2,sm=true,so=false){
  difference(){
    tear_drop(r=od/2,h=h,s=sm);
    if(so){
    }else{
      translate([0,0,-0.5])
        tear_drop(r=od/2-t,h=h+1,s=sm);
    }
  }
}

module mount_hole(d_l,d_s,deep,h)
{
  rotate([0,180,0]){
	 cylinder(r=d_s/2,h=h+0.1,$fn=60);
	 cylinder(r1=d_l/2,r2=d_s/2,h=deep,$fn=60);
  }
}

module plate()
{
	difference(){
	  // plate
	  translate([0,0,thick/2])
	    cube([size,size,thick],center=true);
	  translate([0,0,-0.5])
	    cylinder(r=id/2,h=thick+1,$fn=120);
	  // round corners
	  for(a=[0,90,-90,180]){
	    rotate([0,0,a]){
	      translate([mount/2,mount/2,-0.5])
	        difference(){
	          cube([(size-mount)/2+0.1,(size-mount)/2+0.1,thick+1]);
	          cylinder(r=(size-mount)/2,h=thick+1,$fn=60);
	        }
	    }
	  }
	}
}

// grill
intersection(){
  rotate([0,0,45])
    union(){
      for ( n = [step:step:size-step] ) {
        if(n==step){
          if(s_center){
            tear_drop_ring(od=n,t=g_wide,h=thick,sm=smooth,so=s_center);
          }else{
            tear_drop_ring(od=n,t=g_wide,h=thick,sm=smooth);
          }
        }else{
          tear_drop_ring(od=n,t=g_wide,h=thick,sm=smooth);
        }
        // small rod for largest free tear drop
        if(tear_drop){
          if((size)-(sq2*n)>0){
            if((size)-(sq2*n)<sq2*step){
              //generate small rod
              rotate([0,0,45])
                translate([sq2*(n/2-g_wide),-g_wide/2,0])
                  cube([(size/2-sq2*(n/2-g_wide)),g_wide,thick]);
            }
          }
        }
      }

    }
    // cut tear drop ring outside plate 
    translate([-size/2,-size/2,0])
      cube([size,size,thick]);
}

// rods
for(a=[45,-45,135,-135]){
  rotate([0,0,a])
    translate([step/2-g_wide,-g_wide/2,0])
      cube([(size/2-step/2+0.01),g_wide,thick]);
}

// main plate
if(Mount_type=="pins")
{
union() {
	plate();
	//mount pins
	for(a=[0,90,-90,180]){
	    rotate([0,0,a]){
	      translate([mount/2,mount/2,thick])
	        pin(pin_h, pin_r, pin_lh, pin_lt);
	    }
	  }
	
}
}
else
{
difference(){
  // plate
  plate();
  // mount holes and round corners
  for(a=[0,90,-90,180]){
    rotate([0,0,a]){
      translate([mount/2,mount/2,thick+0.01])
        mount_hole(m_od,m_id,m_h,thick);
    }
  }
}
}

