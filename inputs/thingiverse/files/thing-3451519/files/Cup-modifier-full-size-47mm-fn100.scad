$fn=100;
    cylinder(r=41.5, h= 20);

translate([0,0,20]) 
cylinder(r=52,h=1);
translate([0,0,21]) 
difference() {
    cylinder(r=52,h=5);
    cylinder(r=47,h=5);
}
