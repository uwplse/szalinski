/*  Squarden. Highly configurable gardening squares based on Growgrid by Aker but here you can change the wood thickness.
    Copyright (C) 2016  PMorel for Thilab (www.thilab.fr)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
/* [Build parameters (in millimeters)] */
//Scale (to be able to test your design. The scale is not applied to the wood thickness)
scale = 1; //[0.1:0.1:1]

// Length of the left and right sides of the base
side_length=1500;
// Height of the left and right sides of the base 
side_height=300;
// Margin to apply on the left and right sides 
base_side_margin=70;
 // Longueur des cotés avant et arrière de la base  mais aussi du niveau 1 
 // Length of front and back sides
front_length=1200;
// Wood thickness
wood_thick=19;
// Slack in the slits in percentage of the wood thickness
slack=5;

// Minimal distance between two slits. Used to calculate the number of slits on each side 
slit_min=130;

// 2D or 3D representation.
type_of_view="3D"; // [2D,3D]

/* [3D View only] */

// Slit position of the fist level rear side
level1_pos_rear=3;
// Slit position of the fist level front side
level1_pos_front=8;
// Slit position of the second level left side
level2_pos_left=3;
// Slit position of the second right left side
level2_pos_right=6;
// Slit position of the third level rear side
level3_pos_rear=2;
// Slit position of the third level front side
level3_pos_front=5;

/* [Hidden] */

// Calculated

base_side_length=side_length*scale;
base_side_height=side_height*scale;
side_margin=base_side_margin*scale;
base_front_height=0.7*base_side_height;
ecart_slit_min=slit_min*scale;
front_margin=side_margin;
base_front_length=front_length*scale;
// Largeur d'une fente (10% de l'épaisseur du bois)
slit_width=wood_thick*(1+slack/100); //10 pourcent de marge pour l'emboitement
// Hauteur d'une fente (dépend des hauteurs des cotés avant/arrière et gauche/droit
slit_height=(base_side_height - base_front_height)/2;

if( type_of_view=="2D" )
    draw_2D();
else
    draw_3D();


// Draw a 2D view. Export it as DXF to use it on your own CNC machine.
module draw_2D() {
    separ_pieces = 20*scale;
    blocker_shift_Y = slit_height*2 + separ_pieces;
    blocker_shift_X = slit_width*3 + separ_pieces;

    // Niveau 1 avant / arrière
    nb_slits_base = getSlits(base_side_length, side_margin);
    nb_slits_front = getSlits(base_front_length, front_margin);
    shift_side = getShiftSlit(base_side_length, side_margin, nb_slits_base)+slit_width;
    shift_front = getShiftSlit(base_front_length, front_margin, nb_slits_front)+slit_width;
    
    // Niveau 2 gauche et droite            
    level2_length = side_margin*2 + shift_side*(level1_pos_front-level1_pos_rear)+slit_width;

    // Level 3 avant / arrière
    level3_length = front_margin*2 + shift_front*(level2_pos_right-level2_pos_left)+slit_width;
    
    base_side_shift_X = base_side_length + separ_pieces;
    base_side_shift_Y = base_side_height + separ_pieces;

    base_front_shift_X = base_front_length + separ_pieces;
    base_front_shift_Y = base_front_height + separ_pieces;


    
    translate([0, 0]) {

        // Base mur avant et arrière
        translate([0,0])
            rotate([0,0,0])
                    base_front_rear();

        translate([0,base_front_shift_Y])
            rotate([0,0,0])
                    base_front_rear();
        
        // Niveau 1
        translate([0,base_front_shift_Y*2]) {
            translate([0,0])
                rotate([0,0,0])
                    level1_front_rear();

            translate([0,base_front_shift_Y])
                rotate([0,0,0])
                     level1_front_rear();
        }
        
        // Base murs gauche et droite
        translate([0, base_front_shift_Y*4]) {
            
            translate([0,0])
                rotate([0,0,0])
                        base_left_right();

            translate([0,base_side_shift_Y])
                rotate([0,0,0])
                        base_left_right();
            
            // Blockers
            translate([base_side_shift_X,0]) {
                translate([0,0])
                    rotate([0,0,0])
                           do_blocker();

                translate([0,blocker_shift_Y*1])
                    rotate([0,0,0])
                            do_blocker();

                translate([0,blocker_shift_Y*2])
                    rotate([0,0,0])
                            do_blocker();

                translate([0,blocker_shift_Y*3])
                    rotate([0,0,0])
                            do_blocker();
            }

        }
    }

