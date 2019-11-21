/********************************
Project:	Biblioduino
Date:		september 2014
Hubout Makers Lab
Designed by: Andrea Mantelli

Biblioduino is born in september 2014 at Hubout Makers Lab from an idea of Andrea Mantelli, Giorgio Rancilio, Andrea Sottocornola.
This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
To read a copy of the licence goes to the web page:
http://creativecommons.org/licenses/by-sa/4.0/
*********************************/

// preview[view:south east, tilt:top]

// Which one would you like to see?
part = "both"; // [first:Personalized Box Only, second:Box Enclosure Only, both:Personalized Box and enclosure]

//Internal Lenght of the module
lenght_module = 1;  //[1:24, 2:54, 3:84, 4:110, 5:140]
x = lenght_module;

//Internal Widht of the module
width_module = 1;  //[1:24, 2:54, 3:84, 4:110, 5:140]
y = width_module;

//internal Height of the module (standard = 18.5)
internal_height = 18.5;      //[18.5 : 0.5 : 50]

hole_type = 0;          //[0:Circular, 1:Rectangular]
radius_hole = 5.2;      //[0.4 : 0.2 : 100]
rectangle_lenght =10;   //[1 : 100]    
rectangle_width = 10;   //[1 : 100]
h = internal_height+1.6;
s = h-11.6;



/* [Hidden] */
m = 3+0;          //profondità denti
t = 0.3+0;        //tolleranza
f = 0.7+0;        //raggio fillet
k = 7+0;          //larghezza dente
l = 1+0;          //strizione dente
a = 30+0;         //larghezza modulo
p = 1.4;          //spessore pareti
$fn=32;           //accuratezza circolare
//supplementar calculation constants
b1 = k+t;
b2 = k-l+t;
c1 = k-t;
c2 = k-l-t;

//////////////////////////////////////////////////////////////////////////////////

print_part();

//////////////////////////////////////////////////////////////////////////////////

module print_part() {
	if (part == "first") {
		personalized_box();
	} else if (part == "second") {
		box_enclosure();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}


//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//module constructing Biblioduino Boxes///////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module base_shape() {
    
    union() { 
        
        for (j = [0:1:y-1]) {
            
            translate([0,j*a])
            
            for (i = [0:1:x-1]) {
                
                translate([i*a,0])
                polygon([[0,0],[b1,0],[b2,-m],[a-b2,-m],[a-b1,0],[a,0],[a,c1],[a-m,c2],[a-m,a-c2],[a,a-c1],[a,a],[a-c1,a],[a-c2,a-m],[c2,a-m],[c1,a],[0,a],[0,a-b1],[-m,a-b2],[-m,b2],[0,b1]],true);
            }
        }
    
    polygon([[p,p],[(a*x)-p-m,p],[(a*x)-p-m,(a*y)-p-m],[p,(a*y)-p-m]],true);
        
    }
}


//////////////////////////////////////////////////////////////////////////////////

module Box() {
    
    translate([-((a*x)-m)/2,-((a*y)-m)/2])
    difference() {
        union() {
            linear_extrude(height = s, center = false, convexity = 100, twist = 0)
            rounding(r=f)
            base_shape();
        
            linear_extrude(height = h, center = false, convexity = 100, twist = 0) 
            polygon([[0,0],[(a*x)-m,0],[(a*x)-m,(a*y)-m],[0,(a*y)-m]],true);
        }

        translate([0,0,1.5]) linear_extrude(height = h, center = false, convexity = 100, twist = 0) 
        polygon([[p,p],[(a*x)-p-m,p],[(a*x)-p-m,(a*y)-p-m],[p,(a*y)-p-m]],true);
    }
}




//////////////////////////////////////////////////////////////////////////////////

module personalized_box() {
    difference() {
    
        Box();
    
        translate([-(a*x/2)+5.75,-(a*y/2)+5.75])
        cylinder(20,d = 3.5,center=true);
    
        if (hole_type == 0)    {
            translate([0.6,0.6])
            cylinder(20,r = radius_hole,center=true);
        } 
        if (hole_type == 1)    {
            translate([1.8,1.8])
            cube([rectangle_lenght,rectangle_width,20],center=true);
        }
    }
}




//////////////////////////////////////////////////////////////////////////////////

module box_enclosure() {
    difference() {
        union() {
            linear_extrude(height = 1.5, center = false, convexity = 100, twist = 0)
            rounding(r=f)
            square([(a*x)-m,(a*y)-m], center = true);
    
            linear_extrude(height = 3, center = false, convexity = 100, twist = 0)
            rounding(r=3+p)
            square([(a*x)-m-2*p-2*t,(a*y)-m-2*p-2*t], center = true);
        }
        translate([0,0,1.5])
        linear_extrude(height = 3, center = false, convexity = 100, twist = 0)
        rounding(r=3)
        square([(a*x)-m-4*p-2*t,(a*y)-m-4*p-2*t], center = true);
    }
}

//////////////////////////////////////////////////////////////////////////////////

module both() {
    if (x>y) {
        translate([0, (((a*y)-m)/2)+8, 0]) personalized_box();
        translate([0, -(((a*y)-m)/2)-5, 0]) box_enclosure();
    }
    else {
        translate([-(((a*x)-m)/2)-8, 0, 0]) personalized_box();
        translate([(((a*x)-m)/2)+5, 0, 0]) box_enclosure();
    }
}



//////////////////////////////////////////////////////////////////////////////////
// morphology.scad
// Copyright (c) 2013 Oskar Linde. All rights reserved.
// License: BSD
//
// This library contains basic 2D morphology operations
//
// outset(d=1)            - creates a polygon at an offset d outside a 2D shape
// inset(d=1)             - creates a polygon at an offset d inside a 2D shape
// fillet(r=1)            - adds fillets of radius r to all concave corners of a 2D shape
// rounding(r=1)          - adds rounding to all convex corners of a 2D shape
// shell(d,center=false)  - makes a shell of width d along the edge of a 2D shape
//                        - positive values of d places the shell on the outside
//                        - negative values of d places the shell on the inside
//                        - center=true and positive d places the shell centered on the edge
//////////////////////////////////////////////////////////////////////////////////

module outset(d=1) {
	// Bug workaround for older OpenSCAD versions
	if (version_num() < 20130424) render() outset_extruded(d) children();
	else minkowski() {
		circle(r=d);
		children();
	}
}

module outset_extruded(d=1) {
   projection(cut=true) minkowski() {
        cylinder(r=d);
        linear_extrude(center=true) children();
   }
}

module inset(d=1) {
	 render() inverse() outset(d=d) inverse() children();
}

module fillet(r=1) {
	inset(d=r) render() outset(d=r) children();
}

module rounding(r=1) {
	outset(d=r) inset(d=r) children();
}

module shell(d,center=false) {
	if (center && d > 0) {
		difference() {
			outset(d=d/2) children();
			inset(d=d/2) children();
		}
	}
	if (!center && d > 0) {
		difference() {
			outset(d=d) children();
			children();
		}
	}
	if (!center && d < 0) {
		difference() {
			children();
			inset(d=-d) children();
		}
	}
	if (d == 0) children();
}


// Below are for internal use only

module inverse() {
	difference() {
		square(1e5,center=true);
		children();
	}
}
//////////////////////////////////////////////////////////////////////////////////