//-----------------------------------------------------
// Customisable box 
// 2017 - Fumee Bleue
//-----------------------------------------------------
// 24 oct 2017 - V1.00 - Create
// 25 oct 2017 - V1.01 - Add vents
// 10 nov 2017 - V1.02 - Add invert option
//                     - Footbox length update
//                     - Vents update (logo)
//                     - Use screw_holes.scad librarie https://www.thingiverse.com/thing:1731893
// 12 nov 2017 - V1.03 - Replace png to svg logo/vents - increase speed render
// 17 nov 2017 - V1.04 - Bug fix
// 18 dec 2017 - V1.05 - Bug fix on ajust parameter
// 04 feb 2018 - V1.06 - Add simple cover option
//                     - Add lcd position parameters
// 28 jul 2019 - V1.07 - Text bug fix
//                     - Remove translate warning
//                     - Remove bad character for customiser engine
//-----------------------------------------------------
include <screw_holes.scad>
include <fb.scad>

/* [Box dimensions] */
// Inside width box - Largeur interne(mm)
width_in = 35;
// Inside length box - Longeur interne (mm)
length_in = 60;
// Inside height box - Hauteur interne (mm)
height_in = 25;
// Thick wall - Epaisseur (mm)
thick = 2; //[2:5]

/* [Box options] */
// Invert - Inversion boite
invert=false; 
// Simple cover - Couvercle simple
simple_cover=false; 
// screw diameter - Diametre trou (mm)
screw_dia = 3;
// Plate length - Longeur patte (mm)
length_plate = 10;
// Ajust - Ajustement pieces (mm)
ajust=0.3*1; 

/* [Box Extras] */
// Text - Affichage texte
flag_text=true;
// - Text 
txt = "Fumee Bleue";      
// - Font size  
txt_size = 4;       
// - Font  
police = "Arial Black"; 
// Lcd panel - Affichage fenetre LCD
flag_lcd=true;
// - Width lcd panel
width_lcd = 20;
// - Length lcd panel
length_lcd = 30;
// Lcd center - Position de fenetre LCD au centre
center_pos_lcd=true;
// - Pos x lcd panel
pos_x_lcd = 2;
// - Pos y lcd panel
pos_y_lcd = 2;
// Pcb feet - Pieds Pcb
flag_pcb = true;
// Vent - Event
flag_vent=true;
// Through - Traversant
throught_vent=false;

/* [Others] */
radius = 2*thick/3; 
posx_lcd = width_in/2;
posy_lcd = length_in/2;

//------------------------------------
// Vent
//------------------------------------
module Vent(){  
    if (throught_vent == true) {
        rotate([90,0,180]) resize(newsize=[height_in/3,height_in/1.5,0]) {
            poly_path4398(2*thick);
            poly_path4452(2*thick);
            poly_path4360(2*thick);
        }   
    }
    else {
        rotate([90,0,180]) translate([0,0,-thick]) resize(newsize=[height_in/3,height_in/1.5,0]) {
            poly_path4398(2*thick);
            poly_path4452(2*thick);
            poly_path4360(2*thick);
        }
    }
}

//------------------------------------
// Panel LCD
//------------------------------------
module PanelLcd(pwitdh_lcd, plength_lcd, pthick_lcd){  
   
    // lcd dimensions with thales... ;)
    pthick = 8*pthick_lcd;
    pwitdh = pthick*pwitdh_lcd/(pthick-pthick_lcd);
    plength = pthick*plength_lcd/(pthick-pthick_lcd);
        
    polyhedron(
        points=[ [plength/2,pwitdh/2,0],[plength/2,-pwitdh/2,0],[-plength/2,-pwitdh/2,0],[-plength/2,pwitdh/2,0], // the four points at base
                [0,0,pthick]  ],                                 // the apex point 
        faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
                [1,0,3],[2,1,3] ]                         // two triangles for square base
    );
}

//------------------------------------
// Text
//------------------------------------
module Text_logo(x, y, z, buffer) {
    translate([x,y,z]){// x,y,z
          rotate([270,180,90]){
              linear_extrude(height = 2){
                text(buffer, font = police, size = txt_size,  valign ="center", halign ="center");
              }
          }
    }
}

//------------------------------------
// Rouned box
//------------------------------------
module RoundedBox(pwitdh, plength, pheight, plate){
    translate([radius,radius,0]) {
        if (plate == true) {
            minkowski(){
                cube([pwitdh-2*radius,plength-2*radius,pheight-1]);
                cylinder(r=radius,$fs=0.1, h=1);
            }
        }
        else {
            translate([0,0,radius]) {
                difference() {
                    minkowski () {
                        cube([pwitdh-2*radius,plength-2*radius,pheight-1]);
                        sphere (r=radius, $fs=0.1, 1);
                    }  
                    translate([-2*radius, -2*radius, pheight-radius]) cube ([pwitdh+2*radius,plength+2*radius,2*radius]);
                }
            }
        }
    }
}

