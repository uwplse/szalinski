//
// Straight cocktail stick with round, pointed stick
//
// The "ornament" is just a ring 
//
// by Egil Kvaleberg
//

//*****************************************************************************
// Adjustables

// length of stick
total_length = 100;

// length of cone section
cone_length = 5; 

// diameter of stick
stick_diameter = 3.2;

// size of ornament
ornament_size = 20;

// thickness of ornament
ornament_thickness = 2;

stick_fs = 1*0.1;
ornament_fs = 1*0.5;

//*****************************************************************************
// Derived

stick_radius = stick_diameter / 2;
stick_length = total_length - cone_length;

//*****************************************************************************
// View and printing

view(); 

//*****************************************************************************
// 

module cone()
{
    rotate([0, 90, 0]) cylinder(r1 = 0, r2 = stick_radius, h = cone_length, $fs = stick_fs);
}

module stick()
{
    translate([cone_length, 0, 0]) rotate([0, 90, 0]) cylinder(r = stick_radius, h = stick_length, $fs =stick_fs);
}

module ornament()
{
    difference() {
        cylinder(r = ornament_size/2, h = stick_diameter);
        translate([0, 0, -stick_diameter/2]) cylinder(r = ornament_size/2 - ornament_thickness, h = stick_diameter*2);
    }
}

module view()
{
     translate([-total_length/2, 0, stick_radius]) {
         cone();
         stick();
    }
    translate([total_length/2 + ornament_size/2 - 0.2, 0, 0]) {     
        ornament();
    }
}

//*****************************************************************************
