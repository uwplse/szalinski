//customizable optical encoder
// James Wickware - 7/18/2016

// preview[view:north east, tilt:top diagonal]

/* [Encoder] */
// the outer diameter of the optical encoder in millimeters.
outer_diameter = 30; //[0:150] 

// the height of the encoder wheel in millimeters.
wheel_height = 2; //[0.1:0.1:20]

// the length of the slits in millimeters.
slit_length = 6; //[0:0.5:75]

// the number of slits in the encoder.
slit_count = 24; // [2:100]

// the ratio of the slit opening to the solid section between the slits. (0.5 is equal )
slit_ratio = 0.5; // [0.05:0.05:0.95]

// the distance between the outer diameter and the opening of the slits in millimeters.
rim_width =  1.75; // [0:0.25:25]



/* [Hub] */
// the diameter of the inner hub in millimeters.
hub_diameter = 12; // [0:0.25:25]

// the length that the hub shaft extends from the encoder wheel in millimeters.
hub_height = 4; // [0:0.5:50]


/* [Shaft] */
// the type of shaft 0 for circular shaft, 1 d shaft (circular with 1 flat, 2 double d shaft (circular with 2 flats), 3 for square shaft 4 for hex shaft, 5 for octagonal shaft.
shaft_type =2; //[0:Cylindrical Shaft, 1:D Type Shaft,2:Double D type Shaft,3:Square Shaft, 4:Hexagonal Shaft, 5:Octagonal Shaft]

// the diameter of the hole for the shaft in millimeters.
shaft_diameter = 4.5; //[0:0.1:20]

// Choose whether or not you want the shaft to go all the way through the encoder wheel.
shaft_goes_through_encoder =0 ; // [0:False,1:True]

// the depth of the flat from the outside edge of the shaft in millimeters (for d and double d shaft type only).
shaft_flat_depth = 1; // [0:0.1:10]


/* [Set Screw] */
// choose whether to include a hole for a set screw
set_screw = 1; // [0:False,1:True]

// the size of the set screw in millimeters
set_screw_diameter = 3; // [0:0.5:10]

// choose whether to include a slot for a set screw nut (automatically disabled when there is not enough room for it).
set_screw_nut = 1; // [0:False,1:True]

// the set screw nut diameter in millimeters. (for hex nuts, the distance from one corner to the opposite corner)
set_screw_nut_diameter = 5; // [1:0.25:14]
 
//  the set screw nut thickness in millimeters
set_screw_nut_thickness = 2; //[0.25:0.25:10]

/* [Hidden] */

// the outer radius
outer_radius = max(outer_diameter/2, hub_diameter/2);

// the hub radius.
hub_radius = hub_diameter/2;
shaft_radius = shaft_diameter/2;

// the depth of the hole for the shaft in millimeters.
shaft_depth = hub_height + (wheel_height*shaft_goes_through_encoder);  

// calcuate whether or not the set screw and or nut can safely be included.
min_set_screw_nut_diameter = set_screw_diameter + 0.5;
max_set_screw_nut_diameter = (hub_diameter - shaft_diameter) * 0.6; // allow 60% of distance between shaft and hub
max_set_screw_nut_thickness = (hub_radius - shaft_radius) * 0.6; // allow 60% of distance between shaft and hub

can_have_screw =  (hub_height-0.99 > set_screw_diameter)  ? 1:0 ;
  
can_have_nut =  ((set_screw_diameter > 0) ? 1: 0)
                 * ((set_screw_diameter < set_screw_nut_diameter) ? 1:0)
                * ((set_screw_nut_thickness < max_set_screw_nut_thickness) ? 1:0) 
                * set_screw_nut
                * can_have_screw;
echo(can_have_screw);
echo(can_have_nut);

set_screw_nut_offset = (((shaft_type == 0) ? 1:0) * .95)
                       +(((shaft_type == 1) ? 1:0) * .85)
                       +(((shaft_type == 2) ? 1:0) * .85)
                       +(((shaft_type == 3) ? 1:0) * .925)
                       +(((shaft_type == 4) ? 1:0) * .925)
                       +(((shaft_type == 5) ? 1:0) * .925)
                       +(((shaft_type == 6) ? 1:0) * .925)
                       +(((shaft_type == 7) ? 1:0) * .925)
                       +(((shaft_type == 8) ? 1:0) * .925)
                       ;
                       
                       
                       echo(set_screw_nut_offset);
