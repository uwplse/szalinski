vyska = 8; // the latch height
sirka = 8; // the latch width
draha = 15; // the length of the latch
madlo_v = 15; // height of handrail

module telo()
{
    difference()
    {
        union()
        {
            translate([0,0,0]) cube([(60+draha),(sirka+26),3]);
            translate([0,10,0]) cube([(60+draha),(sirka+6),(vyska+5)]);
        }
        union()
        {
            translate([10,5,0]) cylinder(d1=3,d2=8,h=3);
            translate([(50+draha),5,0]) cylinder(d1=3,d2=8,h=3);
            translate([10,(sirka+21),0]) cylinder(d1=3,d2=8,h=3);
            translate([(50+draha),(sirka+21),0]) cylinder(d1=3,d2=8,h=3);
 
            translate([5,12,0]) cube([(draha+64),(sirka+2),(vyska+2)]);

            translate([15,13,0]) cube([(draha+20),(sirka+1),(vyska+6)]);

            translate([15,12,0]) cube([11,(sirka+2),(vyska+6)]);
            translate([(draha+25),12,0]) cube([11,(sirka+2),(vyska+6)]);
        }
    }
}

module zamek()
{
    difference()
    {
        union()
        {
            translate([(draha+62),0,0]) cube([(draha+2),(sirka+26),3]);
            translate([(draha+62),10,0]) cube([(draha+2),(sirka+6),(vyska+5)]);
        }
        union()
        {
            translate([(((draha+62)+((draha+2)/2))),5,0]) cylinder(d1=3,d2=8,h=3);
            translate([(((draha+62)+((draha+2)/2))),(sirka+21),0]) cylinder(d1=3,d2=8,h=3);
            translate([(draha+62),12,0]) cube([draha,(sirka+2),(vyska+2)]);
        }
    }
}

module jezdec()
{
     $a = 00;
     translate([6 + $a,13,0]) cube([(55+draha),sirka,vyska]);
     translate([16 + $a,13,vyska]) cube([9,sirka,madlo_v]);
}

telo();
zamek();
jezdec();
