// Square fan to pipe adapter - with square sections of fan - Version 2
// (this was inspired by 
// Includes handy gasket-maker
// This set of values fits a standard PC cooling fan to a flexible pipe
// Suggestions/improvements welcome - This is my first OpenSCAD project

// Pipe Side Dimentions (Default 3" hose)

// Zero to do the full adapter, 1 to only do a fan-side gasket
flange_gasket_only = 0;   
// If flange_gasket_only = 1 then use this as the flange gasket thickness
flange_gasket_thickness = 1;   


pipe_wall_thickness = 1.68;
// Pipe outside diameter | 3" pipe = 78.6 / 4" pipe = 106
pipe_od = 78.6;  
pipe_id = pipe_od - pipe_wall_thickness * 2;
pipe_length = 15; // length of straight section of pipe

// Transition Body

// Fan-to-pipe tranfer section length
transition_length = 15; 

// Fan Side Dimensions


fan_wall_thickness = 1.9;

// Fan outside diameter (92mm fan exhaust = 103.7 intake = 99)
fan_round_od = 103.7;  
fan_round_id = fan_round_od - fan_wall_thickness * 2;  // inside diameter of the round portion of the fan opening

// Fan square outside dimension (92mm fan exhaust or intake = 92)
fan_square_od = 92; 
fan_square_id = fan_square_od - fan_wall_thickness * 2; // the inside square dimension of the straight portion of the fan opening



plate_size = fan_square_od;
// Fan adapter plate thickness - adjust for optimum strength
plate_thickness = 3.0; 
// Plate corner fillet (2.5 closely matches the fan I have)
plate_corner_fillet_radius = 2.5;

// without this, the rotated fillets have a sliver left over from math error
fillet_fudge_factor = .01;  

// Screw hole spacing (these values fit my 92mm fan)
screw_hole_spacing = 83; 
// Screw hole diameter
screw_hole_diameter = 5; 

// minimum angle for an arc fragment
arc_fragment_angle = 1;  

// minimum size of an arc fragment
arc_fragment_size = .30;      

$fa = arc_fragment_angle;   // set fragment angle
$fs = arc_fragment_size;   // set fragment size
 

if(flange_gasket_only != 1) {
    
     // Do the fan mounting plate:
    difference() {
        // the plate for attaching the fan onto
        linear_extrude(height=plate_thickness)
            square(size=plate_size,center=true);
        // subtract the following:
          
        // round/square plate opening:
            rotate(45) {
              intersection() {
                cylinder( plate_thickness, fan_round_id/2, fan_round_id/2);
                 tmp_dia = sqrt(pow((fan_square_id/2),2) + pow((fan_square_id/2),2));
                 cylinder( plate_thickness, tmp_dia, tmp_dia,$fn=4);
             };
         };
         
         // corners:
         for ( i = [0:3]) {
             rotate (i*90) {
                 // fillets
                 translate (v=[(plate_size/2)-plate_corner_fillet_radius,(plate_size/2)-plate_corner_fillet_radius,0])
                     linear_extrude(height=plate_thickness) 
                         difference() {square(plate_corner_fillet_radius+fillet_fudge_factor); circle(plate_corner_fillet_radius);};
                 // holes
                 translate(v=[screw_hole_spacing/2,screw_hole_spacing/2,0])
                     cylinder(h=plate_thickness,r=screw_hole_diameter/2);

             };
         };
    }

    
    // Do the transition section:
    translate(v=[0,0,plate_thickness]) {
        rotate(45) {
            difference() {   // subtract the inside object from the outside object to make shell
                intersection() { // AND a tapered cylinder with a tapered pyramid (4-faced cylinder) for the outside of the transition:
                    cylinder( transition_length, fan_round_od/2, pipe_od/2);
                    // use Pythagorean theorem to get side-to-side vs corner-to-corner dims:
                    tmp_dia_od = sqrt(pow((fan_square_od/2),2) + pow((fan_square_od/2),2));
                    tmp_dia2_od = sqrt(pow((pipe_od/2),2) +pow((pipe_od/2),2));
                    cylinder( transition_length, tmp_dia_od, tmp_dia2_od,$fn=4); // "4-sided cylinder"
                };
                intersection() { // AND a tapered cylinder with a tapered pyramid (4-faced cylinder) for the inside of the transition
                    cylinder( transition_length, fan_round_id/2, pipe_id/2);
                    // use Pythagorean theorem to get side-to-side vs corner-to-corner dims:
                    tmp_dia_id = sqrt(pow((fan_square_id/2),2) + pow((fan_square_id/2),2));
                    tmp_dia2_id = sqrt(pow((pipe_id/2),2) + pow((pipe_id/2),2));
                    cylinder( transition_length, tmp_dia_id, tmp_dia2_id,$fn=4); // "4-sided cylinder"
                };
            }
        }
    }
     
     // Do the straight section of pipe
    translate(v=[0,0,plate_thickness+transition_length]) {
        difference() {
            cylinder(pipe_length, pipe_od/2,pipe_od/2);
            cylinder(pipe_length, pipe_id/2,pipe_id/2);
        }
    }
} else {
     // Do the fan mounting plate gasket:
    difference() {
        // the plate for attaching the fan onto
        linear_extrude(height=flange_gasket_thickness)
            square(size=plate_size,center=true);
        // subtract the following:
          
        // round/square plate opening:
            rotate(45) {
              intersection() {
                cylinder( flange_gasket_thickness, fan_round_id/2, fan_round_id/2);
                 tmp_dia = sqrt(pow((fan_square_id/2),2) + pow((fan_square_id/2),2));
                 cylinder( flange_gasket_thickness, tmp_dia, tmp_dia,$fn=4);
             };
         };
         
         // corners:
         for ( i = [0:3]) {
             rotate (i*90) {
                 // fillets
                 translate (v=[(plate_size/2)-plate_corner_fillet_radius,(plate_size/2)-plate_corner_fillet_radius,0])
                     linear_extrude(height=flange_gasket_thickness) 
                         difference() {square(plate_corner_fillet_radius+fillet_fudge_factor); circle(plate_corner_fillet_radius);};
                 // holes
                 translate(v=[screw_hole_spacing/2,screw_hole_spacing/2,0])
                     cylinder(h=flange_gasket_thickness,r=screw_hole_diameter/2);

             };
         };
    }
}
         
     
     
 

  
 
 
 