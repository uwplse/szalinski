/*----------------------------------------------------------------------------*/
/*  Fantastic Castle Generator v1                                             */
/*  Created by Ziv Botzer                                                     */
/*  zivbot@gmail.com                                                          */
/*  7.6.2016                                                                  */
/*  License: Creative Commons - Attribution - Non-Commercial                  */
/*----------------------------------------------------------------------------*/

// preview[view:south, tilt:side]

// Master switch for details (windows, decorations...) - keep it off while you calibrate
generate_details = "No"; // [Yes, No]
// Castle variations - change it for a completely different result
random_seed = 23; // [1:1:400]
// Would you like an island, Sir?
island = "Yes"; // [Yes, No]
// No. of turrets attached to each turret
children = 2;  // [0:1:5]
// Generations (recursions) !!Exponential complexity!!
max_recursion = 2;  // [0:1:5]
// Symmetry for first level !Double complexity!
first_level_symmetry = "No"; // [Yes, No] 
// Symmetry for all other levels !Double complexity!
next_levels_symmetry = "No"; // [Yes, No] 
// Pointed roofs - tall or low? 
roof_pointed_ratio = 1.8; // [0.4:0.2:4]

/* [Main structure ] */
// How many sides/facets for main building 
building_number_of_sides = 0; // [4,6,8,12,60,0:Random]
// Height (without roof) (0 = Random)
building_height = 0;  // [0:1:100]
// Width  (0 = Random)
building_width = 0; // [0:1:100]
// Main building roof type
building_roof_type = 0; // [1:Pointed,2:Flat,3:Flat+Point,4:Dome,0:Random]

/* [Towers and Turrets] */
// Height (without roof)  (0 = Random)
towers_height = 0;  // [0:1:100]
// Width  (0 = Random)
towers_width = 0; // [0:1:100]
// How many sides/facets for towers
towers_number_of_sides = 0; // [4,6,8,12,60,0:Random]
// Towers roof types
towers_roof_type = 0; // [1:Pointed,2:Flat,3:Flat+Point,4:Dome,0:Random]

// Turrets roof types
turrets_roof_type = 0; // [1:Pointed,2:Flat,3:Flat+Point,4:Dome,0:Random]
// Turrets number of sides
turrets_number_of_sides = 0; // [4,6,8,12,60,0:Random]

// Ratio of children turrets to parent (0.1 - very narrow, 0.9 - very wide)
children_width_ratio = 0.7; // [0.1:0.1:0.9]
// Ratio of children turrets to parent (0.1 - very narrow, 0.9 - very wide)
children_height_ratio = 0.7; // [0.1:0.1:0.9]


/* [ Island ] */
// Variations of the island
island_random_seed = 7; // [1:1:200]
// Height
island_height = 25;  // [5:1:100]
// Width
island_width = 80; // [40:1:200]

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
window_coverage = 0.3; // [0.1:0.1:1]
// Height of each floor (affects windows and roofs, as well as minimal turret width)
floor_height = 5; // [1:0.5:20]
// Width of windows
window_width_base = 2.5; // [1:0.5:10]

/* [Decorations: Bricks] */
// Height of the bricks
brick_height = 1.5; // [1:0.5:3]
// Width of the bricks
brick_horz = 12; // [1:0.5:20]
// Width of mortar between the bricks
brick_space = 0.2; // [0.2:0.1:2]
// Depth of spacing between the bricks !this is an overhang - keep it tiny!
brick_space_depth = 0.1; // [0.1:0.1:1]

/* [Partial Generation] */
// Use to separate STLs for colors / materials (didn't test this for printing)
what_to_generate = 1; // [1:Everything,2:Island only,3:Structures only,4:Roofs only]


/* [Hidden] */

// Flag poles are more likely to mess up the print than look nice, so they're permanently off
generate_flag_poles = "No"; // [Yes, No]

// More constants
sides_predef=[4,6,8,12,60]; // possible number of sides per polygon
$fn = 10; // Basic resolution (hardly affects anything, mostly controlled locally)
overlap = 0.01; // used to make sure union/difference give nice results

roof_flat_extend_ratio = 0.5; // [0.1:0.1:1] // Flat roofs - how wide?
pointed_roof_cone_base_ratio = 0.04; // ratio between inverted base cone of roof, and the cone of roof
roof_deco_spacing_height = 0.25*floor_height; // distance between ring decorations on the roofs

