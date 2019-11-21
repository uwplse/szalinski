//(mm)
drawer_length = 100;
//(mm)
drawer_width = 60;
//(mm)
drawer_depth = 10;
//(mm)
material_width = 3;

number_of_horizontal_compartments = 4;
number_of_vertical_compartments = 5;

//translate([0,drawer_width/2-material_width/2,0]) cube([drawer_length, material_width, drawer_depth]);

cube([drawer_length-material_width, material_width, drawer_depth]);
translate([0,drawer_width-material_width, 0]) cube([drawer_length, material_width, drawer_depth]);
cube([material_width, drawer_width, drawer_depth]);
translate([drawer_length-material_width, 0, 0]) cube([material_width, drawer_width, drawer_depth]);


//translate([material_width*3+29.3*2,5,0]) cube([29.3,material_width, drawer_depth*1.1]);

module horizontal_lineup(num, space) {
   for (i = [0 : num-1])
     translate([space+space*i, 0, 0 ]) children();
     }

 color("red") {horizontal_lineup(number_of_horizontal_compartments-1, (drawer_length-material_width)/number_of_horizontal_compartments){ cube([material_width,drawer_width,drawer_depth]);}}

module vertical_lineup(num, space) {
   for (i = [0 : num-1])
     translate([0, space+space*i, 0 ]) children();
     }

 color("red") {vertical_lineup(number_of_vertical_compartments-1, (drawer_width-material_width)/number_of_vertical_compartments){ cube([drawer_length,material_width,drawer_depth]);}}

//echo("compartment width =", len(horizontal_lineup));

module compartment(){
    
    }
    
    /* Helpful documentation https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/User-Defined_Functions_and_Modules#Children
    */