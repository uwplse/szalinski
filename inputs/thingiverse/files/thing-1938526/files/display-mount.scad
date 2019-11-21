

w = 3;
d = 4;

dw = 40;

hh = 30;

difference(){
union(){    
cube([dw,35,w]);//Front panel

translate([0,35,3])
rotate([135,0,0])
translate([0,-40,0])
{
cube([dw,40,w]);//top
    
cube([dw,w,hh]);
translate([0,w+6.2,0])
cube([dw,w,hh]);
}    
}

translate([dw/2-7.5-d/2,10,-.1])
cube([d,40,w+1]);
    
translate([dw/2+7.5-d/2,10,-.1])
cube([d,40,w+1]);    

translate([dw/2-7.5,25,0])
rotate([-90,0,0])
cylinder(30,2,9);

translate([dw/2+7.5,25,0])
rotate([-90,0,0])
cylinder(30,2,9);
}



