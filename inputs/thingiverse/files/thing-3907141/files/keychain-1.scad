/* text */
name = "Name"; 
translate([0,-5,0])
linear_extrude(height = 5)
text(name);




difference() {
//cut this
    hull(){
        cylinder(h=2, d=16);
        translate([50,0,0])
        cylinder(h=2, d=16);
    }
//with this
    
    translate([50,0,0])
    cylinder(h=2, d=14);
    
}