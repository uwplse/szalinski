// Radius of hole for screw/nail
pegholeraio=1.5; // [.5:.1:3]

// Number of tool holes
furos=5; // [3:9]

// Radius of hole for tool
toolraio=13; // [1:.2:20]

module placona() {
  intervalo=180/furos;
  inicio=intervalo/2;
  difference() {
    union() {
      minkowski() {
        cube([180,30,5]);
        cylinder(r=5,h=5);    
      }
      for (furo=[inicio:intervalo:180]) {
        translate([furo,10,-1]) cylinder(r=toolraio+5,h=11);
      }
    }
    translate([-5,35,-1]) cube([200,40,60]);
    translate([-10,-10,-20]) cube([200,60,20]);

    for (furo = [inicio:intervalo:180]) {

      translate([furo,10,-12]) union() {
        cylinder(r=toolraio,h=20,$fn=40);
        translate([0,0,19.99]) cylinder(r1=toolraio,r2=toolraio*2,h=10,$fn=40);
      }
    }
  }       
}

module abinha() {
  difference() {
    minkowski() {
      cube([12,3,20]);
      rotate([90,0,0]) cylinder(r=3,h=2,$fn=30);
    }
    translate([6,10,12]) rotate([90,0,0]) cylinder(r=pegholeraio,h=20,$fn=30); 
  }
}  

placona();  
translate([2,32,10]) abinha();
translate([52.91,32,10]) abinha();
translate([116.57,32,10]) abinha();
translate([167.5,32,10]) abinha();