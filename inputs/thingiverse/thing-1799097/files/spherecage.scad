diam=50;
diam2=2;
xx=8;
yy=8;
qual=6;
//SphereCage(diam=50,diam2=2,xx=8,yy=8,qual=6);
SphereCage();



module SphereCage()
{
    union()
    {
        for(j=[0:xx])
        {
            for(i=[0:yy])
            {
                hull()
                {
                    rotate([(360/(xx)*j),0,0])
                    rotate([0,0,(180/(yy)*i)])
                    translate([diam-diam2/2,0,0])
                    sphere(d=diam2,$fn=qual);        

                    rotate([(360/(xx)*(j)),0,0])
                    rotate([0,0,(180/(yy)*(i+1))])
                    translate([diam-diam2/2,0,0])
                    sphere(d=diam2,$fn=qual);        
                }
                hull()
                {
                    rotate([(360/(xx)*j),0,0])
                    rotate([0,0,(180/(yy)*i)])
                    translate([diam-diam2/2,0,0])
                    sphere(d=diam2,$fn=qual);        

                    rotate([(360/(xx)*(j+1)),0,0])
                    rotate([0,0,(180/(yy)*(i))])
                    translate([diam-diam2/2,0,0])
                    sphere(d=diam2,$fn=qual);        
                }
            }
        }
    }
}