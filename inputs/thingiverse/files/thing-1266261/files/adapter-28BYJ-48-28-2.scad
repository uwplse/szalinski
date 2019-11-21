/* 
***************************************************************************
    Adapter from motor 28BY-48 to motor 17HS
    Copyright (C) 2016 Andrey Kostin

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
     any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY.
    See the GNU General Public License for more details.

************************************************************************* 
*/

//height motor
ht = 34;//17HS42

//width motor
a = 42.3; //17HS42

//distance from hole to surface motor
kd =5.65;

$fn = 70;

difference(){   
    
translate(v=[0,0,-ht/2]){
cube([a,a,ht], center=true);
}
union(){        
    
//case 28BY-48
translate(v=[0,8,-(ht+1)]){
cylinder(h=ht+2,r=28.5/2,r2=28.5/2);
}
translate(v=[((a/2)-kd),((a/2)-kd),-(ht+1)]){
cylinder(h=ht+2,r=2.7/2,r2=2.7/2);
}
translate(v=[-((a/2)-kd),((a/2)-kd),-(ht+1)]){
cylinder(h=ht+2,r=2.7/2,r2=2.7/2);
}
translate(v=[((a/2)-kd),-((a/2)-kd),-(ht+1)]){
cylinder(h=ht+2,r=2.7/2,r2=2.7/2);
}
translate(v=[-((a/2)-kd),-((a/2)-kd),-(ht+1)]){
cylinder(h=ht+2,r=2.7/2,r2=2.7/2);
}
//mount 28BY-48
translate(v=[0,8,-1/2]){
cube([a+2,7.2,1.7], center=true);
}
//side box 28BY-48
translate(v=[0,((28.5/2)+8),-(ht/2)]){
cube([18,8,(ht+2)], center=true);
}
//the bolts 28BY-48
translate(v=[-35/2,8,-(ht+2)]){
cylinder(h=ht+4,r=1,r2=1);
}
translate(v=[35/2,8,-(ht+2)]){
cylinder(h=ht+4,r=1,r2=1);
}
translate(v=[0,0,-((ht/2)+10)]){
cube([(a-10),(a-10),ht], center=true);
}
//cylinder for smooth edges
difference(){   
translate(v=[0,0,-(ht+1)]){    
cylinder(h=ht+4,r=a+5,r2=a+5);
}
translate(v=[0,0,-(ht+2)]){
cylinder(h=ht+6,r=a/2+5,r2=a/2+5);}
}
}
}