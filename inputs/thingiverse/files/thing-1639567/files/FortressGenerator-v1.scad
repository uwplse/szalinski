/*----------------------------------------------------------------------------*/
/*  Fortress Generator v1                                                     */
/*  based on my previous Castle Generator at                                  */
/*    http://www.thingiverse.com/thing:1612651                                */
/*  Created by Ziv Botzer                                                     */
/*  zivbot@gmail.com                                                          */
/*  License: Creative Commons - Attribution - Non-Commercial - Share Alike    */
/*                                                                            */
/*  22.6.2016 First version on Thingiverse                                    */
/*----------------------------------------------------------------------------*/

// preview[view:south east, tilt:top diagonal]

// Master switch for details (windows, decorations...) - keep it off while you calibrate
generate_details = "No"; // [Yes, No]
// Variations - change it for a different results
random_seed = 42; // [1:1:400]
// Should each corner have a tower?
probability_of_towers = 1; // [0:0.1:1]
// Should a tower have turrets?
probability_of_turrets = 0.5; // [0:0.1:1]
// Maximum number of turrets per tower
max_number_of_turrets = 2;  // [0:1:5]
// Pointed roofs - tall or low? 
roof_pointed_ratio = 1.8; // [0.4:0.2:4]

/* [Walls] */
wall_height = 35; // [10:1:140]
wall_diameter = 80; // [20:5:200]
wall_sides = 5; // [4,5,6,8,12,60,0:Random]
wall_thickness = 6; // [4:1:40]

/* [Towers and Turrets] */
// Height (without roof)  (0 = Random)
towers_height = 40;  // [0:1:150]
// Width  (0 = Random)
towers_width = 23; // [0:1:100]
// How many sides/facets for towers
towers_number_of_sides = 0; // [4,5,6,8,12,60,0:Random]
// Towers roof types
towers_roof_type = 0; // [1:Pointed,2:Flat,3:Flat+Point,0:Random]

// Turrets roof types
turrets_roof_type = 0; // [1:Pointed,2:Flat,3:Flat+Point,0:Random]

// Ratio of children turrets to parent (0.1 - very narrow, 0.9 - very wide)
turrets_width_ratio = 0.6; // [0.1:0.1:2]
// Ratio of children turrets to parent (0.1 - very narrow, 0.9 - very wide)
turrets_height_ratio = 0.7; // [0.1:0.1:2]


/* [Decorations] */
//
generate_windows = "Yes"; // [Yes, No]
// Rings, archers slots, etc.
generate_roof_decorations = "Yes"; // [Yes, No]
// Generate corbel decoration beneath turrets?
generate_corbels = "Yes"; // [Yes, No]
// (Extremely geometry intensive!! and not very effective when printing small)
generate_bricks = "No"; // [Yes, No]

/* [Decorations: Windows] */
// How many windows to scatter (1 = everywhere)
window_coverage = 0.15; // [0.02:0.02:1]
// Height of each floor (also determines gate structure)
floor_height = 3; // [1:0.5:20]
// Width of windows (default 2.5)
window_width_base = 1.2; // [1:0.1:10]

/* [Decorations: Bricks] */
// Height of the bricks
brick_height = 1.5; // [1:0.1:3]
// Width of the bricks
brick_horz = 4; // [1:0.5:20]
// Width of mortar between the bricks
brick_space = 0.2; // [0.2:0.1:2]
// Depth of spacing between the bricks !this is an overhang - keep it tiny!
brick_space_depth = 0.15; // [0.1:0.05:1]

/* [Partial Generation] */
// Use to separate STLs for rendering
what_to_generate = 1; // [1:Everything,3:Structures only,4:Roofs only]


/* [Hidden] */


// Symmetry for all other levels !Double complexity!
next_levels_symmetry = "No"; // [Yes, No] 

// Flag poles are more likely to mess up the print than look nice, so they're permanently off
generate_flag_poles = "No"; // [Yes, No]

// More constants
sides_predef=[4,5,6,8,12,60]; // possible number of sides per polygon
$fn = 10; // Basic resolution (hardly affects anything, controlled locally)
overlap = 0.01; // used to make sure union/difference give nice results

