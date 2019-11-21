$motor_hole_distance = 31.0; // NEMA 17 Stepper
$thickness = 20; // keep belt as close to the motor as possible to reduce leverage on the rails
$screw_d = 3.4; // M3 screw H13
$screw_head_d = 6; // diameter of the sinkhole for the screw head
$screw_head_sink = 3; // depthness of the sinkhole
$belt_slit_wall_thickness = 3; // space in Z direction on each side
$rail_distance = 20;
$rail_diameter = 8.5; // M8 screw H13
$rail_to_body = 15;

$fn = 64;

difference() {
    union() {
        // main body
        translate([-2.5,-2.5])
            cube([$motor_hole_distance + 5,     $motor_hole_distance + 5,$thickness]);

        // edges
        cylinder(h=$thickness, d=10);

        translate([$motor_hole_distance,0])
            cylinder(h=$thickness, d=10);
         
        translate([0, $motor_hole_distance])
            cylinder(h=$thickness, d=10);
            
        translate([$motor_hole_distance, $motor_hole_distance])
            cylinder(h=$thickness, d=10);
        
        // rail mounting holes
        $rail_outerradius = $rail_diameter + 6;
        // middle hole
        translate([$motor_hole_distance/2,$motor_hole_distance+$rail_to_body,0])
            cylinder(h=$thickness, d=$rail_outerradius);
        // sidehole
        translate([$motor_hole_distance/2 + $rail_distance,$motor_hole_distance+$rail_to_body,0])
            cylinder(h=$thickness, d=$rail_outerradius);
        // connecting block near body
        translate([$motor_hole_distance/2-$rail_outerradius/2,$motor_hole_distance,0])
            cube([$rail_distance+$rail_outerradius/2,$rail_to_body,$thickness]);
        // connecting block outer
        translate([$motor_hole_distance/2,$motor_hole_distance + $rail_to_body,0])
            cube([$rail_distance,$rail_outerradius/2,$thickness]);
    }


    union() {
        // big round hole
        translate([$motor_hole_distance/2, $motor_hole_distance/2, -1])
            cylinder(h=$thickness+2, d = $motor_hole_distance/1.15);
        
        // screw holes + screwheadsinks
        screw_cutout(0,0);
        screw_cutout($motor_hole_distance,0);
        screw_cutout(0,$motor_hole_distance);
        screw_cutout($motor_hole_distance, $motor_hole_distance);
        
        // belt cutout
        translate([$motor_hole_distance/2-$motor_hole_distance/1.5/2,-10,$belt_slit_wall_thickness])
            cube([$motor_hole_distance/1.5,$motor_hole_distance/2+10, $thickness-$belt_slit_wall_thickness * 2]);
        
        // rail mounting holes
        $rail_outerradius = $rail_diameter + 5;
        translate([$motor_hole_distance/2,$motor_hole_distance+$rail_to_body,-1])
            cylinder(h=$thickness + 2, d=$rail_diameter);
        translate([$motor_hole_distance/2+$rail_distance,$motor_hole_distance+$rail_to_body,-1])
            cylinder(h=$thickness + 2, d=$rail_diameter);
    }

}

module screw_cutout(x,y) {
    translate([x,y,$thickness-$screw_head_sink])
        cylinder(h=50, d=$screw_head_d);
    translate([x,y,-1])
        cylinder(h=$thickness+2,d=$screw_d);
}