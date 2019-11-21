/*

LICENCE
    USB Organizer by Sepio is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/.
 
VERSION
    0.x - Sepio - 2016-07-02
    - Idea + programming
    
    1.0 - Sepio - 2016-07-03
    - First version
    
    1.1 - Sepio - 2016-07-05
    - Different way to create flat underside the body (without extra hull operation) 
*/

/* [Body] */
// Number of horizontal holes
body_grid_cols               = 2; // [1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20]       
// Number of vertical holes
body_grid_rows               = 4; // [1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20]       
// Space between holes in mm
body_grid_spacing            = 10; // [2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20]       
// Height of the backplate behind the holes in mm
body_backplate_height        = 1; // [0:1:10]       
// The radius of the body corners
body_corner_radius           = 3;  // [0,1,2,3,4,5,6,7,8,9,10]       


/* [Connector hole] */
// Exact width of connector in mm, USB A = 12mm
connector_width             = 12;  // [1:0.1:20]     
// Exact height of connector in mm, USB A = 4.5mm
connector_height            = 4.5; // [1:0.1:20]     
// Length of connector (depth of hole) in mm, USB A = 12.x mm 
connector_length            = 13; // [1:0.5:20]    
// Tolerance in mm for the connector hole  (0.05 + filament shrinkage)
connector_tolerance         = .3; // [0:0.05:1]    


/* [Screw hole] */
// Diameter of the screw head in mm
screw_head_diameter         = 8; // [4,5,6,7,8,9,10,11,12]      
// Height of the screw head in mm
screw_head_height           = 4; // [2,3,4,5,6]      
//Diameter of the screw shank (or thread) in mm
screw_shank_diameter        = 4; // [2,3,4,5,6]      
//Tolerance in mm for the screw hole
screw_tolerance             = 1; // [0.5,1,1.5,2,2.5,3,3.5,4]     

/* [Hidden] */
//Thicknes off the wall (space between screw hole and connector hole)
screw_hole_wall_thickness   = 1; // [1,2]


/*--------------------------------------------------------------------------------------------*/
/*Calculated vars, please do not change*/
$fn=90;

screw_head_radius  = (screw_head_diameter+screw_tolerance)/2;
screw_shank_radius = (screw_shank_diameter)/2;
screw_hole_width   = (screw_head_radius*2);
screw_hole_length  = (screw_head_radius*4);
            
echo("screw head radius:", screw_head_radius);
echo("screw shank radius:", screw_shank_radius);
echo("screw hole width", screw_hole_width) ;
echo("screw hole length", screw_hole_length) ;
echo("screw hole wall thickness", screw_hole_wall_thickness) ;

body_height = 
    connector_length 
    + connector_tolerance 
    + body_backplate_height;
body_radius = 
    min(body_corner_radius, ((body_height-0.1)/2));
body_width = 
    (screw_hole_wall_thickness * 4) 
    + (screw_head_radius * 4) 
    + (body_grid_cols * (connector_width + connector_tolerance))
    + ((body_grid_cols-1) * body_grid_spacing);
body_length =  
    (screw_hole_wall_thickness * 4)
    + (screw_head_radius * 4)
    + (body_grid_rows * (connector_height + connector_tolerance))
    + ((body_grid_rows-1) * body_grid_spacing);
    
echo("body height:", body_height);
echo("body width:",  body_width);
echo("body length:", body_length);
echo("body radius:", body_radius);
/*--------------------------------------------------------------------------------------------*/
/*Just one connector*/
module connector_hole(width, depth, height){
    difference(){
        union() {
            /*Connector hole*/
            color("gray")
            translate([0,0,-0.01]){ /*Break through the bottom*/
                cube([width, depth, height+1]);
            }
            /*Top sides of the hole*/
            color("lightgray");
            translate([width/2,depth/2,height-1]) {
                linear_extrude(
                    height = min(width,height)/2
                    , center = false
                    , scale = [2,2]
                    , convexity = 10
                    , twist = 0
                ) {
                    translate([-width/2, -depth/2 ,0])
                    square([width, depth]);
                } 
            }
        
        }
        
        /*Make the top side as small as possible*/
        translate([-width,-depth,height+0.5]){
            cube([width*3, depth*3, min(width,height)]);
        }
    }
}    

