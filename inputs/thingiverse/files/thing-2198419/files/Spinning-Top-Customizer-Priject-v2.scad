/////VARIABLES/////

stemHeight=110; //[90:Short, 110:Medium, 130:Tall]

rimThickness=80; //[77:Thin, 80:Medium, 83:Thick]

rimDesign=0;  //[0:None, 1:Circles, 2:Triangles, 3:Diamonds]

shapeSymmetry=3;  //[0:None, 2,3,4,5]

/////MODULES/////////////////////////////////////////////////////////////
module Spinner (size)
{
scale(size)
    {
        rotate_extrude(convexity=10, $fn=100)
        {
            mirror([1,0,0])
                rotate([0,0,90])
                    translate([2.5,0,0])
                        union()
                        {
                            //body
                            rotate(90,[0,0,0])
                                difference()
                                {
                                    //base
                                    square([stemHeight,50]);
                                    //extended base
                                    translate([80,5,0])
                                        square(50);
                                    //top cutout
                                    translate([rimThickness,50,0])
                                        circle(45, $fn=100);
                                    //bottom cutout
                                    translate([-15,47,0])
                                        circle(45, $fn=100);
                                }
                            //bottom ball; commented out to be replaced by "bottom ball cap"
                            //translate([0,2.4,0])
                            //circle(2.2, $fn=50);
                            //top ball
                            translate([stemHeight,2.5,0])
                                circle(2.5, $fn=50);
                        }
        }
        //top ball cap; shpere added to top to make it rounded
        translate([0,0,stemHeight+2.5])
            sphere(5, $fn=50);
        //bottom ball cap; shpere added to bottom to make it rounded
        translate([0,0,3.9])
            sphere(4.82, $fn=50);
    }
}
/////RENDERS/////////////////////////////////////////////////////////////

if(rimDesign==0)
    {
        Spinner(1);
    }
    else if(rimDesign==1)
    {
        
        for(i=[0:shapeSymmetry])
            {
                rotate([0,0,(360/shapeSymmetry)*i])
                union()
                {
                    Spinner (1);
            
                    //circles
                    translate([20,20,38])
                    cylinder(h=3, r=15, $fn=50);
                }
            }
    }
    else if(rimDesign==2)
    {
        for(i=[0:shapeSymmetry])
            {
                rotate([0,0,(360/shapeSymmetry)*i])
                union()
                {
                    Spinner (1);
            
                    //triangles
                    translate([22,22,38])
                    rotate([0,0,45])
                    cylinder(h=5, r=15, $fn=3);
                }
            }
    }
    else if(rimDesign==3)
    {
        for(i=[0:shapeSymmetry])
            {
                rotate([0,0,(360/shapeSymmetry)*i])
                union()
                {
                    Spinner (1);
            
                    //diamonds
                    translate([22,22,38])
                    rotate([0,0,45])
                    cylinder(h=5, r=15, $fn=4);
                }
            }
    }