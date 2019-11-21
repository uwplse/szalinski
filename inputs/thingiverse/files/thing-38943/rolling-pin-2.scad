// Rolling Pin Spacers
// all measurements are in mm

// Diameter of rolling pin in mm (best if slightly smaller than actual)
pin = 46;
pinr=pin/2;

// How thick you want the dough to be in mm
Dough = 5;

difference () {
   cylinder (h=7,r=pinr+Dough, $fn = 200);
   translate ([0,0,-2]) cylinder (h=14,r=pinr, $fn = 200);
   rotate([30,0,0]) translate ([0,0,-5]) cube([pinr+Dough+2,2,20]);;
}