/*All connectors in the grid*/
module connector_holes (cols, rows){
    translate([-body_radius,-body_radius,0]){
        for (col = [1:1:cols]) {
            for (row = [1:1:rows]) {
                x = ((screw_head_radius+screw_hole_wall_thickness)*2)
                  + ((col-1)*(connector_width+connector_tolerance))
                  + ((col-1)*body_grid_spacing);

                y = ((screw_head_radius+screw_hole_wall_thickness)*2)
                  + ((row-1)*(connector_height+connector_tolerance))
                  + ((row-1)*body_grid_spacing);
                
                z = body_backplate_height;
                echo("Hole",row*col,x,y,z);
                translate([x,y,z]) {
                    connector_hole(    
                        connector_width + connector_tolerance
                        , connector_height + connector_tolerance
                        , connector_length + connector_tolerance
                    );
                }
            }
        }
    }
}

/* A hole (on the back) to mount the organizer */
module screw_hole(){
    //$fn=60;
    translate([-body_radius,-body_radius,0]){
        union (){
            color("lightgray")
            hull(){
                translate([
                    screw_head_radius
                    ,  screw_head_radius
                    , -.5 /*break through the bottom*/
                ]){
                    cylinder(r=screw_head_radius, h=3);
                }
                translate([
                    screw_head_radius
                    , (screw_head_radius*3)
                    , -.5 /*break through the bottom*/
                ]){
                    cylinder(r=screw_shank_radius, h=3);
                }
            }

            color("gray")
            hull(){
                translate([
                    screw_head_radius
                    , screw_head_radius
                    , 2 
                ]){
                    cylinder(r=screw_head_radius, h=screw_head_height+screw_tolerance);
                }
                translate([
                    screw_head_radius
                    , (screw_head_radius*3)
                    , 2
                ]){
                    cylinder(r=screw_head_radius, h=screw_head_height+screw_tolerance);
                }
            }    
        }
    }
}


/*The organizer body*/
module organizer_body (width, depth, height) {
    translate([-body_radius,-body_radius,-body_radius]){
        difference(){
            /*rounded body*/
            translate([body_radius,body_radius,body_radius]){
                minkowski(){
                    cube([width-(body_radius*2), depth-(body_radius*2), height-(body_radius)]);
                    sphere(r=body_radius);
                }
            }
            
            cube([width, depth, body_radius]);
        }
    }
}

/*The body with holes*/
module main(){
    translate([body_radius,body_radius,0]){
        difference() {
            /*Body*/
            organizer_body(body_width, body_length, body_height);
            
            /*The grid of connector holes*/
            connector_holes(body_grid_cols, body_grid_rows);
            
            /*Top left screw hole*/
            translate([
                screw_hole_wall_thickness
                , body_length - screw_hole_length - screw_hole_wall_thickness
                , 0
            ]) {
                screw_hole();
            }
            
            /*Top right screw hole*/
            translate([
                body_width - screw_hole_width - screw_hole_wall_thickness
                , body_length - screw_hole_length - screw_hole_wall_thickness
                , 0
            ]) {
                screw_hole();
            }

            /*If there is enough room for top and bottom screw holes*/
            if  (body_length > (2 * (screw_hole_length+screw_hole_wall_thickness)) ) {
                /*Bottom left screw hole*/
                translate([
                    screw_hole_wall_thickness
                    , screw_hole_wall_thickness
                    , 0
                ]) {
                    screw_hole();
                }
                
                /*Bottom right screw hole*/
                translate([
                    body_width - screw_hole_width - screw_hole_wall_thickness
                    , screw_hole_wall_thickness
                    , 0
                ]) {
                    screw_hole();
                }    
            }
        }
    }
}

/*Draw everything*/
// preview[view:south, tilt:top]
main();