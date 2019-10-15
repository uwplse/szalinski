stl_quality=120; //[30:Low,60:Medium,120:High]
$fn=stl_quality;

//The radius of the ball (mm)
ball_radius=100;

//Size of the base 
base_size=30;

//Use the following to create an oval cutout
scale_x=1;
scale_y=1;
scale_z=1;

//Amount of arms
amount_arms=10;

//Use this to cut the top off and make it shorter
arm_height=60;

//Thickness of arms
arm_thickness=10;

//Length of arms (in mm from the centre)
arm_length=100;


/* [Hidden] */
module stand (rad) {
        difference(){
                union(){
                    // Round Base
                    cylinder(r=base_size,h=rad);
                    // Arms 
                    for (a =[0:360/amount_arms:360]){
                        rotate([0,0,a])
                            translate([0,arm_length/2,arm_height/2])
                                cube([arm_thickness,arm_length,arm_height],center=true);
                    }
                }
                // Subtract Ball
                translate([0,0,rad+1.5])
                scale([scale_x,scale_y,scale_z])
                    sphere(r=rad);
        }
}

stand(ball_radius);
