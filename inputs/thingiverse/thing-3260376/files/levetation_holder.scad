//
// Ultrasonic Levetator Stand
//

//Gap Between Holders
gap=15.875;   // default "15.875"


/* [Hidden] */

$fn=50;
in=25.4;

// Run stand module
rotate(100)stand();

module stand()
{
    Length=.5*in;
    Dia = .625*in + .03*in;
    //gap=.625*in;
    throat=1*in;
    wt=.25*in;
    t=.06*in;
    tab=.3*in;
    H_stand=.75*in;

    Dhole1=.15*in;
    Dhole2=.2*in;
    Dhole3=Dhole2;

    difference()
    {
        union()
        {
            half();
            mirror([0,1,0])half();
            
            translate([0,-gap/2-Length-H_stand,0])
            {
                cube([throat+wt,H_stand,t]);
                cube([throat+wt,t,Dia+t*2]);
                translate([throat,0,0])
                    cube([t,H_stand+gap+Length*2,Dia+t*2]);
            }
        }
        
        translate([throat,-gap/2-Length-H_stand/2,Dia/2])
            rotate([0,90,0])
                cylinder(d=Dhole3,h=1*in,center=true);
        translate([throat,gap/2+Length/2,Dia/2])
            rotate([0,90,0])
                cylinder(d=Dhole3,h=1*in,center=true);
        translate([throat*2/3,-gap/2-Length-H_stand,Dia*2/3])
            rotate([90,0,0])
                cylinder(d=Dhole2,h=1*in,center=true);
    }

    module half()
    {
        difference()
        {
            union()
            {        
            rotate([-90,0,0])
                translate([0,-Dia/2-t,0])
                {
                    difference()
                    {
                        union()
                        {
                            translate([0,-Dia/2-tab/2,gap/2+Length/2])
                                cube([5*t,tab,Length/2],center=true);
                            translate([0,0, gap/2])
                                cylinder(d=Dia+t*2,h=Length);
                        }
                        translate([0,0, gap/2-1])
                            cylinder(d=Dia,h=Length+2);
                        translate([0,-Dia/2-tab/2-t/2,gap/2+Length/2])
                            rotate([0,90,0])
                                cylinder(d=Dhole1,h=100,center=true);
                    }
                }
                
            }
            translate([0,0,Dia+tab/2]) cube([t,100,Dia],center=true);
            
        }
        translate([0, gap/2, 0]) cube([throat,Length,t]);
        translate([throat,0, 0]) cube([wt,gap/2+Length,.06*in]);

    }
}
    