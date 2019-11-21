// Layout
arm_width = 23;
arm_length = 35;

// Bearing specs
thickness = 7;
bearing_OD = 22;
bearing_tolerance = 0.1;

// Sizes
sizes = [ 8, 10, 12 ];
size_tolerance = 0.4;
first_hole_distance = 30;

// Ergonomics
arm_fillet_radius = 10;
side_thickness = 3;
chamfer_angle = 45;
corner_radius = 4;

// Refinement
layer_height = 0.2;
$fn = 64;

chamfer_offset = (thickness - side_thickness)/2*tan(chamfer_angle)*-1;
Ad = 3 * sizes[0] / 2 * tan(60) * first_hole_distance;
angle_between_arms=360/len(sizes)/2;
layers = (thickness - side_thickness)/2/layer_height;

difference() {
  // Do layers since hull doesnt work for these angles
  union() {
    for (i = [ 0 : 1 : layers-1 ]) {  
      translate([0, 0, side_thickness/2 + i*layer_height]) linear_extrude(layer_height) offset(chamfer_offset / layers * i) arms(len(sizes));
      translate([0, 0, side_thickness/-2 - (i+1)*layer_height]) linear_extrude(layer_height) offset(chamfer_offset / layers * i) arms(len(sizes));
    }
    translate([ 0, 0, side_thickness/-2 ]) linear_extrude(side_thickness) arms(len(sizes));
  }

  for (i = [ 0 : 1 : len(sizes) - 1 ]) {
    rotate([ 0, 0, i*360/len(sizes)]) {
      
      // Calculate how far the hole must be for equal torque
      d2 = i > 0 ? Ad / (3 * sizes[i] / 2 * tan(60)) : first_hole_distance;
      // Calculate radius of hexagon based on distance across flats
      r = sqrt( pow(sizes[i]/2, 2) + pow(sizes[i]/2/tan(60), 2) );
      echo(sizes[i], r*2, d2);
      
      translate([ 0, 0, thickness/-2]) {
        translate([ 0, d2 ]) {
          rotate([ 0, 0, 30 ])
          color("Red") cylinder(r=r + size_tolerance, h=thickness, $fn=6);
        }
        
        color("Red") cylinder(r=bearing_tolerance + bearing_OD/2, h=thickness);
      }
    }
    
  }
}



module arms(arms = 3) {
  for (i = [ 0 : 1 : arms - 1 ]) {
    rotate([ 0, 0, i*360/arms]) {
      arm();
      
      // Fillet between arms
      rotate([ 0, 0, angle_between_arms ]) {
        difference() {
          
          h = arm_fillet_radius/cos(90-angle_between_arms);
          l = sqrt( pow(h, 2) - pow(arm_fillet_radius, 2) );
          y = pow(l, 2) / h;
          x = arm_fillet_radius*l/h;
          translate([ 0, arm_width/2/sin(angle_between_arms) ]) 
          color("Blue") polygon([
            [0, 0],
            [-1*x, y],
            [x, y]
          ]);
                    
          translate([0, arm_width/2/sin(angle_between_arms) + arm_fillet_radius/cos(90-angle_between_arms) ])
          circle(r=arm_fillet_radius);
        }
      }
      
      
    }
  }
}

module arm(offset = 0) {
  offset(offset) {
    half_arm();
    mirror() half_arm();
  }
  
  if (offset < 0) {
    polygon([
      [ arm_width/-2 - offset, 0 ],
      [ arm_width/2 + offset, 0 ],
      [ arm_width/2 + offset, offset*-1 ],
      [ arm_width/-2 - offset, offset*-1]
    ]);
  }
  
}

module half_arm() {
  hull() {
    polygon(
      [
        [ 0, 0 ],
        [ arm_width/2, 0 ],
        [ arm_width/2, arm_length - tan(30)*corner_radius],
      ]
    );
    translate([ 0, arm_width/2 * tan(30) + arm_length - corner_radius/cos(30) ]) {
      difference() {
        circle(r=corner_radius);
        translate([ corner_radius/-2, 0]) square(size=[ corner_radius, corner_radius*2 ], center=true);
      }
    }
    translate([ arm_width/2 - corner_radius, arm_length - tan(30)*corner_radius ]) circle(r=corner_radius);
  }
}