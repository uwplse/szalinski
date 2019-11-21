$fn=200;

$cube_thickness=32;
$cube_lenght=57;
$cube_heigth=36.5;
$cube_heigth2=13.7;

$hole_offset=14;
$hole_diameter=5;

$screw_z_offset=3;
$screw_height=0;
$screw_diameter=9;

$tube_diameter=26;
$tube_height1=4.5;
$tube_height2=23.5;
$tube_x_offset=10;


//circular_segment
$chord_length=62;
$segment_height=5.82;
$circle_radius=($chord_length*$chord_length)/(8*$segment_height)+$segment_height/2;
//echo ("Outside diameter: ",$circle_radius);
//echo ("Circle diameter: ",$circle_radius-$tube_diameter/2);
$tube_hole_radius=$circle_radius-$tube_diameter/2;
$tube_cutting_cube=$cube_thickness+1;

difference(){
 //base cube
    cube([$cube_lenght,$cube_thickness,$cube_heigth]);
//screw hole
    translate([$hole_offset,$cube_thickness/2,0]) cylinder(d=$hole_diameter, h=$cube_heigth, center=false);
//screw head housing
    translate([$hole_offset,$cube_thickness/2,0]) cylinder(d=$screw_diameter, h=$screw_z_offset, center=false);
//tube hole
translate([$tube_x_offset,$tube_diameter/2+($cube_thickness-$tube_diameter)/2,$tube_hole_radius+$tube_height1]) rotate([90,0,0])rotate_extrude(convexity=10) translate([$tube_hole_radius-$tube_diameter/2,0,0]) circle(d=$tube_diameter);
//cutting
translate([$tube_x_offset,$tube_cutting_cube/2,$tube_hole_radius+$tube_height1]) rotate([90,0,0])rotate_extrude(convexity=10) translate([$tube_hole_radius-$tube_diameter,0,0]) square(size=[$tube_diameter,$tube_cutting_cube],center=true);
};

