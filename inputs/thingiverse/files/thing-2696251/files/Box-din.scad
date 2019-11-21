//-----------------------------------------------------
// Customisable din box 
// 2017 - Fumee Bleue
//-----------------------------------------------------
// 04 dec 2017 - V1.00 - Create
// 11 dec 2017 - V1.01 - Screw_dia bug fix
//                     - Add ajust parameter
// 28 jul 2019 - V1.02 - Text bug fix
//                     - Remove bad character for customiser engine
// 21 oct 2019 - V1.03 - Remove warning with last version of openscad
//-----------------------------------------------------
include <screw_holes.scad>
include <fb.scad>


width_module = 18*1; //hidden
// Number module - Nombre de module
nbr_module = 1;
// Thick wall - Epaisseur (mm)
thick = 1.6; 

// screw diameter - Diametre trou (mm)
screw_dia = 3.1;

// Ajust - Ajustement pieces (mm)
ajust=0.2; 

// Logo - Affichage logo
flag_logo=true;
// Text - Affichage texte
flag_text=true;

// - Text 
txt = "Fumee Bleue";      
// - Font size  
txt_size = 5;       
// - Font  
police = "Arial Black"; 

// Lcd panel - Affichage fenetre LCD
flag_lcd=true;
// - Width lcd panel
width_lcd = 10;
// - Length lcd panel
length_lcd = 15;

expected_measurement = 8*1;
actual_measurement = 8*1;
gain_adjust = expected_measurement / actual_measurement; // Default = 8/8 = 1
lock_screw_length = 8*1; 
lock_nut_height = 2.4 * gain_adjust;
radius = thick/2; //[1:5]



//------------------------------------
// Screw Box
//------------------------------------
module ScrewBox(height){
    difference(){
        union(){
            cylinder(d=screw_dia*2, h=height, $fs=0.1);
            translate([-screw_dia, -screw_dia, 0]) {
                cube([screw_dia,2*screw_dia,height], false);
            }
            translate([-screw_dia, -screw_dia, 0]){
                cube([2*screw_dia,screw_dia,height], false);
            }
        }
        cylinder(d=screw_dia, h=height+0.1, $fs=0.1);
    }
}

//------------------------------------
// Rouned box
//------------------------------------
module RoundedBox(pwitdh, plength, pheight, plate)
{
    translate([radius,radius,0]) {
        if (plate == true) {
            minkowski(){
                cube([pwitdh-2*radius,plength-2*radius,pheight-1]);
                cylinder(r=radius,$fs=0.1, h=1);
            }
        }
        else {
            translate([0,0,radius]) {
                minkowski () {
                    cube([pwitdh-2*radius,plength-2*radius,pheight-1]);
                    sphere (r=radius, $fs=0.1);
                }
            }
        }
    }
}

