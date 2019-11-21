$fn=120;
ur=170; //pot upper rim diameter
lr=128; //pot lower rim diameter
hi=153; //pot outer height
th=3; //wall thickness
an=1; //annular distance between inner and outer pot
ma=0.01;//rendering margin

//adopting the ellipsoid function
function funcC(x,y,z,a,b)=sqrt((z*z)/(1-((x*x)/(a*a)+(y*y)/(b*b))));

//values for pot dimensions
xp=lr/2;
yp=0;
zp=hi;
ap=ur/2;
bp=ur/2;

cp=funcC(xp,yp,zp,ap,bp);

sp=cp/ap; //calculate scale
echo(xp,yp,zp,ap,bp,cp,sp);

//pot extremities
*color("red")
{
    cylinder(d=lr,h=1,center=false); //lower rim
    
    translate([0,0,zp-1])
    cylinder(d=2*ap,h=1,center=false); //upper rim
    
    cylinder(d=1,h=zp,center=false); //pot height
}
//pot ellipsoid
*color("green")
{
    difference()
    {
        translate([0,0,zp])
        scale([1,1,sp])
        sphere(d=2*ap,center=true); //pot ellips
        
        translate([0,0,zp])
        cylinder(h=cp+ma,d=2*ap+ma); //top cut-off
        
        translate([0,0,-cp+zp-ma])
        cylinder(h=cp-zp+ma,d=2*ap+ma); //bottom cut-off
    };
};

difference()
{
    //values for outer dimensions
    xo=xp+an+th;
    yo=0;
    zo=hi+an+th;
    ao=ap+an+th;
    bo=ap+an+th;

    co=cp+an+th; //add annular and thickness margin to height

    so=co/ao; //calculate scale
    echo(xo,yo,zo,ao,bo,co,so);

    //outer ellipsoid
    color("purple")
    {
        difference()
        {
            translate([0,0,zo-an-th])
            scale([1,1,so])
            sphere(d=2*ao,center=true); //outer ellips
            
            translate([0,0,zo-an-th])
            cylinder(h=co+ma,d=2*ao+ma); //top cut-off
            
            translate([0,0,-co+zo-ma-an-4*th/3])
            cylinder(h=co-zo+ma,d=2*ao+ma); //bottom cut-off
            
            zb=hi+an+4*th/3;
            xb=sqrt(pow(ao,2)*(1-(pow(zb,2)/pow(co,2))));
            echo(zb,xb);
            
            translate([0,0,-an-4*th/3])
            //rotate([90,0,0])
            //cylinder(h=2*xb+th,d=th,center=true);
            
            difference() //bottom Archimedean spiral
            {
                union()
                {
                    translate([0,th,0])
                    sphere(d=th,center=true);
                    
                    difference()
                    {
                        for(a=[th:2*th:xb])
                        rotate_extrude(convexity = 10)
                        translate([a, 0, 0])
                        circle(d = th);

                        translate([ma,-xb-th/2,-th/2-ma])
                        cube([xb,2*xb+th,th+2*ma]);
                    };

                    translate([0,th,0])
                    rotate([0,0,180])
                    difference()
                    {
                        for(a=[2*th:2*th:xb])
                        rotate_extrude(convexity = 10)
                        translate([a, 0, 0])
                        circle(d = th);

                        translate([ma,-xb-th/2,-th/2-ma])
                        cube([xb,2*xb+th,th+2*ma]);
                    };

                };
                
                rotate_extrude(convexity = 10)
                    translate([xb-th, -th/2, 0])
                    square(size = 3*th);
            };
            
        };
    };

    //values for inner dimensions
    xi=xp+an;
    yi=0;
    zi=hi+an;
    ai=ap+an;
    bi=ap+an;

    ci=cp+an; //add annular margin to height

    si=ci/ai; //calculate scale
    echo(xi,yi,zi,ai,bi,ci,si);

    //inner ellipsoid
    color("blue")
    {
        difference()
        {
            translate([0,0,zi-an])
            scale([1,1,si])
            sphere(d=2*ai,center=true); //inner ellips
            
            translate([0,0,zi-an])
            cylinder(h=ci+ma,d=2*ai+ma); //top cut-off
            
            translate([0,0,-ci+zi-ma-an])
            cylinder(h=ci-zi+ma,d=2*ai+ma); //bottom cut-off
        };
    };
};

