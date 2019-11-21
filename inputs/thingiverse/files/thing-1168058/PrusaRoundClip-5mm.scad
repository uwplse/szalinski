//*******************************************************
// ********** Prusa Rounded Clip by MacFly **************
// **            made dec 02 2015                      **
//*******************************************************

//--------------------------------------------------------------------------------------//
$fn = 100;
CYLINDER_HEIGHT = 20;         // cylinder height mm - Hauteur du cylindre en mm
CYLINDER_RADIUS = 8.80;      // cylinder radius mm - Rayon du cylindre en mm
TAB_LENGTH = 15;            //  Tab length - longueur de la languette en mm
TAB_THICKNESS = 3;         // 5mm thickness - Epaisseur de la languette
TAB_WIDTH = 10;           // Tab width mm - Largeur de la languette en mm
SCREW_HOLE_RADIUS = 1.5; // screw hole radius - Diamètre du trou pour la vis
SCREW_HOLE_OFFSET = 5; // tab screw hole 5mm from the edge - distance du trou 5mm du bord extérieur
EXTRUSION_THICKNESS = 6; // 8.80 - 6 = 2.8 / 2 = 1.4mm shell thickness - Epaisseur de l'extrusion intérieur du cylindre

module Maincylinder()
    {
    difference(){
        
            cylinder(r=CYLINDER_RADIUS, h=CYLINDER_HEIGHT);
            translate([0,0,5]) ExtruCylinder();
        }
        
      
        
    }
module ExtruCylinder()
    {    
            #cylinder(r=EXTRUSION_THICKNESS, h=CYLINDER_HEIGHT - 10);  
    }
module tab()
    {
        
    difference() 
        {
            translate([0,0,0]) rotate([90,90,0]) cube([TAB_LENGTH,TAB_WIDTH,TAB_THICKNESS]);
            translate([5,75,-SCREW_HOLE_OFFSET - 1.5]) rotate([90,90,0]) #cylinder(r=SCREW_HOLE_RADIUS,h=150);
        }
    }


Maincylinder();
    translate([-TAB_WIDTH/2,TAB_THICKNESS + 2.5,CYLINDER_HEIGHT + TAB_LENGTH]) tab();
    translate([-TAB_WIDTH/2,-2.5,CYLINDER_HEIGHT + TAB_LENGTH]) tab();

