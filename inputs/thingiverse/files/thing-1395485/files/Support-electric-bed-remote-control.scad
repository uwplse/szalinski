
difference(){
union(){    
translate([-12.5,0,0])    
    cube([25,40,2]);
translate([-12.5,0,0])  
    cube([25,4,35]);
translate([-12.5,0,35])
    difference() {
        cube([25, 35, 3]);
        translate([25,15,0])
            rotate([0,0,10])
                cube([25,25,3]);
        translate([-25,15,0])
            rotate([0,0,-10])
                cube([25,25,3]);
        }
translate([0,5,1])
    cylinder(h=35,r=5);       
translate([0,3.5,-6])
    cylinder(h=6,r=2);
        
translate([-7.5,22,-3])
    cylinder(h=3,r=1); 
translate([7.5,22,-3])
    cylinder(h=3,r=1);        
}
translate([0,4,1.5])
    cylinder(h=40,r=3.5);
translate([0,3.5,-8])
    cylinder(h=10,r=1.5);
}