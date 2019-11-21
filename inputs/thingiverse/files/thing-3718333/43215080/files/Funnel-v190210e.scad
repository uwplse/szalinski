hc=25.63435; // cone surpluss height
ac=60; // cone angle from x-axis / ccw
xc=hc/tan(ac); // cone width

dt=44.4; // tube outer diameter
lt=30; // tube length

hr=30; // rim height

tw=2; // wall thickness
xw=tw/sin(ac); // cone wall x-dir thickness

echo(str("Cone Diameter = ",dt+2*xc));
echo(str("Funnel Height = ",lt+hc+hr));
echo(str("Inside Tube Diameter = ",2*(dt/2-tw)));
echo(str("Inside Cone Diameter = ",2*(dt/2+xc-tw)));

rotate_extrude(angle = 360, convexity = 2, $fn = 360)
{
    polygon([
        [dt/2-tw   ,       0],
        [dt/2      ,       0],
        [dt/2      ,lt      ],
        [dt/2+xc   ,lt   +hc],
        [dt/2+xc   ,lt+hr+hc],
        [dt/2+xc-tw,lt+hr+hc],
        [dt/2+xc-tw,lt+xw-tw+hc],
        [dt/2-tw   ,lt+xw-tw]],
        paths=[[0,1,2,3,4,5,6,7]]);
};
