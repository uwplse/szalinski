//  Written by lkiefer  -  http://blog.lkiefer.org
//  Copyright (c) 2015 lkiefer
//  Version 1

//######## LICENSE #####################################

//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

//######## DESCRIPTION ##################################

//  This fanduct is intended to be used with the Mendel90 3D printer with
//  a e3d v5 or similar hotend, and a 50mm radial fan (blower).
//  You can modify the values above to adapt the fanduct to your printer.
//  The fanduct is designed to be easily printable without support.
//  This file would works with OpenSCAD 2015-03 or later.

//######## PARAMETERS ##################################

//These parameters will affect the position of the hotend
trx=17;     //X offset
try=35;     //Y offset
h2=45;      //Z position of the fasteners holes
h2t=6;      //tollerance to adjust the Z position of the duct

//Size of duct part
d1=57;      //external diameter
d2=50;      //medium diameter
d3=32;      //small internal diameter
d4=40;      //big internal diameter
h1=9;       //height
fn=64;      //number of cylinders facets

//Size of the rear part
w=55;       //size in X
belt=10;    //gap for the belt
xfan=20.5;  //fan hole size
yfan=15.5;  //fan hole size
e3=0.5;     //height to avoid air leaks

//Fasteners settings
spacing=30; //spacing between the screw
dhole1=3.5; //fanduct fasteners hole diameter
dhole2=3.5; //fan fasteners hole diameter
nut=5.6;    //hex nut size
xh1=47;     //hole1 position for fan
yh1=7;
xh2=5;      //hole2 position for fan
yh2=45;

//Global settings
e1=1.5;     //low thickness
e2=3;       //high thickness (wall that should be stronger)
e4=3;       //ribs thickness
oh=30;      //overhang angle

//######## PROGRAM ###################################

difference(){
  union(){
    cylinder(d=d1, h=h1, $fn=fn);
    translate([-w/2+trx,try+belt]) cube(size=[w, yfan+e2+e1, h1+e1]);
    linear_extrude(height=h1) polygon([[-d1/2,0],[d1/2,0],[w/2+trx,try+belt],[-w/2+trx,try+belt]]);
    translate([w/2+trx-2*e1-xfan,try+belt+e2-0.1,h1+e1]) cube(size=[xfan+2*e1,yfan+e1+0.1,e3]);
  }
  translate ([0,0,e1]) cylinder(d=d1-2*e1, h=h1-2*e1, $fn=fn);
  translate([0,0,h1-e1-0.1]) cylinder(d=d2, h=e1+0.2, $fn=fn);//cut top hole
  translate([0,0,-0.1]) cylinder(d1=d4, d2=d4+2*e1, h=e1+0.2, $fn=fn);//cut bottom hole 45°
  translate([0,0,e1]) linear_extrude(height=h1-2*e1) polygon([[-d1/2+e1,0],[d1/2-e1,0],[w/2+trx-e1,try+belt],[-w/2+trx+e1,try+belt]]);
  translate([-w/2+trx+e1,try+belt-0.1,e1]) cube(size=[w-2*e1, yfan+e2+0.1, h1-2*e1]);
  translate([-w/2+trx+e1,try+belt+e2,h1-e1-0.1]) cube(size=[w-2*e1, yfan,e1+0.1]);
  translate([w/2+trx-e1-xfan,try+belt+e2,h1-0.1]) cube(size=[xfan,yfan,e1+e3+0.2]);
  }
//central cone
difference(){
  cylinder(h=h1, d1=d3+2*e1, d2=d2+2*e1, $fn=fn);
  translate ([0,0,-0.05]) cylinder(h=h1+0.1, d1=d3, d2=d2, $fn=fn);  
}
x=tan(oh)*belt; //overhang
xholes=trx+w/2-e1; //fan holes base
yholes=try+belt;   //fan holes base
difference(){
  union(){
    translate ([trx+w/2,try+belt+e2,0]) rotate ([90,0,-90]) linear_extrude(height=w) polygon([[0,h1],[0,h2+h2t],[e2+belt,h2+h2t],[e2+belt,h2-h2t],[e2,h2-h2t-x],[e2,h1]]);
  }
  translate([trx-w/2+e1,try+e2,h2-h2t]) cube([w-2*e1,belt+0.1,2*h2t+0.1]);
  //translate([trx-w/2+e1,try+belt-0.01,h2-h2t]) cube([w-2*e1-xh2-dhole2/2-3,e2+0.02,2*h2t+0.1]);
  //fanduct fasteners holes
  translate ([trx-spacing/2-dhole1/2,try-0.5,h2-h2t]) cube([dhole1,e2+1,2*h2t+0.1]);
  translate ([trx+spacing/2-dhole1/2,try-0.5,h2-h2t]) cube([dhole1,e2+1,2*h2t+0.1]);
  //fan screw holes
  translate([xholes-xh1, yholes, h1+yh1+e1]) rotate([-90,0,0]) cylinder(d=dhole2, h=e2+0.1);
  //hex nut
  translate([xholes-xh1, yholes-1, h1+yh1+e1]) rotate([-90,0,0]) rotate([0,0,90]) cylinder(d=nut*2/sqrt(3), h=e2, $fn=6);
  //translate([xholes-xh2, yholes-1, h1+yh2]) rotate([-90,0,0]) cylinder(d=nut*2/sqrt(3), h=e2, $fn=6);
  //cut for the belt tensionner
  translate([trx-w/2-1,try-1,h2-h2t-x]) cube([w/2-spacing/2-dhole1/2-3+1,belt+e2+2,h2t*2+x+1]);
  
}
//second fan screw hole
cubex=xh2+nut/2+e1;
difference(){
  translate([trx+w/2-cubex-e1,try+belt,h2-h2t]) 
  cube([cubex,e2,h1+e1+yh2+nut/2+e1-(h2-h2t)]);
  translate([xholes-xh2, yholes, h1+yh2+e1]) rotate([-90,0,0]) cylinder(d=dhole2, h=e2+0.1);
  translate([xholes-xh2, yholes-1, h1+yh2+e1]) rotate([-90,0,0]) rotate([0,0,90]) cylinder(d=nut*2/sqrt(3), h=e2, $fn=6);
}
//ribs
nerv=belt; //size
x2=nerv*(trx+w/2-d1/2)/(try+belt);  //thales: displace the rib to stay on the top of h1
//top rib
translate([trx,try+e2,h2-h2t]) rotate([90,0,90]) linear_extrude(height=e4, center=true) polygon([[0,0],[0,h2t*2],[belt,0]]);
//displace the ribs considering trx
if ((trx+w/2)>(d1/2)){
  translate([trx+w/2-e4/2-x2,try+belt,h1]) rotate([0,-90,0]) linear_extrude(height=e4, center=true) polygon([[0,0],[0,-nerv],[nerv,0]]);
  translate([trx-w/2+e4/2,try+belt,h1]) rotate([0,-90,0]) linear_extrude(height=e4, center=true) polygon([[0,0],[0,-nerv],[nerv,0]]);
}
else {
translate([trx+w/2-e4/2,try+belt,h1]) rotate([0,-90,0]) linear_extrude(height=e4, center=true) polygon([[0,0],[0,-nerv],[nerv,0]]);
translate([xholes-xh1+nut/2+e4,try+belt,h1]) rotate([0,-90,0]) linear_extrude(height=e4) polygon([[0,0],[0,-nerv],[nerv,0]]);
}

angle=atan(h1/((d2-d3)/2));
echo("Duct Angle:", angle);
