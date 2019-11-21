// distance between parallel rod centers
bar_distance = 60;
// parallel rods diameter
bar_diameter = 8;
// distance between belt loop 
belt_distance = 30;
// desired wall thickness
wall_thickness = 2.55; //[1:.25:5]
// extra height for base
base_height = 14;  //7:1:25]
// rod diameter
rod_diameter = 8;

//Calculated for reuse
bar_radius = bar_diameter/2;
rod_radius = rod_diameter/2;
total_base_height = base_height + rod_diameter;

difference(){
  union(){
    difference(){
      union(){
        hull(){
          translate([0, -bar_distance/2, 0])
            cylinder(total_base_height, bar_radius+wall_thickness, bar_radius+wall_thickness);
          translate([0, bar_distance/2, 0])
            cylinder(total_base_height, bar_radius+wall_thickness, bar_radius+wall_thickness);
        }
        /* Belt saver wall */
        translate([-(1.2*bar_radius+wall_thickness), 0, 0])
        hull(){
          translate([0, -belt_distance/2, 0])
            cylinder(total_base_height, bar_radius, bar_radius);
          translate([0, belt_distance/2, 0])
            cylinder(total_base_height, bar_radius, bar_radius);
        }
        /*Spool rod fixture reinforcement*/
        translate([-2.1*bar_radius-wall_thickness, 0, total_base_height/2])
          rotate([0,-90,0])cylinder(rod_radius+wall_thickness, rod_radius+2*wall_thickness, rod_radius+wall_thickness, $fn=32);
      }
      /* Openning */
      hull(){
        translate([0, -bar_distance/2, 0])
          cylinder(total_base_height, bar_radius, bar_radius);
        translate([0, bar_distance/2, 0])
          cylinder(total_base_height, bar_radius, bar_radius);
      }
      /*Front opennig*/
      translate([bar_radius, -bar_distance/2,0])
        cube([bar_diameter, bar_distance, total_base_height]);
  
      /* Belt saver */
      translate([-1.2*bar_radius, 0, 0])
      hull(){
        translate([0, -(belt_distance/2-wall_thickness), 0])
          cylinder(total_base_height, bar_radius, bar_radius);
        translate([0, belt_distance/2-wall_thickness, 0])
          cylinder(total_base_height, bar_radius, bar_radius);
      }
    }
    /*Spool rod fixture reinforcement 2*/
    translate([-.7*bar_radius, 0, total_base_height/2])
      rotate([0,-90,0])
        cylinder(rod_radius+wall_thickness, rod_radius+wall_thickness, rod_radius+2*wall_thickness, $fn=32);
  }
  /*Spool rod fixture*/
  translate([0, 0, total_base_height/2])
  rotate([0,-90,0]) 
    cylinder(3*(rod_radius+wall_thickness), rod_radius, rod_radius, $fn=27);
}
