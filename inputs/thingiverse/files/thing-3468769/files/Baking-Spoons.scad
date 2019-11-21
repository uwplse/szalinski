/* [Settings] */
// Volume of spoon (in ml). For reference: 1tsp = 5ml, 1tbsp = 15ml, 1 cup = 250ml
volume = 15;
// Thickness of the spoon walls and handle (in mm)
thickness = 2;
// Length of the handle (in mm)
handle_length = 80;
// Width of the handle (in mm)
handle_width = 25;
// Diameter of the hole in the end of the handle (in mm)
hole_size = 10;
// Text to emboss on the handle
label = "1 tbsp (15ml)";
// Depth of embossed label
label_depth = 0.5;
/* [Options] */
// Size of label text (55 should work well)
label_size = 55;
// Add a rib on the back for added strength on large measures
enable_rib = 0; // [0:No, 1:Yes]

enable_rib_bool = (enable_rib==1)?true:false;

sphereVolume = volume * 1000 * 2;

radius = pow(((sphereVolume * 3) / (4 * PI)), (1/3));

rotate([180,0,0]) {
difference() {
  difference() {
    union() {
      sphere(radius + thickness, $fn=50); //outer sphere
      translate([0,-(handle_width/2),0]) //handle
        cube([handle_length, handle_width, thickness]); 
      translate([(handle_length),0,0]) //rounded end on handle
        cylinder(r=(handle_width/2), h=thickness);
      if (enable_rib_bool) rotate([0,30,0]) { //support rib
        cube([tan(60)*(radius + thickness), thickness, radius + thickness]);
      };
    };
    translate([0,0,-(4*((radius + (thickness*2))/2))]) //remove half of the sphere
      cube(4*(radius + (thickness*2)), true);
  };
  sphere(radius, $fn=50); //inner sphere (actual volume required)
  translate([handle_length,0,-thickness/2]) //hanger hole
    cylinder(r=hole_size/2, h=thickness*2);
  linear_extrude(label_depth*2) //text in handle
    translate([radius+(handle_width/3),0,-label_depth])
    rotate([0,180,180]) {
      text(label, size=10*(label_size/100), valign="center");
    };
};
};