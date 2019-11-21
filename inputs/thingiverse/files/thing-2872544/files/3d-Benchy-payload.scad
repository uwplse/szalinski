//type of the payload
shape = "cube";//[cube,sphere,torus]
//quantity of the payloads
quantity = 2;
//distance between the payloads on the printbed
distance = 1;
/*[sphere]*/
// radius of your sphere in mm
radius = 1;
// sides of your sphere in mm
sides_of_sphere = 50;//[3:100]
/*[cube]*/
//width of your cube in mm
width = 1;
//height of your cube in mm
height = 1;
//length of your cube in mm
length2 = 1;
/*[torus]*/
// radius of your torus in mm
torus_radius = 3;
// radius of your torus  thickness in mm
torus_thickness_radius = 1;
// sides of the torus
torus_sides = 8;
// faces of the torus
torus_faces = 16;
/*[Hidden]*/
for (i = [1 : abs(1) : quantity]) {
  if (shape == "sphere") {
    translate([((i - 1) + (i - 1) * distance), 0, 0]){
      {
        $fn=sides_of_sphere;    //set sides to sides_of_sphere
        sphere(r=radius);
      }
    }
  } else if (shape == "torus") {
    translate([((i - 1) + (i - 1) * distance), 0, 0]){
      // torus
      rotate_extrude($fn=torus_sides) {
        translate([torus_radius, 0, 0]) {
          circle(r=torus_thickness_radius, $fn=torus_faces);
        }
      }
    }
  } else {
    translate([((i - 1) + (i - 1) * distance), 0, 0]){
      cube([width, length2, height], center=false);
    }
  }

}
