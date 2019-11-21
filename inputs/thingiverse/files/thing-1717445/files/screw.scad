// Parametric screw-like things (ball screws, augers)
// License: GNU LGPL 2.1 or later.
// © 2010 by Elmo Mäntynen


pitch = 450;
pillars = 15;
height = 100;
radius = 50;
pillar_radius = 3;
base_yes_or_no = "yes";
base_solid_yes_or_no = "yes";
base_height = 2;
rim_yes_or_no = "yes";
rim_solid_yes_or_no = "no";
rim_height = 2;
both_directions_yes_or_no = "yes";

if (both_directions_yes_or_no == "yes"){
for (rotation = [0:360/pillars:360]){
echo (rotation);
test_ball_groove(
    rotation = rotation,
    pitch = -pitch,
    height = height,
    radius = radius,
    pillar_radius = pillar_radius);
}
    
}
for (rotation = [0:360/pillars:360]){
echo (rotation);
test_ball_groove(
    rotation = rotation,
    pitch = pitch,
    height = height,
    radius = radius,
    pillar_radius = pillar_radius);
}

if (rim_yes_or_no == "yes"){
rim(radius = radius + pillar_radius,height=height,rim_height=rim_height);
}
if (base_yes_or_no == "yes"){
base(radius = radius + pillar_radius, base_height = base_height);
}

module helix(pitch, height, rotation, slices=500){
    rotate(rotation){
    rotations = height/pitch;
    linear_extrude(height=height, center=false, convexity=10, twist=360*rotations, slices=slices, $fn=100)
            child(0);}
}

module ball_groove(pitch, height, radius, rotation, pillar_radius) {
    helix(pitch, height, rotation, slices=height)
        translate([radius, 0, 0])
        circle(r = pillar_radius);
}

module test_ball_groove(){ ball_groove(pitch, height, radius, rotation, pillar_radius);}

module base(radius, base_height){
    difference (){
        linear_extrude(height = base_height)
        circle(r = radius,$fn=100);
        echo(base_height);
        if (base_solid_yes_or_no == "no"){
            translate([0,0,-base_height]){
        linear_extrude(height = base_height*3)
        circle(r = radius - (pillar_radius*2),$fn=100);
        }
    }
    } 
}
module rim(radius,height,rim_height){
   difference (){
    translate([0,0,height]){ 
    
        linear_extrude(height = rim_height)
        circle(r = radius,$fn=100);
        }
    if (rim_solid_yes_or_no == "no"){
        translate([0,0,height - rim_height/2]){
            
        linear_extrude(height = rim_height+2)
        circle(r = radius - (pillar_radius*2),$fn=100);
            }
        }
    }
}