max_roof_types = 4;

// collection of booleans for easier handling
gen_roof_decorations = (generate_roof_decorations == "Yes") && (generate_details == "Yes");
gen_windows = (generate_windows == "Yes") && (generate_details == "Yes");
gen_flag_poles = (generate_flag_poles == "Yes") && (generate_details == "Yes");
gen_corbel_decoration = (generate_corbels == "Yes") && (generate_details == "Yes");
gen_bricks = (generate_bricks == "Yes") && (generate_details == "Yes");

gen_structure = ((what_to_generate == 1) || (what_to_generate == 3));
gen_roofs = ((what_to_generate == 1) || (what_to_generate == 4));
gen_island = (island == "Yes") && ((what_to_generate==1) || (what_to_generate == 2));

// uncomment to make every rebuild really random:
//random_seed = floor(rands(0,1000,1)[0]); 
echo(random_seed);




//********************** MAIN *****************************

union() {
    //**** ISLAND *****
    if (gen_island)
        generate_island(island_width, island_height, island_random_seed+random_seed);

    //**** CASTLE *****
    translate([0,0,((gen_island)?overlap:0) ])
        generate_castle(random_seed);
}


/**************************************************************
   Generate a castle.
   No parameters passed except random-seed, it uses the global parameters
***************************************************************/

module generate_castle(rseed) {

    // Place the main building in the middle
    building_width_ = decide_dimension ( building_width, floor_height, 
                                            floor_height*3, 60, rseed);
    building_height_ = decide_dimension ( building_height, 
                                            floor_height*2, 
                                            floor_height*5,
                                            60, rseed) + (gen_island?island_height:0);
    
    turret_round ( building_width_, building_height_, false, 
        decide_number_of_sides (building_number_of_sides, rseed), 
        roof_pointed_ratio/2, decide_roof_type ( building_roof_type, rseed ) );




    // Place #children towers around main structure, with recursive children turrets
    if(children>0)
    for (i = [1:children]) {
        r1 = rands(0,360,1,rseed+i)[0];
        v1 = building_width_*1.1/2;
        
        towers_width_ = decide_dimension ( towers_width, floor_height, 
                                            floor_height*3, 30, rseed+i);
        towers_height_ = decide_dimension ( towers_height, 
                            floor_height*2, 
                            0.4*building_height_, 
                            1.5*building_height_, rseed+i) 
                            + rands(0,15,1,rseed+i)[0];
        
        rotate([0,0, r1 ] )
         translate([0,v1, 0 ])
         turret_recursive(1,max_recursion, towers_width_, towers_height_, true, rseed+i*10 );
        
        if (first_level_symmetry=="Yes") {
            rotate([0,0, 360-r1 ] )
             translate([0,v1, 0 ])
             turret_recursive(1,max_recursion, towers_width_, towers_height_, true, rseed+i*14 );
        }
    }

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


/**************************************************************
   Generate turrets with recursive children
***************************************************************/
module turret_recursive ( current_depth, max_recursion, w, h, main_tower, rseed ) {
    
    if (current_depth <= max_recursion)
    union() {
        
        // how many sides if this were a main tower
        main_tower_number_of_sides = decide_number_of_sides (towers_number_of_sides, rseed+current_depth );
        
        // decide how many sides for this tower/turret
        sides = (main_tower)? main_tower_number_of_sides : 
            decide_number_of_sides (turrets_number_of_sides, rseed+current_depth );
        
        // decide roof type
        main_tower_roof_type = decide_roof_type (towers_roof_type, rseed+current_depth);
        
        this_roof_type = (main_tower)? main_tower_roof_type : 
            decide_roof_type (turrets_roof_type, rseed+current_depth );
        
        // GENERATE TOWER/TURRET
        turret_round(w, h, !main_tower, sides, roof_pointed_ratio, this_roof_type);
        
        inradius = w * cos( 180 / sides ); 

