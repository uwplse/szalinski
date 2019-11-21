// distance between parallel rod centers
bar_distance = 60;
// parallel rods diameter
bar_diameter = 8;
// distance between belt loop 
belt_distance = 30;
// desired wall thickness
wall_thickness = 2; //[1:.25:5]
// extra height for base
base_height = 10;  //7:1:25]
// fixing bolt diameter
bolt_diameter = 3;
// horizontal distance between fixing holes in PCB (48.26 for RAMPS)
fixture_distance = 48.26;
// vertical distance between fixing holes in PCB (-1.27 and 6.35 for RAMPS top and bottom)
fixture_v_distance = 6.35;
//Dimensions taken from https://www.google.com/search?client=firefox-b-ab&biw=1440&bih=763&tbm=isch&sa=1&ei=0kxJW8HlIs62sAXto6XwAg&q=arduino+mega++mounting+dimensions&oq=arduino+mega++mounting+dimensions&gs_l=img.3...1280.2306.0.2470.8.8.0.0.0.0.122.666.6j2.8.0....0...1c.1.64.img..0.1.122...0i8i7i30k1.0.4l28b11gZ5o#imgrc=DRY_3DzLKY0mjM:

//Calculated for reuse
bar_radius = bar_diameter/2;
bolt_radius = bolt_diameter/2;
total_base_height = base_height + abs(fixture_v_distance);

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
    /*RAMPS fixture reinforcement*/
    translate([-bar_radius, 0, total_base_height/2])
    rotate([0,-90,0]){
      translate([fixture_v_distance/2, -fixture_distance/2, 0],  $fn=10)
        cylinder(bar_radius+2*wall_thickness, bolt_radius+wall_thickness, bolt_radius+wall_thickness, $fn=10);
      translate([-fixture_v_distance/2, fixture_distance/2, 0], $fn=10)
        cylinder(bar_radius+2*wall_thickness, bolt_radius+wall_thickness, bolt_radius+wall_thickness, $fn=10);
     }
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

  /*RAMPS fixture*/
  translate([0, 0, total_base_height/2])
  rotate([0,-90,0]){
    translate([fixture_v_distance/2, -fixture_distance/2, 0],  $fn=10)
      cylinder(2*(bar_radius+wall_thickness), bolt_radius, bolt_radius);
    translate([-fixture_v_distance/2, fixture_distance/2, 0], $fn=10)
      cylinder(2*(bar_radius+wall_thickness), bolt_radius, bolt_radius);
   }
}
