hj=82.2;      //jar height
dj=67.3;      //jar diameter
rj=7;         //jar edge radius

nd=0.4;       //nozzle diameter
fl=0.2;       //first layer height
lh=0.2;       //print layer height

tw=5;         //wall thickness
fn=0;         //finish finenss

jlr=0.25;     //jar-lid ratio of total height

d=(floor(dj/nd)+2)*nd; echo(d);
h=(floor((hj-fl)/lh)+2)*lh+fl; echo(h);

union()
{
    
    difference()
    {
        
        translate([0,0,rj+tw])
        minkowski()
        {
            cylinder(h=h-2*rj,d=d-2*rj,$fn=fn);
            sphere(r=rj+tw,$fn=fn);
        }; 

        translate([0,0,rj+tw])
        minkowski()
        {
            cylinder(h=h-2*rj,d=d-2*rj,$fn=fn);
            sphere(r=rj+tw/2+nd/2,$fn=fn);
        };
        
        translate([0,0,(1-jlr)*(h+2*tw)])
        cylinder(h=h,d=d+rj+2*tw);;
    };

    difference()
    {
        
        translate([0,0,rj+tw])
        minkowski()
        {
            cylinder(h=h-2*rj,d=d-2*rj,$fn=fn);
            sphere(r=rj+tw,$fn=fn);
        }; 

        translate([0,0,rj+tw])
        minkowski()
        {
            cylinder(h=h-2*rj,d=d-2*rj,$fn=fn);
            sphere(r=rj,$fn=fn);
        };
        
        translate([0,0,(1-0.5)*(h+2*tw)])
        cylinder(h=h,d=d+rj+2*tw);;
    };
};