roof_flat_extend_ratio = 0.5; // [0.1:0.1:1] // Flat roofs - how wide?
pointed_roof_cone_base_ratio = 0.04; // ratio between inverted base cone of roof, and the cone of roof
roof_deco_spacing_height = 0.25*floor_height; // distance between ring decorations on the roofs
edge_margin_factor = 0.1;

max_roof_types = 3; // 4 allows for dome roofs

// collection of booleans for easier handling
gen_roof_decorations = (generate_roof_decorations == "Yes") && (generate_details == "Yes");
gen_windows = (generate_windows == "Yes") && (generate_details == "Yes");
gen_flag_poles = (generate_flag_poles == "Yes") && (generate_details == "Yes");
gen_corbel_decoration = (generate_corbels == "Yes") && (generate_details == "Yes");
gen_bricks = (generate_bricks == "Yes") && (generate_details == "Yes");

gen_structure = ((what_to_generate == 1) || (what_to_generate == 3));
gen_roofs = ((what_to_generate == 1) || (what_to_generate == 4));

// uncomment to make every rebuild really random:
//random_seed = floor(rands(0,1000,1)[0]); 
//echo(random_seed);

//include <fort_settings2.scad>;

//********************** MAIN *****************************


number_of_towers = (wall_sides <= 8)?wall_sides:8;

// walls
difference() {
    gate_width = 3*floor_height;
    gate_height = 5*floor_height;

    translate([0,0,-overlap])
    union() {
        difference() {
            // walls
            turret_round ( wall_diameter, wall_height, false, wall_sides, 1, 2 );
            
            // negative volume
            if (gen_structure)
            color("Gainsboro")
            translate([0,0,-overlap])
            linear_extrude(200)
            rotate([0,0,correction_angle(wall_sides)])
            circle(d=wall_diameter-2*wall_thickness, $fn=wall_sides);
            
        }
        
        // gate tower
        translate([0,-inradius( wall_diameter, wall_sides ) /2 ])
        union() {
            gate_tower_width = 3*gate_width;
        
            //translate([0,0,-overlap])
            turret_round ( gate_tower_width, 1.4*gate_height, false, 4, 1, 2 );
        
            //translate([0,0,-overlap])
            if (gen_structure)
            rotate([90,0,0])
            translate([0,gate_height/2,0])
            linear_extrude(inradius(gate_tower_width, 4)+2, center=true)
            special_rectangle(gate_width+3, gate_height+3);

        }
        
        // position towers around wall
        rotate([0,0,wall_sides==5?360/10:0])
        for (i = [0:number_of_towers-1])
            if (rands(0,1,1,random_seed+i*5)[0] <= probability_of_towers) {

            n_of_children = (rands(0,1,1,random_seed+i*3)[0] <= probability_of_turrets)?
                            floor(rands(1,max_number_of_turrets-0.01,1,random_seed+i*4)[0]) : 0;
  
            rotate([0,0,i*(360/number_of_towers) + 360/number_of_towers/2 ])
            translate([0,0.97*wall_diameter/2,0])
            rotate([0,0,wall_sides==4?45:0])
            turret_recursive(1, 2,
                            n_of_children,
                            (towers_width==0)?
                                rands(1.1,4.0,1,random_seed*(i+1))[0]*wall_thickness:towers_width, 
                            (towers_height==0)?
                                rands(1.1,2,1,random_seed*(i+1))[0]*wall_height:towers_height, 
                            true, 
                            towers_number_of_sides,
                            random_seed+i*100 );
        }  
    }
    

    // gate inner cut!
    if (gen_structure)
    color("Black")
    translate([0,0,-overlap])
    rotate([90,0,0])
    translate([0,gate_height/2,0])
    linear_extrude(500)
    special_rectangle(gate_width, gate_height);
    
    // trim everything below 0 Z
    if (gen_structure)
    translate([0,0,-50])
    cube([500, 500, 100], center=true);
}


/**************************************************************
   Helper functions
***************************************************************/
function decide_roof_type( t, rseed ) = (t==0)? floor(rands(0,max_roof_types-0.01,1,rseed)[0]+1) : t;

