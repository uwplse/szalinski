
outer_radius = 95;  
inner_radius = 51;
height       = 57;
segments     = 360;

//----------------------------------------------------
outer_diameter = 2 * outer_radius;
border         = outer_radius - inner_radius;

//----------------------------------------------------
color("red")
  translate([0, 0, 0])
    resize([outer_diameter, outer_diameter, height])  
      rotate_extrude( $fn = segments)
        translate([inner_radius, 0])    
          intersection() {
            circle(r=border, $fn = segments);
            square(border);
            };
//----------------------------------------------------
color("green")
  translate([0, 0, 0])
    rotate_extrude( $fn = segments)
      translate([0, 0])
        square (size = [inner_radius,2], center = false);


          