    // Niveaux 2 et 3
    translate([base_front_shift_X,0]) {

        translate([0, 0]) {
            
            translate([0,0])
                rotate([0,0,0])
                        level2_3(level2_length, side_margin);

            translate([0,base_front_shift_Y])
                rotate([0,0,0])
                        level2_3(level2_length, side_margin);
            
            translate([0, base_front_shift_Y*2]) {
                
                translate([0,0]) 
                    rotate([0,0,0])
                            level2_3(level3_length, front_margin);

                translate([0,base_front_shift_Y])
                    rotate([0,0])
                            level2_3(level3_length, front_margin);
            }            
        }         
    }
}


// Draw a 3D view. Used to see if everything is correct before to export it in DXF 
module draw_3D() {
    translate([side_margin-slit_width,-wood_thick,base_front_height-2*slit_height])
        rotate([90,0,0])
            linear_extrude(wood_thick) 
                do_blocker();

    translate([base_side_length-side_margin-slit_width*2,-wood_thick,base_front_height-2*slit_height])
        rotate([90,0,0])
            linear_extrude(wood_thick) 
                do_blocker();

    translate([side_margin-slit_width,base_front_length-2*side_margin,base_front_height-2*slit_height])
        rotate([90,0,0])
            linear_extrude(wood_thick) 
                do_blocker();

    translate([base_side_length-side_margin-slit_width*2,base_front_length-2*side_margin,base_front_height-2*slit_height])
        rotate([90,0,0])
            linear_extrude(wood_thick) 
                do_blocker();
        
    // Base murs gauche et droite
    translate([0,0,0])
        rotate([90,0,0])
            linear_extrude(wood_thick) 
                base_left_right();

    translate([0,base_front_length-2*front_margin-wood_thick,0])
        rotate([90,0,0])
            linear_extrude(wood_thick) 
                base_left_right();
                
    // Base mur avant et arrière
    translate([side_margin,-front_margin-wood_thick,0])
        rotate([90,0,90])
            linear_extrude(wood_thick) 
                base_front_rear();

    translate([base_side_length - side_margin - slit_width,-front_margin-wood_thick,0])
        rotate([90,0,90])
            linear_extrude(wood_thick) 
                base_front_rear();

    // Niveau 1 avant / arrière
    nb_slits_base = getSlits(base_side_length, side_margin);
    nb_slits_front = getSlits(base_front_length, front_margin);
    shift_side = getShiftSlit(base_side_length, side_margin, nb_slits_base)+slit_width;
    shift_front = getShiftSlit(base_front_length, front_margin, nb_slits_front)+slit_width;

