/* 
    Bearing Generator v0.10, 2019-03-06
    Author: SeanTheITGuy (theitguysean@gmail.com)
    Generates bearings of any size with some magic for lightening the overall build if the ID and OD are of significantly different size.
    License: Do what you want. I'm not a cop.
    
    2019-03-07 - v0.1.1.  Updated to create better clearance for bearings and improve poly count.
    
    2019-03-08 - v0.2.0.  Rebuilt how base extrusion is created to allow for best possible ball race placement.
 */
    

// Diameter of desired bearings (mm) (Airsoft BBs are 6mm. Standard marbles are ~16mm.)
ball_size = 6;  
// Desired number of balls (if outside sensible bounds, will be set to max or min, accordingly)
balls = 8;
// Clearance for ball imperfection (mm) (recommended min 0.25)
clearance = 0.5;
// ID of bearing (mm)
inner_race = 32; 
// OD of bearing (mm)
outer_race = 55;
// Thickness of walls (mm)
wall_thickness = 2;
// Make the inner race?
make_inner = 1; // [1:true, 0:false]
// Make the outer race?
make_outer = 1; // [1:true, 0:false]
// Make weight reduction if a race wall is excessively tall?
speed_holes = 1; // [1:true, 0:false]
// Fragment Count (resolution) (recommended min 100+ for 3D Printing)
resolution = 200;

{ echo("Begin."); }

// Set face resolution high for 3d printing
$fn=resolution; 

// check for sense
max_ball_size = outer_race/2 - inner_race/2 - wall_thickness*2 - clearance;
echo("Max Ball Size: ", max_ball_size);
if (ball_size+clearance > max_ball_size){
    color("red") text("Error. Balls too big.", size=6, halign="center");
}
else{        
    // build clearance for easy rolling
    race_size = ball_size+clearance; 
     
    // Determine the max and min number of balls for set parameters
    min_balls = floor( (PI * (inner_race + race_size + wall_thickness*2)) / ball_size) ;
    max_balls = floor((PI * (outer_race - (race_size + wall_thickness*2))) / ball_size);
    echo("Ball limits: ", min_balls, max_balls);
    
    // If requested ball count doesn't make sense, set within range
    ball_count = balls < min_balls ? min_balls : (balls > max_balls ? max_balls : balls);

    // find distance from center of bearing to center of desired race channel
    channel_radius = (ball_size * ball_count) / (PI * 2) + wall_thickness;
    
    // Create the thing
    difference(){
        difference(){
            // create the inner and outer races
            rotate_extrude(){
                difference(){
                    difference(){
                        // Draw profile of inner and outer race
                        difference(){
                            translate([inner_race/2, (-race_size - wall_thickness)/2, 0])
                                square([(outer_race - inner_race)/2, race_size + wall_thickness]);
                            
                            // Draw the race channel
                            translate([channel_radius, 0, 0])
                                circle(race_size/2);
                        }
                        // Separate the inner and outer races
                        translate([channel_radius, 0, 0]) 
                            square([wall_thickness, race_size + wall_thickness * 2], center=true);
                    }
                    // Delete inner or outer race as required                    
                    if (!make_inner) {
                        translate([inner_race/2, (-race_size - wall_thickness)/2, 0])
                            square([channel_radius - inner_race/2, race_size + wall_thickness]);
                    }
                    if (!make_outer) {
                        translate([channel_radius, (-race_size - wall_thickness)/2, 0])
                            square([outer_race/2 - channel_radius, race_size + wall_thickness]);
                    }
                }
            }            
            // place the bearing insertion hole
            translate([channel_radius, 0, 0]) 
                cylinder(r=race_size/2, h=race_size+wall_thickness);
        }
        // check if race walls are excessively tall
        union(){
            if (speed_holes){
                if (channel_radius - inner_race/2 > 2*race_size){
                    hole_count = floor((PI*(channel_radius + inner_race/2)/2) / race_size);
                    for (hole=[0:360/hole_count:360]){
                        rotate([0,0,hole])
                            translate([(channel_radius + inner_race/2)/2,0,-race_size])
                                cylinder(r=race_size/1.33, h=2*race_size);
                    }
                }
                if (outer_race/2 - channel_radius > 2*race_size){
                    hole_count = floor((PI*(outer_race/2 + channel_radius)/2) / race_size);
                    echo("HOLES: ", hole_count);
                    for (hole=[0:360/hole_count:360]){
                        rotate([0,0,hole])
                            translate([(outer_race/2 + channel_radius)/2,0,-race_size])
                                cylinder(r=race_size/1.33, h=2*race_size);
                    }
                }
            }
        }
    }  
    /*
    // For visual, generate balls in place
    for (ball=[0:360/ball_count:360]) {
        rotate([0,0,ball]) color("grey") translate([channel_radius, 0, 0]) sphere(r=ball_size/2);
    }
    */
}

