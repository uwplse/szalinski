//Diameter, at the widest, for a standard Pico Squeeze squonk bottle
bottle_diameter = 19.25;

//Length of the bottle cap
bottle_cap_length = 15;

bottle_length = 33.75 + bottle_cap_length;

//How many bottles?
bottle_count = 4; //[1:8]

//The space between each bottle
bottle_spacing = 0.8;

container = [
     bottle_spacing + (bottle_diameter+bottle_spacing)*bottle_count,
     bottle_diameter,
     bottle_length + (bottle_spacing*2)
];

container_rounding_radius = 2 * 1; // * 1 hides this from thingiverse's customizer

//Include rear juice level viewing window?
include_window = 1; //[1:true, 0:false]

module rounded_rectangle(size, radius) {
     x = size[0];
     y = size[1];
     z = size[2];

     linear_extrude(height = z, center = true) hull() {
          translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
               circle(r=radius);
          translate([(x/2)+(radius/2), (-y/2)+(radius/2), 0])
               circle(r=radius);
          translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
               circle(r=radius);
          translate([(x/2)+(radius/2), (y/2)-(radius/2), 0])
               circle(r=radius);
     }
}

translate([0,0,0]) {
    difference() {
      rounded_rectangle(container, container_rounding_radius, $fn=100);
      translate([
        -(container.x/2)+(container_rounding_radius/2)+(bottle_spacing+(bottle_diameter/2)),
        -(container_rounding_radius),
        0
      ]) {
          for (bottle = [0:(bottle_count-1)]) {
            translate_vector = [
              (bottle)*(bottle_diameter+bottle_spacing),
              0,
              (bottle_spacing*2)
            ];

            translate(translate_vector) {
              cylinder(
                h = bottle_length,
                d = bottle_diameter,
                $fn = 100,
                center = true
              );
            }

            if (include_window) {
              translate([translate_vector.x, +(bottle_diameter/2), translate_vector.z - (bottle_cap_length/2)])
                cube([(bottle_diameter/4), 10, bottle_length - bottle_cap_length], center = true);
            }
          }
      }
    }
}
