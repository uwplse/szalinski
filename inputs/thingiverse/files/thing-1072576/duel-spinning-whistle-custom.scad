//This changes the left side's size
leftpitch=0;
leftradiusIn=9.75+leftpitch;
leftradiusOut=10.50+leftpitch;
leftcenter=10.25+leftpitch;
leftslices=leftpitch*0.5;

//This changes the right side's size
rightpitch=0;
rightradiusIn=9.75+rightpitch;
rightradiusOut=10.50+rightpitch;
rightcenter=10.25+rightpitch;
rightslices=rightpitch*0.5;

move=size*0.5;
move2=2*leftpitch+2*rightpitch;

lid();
body();
leftspinner();
rightspinner();

module leftspinner()
{
    translate([20,-40-4*leftpitch,1.9])
scale(1.4)
    {
    difference()
        {
            union()
            {
                for(i=[0:9])
                {
                    rotate([0,0,i*360/10])translate([0,6.5+leftslices,0])cube([1.5,5.5+leftpitch,2.75],center=true);
                }
                cylinder($fn=80,r=4, h=2.75, center=true);
            }
            
            union()
            {
                cylinder($fn=80,r=3, h=10,center=true);
            }
        }
    }    
}


module rightspinner()
{
    translate([20,40+5*rightpitch,1.9])
scale(1.4)
    {
    difference()
        {
            union()
            {
                for(i=[0:9])
                {
                    rotate([0,0,i*360/10])translate([0,6.5+rightslices,0])cube([1.5,5.5+rightpitch,2.75],center=true);
                }
                cylinder($fn=80,r=4, h=2.75, center=true);
            }
            
            union()
            {
                cylinder($fn=80,r=3, h=10,center=true);
            }
        }
    }    
}


module body()
{
    translate([40+move2,0,0])
    scale(1.4)
    {
        difference()
        {
            union()
            {
                //left
                translate([0,-10.25,0])
                {
                    translate([0,5.25,0])cube([21,5,5.25]);
                    translate([0,-leftpitch,0])cylinder($fn=80, r=leftradiusOut, h=5.25);
                }
                //right
                translate([0,10.25,0])
                {
                    translate([0,-10.25,0])cube([21,5,5.25]);
                    translate([0,rightpitch,0])cylinder($fn=80, r=rightradiusOut, h=5.25);
                }
            }
            union()
            {
                //left
                translate([0,-10.25,0])
                {
                    translate([0,-leftpitch,1])cylinder($fn=80, r=leftradiusIn, h=10.75); 
                }
                //right
                translate([0,10.25,0])
                {
                    translate([0,rightpitch,1])cylinder($fn=80, r=rightradiusIn, h=10.75); 
                }
                    translate([12,-2.125,4])cube([23,3.2,6],true);
                    translate([12,2.125,4])cube([23,3.2,6],true);
            }
        }
        translate([0,-leftcenter,0])cylinder($fn=80, r=2.75, h=6.25);
        translate([0,rightcenter,0])cylinder($fn=80, r=2.75, h=6.25);
    }
}

module lid()
{   
    scale(1.4)translate([0,-10.25-leftpitch,2])rotate([0,180,0])rightlid();
    scale(1.4)translate([0,10.25+rightpitch,2])rotate([0,180,0])leftlid();

    module rightlid()
    {
        difference()
        {
            union()
            {
                cylinder($fn=80, r=leftradiusIn, h=1);
                translate([0,0,1])cylinder($fn=80, r=leftradiusOut, h=1);
            }
            union()
            {
                for(i=[0:9])
                {
                    rotate([0,0,i*360/10])translate([0,6.5+leftslices,0])cube([1.5,5+leftpitch,5],true);
                }
                cylinder($fn=80, r=2.85, h=11.5,center=true);
                translate([1.5,10.25+leftpitch,.5])cube([40,1.1,1],true);
            }
        }
    }

    module leftlid()
    {
        difference()
        {
            union()
            {
                cylinder($fn=80, r=rightradiusIn, h=1);
                translate([0,0,1])cylinder($fn=80, r=rightradiusOut, h=1);
            }
            union()
            {
                for(i=[0:9])
                {
                    rotate([0,0,i*360/10])translate([0,6.5+rightslices,0])cube([1.5,5+rightpitch,5],center=true);
                }
                cylinder($fn=80, r=2.85, h=11.5,center=true);
                translate([1.5,-10.25-rightpitch,.5])cube([40,1.1,1],true);
            }
        }
    }
    translate([0,0,2.75])rotate([0,180,0])scale(1.4)
    {
        union()
        {
            difference()
            {
                union()
                {
                    translate([10.5,0,1])cube([21,10,2],true);
                }
                union()
                {
                    translate([0,-10.25-leftpitch,0])for(i=[0:9])
                    {
                        rotate([0,0,i*360/10])translate([0,6.5+leftslices,0])cube([1.5,5+leftpitch,5],center=true);
                    }
                    translate([0,10.25+rightpitch,0])for(i=[0:9])
                    {
                        rotate([0,0,i*360/10])translate([0,6.5+rightslices,0])cube([1.5,5+rightpitch,5],center=true);
                    }
                    translate([1.5,0,.5])cube([40,1.1,1],true);
                    translate([7,3.7,0])cube([14,1.3,1]);
                    translate([7,-5,0])cube([14,1.3,1]);
                }
            }
        }
    }
}