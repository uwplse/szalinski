// Project boxes for electronic projects
// TODO: Snap fit connection between lid and box, HELPME
// -----------------------

// Outer width
external_width = 30; // [10:100]

// Outer length
external_length = 30; // [10:100]

// Outer height
external_height = 10; // [5:100]

// Shell thickness
shell_thickness = 1.2; // [0.8:Thin (0.8),1.2:Normal (1.2),1.6:Thick (1.6)]

// Corner radius
radius = 7; // [0:10]

// Cut out a circle to save material (for test prints)
cutout_circle = "yes"; // [yes,no]


height_without_lid = external_height-shell_thickness;

// Modules
// -----------------------

module cyl() {
    cylinder(height_without_lid, radius, radius, center = false, $fn=99);
};

module box() {
    hull() {
        translate([-(external_width/2-radius),-(external_length/2-radius),0])
        cyl();       
        translate([+(external_width/2-radius),-(external_length/2-radius),0])
        cyl();    
        translate([-(external_width/2-radius),+(external_length/2-radius),0])
        cyl();        
        translate([+(external_width/2-radius),+(external_length/2-radius),0])
        cyl();
    }
};

// The box itself
// -----------------------

translate([0,external_length+1,0]) // Move out of the way

difference() {

    // Construct the outer box
    box();

    // Cut out the inner box
    translate([0,0,shell_thickness])
    resize([external_width-2*shell_thickness,external_length-2*shell_thickness,height_without_lid])
    box();
    
    if(cutout_circle=="yes"){
        // Cut out a circle to save material during test prints
        cylinder(h=3*height_without_lid, r=((min(external_width,external_length)-4*shell_thickness)/2), center=true, $fn=99);
    }
}

// The lid
// -----------------------

difference() {
        
    // Base of the Lid
    resize([0,0,shell_thickness])
    box();
  
    if(cutout_circle=="yes"){    
        // Cut out a circle to save material during test prints
        cylinder(h=3*height_without_lid, r=((min(external_width,external_length)-4*shell_thickness)/2), center=true, $fn=99);
    }
}