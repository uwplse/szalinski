dn=0.4; //nozzle diameter

do=50; //outer diameter

nr=8; //number of rings

nw=2; //number of wall thickness

na=1; //number of annular spaces

hr=(do-dn*nr*(nw+na))/2; //height of rings

fn=30; //rendering fineness

difference()
{
    for(n=[0:nr-1])
    {
        difference()
        {
            sphere(d=do-dn*n*(nw+na),$fn=fn);
            sphere(d=do-dn*((n+1)*nw+n*na),$fn=fn);
            
        };
    };
    translate([0,0,hr])
    #cube([do+dn,do+dn,hr], center=true);
    translate([0,0,-hr])
    #cube([do+dn,do+dn,hr], center=true);
};