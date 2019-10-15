//translate([0,40,0])
//import_stl("Bed_Bracket_45_1.0.stl");

// The size of the hole for the T-nut screw
screw = 5; // [3:M3, 4:M4, 5:M5]

// The length of the bed bracket
distance = 15; // [10:0.25:50]



/* [Hidden] */
$fn = 30;
screw_radius = screw / 2;

//Top mounting part
difference(){
    //Cube
    cube([14,20,5.5]);
    
    //Cut out hole
    translate([8 + screw_radius,10,0])
    cylinder(8, screw_radius, screw_radius, center=false);
    
    //Cut out slot
    translate([8 + screw_radius, 10 - screw_radius, 0]) {
        cube([6, screw_radius * 2, 6]);
    }
}



//Side mounting part

//-5 is it's thickness, 25.5 height
translate([-5,0,0])
difference() {
    cube([5,20, 25.5]);
    
    //Screw hole
    translate([0,10,15])
    rotate([00,90,0])
    cylinder(8, screw_radius, screw_radius, center=false);
}

//Bed screw hole
difference() {
    //A circle around the hole, extended to the middle part
    hull() {
        translate([-distance, 10, 0])
        cylinder(10, 4, 4);
            
        translate([-5,0,0])
        cube([5,20, 10]);
    }
    
    //Cut out the actual hole for the screw
    translate([-distance, 10, 0])
    cylinder(10,1.7,1.7);
}


//An complete mess of an angled support
//Copies the same circle, but extends it in the Z-axis to only have angled supports above the other parts
intersection() {
   union() {
        hull() {
            translate([-distance, 0, 6])
            cube([1, 5, 1]);
           
            translate([-5,0,24.5])
            cube([1,1,1]);
        
        
            translate([-5,4,24.5])
            cube([1,1,1]);
        
            translate([0,4,0])
            cube([1,1,1]);
        
        
            translate([0,0,0])
            cube([1,1,1]);
        }

        //Same as above, but on other side
        translate([0, 15, 0])
        hull() {
            translate([-distance, 0, 6])
            cube([1, 5, 1]);
            
            translate([-5,0,24.5])
            cube([1,1,1]);
                
                
            translate([-5,4,24.5])
            cube([1,1,1]);
                
            translate([0,4,0])
            cube([1,1,1]);
                
                
            translate([0,0,0])
            cube([1,1,1]);
        }
    }

    //The same circle but extended in the Z-axis to add the angled supports
    hull() {
    translate([-distance, 10, 0])
    cylinder(30, 4, 4);
        
    translate([-5,0,0])
    cube([5,20, 30]);
    }

}

