// === V4: Removed all nut inserts in the inner holder/support, made screw holes smaller and not thru. This is so you can tap screws directly into mount without any nuts.
// --- V5: Outer bracket mounting holes need to be 48 mm apart (not 45)
// --- V6: Longer external bracket (10mm towards back) to fit tube. Added elongated mounted screw hole
tube_d=80;
//tube_d=55;
tube_r=tube_d/2;
// ==========================================================================================================
// ---- Tube hanger (inner support) ---
// ==========================================================================================================
module hanger(){ 
difference(){
union(){
    
rotate([0,0,-45+180]){
difference(){ // Center tube holder
cylinder(r=tube_r+1.5+10,h=25,$fn=50,center=true); // OD

//translate([0,25,0])  cube([80,70,25],center=true); // Cut more than half of holder
  translate([0,35,-0.01])  cube([120,60,25.2],center=true); // Cut half of holder

cylinder(r=tube_r+1.5,h=25.1,$fn=50,center=true); // ID
}
}

translate([tube_r+10,0,0])  cube([7.5,30,25],center=true); // Back square protrusion
translate([0,tube_r+9.5,0])  cube([30,7.5,25],center=true);// Top square protrusion
}
translate ([tube_r+11,0,0]) rotate([0,90,0]) cylinder(r=2.3,h=10,$fn=15,center=true); // Back screw hole
translate ([0,tube_r+9.5,0]) rotate([90,0,0]) cylinder(r=2.3,h=10,$fn=15,center=true);// Top screw hole


// Top opening for zip-ties
rotate([0,0,45-5]) translate([0,tube_r+6.5-1,6])   cube([100,2,6],center=true);
rotate([0,0,-90-45+5]) translate([0,tube_r+6.5-1,6])   cube([100,2,6],center=true);
// Bottom opening for zip-ties
rotate([0,0,45-5]) translate([0,tube_r+6.5-1,-6])   cube([100,2,6],center=true);
rotate([0,0,-90-45+5]) translate([0,tube_r+6.5-1,-6])   cube([100,2,6],center=true);



// Nut holes
//translate([28.8,0,0]) rotate([30,0,0]) rotate([0,90,0]) cylinder(r=5.65,h=8,$fn=6,center=true); // Inner
//translate([40,0,0]) rotate([30,0,0]) rotate([0,90,0]) cylinder(r=5.65,h=3,$fn=6,center=true); // Outer
//translate([0,28.8,0]) rotate([90,0,0]) cylinder(r=5.65,h=8,$fn=6,center=true); // Inner
//translate([0,40,0]) rotate([90,0,0]) cylinder(r=5.65,h=3,$fn=6,center=true); // Outer

}

}


// ==========================================================================================================
// ---- External Bracket ---
// ==========================================================================================================
module ex_bracket () {
  difference(){ 
    union(){
        translate([38.5+tube_r,6.75,0]) cube([15,tube_d+58.5,25],center=true); // Back end
        translate([15,-15-tube_r,0]) cube([tube_d+45,15,25],center=true); // Bottom
        translate([17.5,tube_r+28.5,0]) cube([34+tube_d,15,25],center=true); // Top
        translate([28.5+tube_r,17.5+tube_r,0]) rotate([0,0,45]) cube([15,25,25],center=true); // Upper inner corner cut
        translate([28.5+tube_r,-tube_r-7.5,0]) rotate([0,0,-45]) cube([15,25,25],center=true); // Lower inner corner cut
    }

    // ---------------------------------------------------------------------------------------------------------
    // --- Bracket Mounting Holes
    translate([-tube_r+3.5,0,0]) translate ([0,-50.5-tube_r,0]) rotate([90,0,0]) cylinder(r=2.6,h=100,$fn=15,center=true); //Mounting hole #1
    translate([-tube_r+3.5,0,0]) translate ([0,-tube_r-6.5,0]) rotate([90,0,0]) cylinder(r=5,h=10,center=true); //Head slot for mounting screw #1
    
    // --- Elongated Mounting hole #2
    translate([tube_r-6.5,0,0]) translate ([0,-tube_r-50.5,0]) rotate([90,0,0]) cylinder(r=2.6,h=100,$fn=15,center=true);//Mounting hole #2.1
    translate([tube_r+2.5,0,0]) translate ([0,-tube_r-50.5,0]) rotate([90,0,0]) cylinder(r=2.6,h=100,$fn=15,center=true);//Mounting hole #2.2
    translate([tube_r-6.5,0,0]) translate ([0,-tube_r-6.5,0]) rotate([90,0,0]) cylinder(r=5,h=10,center=true); //Head slot for mounting screw #2.1
    translate([tube_r-2,-tube_r-17.5,0]) cube([10,15,5.2],center=true); // Slot that joins two mounting hole #2 parts
    translate([tube_r+2.5,0,0]) translate ([0,-tube_r-6.5,0]) rotate([90,0,0]) cylinder(r=5,h=10,center=true); //Head slot for mounting screw #2.2
    translate([tube_r-2,-tube_r-8.5,0]) cube([11,6,9.8],center=true); // Slot that joins two mounting Head hole #2 parts 
    
    
    
    // ---------------------------------------------------------------------------------------------------------
    // --- Front Adjustment Screw Slots (moves tube up/down) ----
    translate([0,10,0]) rotate([0,90,0]) cylinder(r=2.5,h=200,$fn=15,center=true); // Screw slot end upper(back side)
    translate([0,-10,0]) rotate([0,90,0]) cylinder(r=2.5,h=200,$fn=15,center=true); // Screw slot end lower (back side)
    translate([38.5+tube_r,0,0]) cube([15.1,20,5],center=true); // --- Front adj opening (Square connection joining two holes)
    translate([38.5+tube_r,2.5,0]) cube([6.3,45,25.1],center=true);// Adjustment nut slot (front)
    
    // ---------------------------------------------------------------------------------------------------------
    // --- Upper Adjustment Screw Slots (moves tube Front/Back) ----
    translate([15,tube_r+2.5,0]) rotate([90,0,0]) cylinder(r=2.5,h=100,$fn=15,center=true); // Screw slot end back (upper side)
    translate([-5,tube_r+2.5,0]) rotate([90,0,0]) cylinder(r=2.5,h=100,$fn=15,center=true); // Screw slot end front(upper side)
    translate([5,tube_r+28.5,0]) cube([20,15.1,5],center=true); // Slot that joins two holes on upper part
    translate([5,tube_r+28.5,0]) cube([50,6.3,25.1],center=true); // Adjustment nut slot (upper)
    
    // ---------------------------------------------------------------------------------------------------------
    translate([tube_r+42.5,tube_r+32.5,0]) rotate([0,0,45]) cube([18,55,25.2],center=true); // Upper corner cut
    translate([44.5+tube_r,-tube_r-16.5,0]) rotate([0,0,-45]) cube([12,35,25.2],center=true); // Low corner cut
    translate([0,-tube_r-15.5,0])  cube([20,5,25.2],center=true); // Slot in lower part (just to lighten part)
  }
    //translate([0,-50,0]) cube([170,2,25],center=true);

    //UNCOMMENT TO SEE 8mm rod
    //translate([52,0,0]) rotate([0,90,0]) cylinder(r=4,h=50,$fn=15,center=true);
    //translate([0,52,0]) rotate([90,0,0]) cylinder(r=4,h=50,$fn=15,center=true);


    //translate([22,-59,0]) cube([90,15,8],center=true);
    //translate([82,8,0]) cube([15,117,8],center=true);
}

// --- Raise Both to Z=0
translate([0,0,12.5]){
    hanger();
    ex_bracket();
}
