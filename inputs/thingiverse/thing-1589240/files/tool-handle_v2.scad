
// customizable tool handle v2
// discostu http://www.thingiverse.com/discostu/about

// Hole number of sides (Triangle, Square, Hexagonal)
number_sides = 4; //[3:traingle,4:square,6:hex] 

// Tool adapter hole size (mm*100)
radius_hole = 350;

// top cylinder (mm*100)
top_center_radious = 600;

// bottom cylindre (mm*100)
bottom_centre_radious = 800; 

// x axis tool length (mm*10)
x_tool_length = 600;

// y axis tool length (mm*10)
y_tool_length = 50;

// Base and hole substraction
difference(){
    base();
    translate([0,0,10]) rotate([0,0,45]) cylinder(17,radius_hole/100,radius_hole/100, $fn=number_sides, center = true);
}

module base(){
    union(){
        //top center cylinder
        translate([0,0,10]) cylinder(10,top_center_radious/100,top_center_radious/100,$fn=60, center = true);
        //bottom center cylinder
        cylinder(10,bottom_centre_radious/100,bottom_centre_radious/100,$fn=60,center = true);
        
        //x lateral cylinders
        translate([x_tool_length/20,0,0]) cylinder(10,5,5, $fn=60,center = true);
        translate([-x_tool_length/20,0,0]) cylinder(10,5,5, $fn=60,center = true);
        //x tool body
        cube([x_tool_length/10,10,10],center = true);
        
        //y lateral cylinders
        translate([0,y_tool_length/20,0]) cylinder(10,5,5, $fn=60,center = true);
        translate([0,-y_tool_length/20,0]) cylinder(10,5,5, $fn=60,center = true);
        //x tool body
        cube([10,y_tool_length/10,10],center = true);
    }
}