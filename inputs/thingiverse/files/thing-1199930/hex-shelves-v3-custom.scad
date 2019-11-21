/* hexagonal shelving clips
Gian Pablo Villamil
May 2015

Clips designed to hold wooden shelves in a hexagonal array

Default to work with 3/4 inch plywood

*/

shelf_thick = 5; // 3/4 inch in mm, thickness of wood
wall_thick = 3; //thickness of bracket sides
wall_length = 25; // length of the bracket
depth = 25 ; //epth of the bracket
bracket_thick = shelf_thick+wall_thick*2;
screw_dia = 4.75; // #8 size screw is 4.75
tri_height = sqrt(pow(bracket_thick,2)-pow(bracket_thick/2,2)); // calculate the height of an equilateral triangle
centroid = tan(30) * (bracket_thick/2);
closed = false;
corner_rad = 1;
floor_thick = 3;
$fn=16;

echo(centroid);

module wall() {
    translate([shelf_thick/2,0,0]) 
    translate([0,0,0]) 
        difference() {
                                                                   //cube([wall_thick,wall_length,depth]);
            union() {
                translate([wall_thick/2,wall_length/2,depth/2]) roundedBox([wall_thick,wall_length,depth],corner_rad,true);
                cube([wall_thick,2,depth]);
            };
            translate([wall_thick/2,wall_length/2,depth/2])
            rotate([0,90,0])
            cylinder(h=wall_thick+1,d=screw_dia,center=true,$fn=16);
        }
    };

module bracket() {
    translate([0,centroid-0.1,0]){
        wall();
        mirror([1,0,0]) 
        wall();
        if (closed ) {
        translate([0,wall_length/2,floor_thick/2]) roundedBox([bracket_thick,wall_length,floor_thick],corner_rad,true); }
        };
    };
    
module bracketleg() {
    translate([0,centroid-0.1,0]){
        union() {
            wall();
            translate([-depth/5+0.1,wall_length/2,depth/2])
            rotate([0,270,0])
            cylinder(r1=depth/2.5,r2=depth/6,h=depth/2.5); 
        }
        mirror([1,0,0]) 
        wall();
        if (closed ) {
        translate([0,wall_length/2,floor_thick/2]) roundedBox([bracket_thick,wall_length,floor_thick],corner_rad,true); }
        };
    };
    
    
module hanger() {
    translate([0,centroid-0.1+bracket_thick/2,floor_thick/2])
    difference() {
    union() {
        roundedBox([bracket_thick,bracket_thick,floor_thick],bracket_thick/2,true,$fn=32);
        translate([0,-bracket_thick/4,0]) cube([bracket_thick,bracket_thick/2,floor_thick],center=true);
    }
    cylinder(h=floor_thick+1,d=screw_dia,center=true);
}
}
    
module hub() {
    difference() {
    translate([0,centroid,0]) 
    linear_extrude(height=depth) {
        polygon(points=[[-bracket_thick/2,0],[0,-tri_height],[bracket_thick/2,0]]);}
        translate([0,0,-0.5]) cylinder(r=shelf_thick/4,h=depth+1);
    
        }
    }
    
module threewaybracket() {
    union() {
        hub();
        bracket();
        rotate([0,0,120]) bracket();
        rotate([0,0,240]) bracket();
        }
    };
    
module twowaybracket() {
    union() {
        hub();
        bracket();
        rotate([0,0,120]) bracket();
        }
    };
    
module twowaybracket_leg() {
    union() {
        hub();
        bracket();
        rotate([0,0,120]) bracketleg();
        }
    };    
    
module twowaybracket_hanger() {
    union() {
        hub();
        hanger();
        rotate([0,0,120]) bracket();
        rotate([0,0,240]) bracket();
        }
    };    
    
module twowaybracket_tensioner() {
    union() {
        hub();
        rotate([0,0,180]) translate([0,centroid,0])
        hanger();
        rotate([0,0,120]) bracket();
        rotate([0,0,240]) bracket();
        }
    };    
    // Library: boxes.scad
// Version: 1.0
// Author: Marius Kintel
// Copyright: 2010
// License: BSD

// roundedBox([width, height, depth], float radius, bool sidesonly);

// EXAMPLE USAGE:
// roundedBox([20, 30, 40], 5, true);

// size is a vector [w, h, d]
module roundedBox(size, radius, sidesonly)
{
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];
  if (sidesonly) {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
    }
  }
  else {
    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis])
          translate([x,y,0])
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius);
    }
  }
}

    
//twowaybracket();   
//twowaybracket_hanger();
//twowaybracket_leg();
//
twowaybracket_tensioner();

//threewaybracket();    
// bracket();
// hub();