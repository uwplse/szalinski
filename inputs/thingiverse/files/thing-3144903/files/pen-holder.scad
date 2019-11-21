/*****************************************
 Aliaksei Petsiuk
 EE5777 Open Source 3D Printing
 Customizable Pen Holder
*****************************************/
number_of_faces = 10;


cylinder_height = 70;
cylinder_top_diameter = 50;
cylinder_bottom_diameter = 40;

pen_chamber_depth = 0.9*cylinder_height;
pen_chamber_top_diameter = 0.9*cylinder_top_diameter;
pen_chamber_bottom_diameter = 0.9*cylinder_bottom_diameter;

bottop_feature_1 = cylinder_height/2-2;
bottom_feature_2 = cylinder_height/5;

$fn=number_of_faces;

difference() {
cylinder(h=cylinder_height, r1=cylinder_bottom_diameter/2, r2=cylinder_top_diameter/2, center = false);

translate([0, 0, cylinder_height-pen_chamber_depth+1])
cylinder(h=pen_chamber_depth, r1=pen_chamber_bottom_diameter/2, r2=pen_chamber_top_diameter/2, center = false);
    
//Create Torus for subtraction
  rotate_extrude(convexity = number_of_faces, $fn=50)
  translate([bottop_feature_1, 0, 0])
  circle(r = bottom_feature_2);
}

