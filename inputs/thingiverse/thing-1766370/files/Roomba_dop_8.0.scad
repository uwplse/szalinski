/* [Basic] */
hole_dia = 3 ; // Screw hole. 2mm should sufface, depending on expandexture of plastic
hole_offset = 4.5; // offset center of hole from edge

tower_dia = 4.8; // little tower that goes into the screwhole.
screw_head = 5; // space for screwhead + a bit. Likely the same as the tower_dia
stopper_extensionlength = 12; // how much the stopper sticks out from under the Roomba. Total height is x2.
stopper_total_height = stopper_extensionlength*2 ; 

stopper_thickness = 4; 
stopper_width=20; 

/* [other measures details] */

flesh = hole_offset*2; // because cube is centered x2

Roomba_dia= 380; // 39 cm

/* [Hidden] */
// autocenter[true]
// autocenter 
// [autocenter]
$fn=50;
intersection(){
difference(){
    union(){
        //basic form and a cube to cut out part of the ring.
        intersection(){
            union(){
                translate([0,-Roomba_dia/2])difference(){
                    cylinder(d=Roomba_dia+stopper_thickness,h=stopper_total_height);
                    translate([0,0,stopper_extensionlength])
                    cylinder(d=Roomba_dia,h=stopper_total_height+0.1); // upper part
                    
                }
             
        }
            union(){
                cube([stopper_width,flesh,stopper_total_height*2], center=true);
            }
        }
        hull(){
        translate([0,-hole_offset, stopper_extensionlength-2]){
          cylinder(d1=screw_head, d2=screw_head, h=1);}
            translate([-screw_head,-screw_head,0])
          cube([screw_head*2,screw_head,4], center=false);
//            translate([-screw_head,-flesh/2,0])
//          cube([screw_head*2,flesh/2,stopper_extensionlength], center=false);
        }
       translate([0,-hole_offset, stopper_extensionlength-2]){
                        cylinder(d=tower_dia, h=4);

            }
        
    }
    // 
    union(){ // cutout
        translate([0,-hole_offset]){
            cylinder(d=hole_dia,h=stopper_total_height);
            cylinder(d=screw_head, h=stopper_extensionlength-2);
        }
    }
}
cube([40,40,80], center=true);
}