function decide_number_of_sides ( s, rseed ) = (s==0) ? 
        sides_predef[ floor( rands(0,len(sides_predef)-0.01,1,rseed)[0] ) ] : s;

// the correction angle makes sure all polygons (no matter how many sides) align on one side
function correction_angle ( sides ) = (sides==4)?45: (sides==5)?18: (sides==8)?22.5: (sides==12)?15:0;

function decide_dimension ( dim, minimum, random_min, random_max, rseed ) =
     (dim == 0)? round(rands(random_min, random_max, 1, rseed)[0]) : (
     (dim >= minimum )? dim : minimum );

function inradius ( R, sides ) = R * cos( 180 / sides ); // inradius of the polygon shape



/**************************************************************
   Generate turrets with recursive children
***************************************************************/
module turret_recursive ( current_depth, max_recursion, number_children, w, h, main_tower, sides_, rseed ) {
    
    if (current_depth <= max_recursion)
    union() {
        
        // how many sides if this were a main tower
        sides = decide_number_of_sides (sides_, rseed+current_depth );
        
        // decide roof type
        main_tower_roof_type = decide_roof_type (towers_roof_type, rseed+current_depth);
        
        this_roof_type = (main_tower)? main_tower_roof_type : 
            decide_roof_type (turrets_roof_type, rseed+current_depth );
        
        // GENERATE TOWER/TURRET
        turret_round(w, h, !main_tower, sides, roof_pointed_ratio, this_roof_type);
        
        inradius = w * cos( 180 / sides ); 

        if (number_children >= 1)
        for (i = [1:number_children]) {
            r1 = rands(-200,200,1,rseed + i*10 + current_depth*100)[0];
            v1 = inradius*0.55;  // y (offset from center) translation of children
            
            // calc width of children
            cw = w*turrets_width_ratio*turrets_width_ratio;
            t_width = (cw > 0.8*floor_height)?cw:0.8*floor_height; // set a minimum to turrets width
            
            t_height = h*turrets_height_ratio*turrets_height_ratio;
        
            z_transform = rands(2*t_width,1.0*h,1,rseed + i + current_depth)[0];
            
            rotate([0,0, r1 ] )
            translate([0,v1, z_transform])
            turret_recursive(current_depth+1, max_recursion, number_children, t_width, t_height, false, sides_, rseed*i );
            
            if (next_levels_symmetry=="Yes") 
                rotate([0,0, 360-r1 ] )
                translate([0,v1, z_transform])
                turret_recursive(current_depth+1, max_recursion, number_children, t_width, t_height, false, sides_, rseed*i+10 );
        }
    }
}



/**************************************************************
   Generate a complete turret
***************************************************************/
module turret_round ( w, h, generate_bottom, sides, roof_ratio, roof_type_ ) {

    body_height = h;
    roof_height = w*roof_ratio;
    base_height = w*2;
   
    //rotate([0,0,(sides==4)?45:0])
    rotate([0,0,correction_angle(sides)])
    union() {
        
        // roof
        translate([0,0,body_height-overlap])
           turret_roof (w, roof_height, sides, roof_type_);
       
        // body of turret
        if(gen_structure)
        turret_body(w, body_height, sides);

        // under part
        if(gen_structure)
        translate([0,0,overlap])
        if (generate_bottom) {
            color("Gainsboro")
             turret_base(w, base_height, sides);
        }
        
    }
}


/**************************************************************
   Generate turret ROOF according to type
***************************************************************/
module turret_roof ( w, h, sides, rtype ) {

    union() {

        if (rtype == 1) {
            // pointed roof
            if (gen_roofs)
                roof_pointed ( w, h, sides );
        }
        else if (rtype == 2) {
            // flat roof
            if(gen_structure)
                roof_flat (w, 1.8*floor_height, sides);
        }
        else if (rtype == 3) {
            // flat and point
            if(gen_structure) {
                roof_flat (w, 1.8*floor_height, sides);
                translate([0,0,0.5*floor_height-overlap])
                    turret_body ( 0.7*w, 2*floor_height, sides );
            }
            if (gen_roofs)
                translate([0,0,1.5*floor_height + floor_height-2*overlap])
                roof_pointed ( 0.7*w, 0.8*h, sides );
        }
        else if (rtype == 4) {
            // Dome
            if(gen_structure) {
                roof_flat (w, 1.1*floor_height, sides);
                translate([0,0,0.5*floor_height-overlap])
                    turret_body ( 0.7*w, floor_height, sides );
            }
            if (gen_roofs)
                translate([0,0,0.5*floor_height + floor_height-2*overlap])
                roof_dome ( 0.7*w, 0.8*h, sides );
        }
        
    }
}