//------------------------------------
// Text
//------------------------------------
module Text(buffer, x, y, z) {
    translate([x,y,z]){// x,y,z
          rotate([270,180,90]){
              linear_extrude(height = 2){
                text(buffer, font = police, size = txt_size,  valign ="center", halign ="center");
              }
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
// Din feet
//------------------------------------
module din_feet(width){
    hull() {
        translate([1.8,0,0]) cylinder(h=width, r=1, $fs=0.1, center=false);
        translate([0,1.8,0]) cube([2.8,1,width], center=false);
    }
}

module MainBox()
{
    union () {
        difference() {
            union() {
                RoundedBox(90, width_module*nbr_module, 25, false);
                translate([15,0,0]) RoundedBox(60,width_module*nbr_module,45, false);
                translate([22.5,0,0]) RoundedBox(45,width_module*nbr_module,55, false);
            }
            translate([thick, thick, thick+6.5]) cube([90-2*thick,(width_module*nbr_module)-2*thick,25-2*thick-6.5]);
            translate([15+thick,thick,25-thick-.01]) cube([60-2*thick,(width_module*nbr_module)-2*thick,20]);
            translate([22.5+thick,thick,45-thick-.02]) cube([45-2*thick,(width_module*nbr_module)-2*thick,10]);
            translate([83-thick,thick,thick]) cube([7,(width_module*nbr_module)-2*thick,10]);
            
            // rail din location ----------------------
            translate([26+thick,-.01,-0.1]) cube([38-2*thick,(width_module*nbr_module)+.02,6.5]);
            
            // attach din location ----------------------
            translate([-0.01,(width_module*nbr_module)/2,3.5]) rotate([0, 90, 0]) cylinder(h=30, r=1.6, $fs=0.1, center=false);
            translate([10,((width_module*nbr_module)/2)-2.7,thick/2]) cube([15, 5.4, 5.4]);
            
            // add logo ----------------------
            translate([45,thick/2,33]) rotate([90, 0, 0]) resize(newsize=[20,35,0]) {
                poly_path4398(2*thick);
                poly_path4452(2*thick);
                poly_path4360(2*thick);
            }
            
            // add text ----------------------
            if (flag_text == true) rotate([0, 0, 90]) Text(txt, thick/2, -45, 10);
            
            // add srews holes ---------------------------------
            translate([90-thick-screw_dia,0,thick+screw_dia]) rotate([270, 0, 0]) screw_hole("DIN34811", M3, 3*thick);
            translate([69-thick+screw_dia,0,45-thick-screw_dia]) rotate([270, 0, 0]) screw_hole("DIN34811", M3, 3*thick);
            translate([thick+screw_dia,0,6.5+thick+screw_dia]) rotate([270, 0, 0]) screw_hole("DIN34811", M3, 3*thick);
            translate([15+thick+screw_dia,0,45-thick-screw_dia]) rotate([270, 0, 0]) screw_hole("DIN34811", M3, 3*thick);
            
            // add panl lcd --------------------------------
            if (flag_lcd == true) translate ([45, (width_module*nbr_module)/2, 54.01+thick]) rotate([0,180,0]) PanelLcd(width_lcd, length_lcd, thick);
        }  
        // add rail support ------------------------
        translate ([60, width_module*nbr_module, 3.8]) rotate([90,90,0]) din_feet(width_module*nbr_module);
        
    }
}

module BoxeFace1()
{
    difference() {
        union() {
            MainBox();
            color([0,0,1]) {
                // add internal srews ---------------------------------
                translate([90-thick-screw_dia,thick,thick+screw_dia]) rotate([90, 0, 180]) ScrewBox((width_module*nbr_module)/2-2*thick-ajust);
                translate([69-thick+screw_dia,thick,45-thick-screw_dia]) rotate([90, 90, 180]) ScrewBox((width_module*nbr_module)/2-2*thick-ajust);
                translate([thick+screw_dia,thick,6.5+thick+screw_dia]) rotate([90, 270, 180]) ScrewBox((width_module*nbr_module)/2-2*thick-ajust);
                translate([15+thick+screw_dia,thick,45-thick-screw_dia]) rotate([90, 180, 180]) ScrewBox((width_module*nbr_module)/2-2*thick-ajust);
            }
        }
        translate ([-5,(width_module*nbr_module/2),-.01]) cube([100,(width_module*nbr_module/2)+.01,65]);
    }
}

module BoxeFace2()
{
    difference() {
        MainBox();
        translate ([-.01, -.01,-.01]) cube([100,width_module*nbr_module/2,65]);
    }
    color([0,0,1]) {
            // add internal srews with ajust ---------------------------------
            difference() {
                translate([90-thick-screw_dia,(width_module*nbr_module)/2-thick,thick+screw_dia]) rotate([90, 0, 180]) ScrewBox((width_module*nbr_module)/2);
                translate([90-thick-ajust,(width_module*nbr_module)/2-2*thick,ajust]) cube([2, 2*thick, 3*screw_dia]);
                translate([90-thick-3*screw_dia,(width_module*nbr_module)/2-2*thick,ajust]) cube([3*screw_dia, 2*thick, 2]);
            }
                       
            difference() {
                translate([75-thick-screw_dia,(width_module*nbr_module)/2-thick,45-thick-screw_dia]) rotate([90, 90, 180]) ScrewBox((width_module*nbr_module)/2);    
                translate([75-thick-ajust,(width_module*nbr_module)/2-2*thick,45-thick-3*screw_dia]) cube([2, 2*thick, 3*screw_dia]);
                translate([75-3*screw_dia-ajust,(width_module*nbr_module)/2-2*thick,45-thick-ajust]) cube([3*screw_dia, 2*thick, 2]);
            }
            
            difference() {
                translate([thick+screw_dia,(width_module*nbr_module)/2-thick,6.5+thick+screw_dia]) rotate([90, 270, 180]) ScrewBox((width_module*nbr_module)/2);
                translate([ajust,(width_module*nbr_module)/2-2*thick,6.5+ajust]) cube([2, 2*thick, 3*screw_dia]);
                translate([ajust,(width_module*nbr_module)/2-2*thick,6.5+ajust]) cube([3*screw_dia, 2*thick, 2]);
            }
            
            difference() {
                translate([15+thick+screw_dia,(width_module*nbr_module)/2-thick,45-thick-screw_dia]) rotate([90, 180, 180]) ScrewBox((width_module*nbr_module)/2);
                translate([15+ajust,(width_module*nbr_module)/2-2*thick,45-thick-3*screw_dia]) cube([2, 2*thick, 3*screw_dia]);
                translate([15+ajust,(width_module*nbr_module)/2-2*thick,45-thick-ajust]) cube([3*screw_dia, 2*thick, 2]);
            }
            
    }
}



rotate ([90, 0, 0]) BoxeFace1();
translate ([0, 20, width_module*nbr_module]) rotate ([270, 0, 0]) BoxeFace2();
//translate ([0, 100, 0]) MainBox();
