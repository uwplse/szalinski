difference(){
union(){
difference(){
        union(){
        difference() {
        translate([120,195,0])  rotate([0,0,-20])  cube([32,62,8]);
        translate([0,0,1]) import("Anet_A8_Spoolholder_modified_a_remixed.stl");
        translate([-13.5,-20,1]) scale(1.1)import("Anet_A8_Spoolholder_modified_a_remixed.stl");
        translate([131,164,-1])  rotate([0,0,-13])  cube([30,90,10]);    
        }
            translate([140,240,0]) cylinder(r=45/2,h=8);
        }
        translate([140,243,-1]) cylinder(r=35/2,h=10);
}
difference(){
translate([141,244,0]) cylinder(r=40/2,h=5);
translate([142,244,-1]) cylinder(r=34/2,h=7);
}
}
        translate([105,248,-1]) cube([70,30,10]);        
}

