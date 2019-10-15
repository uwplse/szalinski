//made for swann ads440 pt wireless camera.
$fn=50;
//Length
L1 = 154;
//width
W1 = 110;

//height of back
H1 = 44;
//global thickness
T1 = 10;

//hole diameter
D1= 4;

//hole separation center at platform
HL1 = 80;
//hole separation center at back
HL2 = 83;
//hole location from the front
HL3 = 50;

difference(){
    
 union() {
translate([0,-(L1+W1/-2)/2,0])
cylinder(h = T1, d1 = W1, d2 = W1, center = true);
 
rotate([0,0,0])
translate([0,0,0])
cube([W1,L1-W1/2,T1], center=true);
rotate([0,0,0])
translate([0,+(L1+W1/-2)/2+T1/2,H1/2-T1/2])
cube([W1,T1,H1], center=true);   
 }  
    
    
union() {
translate([-HL1/2,-(L1-W1/2)/2-W1/2+HL3,0])
cylinder(h = T1*2, d1 = D1, d2 = D1, center = true);
translate([ HL1/2,-(L1-W1/2)/2-W1/2+HL3,0])
cylinder(h = T1*2, d1 = D1, d2 = D1, center = true);

rotate([90,0,0])
translate([-HL2/2,H1/2,-(L1+W1/-2)/2-T1/2])
cylinder(h = T1*2, d1 = D1, d2 = D1, center = true);
rotate([90,0,0])
translate([ HL2/2,H1/2,-(L1+W1/-2)/2-T1/2])
cylinder(h = T1*2, d1 = D1, d2 = D1, center = true);
}


 

}