/**************************************************************
   Generate FLAT ROOF with decorations
***************************************************************/
module roof_flat ( w, h, sides ) {

    roof_bottom_part_height = 1.8*roof_flat_extend_ratio*floor_height;
    roof_top_part_height = h-roof_bottom_part_height;
    
    roof_top_width = w+1.8*roof_flat_extend_ratio*floor_height;
    roof_overhang = (roof_top_width - w);
    
    roof_scale = roof_top_width / w;
    
    shortest_radius = w * cos( 180 / sides ) / 2; 
        // ^-- for polygons with low number of sides, gives the constrained radius
    
    circular_n = (sides <= 12)?sides:12;
    
    correct = correction_angle(sides);
    
    color("LightGrey")
    union() {
        translate([0,0,roof_bottom_part_height-overlap])
        difference() 
        {
            // top part 
            
            linear_extrude(roof_top_part_height)
            circle(d=roof_top_width,$fn=sides);
            
            // emboss center
            translate([0,0,0.3*roof_top_part_height])
            linear_extrude(roof_top_part_height)
            circle(d=w,$fn=sides);
            
            // cut archers slots
            translate([0,0,0.5*roof_top_part_height])
            pattern_around_polygon (roof_top_width, roof_top_part_height, sides, 
                                0, 0,
                               element_max_width=floor_height, 
                               element_height=roof_top_part_height, 
                               extrude_length=5,
                               distribution_ratio=1 )
                square([0.4,1], center=true);
        }

        
        
        // base part with corbels
        difference() {
            linear_extrude(roof_bottom_part_height, scale=roof_scale)
             circle(d=w*1.0,$fn=sides);
        
            if (gen_corbel_decoration)
            translate([0,0,-0.1*roof_bottom_part_height])
            pattern_around_polygon (roof_top_width, roof_bottom_part_height, sides, 
                                    2, 0,
                                    element_max_width=0.7*floor_height, 
                                    element_height=roof_bottom_part_height, 
                                    extrude_length=roof_overhang,
                                    distribution_ratio=1 )
                                    special_rectangle(0.6,1);
        }
    }
}

/**************************************************************
   Generate POINTED ROOF with decorations
***************************************************************/
module roof_pointed ( w, h, sides ) {
    
    roof_inverted_cone_height = h*pointed_roof_cone_base_ratio;
    roof_cone_height = h - roof_inverted_cone_height;


    roof_cone_base_width = w + 2*roof_inverted_cone_height;
    
    roof_tip_scale = (gen_flag_poles)?0.1:0.05;
    
    roof_cone_delta = roof_cone_base_width - roof_cone_base_width*roof_tip_scale;
    
    shortest_radius = w * cos( 180 / sides ) / 2; 
        // ^-- for polygons with low number of sides, gives the constrained radius

    union() {
        // roof cone
        color("OrangeRed")
        translate([0,0,roof_inverted_cone_height-overlap])
          linear_extrude(roof_cone_height, scale=roof_tip_scale)
          circle(d = roof_cone_base_width, $fn=sides);

        // up-side-down cone below roof cone
        color("OrangeRed")
        linear_extrude(roof_inverted_cone_height, scale=roof_cone_base_width/w)
          circle(d = w, $fn=sides); 



