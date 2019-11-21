rotate([-90,0,-180]) {
    union() {
    translate([0,0,0]) {
    difference() {
        cube ([50,17,45], center=false);
        translate([4,6,4])
        cube([42,15,45]);
      translate([9.75,11.5,0])
        cylinder(12,1.3,1.3,$fn=100,center=true);
         translate([40.25,11.5,0])
        cylinder(12,1.3,1.3,$fn=100,center=true);

    }
}
   translate([16.75,-18,17]){
difference() 
       {
           $fn=50;
minkowski()
{   cube([11.5,18,16], center=false);
     rotate([0,90,0])
    cylinder(5,5,5);}
    
    translate([0,5.5,7.5])
    rotate([0,90,0])
    cylinder(15,2.75,2.75,$fn=100, center=false);
        translate([13.5,5.5,7.5])
    rotate([0,90,0])
    cylinder(5,4.75,4.75,$fn=6, center=false);
       translate([5,-5,-10])
    cube([6.5,18,36], center=false);    
}
}
}
translate([36.5,13,3]){
         rotate(180,90,90)
     linear_extrude(height = 2.5, center = true, scale=1)
text("Taz_3d", size=5);
 }}