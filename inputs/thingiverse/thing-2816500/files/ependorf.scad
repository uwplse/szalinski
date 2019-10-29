// Copyright 2018 Shusy
// This file is licensed Creative Commons Attribution-Non-Commercial 3.0.
// https://creativecommons.org/licenses/by-nc/3.0/

// You can get this file from https://www.thingiverse.com/thing:2816500

$fn=50*1;

//Number of tube along a axis
na=3;
//Number of tube along b axis
nb=5;
//Holder heigth
hh=28;
//wall thickness
wall=1.8;

skirt=0; // [0:No, 1:Yes]


main();

module main(){
difference(){
    base();
translate([0,0,1])
for(i=[0:na-1]){
    for(j=[0:nb-1]){translate([i*(11.5+wall)+wall/2,j*(11.5+wall)+wall/2,0])hole();
    }
}
}
}

module base(){
    hull(){
       cylinder(d=(11.5+wall),h=hh);
       translate([(11.5+wall)*(na-1)+wall,0,0])cylinder(d=(11.5+wall),h=hh); 
       translate([0,(11.5+wall)*(nb-1)+wall,0])cylinder(d=(11.5+wall),h=hh); 
       translate([(11.5+wall)*(na-1)+wall,(11.5+wall)*(nb-1)+wall,0])cylinder(d=(11.5+wall),h=hh); 
    }
    if(skirt){
     hull(){
       translate([0,0,0])cylinder(d=23,h=1.2);
       translate([(11.5+wall)*(na-1)+wall,0,0])cylinder(d=23,h=1.2); 
       translate([0,(11.5+wall)*(nb-1)+wall,0])cylinder(d=23,h=1.2); 
       translate([(11.5+wall)*(na-1)+wall,(11.5+wall)*(nb-1)+wall,0])cylinder(d=23,h=1.2); 
    }
        }
}

module hole(){
   // cylinder(d2=11.6,d1=4,h=1,$fn=10); 
   // translate([0,0,1])
    cylinder(d=11.6,h=hh);
}    