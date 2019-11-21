// half or full oloid
form = "full";  // [half, full ]
// radius of one circle
radius=20;
// radius of hole - 0 for solid
hole_radius=8; 
// % slope of hole
hole_slope= 30; 
// offset ratio - 1 for true oloid, 1.414 (sqrt(2)for 2 circle roller
offset_ratio =  1.414;



module d(r) {
  cylinder(r1=r,r2=0,h=eps);
}

module disk(r){
  d(r);rotate([0,180,0]) d(r);
}

module hole(r,slope) {
   translate([0,0,-1]) cylinder(r1=r,r2=r+slope,h=100);
   rotate([0,180,0])
      translate([0,0,-1]) cylinder(r1=r,r2=r+slope,h=100);
};

module oloid(radius,offset_ratio,hole_radius,hole_slope){
  difference() {
     hull(){
      disk(radius);
      rotate([90,00,0]) translate([radius*offset_ratio,0,0]) 
         disk(radius);
     }
     hole(hole_radius,hole_slope);
     rotate([90,00,0]) translate([radius*offset_ratio,0,0])
        hole(hole_radius,hole_slope);
 }
}
module ground() {
   translate([0,0,-100]) cube([200,200,200], center=true);

}

module ruler(n) {
   for (i=[0:n-1]) 
       translate([(i-n/2 +0.5)* 10,0,0]) cube([9.8,5,2], center=true);
}

eps=0.1;
$fn=50;

if (form =="half") 
     difference() {
       oloid(radius,offset_ratio,hole_radius,hole_slope);
       ground();
    }
else   
     oloid(radius,offset_ratio,hole_radius,hole_slope);
 
 

*ruler(10);