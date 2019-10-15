//define variables and set defaults
smoothness=40;
$fn=smoothness;
clip_height=8;
clip_width=8;
clip_thickness=5;
half_circle_diameter=2;
brace_height=12;
brace_width=12;
brace_thickness=9;
holes="side_by_side"; //[side_by_side,centered]
center_hole_depth=.825;
distance_to_wall_from_center_of_half_circles=(clip_thickness/2)+brace_thickness;

// adjustable clip part
module clip (){
    difference (){
        translate ([-clip_width/2,-clip_thickness/2,0]) cube ([clip_width,clip_thickness,clip_height]);
        if(holes=="side_by_side") {
            translate ([-clip_width/2,0,-.25]) cylinder (d=half_circle_diameter,h=clip_height+.5);
        translate ([clip_width/2,0,-.25]) cylinder (d=half_circle_diameter,h=clip_height+.5);
        }
        if(holes=="centered") {
            translate ([0,(-clip_thickness/2)*center_hole_depth,-.25]) cylinder (d=half_circle_diameter,h=clip_height+.5);
    }
}

}

// adjustable filler spacer
module brace (){
    translate([-brace_width/2,clip_thickness/2,0]) cube ([brace_width,brace_thickness,brace_height]);
}

// build it 
clip();
brace();

//output distance messages
echo ("distance to wall from center of half circles in mm");
echo (distance_to_wall_from_center_of_half_circles);
echo (holes);