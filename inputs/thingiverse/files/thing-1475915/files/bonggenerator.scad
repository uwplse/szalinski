Diametre_exterieur=60;
Diametre_interieur=55;
Diametre_du_tube=10;
Inclinaison=37;//[0:90]
Vue=2;//[0,1,2]

if(Vue==0){
    Dessous();}
if(Vue==1){
    Milieu();
}
if(Vue==2){
    Dessous();
    translate([0,0,250])
    Milieu();
    color([1,1,1,0.25])
    scale([1,1,0.5])
    tuyau();

    translate([0,0,250])
    rotate([0,Inclinaison,0])
    color([1,1,1,0.25])
    scale([1,1,0.25])
    tuyau();

difference()
    {
    translate([0,0,250])
    rotate([0,-45+(Inclinaison/2),0])
    translate([0,0,Diametre_exterieur/2])
    cylinder(d=Diametre_du_tube,h=100,$fn=64,center=true);
    translate([0,0,250])
    rotate([0,-45+(Inclinaison/2),0])
    translate([0,0,Diametre_exterieur/2])
    cylinder(d=Diametre_du_tube-2,h=101,$fn=64,center=true);
    }
}

module Milieu()
{
    difference()
    {
        union()
        {
            sphere(d=Diametre_exterieur+5,$fn=64);
            rotate([0,Inclinaison,0])    
            cylinder(d=Diametre_exterieur+5,h=Diametre_exterieur+5,$fn=64);
            translate([0,0,-Diametre_exterieur])
            cylinder(d=Diametre_exterieur+5,h=Diametre_exterieur+5,$fn=64);
        }
        translate([0,0,-500-Diametre_exterieur])
        tuyau();
        rotate([0,Inclinaison,0])
        translate([0,0,Diametre_exterieur])
        tuyau();
        union()
        {
            sphere(d=Diametre_interieur-5,$fn=64);
            rotate([0,Inclinaison,0])    
            cylinder(d=Diametre_interieur-5,h=Diametre_exterieur+10,$fn=64);
            translate([0,0,-Diametre_exterieur])
            cylinder(d=Diametre_interieur-5,h=Diametre_exterieur+20,$fn=64);
        }
        rotate([0,-45+(Inclinaison/2),0])
        translate([0,0,Diametre_exterieur/2])
        cylinder(d=Diametre_du_tube,h=100,$fn=64,center=true);

    }
}

module Dessous()
{
    difference()
    {
    hull()
    {
        cylinder(d=Diametre_exterieur+20,h=10,$fn=64);
        cylinder(d=Diametre_exterieur+10,h=20,$fn=64);
    }
    translate([0,0,10])
    tuyau();
}

}

module tuyau()
{
    linear_extrude(height=500,convexity=64)
    difference()
    {
        circle(d=Diametre_exterieur,$fn=64);
        circle(d=Diametre_interieur,$fn=64);
    }    
}