//+------------------------------+
//|OPENSCAD double pipe clamp V2 |
//|      2016 gaziel@gmail.com   |
//|    beerware licence          |
//+------------------------------+  

//first pipe diametre
d1=16; 
//seconde pipe diametre
d2=106; 
//thinkness
ep=3; 
//hight
h=10; 
//if need support
pylone="no"; //[yes,no]
//need hole ?
hole="yes"; //[yes,no]
//hole diametre
dh=3;

$fn=50/2;

difference(){
    union(){
        //creaton des support de tuyaux
        clamp(min(d1,d2));
        translate([((d1+d2)/2)+ep,0,0])clamp(max(d1,d2));
        //creation du module d'accroce a plat
        if (pylone=="yes"){
            pylone(d1,d2);
            translate([(d1+d2)/4,-max(d1/2,d2/2)-ep/2,0])cube([((d1+d2)/2)+(2*ep),ep,h],center=true);
        }
    }       
    //creation des trous 
    if (hole=="yes"){
        rotate([90,0,0])cylinder(d=dh,h=max(d1,d2)*6,center=true);
        translate([((d1+d2)/2)+ep,0,0])rotate([90,0,0])cylinder(d=dh,h=max(d1,d2)*6,center=true);
    }
}

module pylone(dc1,dc2){
    hull(){    
        translate([0,-(min(dc1,dc2)/2)-(ep/2),0]) cube([h,ep,h], center=true);
        translate([0,-(max(dc1,dc2)/2)-ep/2,0]) cube([h+(2*ep),ep,h], center=true);
    }
}

module clamp(dc){
    difference(){
        cylinder(d=dc+ep*2,h=h,center=true);
        cylinder(d=dc,h=h,center=true);
        translate([0,(dc+ep)/2,0])rotate([0,0,45])cube([dc,dc,h],center=true);
    }
}
