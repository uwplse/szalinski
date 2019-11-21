// cable-end
// henry piller 2017 cc
// variable description
// cable-diameter
cablediameter=8;// [5,6,7,8]
/*[Hidden]*/
holediameter=cablediameter*1.33;
cable=cablediameter/2;
$fn=50;
hole=holediameter/2;
// begin
difference(){union(){
 cylinder(h=30,r1=hole,r2=hole,center=false);
 hull(){
  cylinder(h=2,r1=hole*2,r2=hole*2,center=false); 
     translate([hole*3,0,0])
     cylinder(h=2,r1=2.5,r2=2.5,center=false);
        translate([-hole*3,0,0])
     cylinder(h=2,r1=2.5,r2=2.5,center=false);
 } 
   cylinder(h=25,r1=hole*1.5,r2=hole,center=false);
 }
  union(){translate([0,0,6]){
      linear_extrude(height = 15, center = false, convexity = 10, twist = 4*360, $fn = 100)
translate([cable, 0, 0])
circle(r = hole);
     }
        translate([hole*3,0,0])
     cylinder(h=2,r1=1.5,r2=1.5,center=false);
        translate([-hole*3,0,0])
     cylinder(h=2,r1=1.5,r2=1.5,center=false);
     cylinder(h=40,r1=cable,r2=cable*1.2,center=false);
  }
  }