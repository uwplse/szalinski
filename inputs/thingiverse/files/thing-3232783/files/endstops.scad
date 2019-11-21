//piastra per endstops

/*
piastra esterna
esterno x=69,y=45,z=33
interno  x=59,y=40,z=33
*/



//primo endstop rosso

difference(){
union(){
    
    translate([33.25-14.5,-13,1.25])
    color([1,0,0])
    cube([3,35,43.5],center=true);
}
hull() {
translate([33.25-17,-4,17])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);
translate([33.25-17,-4,23])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);
}

hull() {
translate([33.25-17,-4-18.5,17])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);
translate([33.25-17,-4-18.5,23])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);
}
rotate([-55,0,0])
translate([19,-18,-26])
cube([4,14,12],center=true);
translate([19,-29.8,-14])
cube([4,14,23],center=true);
}



//secondo endstop blu

difference(){
union(){
    
    translate([33.25-17.5-3.5+2,-25.5,-10.5])
    color([0,-30,1])
    cube([3,60,20],center=true);
}
 hull() {
translate([9+2,-33-1+5,0])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);

translate([9+2,-33-1+5,-10])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);
}

hull() {
translate([9+2,-33-1+5-18.5,0])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);

translate([9+2,-33-1+5-18.5,-10])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);
}



}


//terzo endstop verde

difference(){
union(){
    
    translate([-33.25+17,-13,1.25])
    color([0,1,0])
    cube([3,35,43.5],center=true);
}
hull() {
   
    
translate([-33.25+15,-4,17])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);
translate([-33.25+15,-4,23])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);
}

hull() {
translate([-33.25+15,-4-18.5,17])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);
translate([-33.25+15,-4-18.5,23])
rotate([0,90,0])
cylinder(r=2,h=6,$fn=100);
}

}

difference() {
union() {
translate([1.25,-15.5,-19])
cube([37.98,40
,3],center=true);
}
hull() {
translate([5,-16,-22])
cylinder(r=2,h=6,$fn=100);
translate([5,-24,-22])
cylinder(r=2,h=6,$fn=100);
}  

hull() {
translate([-5,-16,-22])
cylinder(r=2,h=6,$fn=100);
translate([-5,-24,-22])
cylinder(r=2,h=6,$fn=100);
} 
}

translate([1.25,3,-10])
cube([37.98,3
,19],center=true);




