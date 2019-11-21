//Thickness
slide_thickness = 10;

//Number of slides
sausage_slides = 4;

//Sausage radius
sausage_radius = 25/2;

//Number of spaghettis to insert
spaghettis =7;

//Spaghetti radius
spaghetti_radius = 1.2;

//Wall thickness
wall = 2;




    union() {
        for(i=[0:sausage_slides-1]) {
            translate([0,(wall+slide_thickness)*i,0]) 
                union(){
                    difference() {
                        cube([sausage_radius*2+2*wall,wall+slide_thickness,sausage_radius*2+2*wall],  center = true); //base
                        rotate([90,0,0]) cylinder(h=slide_thickness+2*wall, r=sausage_radius, center = true, $fn=200); //cilindro agujereado
                        translate([0,0,sausage_radius]) cube([2*sausage_radius+4*wall,slide_thickness+2*wall,2*sausage_radius ], center = true); //quitatapas
                    }
                    difference() {
                         translate([0,-(slide_thickness)/2,0]) rotate([90,0,0]) cylinder(h=wall, r=sausage_radius, center=true, $fn=200);
                        
                        if(spaghettis%2 == 1) {
                            translate([0,-(slide_thickness)/2,sausage_radius]) cube([2*spaghetti_radius, 3*wall, 2*sausage_radius], center=true);
                            translate([0,-(slide_thickness)/2,0]) rotate([90,0,0]) cylinder(h=3*wall, r=spaghetti_radius, center=true, $fn=200);
                        } 
                        for(i=[1:spaghettis/2]) {
                            x = sausage_radius*0.7*cos(180*(2*i-1)/(spaghettis-spaghettis%2));
                            
                            z = -sausage_radius*0.7*sin(180*(2*i-1)/(spaghettis-spaghettis%2));
                            
                            translate([x,-(slide_thickness)/2,z+sausage_radius]) cube([2*spaghetti_radius, 3*wall, 2*sausage_radius], center=true);
                            translate([x,-(slide_thickness)/2,z]) rotate([90,0,0]) cylinder(h=3*wall, r=spaghetti_radius, center=true, $fn=200);
                        
                        }
                    }
                }
        }
        translate([0,(slide_thickness+wall)*(sausage_slides)-slide_thickness/2,0]) 
        union() {
            difference() {
                        cube([sausage_radius*2+2*wall,wall,sausage_radius*2+2*wall],  center = true); //base
                        rotate([90,0,0]) cylinder(h=2*wall, r=sausage_radius, center = true, $fn=200); //cilindro agujereado
                        translate([0,0,sausage_radius]) cube([2*sausage_radius+4*wall,slide_thickness+2*wall,2*sausage_radius ], center = true); //quitatapas
                    }
        difference() {
                        translate([0,0,0]) rotate([90,0,0]) cylinder(h=wall, r=sausage_radius, center=true, $fn=200);
                        if(spaghettis%2 == 1) {
                            translate([0,0,sausage_radius]) cube([2*spaghetti_radius, 3*wall, 2*sausage_radius], center=true);
                            translate([0,0,0]) rotate([90,0,0])  cylinder(h=3*wall, r=spaghetti_radius, center=true, $fn=200);
                        } 
                        for(i=[1:spaghettis/2]) {
                            x = sausage_radius*0.7*cos(180*(2*i-1)/(spaghettis-spaghettis%2));
                            
                            z = -sausage_radius*0.7*sin(180*(2*i-1)/(spaghettis-spaghettis%2));
                            
                            translate([x,0,z+sausage_radius]) cube([2*spaghetti_radius, 3*wall, 2*sausage_radius], center=true);
                            translate([x,0,z]) rotate([90,0,0]) cylinder(h=3*wall, r=spaghetti_radius, center=true, $fn=200);
                        
                        }
                    }
                }
    }
    
    
// Written by Javier de la Rubia <me@jrubia.es>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
 