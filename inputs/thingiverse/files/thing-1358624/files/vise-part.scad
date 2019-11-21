d = 31.5;
axis_d = 14;
wall = 3;

bd = 7.5;

bottom_z = -10-12.8-7.5;


z1  = bottom_z + 28-3;
z2 = z1+8;
smooth = 72;//360;


module cutout(){
    
//part to cutout
 union(){
sphere(d=d,$fn=smooth);
//hull(){
//cylinder(50, axis_d/2,axis_d/2);

//rotate([0,90,0])
//cylinder(50, axis_d/2,axis_d/2);
//}
cylinder(50, 20.7/2,20.7/2,$fn=smooth);

translate([0,0,-40])
cylinder(40,d/2,d/2,$fn=smooth);


translate([0,0,-10-12.8-1])
rotate([-90,0,0])
cylinder(50,bd/2,bd/2,$fn=smooth);

translate([0,0,-10-12.8-1])
rotate([-90,0,0])
translate([0,0,d/2+wall-1])
cylinder(3,bd/2,11/2,$fn=smooth);

translate([-11,-50,-30+z1])
cube([22,50,30]);

translate([-4,-4-28-1.5,-20])
cube([8,8,50]);

translate([-25,-25,-10+bottom_z])
cube([50,50,10]);
}    
    }

difference(){
    union(){
sphere(d=d+2*wall,$fn=smooth);
translate([0,0,bottom_z])
cylinder(10+12.8+7.5,d/2+wall,d/2+wall,$fn=smooth);
        
        
translate([0,0,-10-12.8-1])
rotate([-90,0,0])
cylinder(20,bd,bd,$fn=smooth);
        
hull(){
translate([-15,-40,z1])
cube([30,40,8]);

translate([-15,0,-30])
cube([30,1,8]);
}


    };
   
  cutout();
}







