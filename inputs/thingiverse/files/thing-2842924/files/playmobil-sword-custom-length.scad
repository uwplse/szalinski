echo(version=version());
 
length = 40; 

difference()  {
color("grey")
rotate([90,90,0])
   cylinder(h=length, r=1.5,$fn=20);
get_square();
}
    
difference()  {
translate([-7.5, -9, 0]) 
rotate([90,90,90])
cylinder(h=15, r=1.5 ,$fn=20);
get_square();
}

difference()  {
rotate([90,90,0])
translate([0, 0, length])
 cylinder(h=4, r1=1.5, r2=0,$fn=20);
get_square();
}


module get_square () { 
translate([-10, -length-5, -2]) 
cube([20,length+5,1]);
}