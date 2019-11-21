/*
Author: Kevin Lutzer
Date Created: Oct 9 2016

Description: Holder for a LED flashlight I made to project light into a lamp
*/

//////////////////////////////////////////////// Parameters ////////////////////////////////////////////////////////

polygon_sides = 50;

stone_diameter = 50.5;
stone_depth = 10;
base_width = 61; 
base_height = 42;
wall_thickness = 5;
tunnel_diameter = stone_diameter - wall_thickness; 

board_joint_height = 5;
board_thickness = 1.6;
component_height = 6.5;

board_height = board_joint_height + board_thickness + component_height;
board_diameter = 55.5;
board_mount_hole_offset = 3.5;
power_connector_height = 12; 
power_connector_width = 10;
power_connector_length = 14.5;

screw_diameter = 2;
screw_height = 8;


//////////////////////////////////////////////// Functional Prototypes ////////////////////////////////////////////

light_cone();

//////////////////////////////////////////////// Modules ///////////////////////////////////////////////////////////

module light_cone(){
    difference(){
        union(){
            base();
            screw_post_addition();
        }
        cylinder(base_height, d1 = tunnel_diameter, d2 = tunnel_diameter, 0, $fn=polygon_sides);
        translate([-power_connector_width,board_diameter/2-power_connector_length+(base_width-board_diameter)/2,0]){
            power_connector();
        }
    }
}

module base(){
    difference(){
        cylinder(base_height, d1 = base_width, d2 = stone_diameter+wall_thickness, 0, $fn=polygon_sides );
        translate([0,0,base_height-stone_depth]){
            cylinder(stone_depth, d1 = stone_diameter, d2 = stone_diameter, 0, $fn=polygon_sides);
        }
        cylinder(board_height, d1 = board_diameter, d2 = board_diameter, 0, $fn=polygon_sides);
        
    }
}
    
module mounting_post(){
    difference(){
        cylinder(component_height, d1 = 2*(base_width - board_diameter)-3, d2 = 2*(base_width - board_diameter)-3, 0, $fn = polygon_sides);
        cylinder(screw_height, d1 = screw_diameter, d2 = screw_diameter, 0, $fn = polygon_sides );
    }
}

module power_connector(){
    cube([power_connector_width, power_connector_length, power_connector_height + board_joint_height + board_thickness],0);
}

module screw_post_addition(){
     translate([(base_width/2-(base_width - board_diameter))/sqrt(2),(base_width/2-(base_width - board_diameter))/sqrt(2),board_joint_height+board_thickness]){
            mounting_post();
        }
        translate([+(base_width/2-(base_width - board_diameter))/sqrt(2),-(base_width/2-(base_width - board_diameter))/sqrt(2),board_joint_height+board_thickness]){
            mounting_post();
        }
        translate([-(board_diameter/2 - board_mount_hole_offset), 0,board_joint_height+board_thickness]){
            mounting_post();
        }
}