//Onion farm

db = 82;//bottle diameter

difference(){
translate([40,0,0]) cube ([50,100,15], center = true);

union(){
cylinder(r=db/2,h = 25,$fn = 50, center = true);
hull(){
translate([65,20,0])cylinder(r=30/2,h = 25,$fn=50, center = true);
translate([65,-20,0])cylinder(r=30/2,h = 25,$fn=50, center = true);}}
}