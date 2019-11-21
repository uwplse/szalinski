/*
 *      Step pyramid. Test object
 *
 * Copyright (C) 2015 Mikhail Basov <RepRap[at]Basov[dot]net>
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
 *              2015. License, GPL v2 or later
 */

/*
 * Inspired by [5mm Calibration Cube Steps](http://www.thingiverse.com/thing:24238)
 * but no one part of origonal model sorce used.
 */

/* Start of customizer header */

/* [Model parameters] */

// - what color to generate? 
color=3; //[1:1-st color, 2:2-nd color, 3:Both colors together]

number_of_small_cubes_in_one_side=5; //[4:12]

// [mm]
small_cube_size=5;

small_bridge_test=1;//[1:true,0:false]

large_bridge_test=1;//[1:true,0:false]

/* [Print parameters] */

slicing_layer_height=0.2;

extrusion_wide=0.4;

/* [Hidden] */
// End of Customizer header

// sv - small value
sv=0.01;

slh=slicing_layer_height;
ev=extrusion_wide;
step=small_cube_size;
size=number_of_small_cubes_in_one_side;
s_bridge_f=small_bridge_test;
l_bridge_f=large_bridge_test;

/* cube_grid.scad library */
// Version 0.1 2015-08-07 (ae0a6117f)

module square_grid(xm=4, ym=4, zm=4, step=5, sv=0.001, f=1){
  // f  - is 0,0 element filled
  // sv - need to prevent "Object isn't a valid 2-manifold!"
  //      sv may be negative
  for (j=[0:ym-1]){
    if(f%2==0){
      for (i=[0:2:xm-(j%2==0?2:1)]){
        translate([step*(i+(j%2==0?1:0))-sv,j*step-sv,-sv])
          cube([step+sv*2,step+sv*2,zm*step+sv*2]);
      }
    } else {
      for (i=[0:2:xm-(j%2==0?1:2)]){
        translate([step*(i+(j%2==0?0:1))-sv,j*step-sv,-sv])
          cube([step+sv*2,step+sv*2,zm*step+sv*2]);
      }
    }
  }
}

/* end of cube_grid.scad library */

module step_pyramid(_step=step, _size=size, _sv=sv, _slh=slh, _ev=ev){
  difference(){
    translate([_sv,_sv,_sv])
      cube([_step*_size-2*_sv,_step*_size-2*_sv,_step*_size-2*_sv]);
    for (j=[0:_size-1]){
      for (i=[0:_size-1]){
          a= _step*(_size-i-j)<=0?10:0;
          translate([_step*(_size-i-j)-a, _step*i-_sv, j*_step-_sv])
            cube([_step*_size*2+a+_sv*2,_step+_sv*2,_step+sv*2]);
      }
    }
    //long bridge test
    if(l_bridge_f!=0)
      translate([-3*_ev,_step,0])
        cube([_step-_sv,2*_step+_sv,_step]);
    //short bridgr test
    if(s_bridge_f!=0)
      translate([_step,-3*_ev,_step])
        cube([_step,_step,_step]);
  }
}

module s_bridge(_slh=slh,_sv=sv){
  translate([_sv,_sv,5*2])
    cube([5*3,5,_slh]);
}

module l_bridge(_slh=slh,_sv=sv){
  translate([_sv,_sv,5])
    cube([5,5*4,_slh]);
}

module color1(){
  color("red"){
    difference(){
      step_pyramid();
      square_grid(xm=size, ym=size, zm=size+1, step=step, sv=2*sv, f=1);
      if(s_bridge_f!=0) s_bridge();
    }
    if(l_bridge_f!=0) l_bridge(_sv=-sv);
  }
}

module color2(){
  color("green"){
    difference(){
      intersection(){
        step_pyramid();
        square_grid(xm=size, ym=size, zm=size+1, step=step, sv=-2*sv, f=1);
      }
      if(l_bridge_f!=0) l_bridge();
    }
    if(s_bridge_f!=0) s_bridge(sv=-sv);
  }
}

if (color==1){
  color1();
} else if (color==2){
  color2();
} else {
  color1();
  color2();
}
