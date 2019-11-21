// simple custom polybowl

sides=11;
bowl_radius=40;
thickness = 1.5;
body_flare = 1.2;
body_twist_multiplier = 4;
body_twist = 360 / sides * body_twist_multiplier;
rim_height = 1;
layer_resolution_multiplier = 1;
base_height = 3;
body_height = 100;
edge_width = 2;
corner_resolution = 100;
both_directions_yes_or_no = "yes";
//solid = "no"; //This option is still being worked on.

//base
linear_extrude(height=base_height)
    polyShape(solid="yes");

//rim(s)

    translate([0,0,base_height + body_height])
    rotate(body_twist)
    scale(body_flare)
    linear_extrude(height=rim_height)    
        polyShape(solid = "no");

//body
   
    translate([0,0,base_height])
    linear_extrude(height=body_height, twist = body_twist, scale = body_flare, slices = layer_resolution_multiplier * body_height)
    polyShape(solid = "no");

if (both_directions_yes_or_no == "yes"){
   
 translate([0,0,base_height])
    //rotate(-bodytwist)
    linear_extrude(height=body_height, twist = -body_twist, scale = body_flare, slices = layer_resolution_multiplier * body_height)
    polyShape(solid = "no");

}
module polyShape(solid){
    difference(){
    offset(r=edge_width, $fn=corner_resolution)
        circle(r=bowl_radius, $fn=sides);
        if (solid=="no"){
            offset(r=edge_width - thickness, $fn=corner_resolution)
            circle(r=bowl_radius, $fn=sides);
        }
    }
}