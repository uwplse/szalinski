//zacatek-0:08
//konec - 0:37
//variables

/* [Hidden] */
//fragment number
$fn = 100;

/* [Main] */
//thickness of desks in mm
thickness_of_desks = 4;
//diameter of handle 
diameter = 25; 
secure_filament_thickness = 4; //[3:5]

difference(){
union(){    
cylinder(h=5, d=diameter);  
translate([0,0,1.5])
cylinder(h=10, d=diameter+3);
translate([0,0,1.5])rotate_extrude()translate([diameter/2,0,0])circle(d=3);}
translate([0,0,3])rotate_extrude()translate([diameter/2+2.6,0,0])circle(d=3);}
difference(){
translate([diameter+4,0,0])cylinder(h=1, d=diameter+3);
translate([diameter+4,10,-1])
cylinder(h=thickness_of_desks+3, d=secure_filament_thickness);
translate([diameter+4,-10,-1])
cylinder(h=thickness_of_desks+3, d=secure_filament_thickness);
}
translate([0,10,10])
cylinder(h=thickness_of_desks+3, d=secure_filament_thickness);
translate([0,-10,10])
cylinder(h=thickness_of_desks+3, d=secure_filament_thickness);