// fudge factor to prevent coplanar boolean issues
fudge = 0.01;
difference(){
    union(){
 
        // Setup variables for wheel
        outer_rad = max((outer_radius - rim_width ) + fudge, hub_radius + fudge) ;
        inner_rad = max((outer_radius - rim_width - max(slit_length,0)) + fudge , hub_radius + fudge );
        step = 360/slit_count;
        half_step = step/2;
        qtr_step =  half_step / 2 ;       
        
        echo("step");
        echo (step);
        ratio_angle = (slit_ratio-0.5) * half_step;
        // don't create slits if some touch-hard has made the hub too big
        if(outer_rad > inner_rad){ 
            // create the wheel
            difference(){
                cylinder(r = outer_diameter/2, h= wheel_height, $fn = slit_count * 2, center = true);
             
                if( slit_count%2 == 0){

                    // create slits
                    for (i = [0 :  step : 360 - fudge  ])
                    {
                        points = [
                        [ sin(i +ratio_angle)*outer_rad, cos(i+ratio_angle)*outer_rad , -wheel_height ],  
                        [ sin(i +ratio_angle)*inner_rad, cos(i+ratio_angle)*inner_rad,  -wheel_height ], 
                        [ sin(i+half_step - ratio_angle)*inner_rad , cos(i+half_step- ratio_angle)*inner_rad, -wheel_height ],  
                        [ sin(i+half_step - ratio_angle)*outer_rad,  cos(i+half_step- ratio_angle)*outer_rad, -wheel_height ],
                        [ sin(i+ratio_angle)*outer_rad, cos(i+ratio_angle)*outer_rad,  wheel_height ],
                        [ sin(i+ratio_angle)*inner_rad, cos(i+ratio_angle)*inner_rad,  wheel_height ],
                        [ sin(i+half_step - ratio_angle)*inner_rad , cos(i+half_step- ratio_angle)*inner_rad,  wheel_height ],
                        [ sin(i+half_step - ratio_angle)*outer_rad,  cos(i+half_step- ratio_angle)*outer_rad,  wheel_height ]
                        ];

                        faces = [
                        [0,1,2,3],   
                        [4,5,1,0],   
                        [7,6,5,4],   
                        [5,6,2,1],   
                        [6,7,3,2],  
                        [7,4,0,3]];  

                        rotate(0,0,i)
                        polyhedron( points, faces ) ; 
                    } 
                }
                else{   
                    for (i = [0 :  step : 360  - fudge])
                    {
                        points = [
                        [ sin(i-qtr_step)*outer_rad, cos(i-qtr_step)*outer_rad , -wheel_height ],  
                        [ sin(i-qtr_step)*inner_rad, cos(i-qtr_step)*inner_rad,  -wheel_height ], 
                        [ sin(i+qtr_step)*inner_rad , cos(i+qtr_step)*inner_rad, -wheel_height ],  
                        [ sin(i+qtr_step)*outer_rad,  cos(i+qtr_step)*outer_rad, -wheel_height ],
                        [ sin(i-qtr_step)*outer_rad, cos(i-qtr_step)*outer_rad,  wheel_height ],
                        [ sin(i-qtr_step)*inner_rad, cos(i-qtr_step)*inner_rad,  wheel_height ],
                        [ sin(i+qtr_step)*inner_rad , cos(i+qtr_step)*inner_rad,  wheel_height ],
                        [ sin(i+qtr_step)*outer_rad,  cos(i+qtr_step)*outer_rad,  wheel_height ]
                        ];

                        faces = [
                        [0,1,2,3],   
                        [4,5,1,0],   
                        [7,6,5,4],   
                        [5,6,2,1],   
                        [6,7,3,2],  
                        [7,4,0,3]];  

                        rotate(0,0,i)
                        polyhedron( points, faces ) ;
                    }
                }
                
            }
        }
        
        // create hub
        if(hub_height > 0){
            if(set_screw == 1 && set_screw_diameter > 0 && can_have_screw == 1){
                difference(){
                  translate([0,0, ((hub_height/2) + (wheel_height /2))] )       
                  cylinder(r= min(hub_diameter/2, (outer_diameter/2)-fudge ), h = hub_height +(fudge*2), $fn = slit_count *2, center = true);
                    
                    // set screw hole
                    translate([0,0, ((hub_height/2) + (wheel_height/2 ))] ) 
                    rotate([-90,0,0]) 
                     cylinder(r=set_screw_diameter/2, h=hub_diameter, $fn=16);
                    if(can_have_nut == 1){
                    // set screw nut
                   translate([0,(hub_radius - ((hub_radius-shaft_radius)/2))*set_screw_nut_offset, ((hub_height/2) + (wheel_height/2 ))] )     
                    rotate([90,00,00])
                    cylinder(r=max(min_set_screw_nut_diameter/2,set_screw_nut_diameter/2), h=max(set_screw_nut_thickness,0.25) +fudge, $fn=6, center = true);
                    
                   translate([0,(hub_radius - ((hub_radius-shaft_radius)/2))*set_screw_nut_offset, ((hub_height/2) + (wheel_height/2 )) + 
                    (((hub_height/2) + (wheel_height/2 )+set_screw_nut_diameter /2 )-fudge) /2] )  
                    cube([max(min_set_screw_nut_diameter ,set_screw_nut_diameter ) ,max(set_screw_nut_thickness,0.25)-fudge,(((hub_height/2) + (wheel_height/2 )+max(min_set_screw_nut_diameter ,set_screw_nut_diameter ) /2 ))  ],center=true);
                    }
                    
                    }
            }
            else {
                translate([0,0, ((hub_height/2) + (wheel_height /2))] )       
                cylinder(r= min(hub_diameter/2, (outer_diameter/2)-fudge ), h = hub_height +(fudge*2), $fn = slit_count *2, center = true);        
            }
        }
    };
 
 // shaft
    // cylindrical shaft
    if(shaft_type == 0){
        translate([0,0, ((shaft_depth/2) + (wheel_height /2) + (hub_height ))]) // move shaft to the top of the hub
        translate([0,0,-min(shaft_depth, hub_height+wheel_height)]) // insert the shaft until it hits bottom >:)

        cylinder(r= shaft_diameter/2, h=shaft_depth + (fudge*4) , $fn = max(slit_count*2, 6) ,center = true);
    }
    
    // d type shaft
    if(shaft_type == 1)
    {
        translate([0,0, ((shaft_depth/2) + (wheel_height /2) + (hub_height ))]) // move shaft to the top of the hub
        translate([0,0,-min(shaft_depth, hub_height+wheel_height)]) // insert the shaft until it hits bottom >:)
    
        difference(){
            cylinder(r= shaft_diameter/2, h=shaft_depth + (fudge*4) , $fn = max(slit_count*2, 6) ,center = true);    
       
            translate([0, max( shaft_diameter - shaft_flat_depth , shaft_diameter/2),0  ]) 
            cube ( [shaft_diameter*2,shaft_diameter, shaft_depth*2 ], center = true)  ; 
       }  
    }

    // double d type shaft -- double D = big breasts -- 
    if (shaft_type == 2)
    {
        translate([0,0, ((shaft_depth/2) + (wheel_height /2) + (hub_height ))]) // move shaft to the top of the hub
        translate([0,0,-min(shaft_depth, hub_height+wheel_height)]) // insert the shaft until it hits bottom >:)
    
        difference(){
            cylinder(r= shaft_diameter/2, h=shaft_depth + (fudge*4) , $fn = max(slit_count*2, 6) ,center = true);    
         
            translate([0, max( shaft_diameter - shaft_flat_depth , shaft_diameter/2),0  ]) 
            cube ( [shaft_diameter*2,shaft_diameter, shaft_depth*2 ], center = true); 
         
            translate([0, min( -( shaft_diameter - shaft_flat_depth), -(shaft_diameter/2)),0  ]) 
            cube ( [shaft_diameter*2,shaft_diameter, shaft_depth*2 ], center = true); 
        }  
    }
    
    // square shaft
    if (shaft_type == 3)
    {
        translate([0,0, ((shaft_depth/2) + (wheel_height /2) + (hub_height ))]) // move shaft to the top of the hub
        translate([0,0,-min(shaft_depth, hub_height+wheel_height)]) // insert the shaft until it hits bottom >:)
        rotate([0,0,45]) 
        cylinder(r= shaft_diameter/2, h=shaft_depth + (fudge*4) , $fn = 4 ,center = true);
    }
    
    // hex shaft
    if (shaft_type == 4)
    {
        translate([0,0, ((shaft_depth/2) + (wheel_height /2) + (hub_height ))]) // move shaft to the top of the hub
        translate([0,0,-min(shaft_depth, hub_height+wheel_height)]) // insert the shaft until it hits bottom >:)
    
        cylinder(r= shaft_diameter/2, h=shaft_depth + (fudge*4) , $fn =   6  ,center = true);
    }
    
    // octopus shaft
    if (shaft_type == 5)
    {
        translate([0,0, ((shaft_depth/2) + (wheel_height /2) + (hub_height ))]) // move shaft to the top of the hub
        translate([0,0,-min(shaft_depth, hub_height+wheel_height)]) // insert the shaft until it hits bottom >:)
      rotate([0,0,22.5]) 
        cylinder(r= shaft_diameter/2, h=shaft_depth + (fudge*4) , $fn =   8  ,center = true);
    }
}