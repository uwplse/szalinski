$strip_width=50;
$strip_height=26;
$frame_width=15;
$frame_thickness=2.4;

$holder_width=$strip_width+2*$frame_thickness;
$holder_length=20;
$holder_thickness=$frame_thickness;

$pin_width=25;
$pin_thickness=12;
$pin_heigth=5;


$screw_hole_diameter=4;
$fn=150;


difference(){
    cube([$strip_width+2*$frame_thickness,$frame_width+$frame_thickness,$strip_height+$frame_thickness], center=true);
    //strip cut
    translate([0,$frame_thickness/2,-$frame_thickness/2]) cube([$strip_width,$frame_width,$strip_height], center=true);
}
difference(){
    translate([0,-$holder_length/2-$frame_width/2-$frame_thickness/2,-$strip_height/2]) 
        cube([$holder_width,$holder_length,$holder_thickness], center=true);
    translate([0,-$holder_length/2-$frame_width/2-$frame_thickness/2,-$strip_height/2]) 
        cylinder(d=$screw_hole_diameter,h=2*$holder_thickness, center=true);
}

translate([0,$pin_thickness/2-$frame_width/2+$frame_thickness/2,$pin_heigth/2-$strip_height/2-$frame_thickness/2]) cube([$pin_width,$pin_thickness,$pin_heigth],center=true);