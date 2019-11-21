dn=0.4; //nozzle diameter

do=100; //outer diameter

nr=10; //number of rings

nw=2; //number of wall thickness

na=1; //number of annular spaces

hr=(do-dn*nr*(nw+na))/2; echo(hr);//height of rings

fn=20; //rendering fineness

//difference()
//{
    for(n=[0:2:nr-1])
    {
        f=1-2*dn*(nw+na)*n/do; echo(f); //scaling factor
        scale([f,f,1])
        {
            
            difference()
            {
                sphere(d=do,$fn=fn);
                sphere(d=do-2*dn*nw,$fn=fn);
                #translate([0,0,hr])
                cube([do+dn,do+dn,hr], center=true);
                #translate([0,0,-hr])
                cube([do+dn,do+dn,hr], center=true);
            };
            
        };
    
    };
    
//};