        // generate decos
       color("OrangeRed") 
        if (gen_roof_decorations) {

            translate([0,0,roof_inverted_cone_height]) {
                
                // small roofs around base of roof
                default_size = window_width_base*1.5;
                s = (sides <= 12)?sides:12;
                mx = 0.7*roof_cone_base_width*3.14/s;
                
                deco_size = (default_size <= mx)?default_size:mx;
                
                translate([0,0,overlap])
                intersection() {
                    pattern_around_polygon ( 0.95*roof_cone_base_width,
                                    deco_size+0.1, sides, 
                                    0.05*roof_cone_base_width,
                                    0, // vertical margin
                                    element_max_width=deco_size, 
                                   element_height=deco_size, 
                                   extrude_length=0.5*roof_cone_base_width,
                                   distribution_ratio=1 )
                        special_rectangle(0.8,1);

                    translate([0,0,-overlap])
                    linear_extrude(deco_size+1)
                    circle(d=roof_cone_base_width-overlap, $fn=sides);
                }
               
                // round horz rails along roof
                rail_spacing = 2*roof_deco_spacing_height;
                how_many_rows =  floor( roof_cone_height / rail_spacing);
                if (how_many_rows>1) {
                    rail_spacing2 = roof_cone_height / how_many_rows;
                    rail_height = 0.1*rail_spacing2;
                
                    color("Maroon")
                    for (i = [1:how_many_rows-1]) {
                        translate([0,0,i*rail_spacing2])
                            linear_extrude(rail_height)
                            circle(d = roof_cone_base_width-i*(roof_cone_delta/how_many_rows), $fn=sides);
                    }
                }
                
                
                // flag poles
                if (gen_flag_poles) {
                    translate([0,0,0.7*roof_cone_height]) {
                        color("DarkGoldenrod")
                        linear_extrude(0.3*roof_cone_height + 1.5*floor_height, scale=0.5)
                        circle(d=0.8, $fn=20);
                        
                        
                        /*
                        // actual flags are not printable without cursed supports...
                        color("White")
                        translate([0,-0.05,5])
                        cube([4,0.1,0.7]);
                        */
                    }
                }
                
            }
        }
    }

}


/**************************************************************
   Generate turret BODY with decorations
***************************************************************/
module turret_body ( w, h, sides ) {

    difference () {
        color("LightGrey")
        linear_extrude(h, convexity = 2) circle (d=w, $fn=sides);
        
        // _____Generate windows______
        color([0.3,0.3,0.3])
        if (gen_windows) 
            pattern_around_polygon (w, h, sides, 
                                    edge_margin_factor*w,
                                    edge_margin_factor*h,
                                    window_width_base,
                                    floor_height,
                                    0.2*w,
                                    window_coverage )
                scale([0.8,1/4,1])
                special_rectangle(0.8,3);

        
        // _____Generate brick pattern______
        color("DarkGray")
        if (gen_bricks) {
            
            how_many_rows =  floor( (h-brick_space) / (brick_height+brick_space));
            brick_height2 = (h-((how_many_rows-1)*brick_space)) / how_many_rows;
            
            how_many_cols = floor(w*3.1416/brick_horz);
            bricks_angle = 360/how_many_cols;

            difference () {
            
                union() {
                    // create the horizontal slots between the rows of bricks
                    for (i = [1: 1:how_many_rows-1] ) {
                        translate([0,0,i*(brick_height2+brick_space)-brick_space]) {
                                linear_extrude(brick_space,false) {
                                    circle(d = w*1.5, $fn=sides);
                            }
                        }
                    }
            
                    // create the vertical slots between the columns of bricks + random rotation
                    union()
                    for(vi = [0:how_many_rows-1]) {
                        rand_rotate = rands(0,1,1)[0];
                        translate([0,0,brick_height2/2+vi*(brick_height2+brick_space)])
                        for (i = [0: 1:(how_many_cols/2)-1] ) {
                            rotate([0,0,(i+rand_rotate)*bricks_angle])
                            color ("DimGray")
                            cube([brick_space, 1.1*w, brick_height2+0.2], center=true);
                        }
                    }
                    
                }
                
                // substract middle volume 
                translate([0,0,-0.5])
                linear_extrude(h+5) circle (d=w-brick_space_depth*2, $fn=sides);
            }
        }
        
    }    
    
}


/**************************************************************
   Generate turret BASE with decorations
***************************************************************/
module turret_base ( w, h, sides ) {