        for (i = [1:children]) {
            r1 = rands(-200,200,1,rseed + i*10 + current_depth*100)[0];
            v1 = inradius*0.6;  // y (offset from center) translation of children
            
            // calc width of children
            cw = w*children_width_ratio*children_width_ratio;
            t_width = (cw > 0.8*floor_height)?cw:0.8*floor_height; // set a minimum to turrets width
            
            t_height = h*children_height_ratio*children_height_ratio;
        
            z_transform = rands(2*t_width,1.1*h,1,rseed + i + current_depth)[0];
            
            rotate([0,0, r1 ] )
            translate([0,v1, z_transform])
            turret_recursive(current_depth+1, max_recursion, t_width, t_height, false, rseed*i );
            
            if (next_levels_symmetry=="Yes") 
                rotate([0,0, 360-r1 ] )
                translate([0,v1, z_transform])
                turret_recursive(current_depth+1, max_recursion, t_width, t_height, false, rseed*i+10 );
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
   
    rotate([0,0,(sides==4)?45:0])
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
                roof_flat (w, 1.3*floor_height, sides);
        }
        else if (rtype == 3) {
            // flat and point
            if(gen_structure) {
                roof_flat (w, 1.1*floor_height, sides);
                translate([0,0,0.5*floor_height-overlap])
                    turret_body ( 0.7*w, floor_height, sides );
            }
            if (gen_roofs)
                translate([0,0,0.5*floor_height + floor_height-2*overlap])
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

    roof_bottom_part_height = roof_flat_extend_ratio*floor_height;
    roof_top_part_height = h-roof_bottom_part_height;
    
    roof_top_width = w+roof_flat_extend_ratio*floor_height;
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
            //if (gen_roof_decorations)
            translate([0,0,0.6*roof_top_part_height])
            pattern_around_polygon (roof_top_width, roof_top_part_height, sides, 
                               element_max_width=floor_height, 
                               element_height=roof_top_part_height, 
                               shape_type=1, shape_width_factor=0.4, 
                               shape_height_factor=1.3, extrude_length=5,
                               distribution_ratio=1 );

        }
        
        
        
