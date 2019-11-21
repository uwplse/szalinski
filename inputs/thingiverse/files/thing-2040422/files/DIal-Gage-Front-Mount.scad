union() {
    translate([0,0,0]) {
    difference() {
        cube ([50,17,45], center=false);
        translate([4,6,4])
        cube([42,15,45]);
      translate([9.75,11.5,0])
        cylinder(12,2,2,$fn=100,center=true);
         translate([40.25,11.5,0])
        cylinder(12,2,2,$fn=100,center=true);

    }
}
   translate([20,-18,17]){
difference() 
       {
           $fn=50;
minkowski()
{   cube([5,18,16], center=false);
     rotate([0,90,0])
    cylinder(5,5,5);}
    
    translate([0,5.5,7.5])
    rotate([0,90,0])
    cylinder(8,2.65,2.65,$fn=100, center=false);
        translate([7,5.5,7.5])
    rotate([0,90,0])
    cylinder(5,4,4,$fn=6, center=false);
}
}
}
  