    translate([front_margin+shift_side*(level1_pos_rear-1),0,base_front_height]) {
        translate([0,-front_margin-wood_thick,0])
            rotate([90,0,90])
                linear_extrude(wood_thick) 
                    level1_front_rear();

        translate([shift_side*(level1_pos_front-level1_pos_rear),-front_margin-wood_thick,0])
            rotate([90,0,90])
                linear_extrude(wood_thick) 
                    level1_front_rear();

        // Niveau 2 gauche et droite            
        level2_length = side_margin*2 + shift_side*(level1_pos_front-level1_pos_rear)+slit_width;

        //Translation globale de tous les niveaux à partir du 2 pour pouvoir travailler comme si on était à l'origine
        translate([-side_margin, shift_front*(level2_pos_left-1)-front_margin, (base_front_height-2*slit_height)]) {
            
            translate([0,front_margin,0])
                rotate([90,0,0])
                    linear_extrude(wood_thick) 
                        level2_3(level2_length, side_margin);

            translate([0,shift_front*(level2_pos_right-level2_pos_left)+front_margin,0])
                rotate([90,0,0])
                    linear_extrude(wood_thick) 
                        level2_3(level2_length, side_margin);
            
            // Level 3 avant / arrière
            level3_length = front_margin*2 + shift_front*(level2_pos_right-level2_pos_left)+slit_width;
            translate([shift_side*(level2_pos_left-1)-side_margin, -wood_thick, base_front_height-2*slit_height]) {
                
                translate([0,0,0]) // shift_front*(level3_pos_rear-1)
                    rotate([90,0,90])
                        linear_extrude(wood_thick) 
                            level2_3(level3_length, front_margin);

                translate([shift_side*(level2_pos_right-level2_pos_left),0,0])
                    rotate([90,0,90])
                        linear_extrude(wood_thick) 
                            level2_3(level3_length, front_margin);
            }            
        }         
    }
}

module base_left_right() {
    difference() {
        square([base_side_length,base_side_height]);
        translate([0,base_side_height-slit_height,0]) 
            do_slits(base_side_length,side_margin, slit_width);
        translate([side_margin, 0, 0])
            do_slit(slit_width, base_front_height-slit_height);
        translate([base_side_length-side_margin-slit_width, 0, 0])
            do_slit(slit_width, base_front_height-slit_height);
    }
}



module base_front_rear() {
    difference() {
        square([base_front_length,base_front_height]);
        translate([0,base_front_height-slit_height,0]) 
            do_slits(base_front_length,front_margin, slit_width);
        translate([side_margin-slit_width, base_front_height-slit_height, 0])
            do_slit();
        translate([base_front_length-side_margin, base_front_height-slit_height, 0])
            do_slit();
    }    
}

module level1_front_rear() {
    difference() {
        square([base_front_length,base_front_height]);
        translate([0,base_front_height-slit_height,0]) 
            do_slits(base_front_length,front_margin, slit_width);
        translate([front_margin-slit_width, 0, 0])
            do_slit();
        translate([base_front_length-front_margin, 0, 0])
            do_slit();
        translate([base_front_length-front_margin-slit_width, 0, 0])
            do_slit();
        translate([front_margin, 0, 0])
            do_slit();
    }
}

module level2_3(length, margin) {
    difference() {
        square([length,base_front_height]);
        translate([0,base_front_height-slit_height,0]) 
            do_slits(length, margin, slit_width);
        *translate([margin-slit_width, 0, 0])
            do_slit();
        *translate([length-margin, 0, 0])
            do_slit();
        translate([length-margin-slit_width, 0, 0])
            do_slit();
        translate([margin, 0, 0])
            do_slit();
    }

}


module do_slit(width=slit_width, height=slit_height) {
    square([width, height]);
}

module do_slits(length, margin, slit_width) {

    slits = getSlits(length, margin);
    shift_slit = getShiftSlit(length, margin, slits );
    
    echo("Slits=", floor(slits), " shift_slit=", shift_slit);
    for(i=[0:slits-1]) {
        translate([i*(shift_slit+slit_width)+margin, 0, 0])
            do_slit();
    }
}

module do_blocker() {
            difference() {
                square([slit_width*3, slit_height*2]);
                translate([slit_width,0])
                    do_slit();
            }
}

function getShiftSlit(length, margin, nb_slits) = (getSlitZone(length, margin) - nb_slits*slit_width)/(nb_slits - 1);

function getSlits(length, margin) = ceil(getSlitZone(length, margin) / ecart_slit_min);

function getSlitZone( length, margin ) = length-2*margin;
