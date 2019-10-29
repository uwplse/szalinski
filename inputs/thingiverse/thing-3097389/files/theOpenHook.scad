//------------------------------------------------------------------//
//--date:-09-12-2018------------------------------------------------//
//--by:---SEBANFICA-------------------------------------------------//
//------------------------------------------------------------------//

//-- Parameters
$fn=50;
diam=3.5; //Radius, fckit, i know, i know
heigth=100;

difference(){ //01
union(){ //Hook Crown
sphere(diam);
translate([0,0,-diam])
cylinder(r=diam, h=diam*2, center=true);
}

translate([diam/2,0,-(diam*2.5)])
rotate([0,-45,0])
cube(diam*3, center=true);
} //diff 01

hull(){
union(){ //Throat
difference(){
translate([0,0,-diam*2])
cylinder(r=diam, h=diam*4, center=true);

translate([-diam*1.5,0,-diam*2])
cube(diam*4, center=true);
}
}

translate([0,0,-(heigth/2)-diam*4])
cylinder(r=diam, h=heigth, center=true);
}

translate([0,0,-(heigth)-diam*4])
sphere(diam);
