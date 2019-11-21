$fn=200;

roulep = 32;
margin=1;
siz1=37;
siz2=55;

module roul()
{
    difference(){
cylinder(10,roulep/2+margin/2,roulep/2+margin/2,center=1);
        for (i = [0,90,180,270]){

        translate([cos(i)*(roulep/2+margin/2),sin(i)*(roulep/2+margin/2),0]) 
            {
                rotate([0,0,i]) 
            {
            
    difference(){
                    cylinder(10,margin/2,margin/2,center=1);
            
        translate([-margin,-margin,10-margin])
        rotate([45,0,90])
        cube(10,10,10,center=1);
            
         translate([-margin,-margin,-margin-12])
        rotate([45,0,90])
        cube(10,10,10,center=1);
    }
}    
}
    }
}
}



difference()
{
union()
{
    cylinder(3,siz1/2,siz1/2);
 translate([0,0,3])    
    cylinder(1,siz1/2,siz1/2-0.5);
 translate([0,0,4])    
    cylinder(7,siz1/2-0.5,siz1/2-0.5);
 translate([0,0,11])    
    cylinder(1,siz1/2-0.5,siz1/2);
 translate([0,0,12])    
        cylinder(3,siz1/2,siz1/2);
 translate([0,0,15])    
        cylinder(3,siz1/2,siz2/2);
 translate([0,0,18])    
        cylinder(3,siz2/2,siz2/2);
 translate([0,0,21])    
        cylinder(1,siz2/2,siz2/2-0.5);
 translate([0,0,22])    
        cylinder(8,siz2/2-0.5,siz2/2-0.5);
 translate([0,0,30])    
        cylinder(1,siz2/2-0.5,siz2/2);
 translate([0,0,31])    
        cylinder(3,siz2/2,siz2/2);
    }


    
union()
{
translate([0,0,-.01])
roul();
translate([0,0,10-0.02])
cylinder(1.02,roulep/2+margin/2,roulep/2-0.5);
translate([0,0,10])
cylinder(14,roulep/2-0.5,roulep/2-0.5);
translate([0,0,23])
cylinder(1.04,roulep/2-0.5,roulep/2+margin/2);
translate([0,0,24.01])
roul();
}
}