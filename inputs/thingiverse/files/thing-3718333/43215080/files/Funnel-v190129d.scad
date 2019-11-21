hc=60; // cone surpluss height
ac=50; // cone angle from x-axis / ccw
xc=hc/tan(ac); // cone width

dt=25; // tube outer diameter
lt=30; // tube length

hr=5; // rim height

tw=0.4; // wall thickness
xw=tw/sin(ac); // cone wall x-dir thickness

echo(str("Cone Diameter = ",dt+2*xc));
echo(str("Funnel Height = ",lt+hc+hr));

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
