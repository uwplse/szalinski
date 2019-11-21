/*
    Parametric Fan cover
    
    Carles Oriol March 22, 2015
    
*/

/* [Global] */

// Fan cover size (always square)
fancoversize=4;
// Fan cover height
fancoverheight=.2;

// Screws inside offset from corners
screwpos=.35;

// Size of screw hole
screwsize=.3;

// Size of screw head
screwcoversize=.55;

// Number of concentric circles
circles = 4;
// Number of radial supports
nradis=3;
// 0-1 Percent of empty space for air.
percair=.75;

// Inset fan
inh = .06;


// Resolution
$fn=128;



ncircles=circles+1;
conerdelta= fancoversize/2-screwpos;

stepsize=(fancoversize/2)/ncircles;
fillstepsize=stepsize*percair;
emptystepsize=stepsize*(1-percair);


difference()
{
union()
{
difference()
{
difference()
{
    hull ()
    {
        translate([conerdelta, conerdelta ,0]) cylinder( r= screwpos, h=fancoverheight );
        translate([-conerdelta, conerdelta,0]) cylinder( r= screwpos, h=fancoverheight );
        translate([conerdelta, -conerdelta ,0]) cylinder( r= screwpos, h=fancoverheight );
        translate([-conerdelta, -(fancoversize/2-screwpos) ,0]) cylinder( r= screwpos, h=fancoverheight );
    }
    
    translate([conerdelta, conerdelta , -fancoverheight/2]) cylinder(r=screwsize/2, h= fancoverheight*2 );
    translate([-conerdelta, conerdelta , -fancoverheight/2]) cylinder(r=screwsize/2, h= fancoverheight*2 );
    translate([-conerdelta, -conerdelta , -fancoverheight/2]) cylinder(r=screwsize/2, h= fancoverheight*2 );
    translate([conerdelta, -conerdelta , -fancoverheight/2]) cylinder(r=screwsize/2, h= fancoverheight*2 );
    
        translate([conerdelta, conerdelta , +fancoverheight/2]) cylinder(r=screwcoversize/2, h= fancoverheight*2 );
    translate([-conerdelta, conerdelta , +fancoverheight/2]) cylinder(r=screwcoversize/2, h= fancoverheight*2 );
    translate([-conerdelta, -conerdelta , +fancoverheight/2]) cylinder(r=screwcoversize/2, h= fancoverheight*2 );
    translate([conerdelta, -conerdelta , +fancoverheight/2]) cylinder(r=screwcoversize/2, h= fancoverheight*2 );
}

i=5;

translate([0,0,-fancoverheight/2])
for( i=[2:ncircles] )
difference()
{
cylinder( r =stepsize*i-emptystepsize/2,          fancoverheight*2);
translate([0,0,-.1]) cylinder( r =stepsize*(i-1)+emptystepsize/2,          fancoverheight*2+1);
}
}

for( i=[0:nradis] )
rotate([0,0,360/nradis*i]) translate( [-fancoversize/2,-emptystepsize/2,0]) cube([ fancoversize,emptystepsize,fancoverheight]);
}

if( inh != 0 )
    translate([0,0,-.01]) cylinder(h=inh, r=fancoversize/2-emptystepsize/2);

}




