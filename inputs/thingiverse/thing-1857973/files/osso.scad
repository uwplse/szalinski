difference(){
cube([28,100,5],center=true);
     translate ([10,0,0]){cube([20,3,100], center=true);}
     cylinder(h=100, r=2.5, center=true, $fn=50);}
difference() {
            translate([0,0,13]){cylinder(h=22,r=7, center=true, $fn=50);} 
            translate([0,0,20])cylinder(h=8, r=5.5, center=true, $fn=50);
            cylinder(h=100, r=2.5, center=true, $fn=50);
            translate ([10,0,0]){cube([20,3,100], center=true);}
            translate([0,0,9]) cylinder(h=14,r=4.5, center=true, $fn=50);} 
           