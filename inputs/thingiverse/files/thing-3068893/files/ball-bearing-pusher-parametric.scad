/*
 * Ball bearing pusher - parametric version
 * ========================================
 *
 * Creates a 3D printable objects that forces an axis or rod into a 
 * ball bearing. Much easier than doing this by hand...
 *
 * Ball bearing pusher OpenSCAD script
 * Copyright (C) 2019  Thomas Hessling <mail@dream-dimensions.de>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * https://www.dream-dimensions.de
 * https://www.thingiverse.com/thing:3068893
 *
 * ChangeLog:
 *  - License changed (2019-09-21)
 *    changed to GPLv3
 *  - Initial release (2018-08-28)
 *    model creation works, need to test final part dimensions
 *
 */
 
 
/*
 * Define your ball bearing and screw size below. 
 * Screw diameter should be equal or smaller than the rod.
 */
/* [General settings] */
// Ball bearing outer diameter
bb_outer_diameter = 16;     
// Ball bearing inner diameter
bb_inner_diameter = 5;      
// Ball bearing width
bb_width = 5;               
// Length of the rod
rod_length = 16;            
// Screw size
screw_index = 2;            //[0:M3,1:M4,2:M5,3:M6,4:M8,5:M10]


/* [Advanced settings] */
// basic tolerance for nut, washer, ball bearing and rod to apply
tolerance = 0.15;
// bottom base thickness 
base_thickness = 3;
// thickness of side walls
side_thickness = 5;
// thickness of the wall the force acts on when pushing the rod 
force_counter_thickness = 8;
// covered part between the nut and rod
cover_width = 10;
// chamfer size
chamfer_size = 1;

/* [Hidden] */
// metric screw nut and washer information
// name, thread diameter, nut thickness, nut width, washer diameter, washer thickness
nut_dims = [["M3", 3, 2.4, 5.5, 7.0, 0.5],
            ["M4", 4, 3.2, 7.0, 9.0, 0.8],
            ["M5", 5, 4.0, 8.0, 10.0, 1.0],
            ["M6", 6, 5.0, 10.0, 12.0, 1.6],
            ["M8", 8, 6.5, 13.0, 16.0, 1.6],
            ["M10", 10, 8.0, 19.0, 20.0, 2.0]];
// the color
col = [0.2,0.7,0.2];
// safety offset for boolean operations, prevents spurious surfaces
s = 0.01;
// safety offset for creating chamfers
cs = 0.1;
// smoothness
$fn = 128;

/*
 * Below are the routines creating the object, only touch them if you know what you are doing.
 * Things break easily. ;-)
 */
create_object();


// TODO: properly document the chamfer stuff...
module chamfer_edge(dims, chamfer) { 
    linear_extrude(max(dims)+2*cs) polygon([[chamfer,0], [0,chamfer], [-cs,chamfer], [-cs,-cs], [chamfer,-cs]]); 
}

module base_corner_bracket(chamfer, cfactor=2) {
    translate([cfactor*chamfer/2,cfactor*chamfer/2,0]) rotate(a=atan(1/sqrt(2)), v=[1,-1,0]) translate([-cfactor*chamfer/2,-cfactor*chamfer/2,-2.5*chamfer]) 
    linear_extrude(5*chamfer) polygon([[0,cfactor*chamfer],[0,0],[cfactor*chamfer,0]]);
}

module corner_bracket(cid, dims, chamfer) {
    if (cid == 1) {
        translate([0,0,0]) rotate([0,0,0])
        base_corner_bracket(chamfer);
    }
    else if (cid == 5) {
        translate([dims[0],0,0]) rotate([0,0,90])
        base_corner_bracket(chamfer);
    }
    else if (cid == 6) {
        translate([dims[0],dims[1],0]) rotate([0,0,180])
        base_corner_bracket(chamfer);
    }
    else if (cid == 2) {
        translate([0,dims[1],0]) rotate([0,0,-90])
        base_corner_bracket(chamfer);    
    }
    else if (cid == 3) {
        translate([0,dims[1],dims[2]]) rotate([180,0,0])
        translate([0,0,0]) rotate([0,0,0])
        base_corner_bracket(chamfer);
    }
    else if (cid == 7) {
        translate([0,dims[1],dims[2]]) rotate([180,0,0])
        translate([dims[0],0,0]) rotate([0,0,90])     
        base_corner_bracket(chamfer);       
    }
    else if (cid == 4) {
        translate([0,dims[1],dims[2]]) rotate([180,0,0])
        translate([dims[0],dims[1],0]) rotate([0,0,180])
        base_corner_bracket(chamfer);
    }
    else if (cid == 0) {
        translate([0,dims[1],dims[2]]) rotate([180,0,0])
        translate([0,dims[1],0]) rotate([0,0,-90])
        base_corner_bracket(chamfer);
    }
}

module chamfered_cube(dims=[1,1,1], chamfer=1, edges=[1,1,0,1,1,0,0,1,1,1,0,1]) { 

