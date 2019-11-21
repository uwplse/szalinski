Breite=112.0;
Tiefe=52.0;
Hoehe=45.0;
Dicke=3.4;
Rund=3.0;
BohrD=5.5;
ScheibeD=11;
$fn = 120;

module KabelZip() 
{
    difference() 
    {
        union()
        {
            rotate([90,0,0]) cylinder(h=15,d=13,center=true);
            cube([13,15,13],center=true);
        }
        translate([0,0,5])
        {
            rotate([90,0,0]) cylinder(h=16,d=9,center=true);
            translate([0,0,5]) cube([18,18,9],center=true);
            translate([0,-3,-3.5]) cube([20,4,2],center=true);
            translate([0,3,-3.5]) cube([20,4,2],center=true);
            translate([6,-3,-3]) rotate([0,-45,0]) cube([4,4,2],center=true);
            translate([6,3,-3]) rotate([0,-45,0]) cube([4,4,2],center=true);
            translate([-6,-3,-3]) rotate([0,45,0]) cube([4,4,2],center=true);
            translate([-6,3,-3]) rotate([0,45,0]) cube([4,4,2],center=true);
        }  
    }
}

module Netzkabel()
{
    difference()
    {
        union()
        {
            translate([Breite-20.0,0,0]) cube([20,Tiefe/2,30],false);  // Netzkabel
            translate([Breite-30.0,0,0]) cube([30,Tiefe/2,12],false); // Netzkabel
        }    
        union()
        {
            translate([Breite-21,Tiefe/4,15]) rotate([0,90,0]) cylinder(h=25,r1=6,r2=5.5,center=false); // Netzkabel
            translate([Breite-31,Tiefe/4,15]) rotate([0,90,0]) cylinder(h=11,r1=8,r2=8,center=false); // Netzkabel
            translate([Breite-25,Dicke-1,1]) rotate([0,0,0]) cylinder(h=Hoehe,d=2,center=false); // Netzkabel
            translate([Breite-25,Dicke+20,1]) rotate([0,0,0]) cylinder(h=Hoehe,d=2,center=false); // Netzkabel
            translate([Breite-50-0.8,Tiefe/4,0]) rotate([0,0,0]) cylinder(h=Hoehe,d=13,center=false); // Sicherung
            translate([Breite-23,Tiefe/4*3-4.8,0]) rotate([0,0,0]) cylinder(h=Hoehe,d=10,center=false); // Leitung
            translate([Breite-23-27,Tiefe/4*3-4.8,0]) rotate([0,0,0]) cylinder(h=Hoehe,d=10,center=false); // Leitung
       }
    }
    
}

module DoIt()
{
    translate([-Dicke,-Dicke,-Dicke])  
    difference()
    {
        union()
        {
            hull()
            {
                translate([Rund,Rund,Rund]) sphere(r=Rund);
                translate([Rund,Tiefe-Rund+Dicke*2,Rund]) sphere(r=Rund);
                translate([Breite-Rund+Dicke*2,Rund,Rund]) sphere(r=Rund);
                translate([Breite-Rund+Dicke*2,Tiefe-Rund+Dicke*2,Rund]) sphere(r=Rund);
                
                translate([Rund,Rund,Hoehe+Dicke-Rund]) sphere(r=Rund);
                translate([Rund,Tiefe-Rund+Dicke*2,Hoehe+Dicke-Rund]) sphere(r=Rund);
                translate([Breite-Rund+Dicke*2,Rund,Hoehe+Dicke-Rund]) sphere(r=Rund);
                translate([Breite-Rund+Dicke*2,Tiefe-Rund+Dicke*2,Hoehe+Dicke-Rund]) sphere(r=Rund);
            }
            difference()
            {
                union()
                {
                   translate([Dicke+30,Tiefe+Dicke*2-4,-20]) cube([Breite-50,+4,24],false);
                   translate([Dicke+30,Tiefe+Dicke*2-Rund*4-4,-Rund*4]) cube([Breite-50,Rund*4+4,24],false);
                 }
                union()
                {
                    translate([Dicke,Tiefe+Dicke*2-Rund*4-4,-Rund*4]) rotate([0,90,0]) cylinder(h=Breite,r=Rund*4,center=false);
                    translate([Dicke+40,Tiefe+Dicke*2,-Rund*4]) rotate([90,0,0]) cylinder(h=20,d=BohrD,center=true);                   
                    translate([Dicke+Breite-30,Tiefe+Dicke*2,-Rund*4]) rotate([90,0,0]) cylinder(h=20,d=BohrD,center=true);                   
                    translate([Dicke+40,Tiefe+Dicke*2-10-4,-Rund*4]) rotate([90,0,0]) cylinder(h=20,d=ScheibeD,center=true);               
                    translate([Dicke+Breite-30,Tiefe+Dicke*2-10-4,-Rund*4]) rotate([90,0,0]) cylinder(h=20,d=ScheibeD,center=true);                   
                }
            }
        }
        union()
        {
        translate([Dicke,Dicke,Dicke]) cube([Breite,Tiefe,Hoehe+Dicke],false);
        translate([Breite-21,Tiefe/4+Dicke,15+Dicke]) rotate([0,90,0]) cylinder(h=30,r1=6,r2=5.5,center=false);
        translate([Breite-50-0.8+Dicke,Tiefe/4+Dicke,0]) rotate([0,0,0]) cylinder(h=15,d=13,center=true); // Sicherung
        translate([20+Dicke,0,14+Dicke,]) cube([31.5,Dicke*3,22.5],true);   // Schalter 
        translate([Breite-23+Dicke,Tiefe/4*3+Dicke-4.8,0]) rotate([0,0,0]) cylinder(h=Hoehe,d=10,center=false); // Leitung
        translate([Breite-23+Dicke,Tiefe/4*3+Dicke-4.8,-2.5]) rotate([0,0,0]) cylinder(h=5,r1=8,r2=4,center=false); // Leitung
        translate([Breite-23-27+Dicke,Tiefe/4*3+Dicke-4.8,0]) rotate([0,0,0]) cylinder(h=Hoehe,d=10,center=false); // Leitung
        translate([Breite-23-27+Dicke,Tiefe/4*3+Dicke-4.8,-2.5]) rotate([0,0,0]) cylinder(h=5,r1=8,r2=4,center=false); // Leitung
       }
    }
    translate([40.0,Tiefe/2,0]) cube([Breite-40,2,30],false);    
    translate([40.0,Tiefe/2,0]) cube([2,Tiefe/4*2,30],false);    
    Netzkabel();
    translate([Breite-7,Tiefe/4*3-4.8,-7.9])  rotate([0,180,90]) KabelZip();           
    translate([Breite-45,0.2,-Dicke]) cube([1,Tiefe/2,Dicke],false); 
}

rotate([180,0,0]) DoIt();
//rotate([0,0,0]) DoIt();