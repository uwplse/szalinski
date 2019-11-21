
difference(){
union(){
translate([0,0,3]){

cube([10,10,6],center=true);}


translate([0,5,3]){
cylinder(h=6, r=5,$fn=150, center=true);}
    
   translate([0,-5,3]){
cylinder(h=6, r=5,$fn=150, center=true);} 
    
}
translate([0,-7.7,3]){
cylinder(h=6.3, r=1.5,$fn=150, center=true);}

translate([0,7.7,3]){

cylinder(h=6.3, r=1.5,$fn=150, center=true);}

translate([0,3.5,3]){

cube([6.5,3.6,6.1],center=true);}

translate([0,-3.5,3]){

cube([6.5,3.6,6.1],center=true);}
}