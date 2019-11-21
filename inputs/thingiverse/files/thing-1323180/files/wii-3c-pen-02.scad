$fn=46;
//aaa d=10; L=43;
height = 120;

batt_d = 11.5; // aaa diam
wall = 2.5;

board_thin=1.7;
board_height=20;
board_width=batt_d + wall;

knob_d = 5;
knob_offset = 20;
knob_depth = 3;//hole_d*2-5.1; //-1.5;  //12.5

diod_d = 5;

pit_scale = 2; //2.5;

twist = 120;

alfa = twist * (height - knob_offset)/height;
echo("alfa=", alfa);
color("SteelBlue")
difference() {
    union() {
        main_body();
        intersection(){
           cylinder(h=height, d=batt_d+wall, center=false);
           rotate([0, 0, 60 - alfa])
            translate([batt_d  + wall - knob_depth, 0, height - knob_offset])
              scale([1,pit_scale,pit_scale]) sphere(d = batt_d + wall);
        }
    }

    rotate([0, 0, 60 - alfa])
     translate([batt_d + wall - knob_depth, 0, height - knob_offset])
      scale([1,pit_scale,pit_scale]) sphere(d = batt_d);

    // knob hole
    translate([0, 0, height - knob_offset])
     rotate([0, 90, 60 - alfa])
      cylinder(h = batt_d + wall, d = knob_d, center = false);

    // board
    translate([0, 0, height/2-1])
     rotate([0, 0, 60 - alfa])
      cube(size = [board_thin, board_width, height], center = true);
    
}

// ==============================================

module main_body() {
    difference(){
        union(){
            linear_extrude(height=height, center = false, convexity = 10, twist = twist) {
                circle(d = (batt_d + wall)*1.25); // center tube
                for ( i = [0 : 120 : 360] )
                {
                    rotate( i , [0, 0, 1])
                     translate([(batt_d - wall)/2, 0, 0])
                      //scale([1.5,1,1])
                       circle(d = batt_d + wall);
                }
            }
            
            // top part
            rotate(-twist, [0,0,1])
            translate([0, 0, height]) {
                scale([1.2, 1.2, 1.8]) sphere(d = batt_d + wall);
                for ( i = [0 : 120 : 360] )
                {
                    rotate( i , [0, 0, 1])
                     translate([(batt_d - wall)/2, 0, 0])
                      sphere(d = batt_d + wall);
                }
            }

            // wings
            rotate(-60, [0,0,1])
            linear_extrude(height=height, center = false, convexity = 10, twist = twist, scale=-1) {
                for ( i = [0 : 120 : 360] )
                {
                    rotate( i , [0, 0, 1])
                     translate([(batt_d - wall)/2, 0, 0])
                      scale([1.3,0.3,1])
                       circle(d = (batt_d + wall)*1.3);
                }
            }

        } // union 
         
        
        // battery hole
        translate([0, 0, -0.1])
         cylinder(h=height, d=batt_d, center=false);
        translate([0, 0, height])
         sphere(d = batt_d);
    
        // diode hole
        translate([0, 0, height])
         cylinder(h=batt_d + wall, d=diod_d, center=false);
        // diode hole chamfer
        translate([0, 0, height + wall + batt_d/2])
         cylinder(h = wall * 2, d1 = diod_d, d2 = diod_d*2, center = false);
       
       // upper cone
       translate([0, 0, height - wall]) {
        difference(){
              cylinder(h = (batt_d + 2*wall-0.2), d = batt_d * 2 + wall, center = false);
              translate([0, 0, -0.1])
              cylinder(h = (batt_d + 2*wall), d1 = batt_d * 2, d2 = diod_d +0.3, center = false);
        }
       }
        
       
       
    } //difference
    

    
} // module main_body 