//------------------------------------
// Foot box
//------------------------------------
module FootBox(lp,l,w,t){

    difference() {
        RoundedBox(w, l+2*lp+radius, t, true);
        translate([screw_dia+radius/2, screw_dia+radius/2, 0]) cylinder(d=screw_dia, h=2*t, $fs=0.1);
        translate([w-(screw_dia+radius/2), screw_dia+radius/2]) cylinder(d=screw_dia, h=2*t, $fs=0.1);
        translate([w-(screw_dia+radius/2), l+2*lp-screw_dia+radius/2]) cylinder(d=screw_dia, h=2*t, $fs=0.1);
        translate([screw_dia+radius/2, l+2*lp-screw_dia+radius/2]) cylinder(d=screw_dia, h=2*t, $fs=0.1);
    }
 
}

//------------------------------------
// Screw Box
//------------------------------------
module ScrewBox(height){
    difference(){
        union(){
            translate([screw_dia/3, screw_dia/3, 0]) cylinder(d=screw_dia*2.2, h=height, $fs=0.1);
            translate([-screw_dia, -screw_dia, 0]) {
                cube([screw_dia,2.2*screw_dia,height], false);
            }
            translate([-screw_dia, -screw_dia, 0]){
                cube([2.2*screw_dia,screw_dia,height], false);
            }
        }
        translate([screw_dia/3, screw_dia/3, 0]) cylinder(d=screw_dia, h=height+0.1, $fs=0.1);
    }
}

//------------------------------------
// Pcd feet
//------------------------------------
module PcbFeet(h){
    translate([2*thick+screw_dia,2*thick+3*screw_dia,thick]) {
        difference() {
            cylinder(d=2*screw_dia, h=h, $fs=0.1);
            cylinder(d=screw_dia, h=h+.01, $fs=0.1);
        }
    }
    translate([width_in-2*thick-screw_dia,2*thick+3*screw_dia,thick]) {
        difference() {
            cylinder(d=2*screw_dia, h=h, $fs=0.1);
            cylinder(d=screw_dia, h=h+.01, $fs=0.1);
        }
    }
    translate([2*thick+screw_dia,length_in-2*thick-3*screw_dia,thick]) {
        difference() {
            cylinder(d=2*screw_dia, h=h, $fs=0.1);
            cylinder(d=screw_dia, h=h+.01, $fs=0.1);
        }
    }
    translate([width_in-2*thick-screw_dia,length_in-2*thick-3*screw_dia,thick]) {
        difference() {
            cylinder(d=2*screw_dia, h=h, $fs=0.1);
            cylinder(d=screw_dia, h=h+.01, $fs=0.1);
        }
    }
}

//------------------------------------
// Main Box
//------------------------------------
module MainBox(){
    
    // create main box -----------------------
	difference() {
		if (invert == false) {
            if (simple_cover == false) RoundedBox(width_in, length_in, height_in, true);
               else translate([0,length_in,height_in]) rotate([180,0,0]) RoundedBox(width_in, length_in, height_in, false);
        }
        else {
            RoundedBox(width_in, length_in, height_in, false);
        }
        translate([thick,thick,thick]) {
		    cube([width_in-2*thick, length_in-2*thick, height_in]);
		}
        translate([thick-ajust,thick-ajust,height_in-thick-ajust/3]) {
		    cube([width_in-2*thick+2*ajust, length_in-2*thick+2*ajust, 3*thick]);
		}
        // text------------------------------------
        if (flag_text == true) {
            if (invert == false) {
                translate([1,-thick,2*height_in/3]) {
                    rotate([0,0,0]) Text_logo(0, length_in/2+thick, 0, txt);
                }
            }
            else {
                translate([1,-thick,height_in-(2*height_in/3)]) {
                    rotate([180,0,0]) Text_logo(0, -length_in/2-thick, 0, txt);
                }
            }
        }
        // create vents ---------------------------
        if (flag_vent == true) {
            translate([width_in/2, -thick/2, height_in/2]) Vent(); 
            translate([width_in/2,length_in+thick/2,height_in/2]) rotate([0,0,180]) Vent();
        }
        
        // lcd --------------------
        if (invert == true) {
            translate([posx_lcd, posy_lcd, -0.01]){
                if (center_pos_lcd == true) rotate([0,0,90]) PanelLcd(width_lcd, length_lcd, thick);
                    else translate([pos_y_lcd, pos_x_lcd,0]) rotate([0,0,90]) PanelLcd(width_lcd, length_lcd, thick);
            }
        }
        
	}

    // create srews ---------------------------
	translate([screw_dia+thick,screw_dia+thick,thick]) {
		ScrewBox(height_in-2*thick-ajust/3);
	}
	translate([width_in-screw_dia-thick,screw_dia+thick,thick]) {
		rotate([0,0,90]) ScrewBox(height_in-2*thick-ajust/3);
	}
	translate([width_in-screw_dia-thick,length_in-screw_dia-thick,thick]) {
		rotate([0,0,180]) ScrewBox(height_in-2*thick-ajust/3);
	}
	translate([screw_dia+thick,length_in-screw_dia-thick,thick]) {
		rotate([0,0,270]) ScrewBox(height_in-2*thick-ajust/3);
	}
    
