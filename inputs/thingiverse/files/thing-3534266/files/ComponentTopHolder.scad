// NOTE - spring design could be better...


//CUSTOMIZER VARIABLES

/* [Basic_Parameters] */

// First rod diameter, in mm
rod_diameter = 8.0;  // [2.0:0.1:40]

// Holder length, in mm
holder_length = 30; // [1:1:100];

// Contact Style
contact_style = 0;   // [0:Hemisphere, 1:SpringPlate, 2:Point, 3:Cylinder]

// Contact length, in mm
contact_length = 5; // [1:40]

// Spring thickness, in mm
spring_thickness = 1;   // [0.5:0.1:4.0]

// Bolt diameter, in mm
bolt_diameter = 3.0;    // [2:0.1:20]

// Nut diameter, in mm
nut_diameter = 6.0;  // [3:0.1:40]

// Nut thickness, in mm
nut_thickness = 2.8;  // [1.0:0.1:30]


/* [Extra_Features_for_Strength] */

// Margin to support the rods, in mm
rod_margin = 5; // [2:30]

// Nut clamp width margin, in mm
nut_clamp_margin = 4;   // [2:30]

//CUSTOMIZER VARIABLES END


// Sanity checks
if( rod_diameter <= 0
    || bolt_diameter <= 0 || nut_diameter <= 0 || nut_thickness <= 0)
{
    echo("<B>Error: Missing important parameters</B>");
}

if(nut_diameter <= bolt_diameter)
{
    echo("<B>Error: Nut size too small for bolt</B>");
}

// how much extra space to allow in nut trap, not user settable
nut_space_factor = 1.20;

nut_trap_len = nut_thickness*nut_space_factor;

bolt_rad = (bolt_diameter+0.7)/2;  // this should be almost loose
rod_rad = (rod_diameter+0.5)/2;  // should be sorta tight

z_rod_diameter = (rod_rad*2);
z_nut_size = 0;

// x length
main_width = max( 10, (rod_rad*2) + max( rod_margin/2, holder_length ) + nut_trap_len + nut_clamp_margin );
// z length
main_depth= max( 10, max(z_rod_diameter+rod_margin,z_nut_size), (bolt_rad*2)+nut_clamp_margin, contact_length*2 );
// y length
main_height = max( 10, nut_diameter + nut_clamp_margin, (bolt_rad*2)+nut_clamp_margin );




rotationZero = [0,0,0];
rotation90 = [90,0,0];
final_rotation = (contact_style == 1) ? rotationZero: rotation90;

translationZ = [0,0,main_depth/2];
translationY = [0,0,main_height/2];
final_translation = (contact_style == 1) ? translationZ: translationY;

// our object, translated to be flat on xy plane for easy STL generation
translate(final_translation) rotate(final_rotation)
    component_holder();


module hexagon(height,radius) 
{
  linear_extrude(height)
    circle(radius,$fn=6);
}

module nuttrap(){
  trap_depth = max( main_depth, main_height );
  translate([0,-nut_trap_len/2,trap_depth/2])
    cube([nut_diameter,nut_trap_len,trap_depth],center=true);
  rotate([90,360/12,0]) // so point is down, nut trapped by straight sides
    hexagon(nut_trap_len,(nut_diameter+1)/2);
}


module component_holder() {

    rod_x = 0;
    
    nut_x = rod_x + rod_rad + (nut_clamp_margin/2);
    nut_y = 0;

    rod_length = max(main_height,main_depth) + 20;

    difference() {

       union() {
          // the main block
          testx = -main_width/2 + rod_rad + nut_trap_len + nut_clamp_margin;
          translate([testx,0,0])
            cube([main_width,main_height,main_depth],center = true);
          
          if (contact_style == 1) {
             // spring plate: best in ABS or PETG, maybe SLA Flexible/Firm?
             plate_len = main_width - (rod_rad*2 + rod_margin/2 + nut_trap_len + nut_clamp_margin);
             
             platex = -main_width + (rod_rad + nut_trap_len + nut_clamp_margin) + plate_len/2;
             translate([platex,main_height/2 + contact_length + spring_thickness/2,0])
               cube([plate_len,spring_thickness,main_depth],center = true);
            
             spring_len = contact_length * 1.4142 + spring_thickness + 0.2;
             spring_offset = plate_len / 4;
             springy = main_height/2 + contact_length/2;
             translate([platex-spring_offset,springy,0])
               rotate([0,0,-45])
                 cube([spring_len,spring_thickness,main_depth],center = true);
             translate([platex+spring_offset,springy,0])
               rotate([0,0,-45])
                 cube([spring_len,spring_thickness,main_depth],center = true);
          } else {
            pointx = -main_width + (rod_rad + nut_trap_len + nut_clamp_margin) + contact_length;
            translate([pointx,main_height/2,0]) {
                if (contact_style == 0) {
                    difference() {
                        sphere(contact_length, $fn=32);
                        translate([0,-(main_height/2)-(contact_length+2)/2,0])
                          cube([main_width,contact_length+2,main_depth+2],center = true);
                    }
                } else if (contact_style == 2) {
                    rotate([-90,0,0])
                    cylinder(contact_length,contact_length,0,$fn=32);
                } else if (contact_style == 3) {
                    rotate([-90,0,0])
                    cylinder(contact_length,contact_length,contact_length,$fn=32);
                }
             }
          }
       
       }    // end union


      // rod clamp nut and bolt hole
      translate([nut_x,nut_y,0])
        rotate([0,0,90])
          nuttrap();
      translate([rod_x,nut_y,0])
        rotate([0,90,0])
          cylinder(main_width,bolt_rad,bolt_rad,$fn=32);

      // the rod
    #color("green")
      translate([rod_x,0,0])
        rotate([90,0,0])
          cylinder(rod_length,rod_rad,rod_rad,center=true,$fn=32);

    }
}


