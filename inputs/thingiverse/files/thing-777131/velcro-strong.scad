/*

Printable velcro

16/04/2015 Carles Oriol

*/


/* [Global] */

// Pacman radius

width=25;
length=25;

/* [Hidden] */

suport_height=.3;
margin=2;


botomdiam=1.2;
topdiam=.3;
maxdiam=max(botomdiam, topdiam );
velcro_height=2;
extrax=maxdiam*2.3;
extray=maxdiam*2.3 ;

distancex=topdiam+extrax;
distancey=topdiam+extray;

cube([width, length, suport_height]);

for (comptay = [margin:distancey:length-margin])
{
    step = (round((comptay-margin)/distancey) % 2)== 0 ? 0: distancex/2;
    
    for (comptax = [margin:distancex:(width-margin)])
    {
        translate([comptax+step, comptay, suport_height]) cylinder(r1=botomdiam, r2=topdiam, h=velcro_height, $fn=6);
        translate([comptax+step, comptay, suport_height+velcro_height-(topdiam*3)/2]) scale([1,1,.5]) sphere(r=topdiam*3.5, $fn=12);
    }

 }