
//Guard Section
//Inner Diameter
ID = 22.5; 
//Outer Diameter
OD = ID+27; 
//Height
H = 10; 

//Inner Diameter ring
EN = 1; // [1:enable, 0:disable]

//Spring Section
//Spring Angle
Angle = 0;
//Spring Count

Count = 3;

/*
Take these from slic3r's setting based on the same parameter name there and put them here.
Or you can totally punch in direct number on WD if you know the number especially from slic3r's recommendation.
*/
overlap_ratio = 0.25;
extrusion_width = 0.45;
WD = extrusion_width * 2 - extrusion_width * overlap_ratio; ; 
echo("wall_width: ",WD);


$fn = 64;

module InnerRing(){
difference(){
    color("green")cylinder(h = H, d = ID+(WD*2));
    color("maroon")cylinder(h = 12, d = ID);
    }
}

//translate([-(ID/2),0,0])rotate([0,0,Angle])cube([WD, OD*0.75, H]);

module OuterRing(){
    difference(){
color("green")cylinder(h = H, d = OD);
color("maroon",0.5)cylinder(h = 12, d = OD-(WD*2));
    }
}

module Spring(){
    intersection(){
        for(i=[0:Count]){
            rotate([0,0,i*360/Count])
        translate([-(ID/2+WD),0,0])rotate([0,0,Angle])cube([WD, OD*0.75, H]);
        }
        color("maroon",0.5)cylinder(h = 12, d = OD);
    }
}

union(){
    if(EN==1){
        InnerRing();
        Spring();
        OuterRing();
    }
    else
    {
        Spring();
        OuterRing();
    }
}