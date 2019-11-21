// Customizer Project

// Customizable Length Golf Tee

// Tee Length in mm
    tee_length = 50;
// Tee thickness divided by 2
        // Range 5 to 7 mm 
    tee_thick = 7;

//Resoultion
res=100;
 
module tee_cylinder(){
translate([0,0,tee_length/2])cylinder(tee_length, tee_thick, tee_thick, true, res);
}

module tee_tip() {
translate([0,0,-5]) cylinder(10,1,tee_thick, true, res);
}

module tee_top() {
    difference(){
    translate([0,0,tee_length+5]) cylinder(10,tee_thick,tee_thick+5,true,res);
    translate([0,0,tee_length+9]) cylinder(4,tee_thick,tee_thick+3.5,true,res);
    }
}

module full_tee() {
    union(){ 
        tee_cylinder();
        tee_tip();
        tee_top();
        } }
        
full_tee();