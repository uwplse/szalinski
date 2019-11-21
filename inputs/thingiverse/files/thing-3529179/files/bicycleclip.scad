//Created by Bryan Jackson
//Edit radius to match handle bars and seat. 
//Print two for handle bars, one for seat. 

radius = 16;
difference(){
    union(){
        cylinder(r=radius+3, h=20);
        translate([-40-radius/2,-4,0])
        cube([40,8,20]);
    }
        cylinder(r=radius, h=20);
        cube([radius+3,radius+3,20]);
        translate([-41-radius,-1.5,0])
        cube([38,3,20]);
    
        translate([-33-radius,-5.5,0])
        rotate([0,0,45])
            cube([8,8,20]);
}
translate([-26.4-radius,-.8,0])
rotate([0,0,45])
cube([3.3,3.3,20]);

translate([-18-radius,-.8,0])
rotate([0,0,45])
cube([3.3,3.3,20]);