    // create foot box -----------------------
    if (invert == false) {
        // create feet pcb -----------------------
        if (flag_pcb == true) {
            PcbFeet(3);
        }
        translate([0, -length_plate-thick/4, 0]) FootBox(length_plate, length_in, width_in, thick);
    }

}

//------------------------------------
// Top Box
//------------------------------------
module TopBox(){
    
    difference() {
        union() {
            
            
            if (simple_cover == false || invert == true) {
                RoundedBox(width_in, length_in, thick, false);
                
                difference() {
                    translate([thick, thick, thick]) cube([width_in-2*thick, length_in-2*thick, thick]);
                    translate([2*thick, 2*thick, thick]) cube([width_in-4*thick, length_in-4*thick, thick+0.01]);
                }
                
                translate([thick+screw_dia,thick+screw_dia,thick]) {
                    ScrewBox(thick);
                }
                translate([width_in-screw_dia-thick,thick+screw_dia,thick]) {
                    rotate([0,0,90]) ScrewBox(thick);
                }
                translate([width_in-screw_dia-thick,length_in-screw_dia-thick,thick]) {
                    rotate([0,0,180]) ScrewBox(thick);
                }
                translate([thick+screw_dia,length_in-screw_dia-thick,thick]) {
                    rotate([0,0,270]) ScrewBox(thick);
                }
            }
            else {
                translate([thick, thick, 0]) cube([width_in-2*thick, length_in-2*thick, thick]);
            }
            
            if (invert == true) {
                translate([0, -length_plate-thick/4, 0]) FootBox(length_plate, length_in, width_in, thick);
            }
        }
        
        if (invert == true) {
            translate([thick+screw_dia+screw_dia/3,thick+screw_dia+screw_dia/3,-.5]) {
                screw_hole(DIN34811, M3, 3*thick);
            }
            translate([width_in-screw_dia-thick-screw_dia/3,thick+screw_dia+screw_dia/3,-.5]) {
                screw_hole(DIN34811, M3, 3*thick);
            }
            translate([width_in-screw_dia-thick-screw_dia/3,length_in-screw_dia-thick-screw_dia/3,-.5]) {
                screw_hole(DIN34811, M3, 3*thick);
            }
            translate([thick+screw_dia+screw_dia/3,length_in-screw_dia-thick-screw_dia/3,-.5]) {
                screw_hole(DIN34811, M3, 3*thick);
            }
        }
        else {
            if (simple_cover == false) {
                translate([thick+screw_dia+screw_dia/3,thick+screw_dia+screw_dia/3,-thick]) {
                    screw_hole(ISO4762, M3, 3*thick);
                }
                translate([width_in-screw_dia-thick-screw_dia/3,thick+screw_dia+screw_dia/3,-thick]) {
                    screw_hole(ISO4762, M3, 3*thick);
                }
                translate([width_in-screw_dia-thick-screw_dia/3,length_in-screw_dia-thick-screw_dia/3,-thick]) {
                    screw_hole(ISO4762, M3, 3*thick);
                }
                translate([thick+screw_dia+screw_dia/3,length_in-screw_dia-thick-screw_dia/3,-thick]) {
                    screw_hole(ISO4762, M3, 3*thick);
                }
            }
            else {
                translate([thick+screw_dia+screw_dia/3,thick+screw_dia+screw_dia/3,-thick]) {
                    screw_hole(ISO4762, M3, 3*thick);
                }
                translate([width_in-screw_dia-thick-screw_dia/3,thick+screw_dia+screw_dia/3,-thick]) {
                    screw_hole(ISO4762, M3, 3*thick);
                }
                translate([width_in-screw_dia-thick-screw_dia/3,length_in-screw_dia-thick-screw_dia/3,-thick]) {
                    screw_hole(ISO4762, M3, 3*thick);
                }
                translate([thick+screw_dia+screw_dia/3,length_in-screw_dia-thick-screw_dia/3,-thick]) {
                    screw_hole(ISO4762, M3, 3*thick);
                }
            }
        }
        
        // lcd --------------------
        if (invert == false && flag_lcd == true) {
            translate([posx_lcd, posy_lcd, -0.001]){
                if (center_pos_lcd == true) rotate([0,0,90]) PanelLcd(width_lcd, length_lcd, thick);
                else translate([pos_y_lcd, pos_x_lcd,0]) rotate([0,0,90]) PanelLcd(width_lcd, length_lcd, thick);
            }
        }  
    }  
}



//------------------------------------
// Main
//------------------------------------
MainBox();

translate([-width_in-20,0,0]) {
	if (simple_cover == false || invert == true) TopBox();
        else translate([40,0,thick]) rotate([0, 180, 0]) TopBox();
}