        // base part with corbels
        difference() {
            linear_extrude(roof_bottom_part_height, scale=roof_scale)
             circle(d=w*1.0,$fn=sides);
        
            if (gen_corbel_decoration)
            translate([0,0,-0.1*roof_bottom_part_height])
            pattern_around_polygon (roof_top_width, roof_bottom_part_height, sides, 
                               element_max_width=0.7*floor_height, element_height=roof_bottom_part_height, 
                               shape_type=2, shape_width_factor=0.6, 
                                shape_height_factor=1, extrude_length=roof_overhang,
                                distribution_ratio=1 );

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
                cube_height = 0.1*roof_cone_height;
                cube_position_ratio = 0.05;
                translate([0,0,overlap])
                intersection() {
                    pattern_around_polygon ( roof_cone_base_width,
                                    cube_height, sides, 
                                   element_max_width=floor_height, 
                                   element_height=cube_height, 
                                   shape_type=2, 
                                   shape_width_factor=0.5, 
                                   shape_height_factor=1, 
                                   extrude_length=0.2*roof_cone_base_width,
                                   distribution_ratio=1 );
                    
                    translate([0,0,-overlap])
                    linear_extrude(cube_height*2)
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
   Generate DOME ROOF with decorations
***************************************************************/
module roof_dome ( w, h, sides ) {
    
    shortest_radius = w * cos( 180 / sides ) / 2; 
        // ^-- for polygons with low number of sides, gives the constrained radius
    dome_diameter = shortest_radius*2;

    union() {
        // roof cone
        color("OrangeRed")
        intersection() {
            sphere(d = dome_diameter, $fn = 60);
            
            translate([0,0, (dome_diameter/2)-overlap])
            cube(dome_diameter, center=true);
        }
        
        if (gen_roof_decorations)
        color("DarkGoldenrod")
        translate([0,0,0.01*dome_diameter])
        intersection() {
            sphere(d = dome_diameter-overlap, $fn = 60);
            
            for (i=[0:1:360/8])
            rotate([0,0,i*360/8])
            translate([0,0, (dome_diameter/2)-overlap])
            cube([dome_diameter, 0.05*dome_diameter,dome_diameter], center=true);
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
            pattern_around_polygon (w, h, sides, window_width_base, floor_height, 
                                2, 0.5, 0.7, 1.5, window_coverage );

        
        // _____Generate brick pattern______
        color("DarkGray")
        if (gen_bricks) {
            
            how_many_rows =  floor( (h-brick_space) / (brick_height+brick_space));
            brick_height2 = (h-((how_many_rows-1)*brick_space)) / how_many_rows;
            
            how_many_cols = floor(w*3.1416/brick_horz);
            bricks_angle = 360/how_many_cols;

            // create the horizontal slots between the rows of bricks
            for (i = [1: 1:how_many_rows-1] ) {
                translate([0,0,i*(brick_height2+brick_space)-brick_space]) {
                        linear_extrude(brick_space,false) {
                        difference () {
                            circle(d = w*1.5, $fn=sides);
                            circle(d = w-brick_space_depth, $fn=sides);
                        }
                    }
                }
                
            }
            
            // create the vertical slots between the columns of bricks + random rotation
            difference () {
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
                
                translate([0,0,-0.5])
                linear_extrude(h+1) circle (d=w-brick_space_depth*2, $fn=sides);
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
    
    correct = (sides==4)?45:(sides==5)?18:(sides==8)?22.5:(sides==12)?15:0;

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
    
    offs = sqrt(2*pow(w/2,2));

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
        
        if (h > offs)
        translate([0,offs+(h-offs)/2,0])
        square([w,h-offs],center=true);
    }
}


/**************************************************************
   Generate an island for anointed knights such as yourself
***************************************************************/
module generate_island ( w, h, iseed ) {
    color("Brown")
    scale([w/10,w/10,h/2])
    difference() {

        linear_extrude(2,scale=0.5)
        circle(d=10,$fn=10);
        
        n = floor( rands(0,6,1,iseed)[0]);
        
        for(i=[0:1:n])
        rotate([0,0,i*(360/n)])
        rotate([11,rands(-4,4,1,iseed+i)[0],0])
        translate([0,0,7])
        cube([10,10,10],center=true);
        
        for(i=[0:1:n])
        rotate([0,0,i*(360/n)])
        rotate([35, rands(-4,4,1,iseed+i*10)[0] ,0])
        translate([0,0,7.8])
        cube([10,10,10],center=true);
        
        for(i=[0:1:n])
        rotate([0,0,(i + rands(-0.5,0.5,1,iseed+i*100)[0] )*(360/n) ])
        translate([10.5,0,-1])
        rotate([0,0,30])
        linear_extrude(5)
        circle(d=14,$fn=5);
    }
}


/**************************************************************
   module for distributing elements along floors, sides and per each facet
***************************************************************/
module pattern_around_polygon (w, h, sides, element_max_width, element_height, 
                                shape_type, shape_width_factor, shape_height_factor, extrude_length,
                                distribution_ratio) {
    // shape_type 1 = rectangle 
    // shape_type 2 = rectangle with sharp tip

    vertical_n = floor(h/element_height); // how many rows of elements

    // treat circular as (diameter/element_width) sided
    circular_n = (sides > 12)? floor(w*3.1415/(element_max_width)): sides; 

    ww = w*sin(180/circular_n); // facet width calculated per circular_n
    element_width = (ww<element_max_width)?ww:element_max_width; // limit window width

    // for circular only one element per facet
    elements_per_facet = (sides <= 12) ?
                floor (  w*sin(180/sides) / element_width ) : 1;
    
    inradius = w * cos( 180 / sides ); // inradius of the polygon shape
    
    delta_per_facet = 0.5*(elements_per_facet-1) * element_width;
    
    rotate([0,0,correction_angle(sides)])
    for (a=[1:1:vertical_n]) // per each floor
    for (b=[0:1:circular_n]) {   // per each side
        for (c=[0:1:elements_per_facet-1]) // per each facet with multiple windows
        if (rands(0,1,1)[0] <= distribution_ratio)
        rotate([0,0,b*360/circular_n])
        translate([-delta_per_facet + c*element_width,0,0])
        translate([0,inradius/2,(a-0.5)*(h/vertical_n)]) {
            union() {
                rotate([90,0,0]) {
                    // **** Generate elements
                    w_width = element_width*shape_width_factor;
                    w_height = element_height*shape_height_factor;
                    
                    if (shape_type == 1) {
                        // simple rectangle
                        rotate([0,0,180])
                        linear_extrude(extrude_length,center=true)
                        square([w_width,w_height],center=true);
                    }
                    else if (shape_type == 2) {
                        // standard window shape
                        f = 1.2; // scale to make tip less than 45deg
                        translate([0,(w_height/2)/f,0]) rotate([0,0,180])
                        linear_extrude(extrude_length,center=true)
                        scale([1,f,1])
                        special_rectangle(w_width,w_height/f);
                    }
                    // **** 
                }
            }
        }
    }

}

// And they lived happily ever after...