    corner_edges = [[0, 1, 4], [1, 2, 5], [2, 3, 6], [3, 0, 7], [4, 8, 11], [5, 8, 9], [6, 9, 10], [7, 8, 11]];
   
   
    difference() {
        cube(dims);

        // front face
        if (edges[0] == 1) {      
            translate([0, -cs, dims[2]]) rotate([-90,0,0]) chamfer_edge(dims, chamfer);
        }
        if (edges[1] == 1) {      
            translate([0, 0, -cs])  rotate([0,0,0]) chamfer_edge(dims, chamfer);
        }
        if (edges[2] == 1) {      
            translate([0, dims[1]+cs, 0]) rotate([90,0,0]) chamfer_edge(dims, chamfer);
        }
        if (edges[3] == 1) {      
            translate([0, dims[1], -cs]) rotate([0,0,-90]) chamfer_edge(dims, chamfer);
        }

        // side faces
        if (edges[4] == 1) {      
            translate([dims[0]+cs, 0, dims[2]]) rotate([-90,0,90]) chamfer_edge(dims, chamfer);
        }
        if (edges[5] == 1) {      
            translate([dims[0]+cs, 0, 0])  rotate([0,-90,0]) chamfer_edge(dims, chamfer);
        }
        if (edges[6] == 1) {      
            translate([-cs, dims[1], 0]) rotate([0,-90,180]) chamfer_edge(dims, chamfer);
        }
        if (edges[7] == 1) {      
            translate([dims[0]+cs, dims[1], dims[2]]) rotate([0,90,180]) chamfer_edge(dims, chamfer);
        }


        // back face
        if (edges[8] == 1) {      
            translate([dims[0], -cs, dims[2]]) rotate([-90,90,0]) chamfer_edge(dims, chamfer);
        }
        if (edges[9] == 1) {      
            translate([dims[0], 0, -cs]) rotate([0,0,90]) chamfer_edge(dims, chamfer);
        }
        if (edges[10] == 1) {      
            translate([dims[0], dims[1]+cs, 0]) rotate([90,-90,0]) chamfer_edge(dims, chamfer);
        }
        if (edges[11] == 1) {      
            translate([dims[0], dims[1], -cs]) rotate([0,0,180]) chamfer_edge(dims, chamfer);
        }

        // chamfer the corners
        for (i = [0 : 1 : 7]) {
            if (edges[corner_edges[i][0]] && edges[corner_edges[i][1]] && edges[corner_edges[i][2]]) {
                corner_bracket(i, dims, chamfer);
            }
        }
    }
    
}


// create a combined cyliner and cube
module create_cylcube(radius, thickness, factor=3) {
    height = thickness+2*tolerance;
    diam = 2*(radius+tolerance);
    
    union() {
        translate([0,0,0]) rotate([0,90,0]) cylinder(h=height, d=diam);
        translate([0,-diam/2, 0]) cube([height,diam,max(bb_outer_diameter,nut_dims[screw_index][4])]);
    }
}

module regular_polygon(order, r){
    r = r/cos(30);
 	angles=[ for (i = [0:order-1]) i*(360/order) ];
 	coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
 	polygon(coords);
}

// create a combined hexagon and cube
module create_hexcube(diameter, thickness, factor=3) {
    height = thickness + 2*tolerance;
    radius = diameter / 2 + tolerance;

    union() {
        rotate([0,90,0]) linear_extrude(height) regular_polygon(6, radius);
        translate([0,-radius, 0]) cube([height,2*radius,max(bb_outer_diameter,nut_dims[screw_index][4])]);
    }
   
}


// create the actual ball bearing pusher object
module create_object() {
    screw_diam = nut_dims[screw_index][1];
    nut_height = nut_dims[screw_index][2];
    nut_width = nut_dims[screw_index][3];
    washer_diam = nut_dims[screw_index][4];
    washer_height = nut_dims[screw_index][5];
    
    b_width = max(bb_outer_diameter,washer_diam) + 2*side_thickness;
    b_height = max(bb_outer_diameter,washer_diam) + base_thickness;
    b_length = ceil(rod_length + bb_width + nut_height*1.5 + 2*force_counter_thickness + cover_width + 6*tolerance);

    axis_position = base_thickness+bb_outer_diameter/2;
    
    
    washer_position = force_counter_thickness;
    nut_position = washer_position + washer_height + 2*tolerance;
    rod_position = nut_position + nut_height*1.5 + cover_width + 2*tolerance;
    bb_position = rod_position + rod_length + 2*tolerance;
    rod_exit_position = bb_position + bb_width + 2*tolerance;
   
    color(col)
    difference() {
        // base object
        difference() {
            translate([0,-b_width/2,0]) chamfered_cube([b_length, b_width, b_height], chamfer_size);
            translate([-2,0,axis_position]) rotate([0,90,0]) cylinder(h=b_length+4, d=screw_diam+2*tolerance);
        }
        
        translate([washer_position, 0, axis_position]) 
            create_cylcube(washer_diam/2, washer_height);

        translate([nut_position-s,0,axis_position]) 
            create_hexcube(nut_width, nut_height*1.5);

        translate([rod_position,0,axis_position]) 
            create_cylcube(bb_inner_diameter/2, rod_length);

        translate([bb_position-s,0,axis_position]) 
            create_cylcube(bb_outer_diameter/2, bb_width);
        
        translate([rod_exit_position-2*s,0,axis_position]) 
            create_cylcube(bb_inner_diameter/2, rod_length);
        
    }
    
    
    
}
