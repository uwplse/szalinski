grommet_height=29;
grommet_width=128;
grommet_depth=30;
brim_width=8;
grommet_penetration_thickness=2;

//module grommet(height, width, depth)
module grommet(ovaldia, totalwidth, gdepth)
{

      difference()
        {
        //rim
        union()
        {
            linear_extrude(1)
            {
                union()
                {
                    
                    //translate([0,ovaldia/2,0])
                    //{
                        circle(d=ovaldia+brim_width);
                    //}
                    translate([0,-(ovaldia+brim_width)/2,0])
                    {
                        square([totalwidth-(ovaldia),ovaldia+brim_width],center=false);
                    }
                    translate([totalwidth-(ovaldia),0,0])
                    {
                        circle(d=ovaldia+brim_width);
                    }
                }
            }
            linear_extrude(gdepth-1)
            {
                union()
                {
                    translate([0,0,0])
                    {
                        circle(d=ovaldia);
                        translate([0,-((ovaldia)/2),0])
                        {
                            square([totalwidth-ovaldia,ovaldia],center=false);
                        }
                        translate([totalwidth-ovaldia,0,0])
                        {
                            circle(d=ovaldia);
                        
                        }  
                    }
                }  
            }
        }   
            //hole
            linear_extrude(gdepth)
            {
                union()
                {
                    //translate([0,ovaldia/2,0])
                    //{
                        circle(d=ovaldia-grommet_penetration_thickness);
                    //}
                    translate([0,-(ovaldia-grommet_penetration_thickness)/2,0])
                    {
                        square([totalwidth-(ovaldia-grommet_penetration_thickness),ovaldia-grommet_penetration_thickness],center=false);
                    }
                    translate([totalwidth-ovaldia,0,0])
                    {
                        circle(d=ovaldia-grommet_penetration_thickness);
                    }
                }
            }
        }

}

grommet(grommet_height, grommet_width, grommet_depth);