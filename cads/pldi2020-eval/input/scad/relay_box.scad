cover=true;
frameOnly=false;
l=50.8;
w=25.3;
h=19;
Rbh=4.5; //relay bottom desk height with pins of pins
t=1.2; //wall thickness
FBroom=8; //front/back room for cable

c=0.15; // clearance
lFull=l+2*FBroom; 
helpers=false;
2t=2*t;
2c=2*c;
2tc=2*(t+c);
tc=t+c;

if (!cover)
{
    frame();
    if (!frameOnly)
        walls();
}
else if (!frameOnly)
    cover();
    

if (helpers)
    relayBottom();

module walls()
{
    h=h+3*t;
    difference()
    {
        translate([0,0,h/2])

            cube([lFull+2tc,w+2tc,h],true);
        translate([0,0,h/2])
            cube([lFull+c,w+c,h],true);
        translate([0,0,3*t+Rbh])
            wallHoles();

    }
}

module cover()
{
    cube([lFull+2tc,w+2tc,t],true);
    difference(){
        translate([0,0,t])
            cube([lFull+c,w,4*t],true);
        translate([0,0,t])
            cube([lFull+2c-2t,2c+w-2t,4*t],true);
    }
}

module wallHoles()
{
    Hw=w/3;
    Hh=h/3;
    hx=h-Rbh;
    a=sin(45)*hx;
    translate ([0,0,Hh/2])
        cube([lFull+2tc,Hw,Hh],true);
    o=(lFull%a)/2;
    for (i=[0:floor(lFull/a)-1])
    {
        translate([(lFull+2tc)/2-a/2-t-i*a-o,0,(h+2t-a)/2])
            rotate([0,45,0])
            cube([t,w+2tc,hx],true);
    }
}
module frame()
{
    /*bottom plate*/
    difference()
    {
        fh=t+Rbh; // frame height
        translate([0,0,fh/2])
            cube([lFull+2tc,w+2tc,fh],true);
        translate([0,0,Rbh/2+t])
            cube([l+2c,w+2c,Rbh],true);
    }
}


module relayBottom()
{
    translate([0,0,Rbh/2])
        cube([l,w,Rbh],center=true);
}



