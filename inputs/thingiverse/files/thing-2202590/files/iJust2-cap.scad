//Personal Preference

cap_width = 22;
cap_height = 27;
outer_diameter = 12.5;
inner_diameter = 6;
outer_lip_diameter =  13.5;

//ecig dimmensions
outer_radius = outer_diameter/2;  //outer radius of mouthpiece
inner_radius = inner_diameter/2; // inner radius of mouthpiece
tolerance = 0.5; //how little you trust your printer or measurements
mouthpiece_height = 22; // how long the cap your covering is

outer_radius_lip = outer_lip_diameter/2; //outer radius of lip if it has a lip at the base. (if there is no lip, you can set it to 0, or the same radius as the outer_radius)
mouthpiece_lip_height = 7;


cap_radius = cap_width/2;
$fn = 100; // resolutiSon
//begin part rendering
difference() {
rough_body();
rounding_inner();
outer_rounding(inner_radius-(tolerance/2), 1);
translate([0,0,cap_height-cap_radius/4]) top_rounding(cap_radius,cap_radius/4); //needs to be translated by the curvature
}

module outer_body(){ //outer cup
difference(){
cylinder(h = cap_height, r = cap_radius, center = false);
translate([0, 0, -1]) cylinder(h = mouthpiece_height+1, r = (outer_radius + 0.5*tolerance), center = false);
    translate([0, 0, -1]) cylinder(h = mouthpiece_lip_height+1, r = (outer_radius_lip + 0.5*tolerance), center = false);
    }
}

module inner_body(){  //inner pin that gets put into the mouthpiece
cylinder(h = cap_height, r = inner_radius - (tolerance/2), center = false);    
}

module rough_body() { //regular polygon body. good enough functionally
    union(){
outer_body();
inner_body();
    }
}


//Pretty Stuff
module rounding_inner() { // create differential shape for internal rounding
curvature = (outer_radius-inner_radius)/2 + tolerance/2;
rotate_extrude(convexity = 10, $fn = 100)
translate([inner_radius+curvature-tolerance/2, mouthpiece_height, 0])
circle(r = curvature, $fn = 100);
}


module outer_rounding(radius, curvature) { // create shape to subtract to round the inner pin
difference(){
    rotate_extrude(convexity = 10, $fn = 100)
    translate([radius-curvature, 0, 0])
    square(curvature, curvature);

    rotate_extrude(convexity = 10, $fn = 100)
    translate([radius-curvature, curvature, 0])
    circle(r = curvature, $fn = 100);

}
}

module top_rounding(radius, curvature) { //create shape to subtract to round the top
difference(){
    rotate_extrude(convexity = 10, $fn = 100)
    translate([radius-curvature, 0, 0])
    square(curvature, curvature);

    rotate_extrude(convexity = 10, $fn = 100)
    translate([radius-curvature, 0, 0])
    circle(r = curvature, $fn = 100);

}
}