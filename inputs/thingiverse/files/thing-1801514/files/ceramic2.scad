// Customizable Twisted Polygon Vase

//use <MCAD/regular_shapes.scad>;

// How high the cup should be?
cup_height = 60;

//The radius of the top part of the cup
top_radius = 25;
//The radius of the bottom part of the cup
bottom_radius = 20;
//Twist of the cup
top_rotation =  70; // [1:90]
//Number of Cup levels 
slice_layers =  5; // [1:20]
//Shape of the cup. Oxtagon? Squre? 
number_of_sides =  16; // [6:40]


initial = "BK";



//////RENDERS///////////////////////////////////////////////////////////////////////////////
top_scale = top_radius / bottom_radius;
inner_scale = (top_radius -0.7) / (bottom_radius -0.7);


//lips
translate([0,0,cup_height]){
    rotate([0,0,-top_rotation]) {
        rotate_extrude($fn=number_of_sides) {
            translate([top_radius-2,0,0]) {
                difference() {
                    circle(2, center = true, $fn=50);
                    translate([0, -2, 0]) {
                        square(4, center = true);
                    }
                }
            }
        }
    }
}

///BODY
difference() {
   linear_extrude(height = cup_height, twist  = top_rotation, slices = slice_layers, scale  = inner_scale) {
        reg_polygon(
           sides  = number_of_sides,
           radius = bottom_radius);
    }
    translate([0,0,5]){
        linear_extrude(height = cup_height, twist = top_rotation, slices = slice_layers, scale = inner_scale) {
            reg_polygon(
               sides  = number_of_sides,
               radius = bottom_radius-0.7);
        }   
    }
}

///CAP
translate([bottom_radius*3,0,5]) {
    rotate([0,0,-top_rotation]) {
    cap(top_radius, number_of_sides);
    }
}
  translate([bottom_radius*2+13,-3,10]) // to align with the face of the stl 
    linear_extrude(height=2, convexity=6) 
      text(initial, size = 8 , font = "Comic Sans MS"); 

//////MODULES///////////////////////////////////////////////////////////////////////////////

module triangle(radius)
{
  o=radius/2;		//equivalent to radius*sin(30)
  a=radius*sqrt(3)/2;	//equivalent to radius*cos(30)
  polygon(points=[[-a,-o],[0,radius],[a,-o]],paths=[[0,1,2]]);
}

module reg_polygon(sides,radius)
{
  function dia(r) = sqrt(pow(r*2,2)/2);  //sqrt(r*2^2/2) if only we had an exponention op
  if(sides<2) square([radius,0]);
  if(sides==3) triangle(radius);
  if(sides==4) square([dia(radius),dia(radius)],center=true);
  if(sides>4) circle(r=radius,$fn=sides);
}

module cap (topr, faces){
    rotate_extrude($fn = 100) {
        polygon(points = [ [0,0], [-topr-1.5, 0], [-topr-4.2,-4.6], [-topr-7.5, -4.6],  [-topr-3.1, 4], [-topr-0.6, 4], [-topr+1.5, 8.3], [-topr+10.3, 8.3], [-topr+11.5, 5.9], [0, 5.9]]);
    }
}

