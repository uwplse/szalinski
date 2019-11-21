$fn=128;
overlap = 0.1;

module solid(){
union() {
    cylinder(h=6.1, d=50.6);
}
}

module remove(){
    union(){
            
        translate([0,0,3]) union(){
            hull(){
                cylinder(d=15, h=6);
                translate([12.5,0,0]) cylinder(d=6.1, h=6);
            }

            hull(){
                translate([12.5,0,0]) cylinder(d=6.1, h=6);
                translate([30,0,0]) cylinder(d=0.1, h=6);
            }
        }
        
        

     for (a =[0:2]) rotate([0,0,60+120*a]) color("red") translate([22.5,0,3]) cylinder(h=10, d=8.9, $fn=32);
    
    for (a =[0:2]) rotate([0,0,60+120*a]) color("red") translate([22.5,0,-overlap])  cylinder(h=10, d=3.8, $fn=32);
    }
    
    translate([0,0,-overlap]) cylinder(d=7, h=10);
}

difference(){
  solid();
  remove();
}