    circular_n = (sides <= 6)?sides:6;
    shortest_radius = w * cos( 180 / sides ) / 2; 
    
    correct = correction_angle(sides);
    
    color("Gainsboro")
    rotate([0,0,(sides==4)?-45:0]) // fix square alignment
    union () {
        // inverted cone
        translate([0,-w/2,0])
        rotate([180,0,0])
        linear_extrude(height = h, scale=0.1, convexity = 3)
        translate([0, -w/2, 0])
        rotate([0,0,(sides==4)?45:0]) // fix square alignment
         difference() {
             
             circle(d = w, $fn=sides);
         
             if (gen_corbel_decoration) {
                rotate([0,0,correct])
                for (i = [0:circular_n-1]){
                    d_ = 0.5*3.1416*w/circular_n;
                    rotate([0,0, i*(360/circular_n) ])
                    translate([0,1.1*shortest_radius,0])
                    circle(d=d_, $fn=sides*4);
                }
            }
         }
         
        if (gen_corbel_decoration) {
            translate([0,-w/4,0])
            rotate([180,0,0])
             linear_extrude(height = h/2, scale=0.1, convexity = 3)
             translate([0, -w/4, 0])
             rotate([0,0,(sides==4)?45:0])
             circle(d = w, $fn=sides);
         }
        
   }
}

/**************************************************************
   Generate rectangle with pointed 45deg tip (for windows and other decorations)
***************************************************************/
module special_rectangle (w, h) {
    // if h is too small its ignored
    // ^-- thats not good behaviour, leading to misalignment <<<<
    offs = sqrt(2*pow(w/2,2));
    rotate([180,0,0])
    translate([0,-h/2,0])
    union() {
        hull() {
            translate([0,offs/2,0])
            rotate([0,0,45])
            square(w/2,center=true);

            difference() {
                translate([0,offs,0])
                circle(d=w, $fn=20);
                
                // substract for half circle
                translate([0,offs+w/2,0])
                square([w*1.1,w],center=true);
            }
        }
        if (h > offs)
                translate([0,offs+(h-offs)/2,0])
                square([w,h-offs],center=true);
    }
}


/**************************************************************
   module for distributing elements along floors, sides and per each facet
***************************************************************/
module pattern_around_polygon (w, h, sides, 
            width_padding, height_padding,
            element_max_width, element_height, 
            extrude_length, distribution_ratio) {
// distribute child geometry along sides of defined polygon (w,h,sides)
// size of 2D element given should be 1X1 to completely fill the grid, or smaller for partial.

    h2 = h-height_padding;

    vertical_n = floor(h2/element_height); // how many rows of elements
    element_height2 = h2/vertical_n;

    // treat circular as (diameter/element_width) sided
    circular_n = (sides > 12)? floor(w*3.1415/(element_max_width)): sides; 

    ww = w*sin(180/circular_n); // facet width calculated per circular_n
    element_width = (ww<element_max_width)?ww:element_max_width; // limit window width

    // for circular only one element per facet
    side_length = w*sin(180/sides)-width_padding;
    elements_per_facet = (sides <= 12) ?
                floor ( side_length / element_width ) : 1;
    
    element_width2 = (sides <= 12) ?
                side_length / elements_per_facet : element_width;
    
    inradius = w * cos( 180 / sides ); // inradius of the polygon shape
    
    delta_per_facet = 0.5*(elements_per_facet-1) * element_width2;
    
    rotate([0,0,correction_angle(sides)])
    for (a=[1:1:vertical_n]) // per each floor
    for (b=[0:1:circular_n]) {   // per each side
        for (c=[0:1:elements_per_facet-1]) // per each facet with multiple windows
        if (rands(0,1,1)[0] <= distribution_ratio)
        rotate([0,0,b*360/circular_n])
        translate([-delta_per_facet + c*element_width2,0,0])
        translate([0,inradius/2,(a-0.5)*(h2/vertical_n) + height_padding/2]) {
            union() {
                rotate([90,0,0]) {
                    linear_extrude(extrude_length,center=true)
                    scale([element_width2, element_height2])
                    children(0);
                }
            }
        }
    }
}


// And they lived happily ever after...

