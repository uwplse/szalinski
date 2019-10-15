dn=0.4; //nozzle diameter

do=100; //outer diameter

nr=16; //number of rings

nw=3; //number of wall thickness

na=1; //number of annular spaces

hr=(do-dn*nr*(nw+na))/2; echo(hr);//height of rings

fn=180; //rendering fineness

//difference()
//{
    for(n=[1:2:nr-1])
    {
        difference()
        {
            sphere(d=do-2*dn*n*(nw+na),$fn=fn);
            echo(do-2*dn*n*(nw+na));
            sphere(d=do-2*dn*((n+1)*nw+n*na),$fn=fn);
            translate([0,0,hr])
            cube([do+dn,do+dn,hr], center=true);
            translate([0,0,-hr])
            cube([do+dn,do+dn,hr], center=true);
        };
    };
    
//};