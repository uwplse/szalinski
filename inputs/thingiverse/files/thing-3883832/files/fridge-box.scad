magnet_depth = 1.5;
magnet_radius = 4;
height = 50;
difference(){
    minkowski(){
      cube([62, 35, height]);
      sphere(r=2,$fn=50);
    }
    union(){
        translate([1, 1, 0])
        cube([60, 30, height+20]);
          
        translate([-2, 35, -2])
        cube([70,30,height+20]);

        translate([31, 35, height/2])   
        rotate([90, 0, 0])
        union(){
            translate([-24, -(height/3), 0])
            cylinder(magnet_depth, r=magnet_radius);
            translate([-24, 0, 0])
            cylinder(magnet_depth, r=magnet_radius);
            translate([-24, (height/3), 0])
            cylinder(magnet_depth, r=magnet_radius);
            translate([24, -(height/3), 0])
            cylinder(magnet_depth, r=magnet_radius);
            translate([24, 0, 0])
            cylinder(magnet_depth, r=magnet_radius);
            translate([24, (height/3), 0])
            cylinder(magnet_depth, r=magnet_radius);  
        }
    }
}
  
  
  