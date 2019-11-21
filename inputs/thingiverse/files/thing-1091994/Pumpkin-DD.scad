//Parts 1 = PUMPKIN NO LID, Parts 2 = LID
Parts = 1; 
// Scaling the Model
Size=1; //[1]
//Detail
$fn = 40;
//Has Nose, 1 = YES, 2 = NO
Has_Nose = 1;
//Cool Eyes or nah, 1 = YES, 2 = NAH
Cool_Eyes = 1;
//Mouth Expression, 1 = Happy, 2 = Not Happy
Mouth_Expression = 1;
    //START MAKING MODULES HERE
    module Mouth()//its the mouth
    {
        translate([0,33 * Size,-28 * Size])
        {
            difference()
            {
                scale([45,40,15])
                {
                    cylinder(Size,0,Size,$fn=4);
                }
                translate([0,0,16*Size])
                {
                    scale([1.99,1,0.30])
                    {
                        sphere(r=Size*20);
                    }
                }
                translate([-5*Size,0,12*Size])//starting to make the mouth pillars MOUTH R1
                {
                    cube([5*Size, 20*Size, 25*Size],true);
                }
                translate([5*Size,0,12*Size])//starting to make the mouth pillars MOUTH L1
                {
                    cube([5*Size, 20*Size, 25*Size],true);
                }
                translate([-14*Size,0,12*Size])//starting to make the mouth pillars MOUTH R2
                {
                    cube([5*Size, 20*Size, 25*Size],true);
                }
                translate([14*Size,0,12*Size])//starting to make the mouth pillars MOUTH L2
                {
                    cube([5*Size, 20*Size, 25*Size],true);
                }
                translate([-24*Size,0,12*Size])//starting to make the mouth pillars MOUTH R3
                {
                    cube([5*Size, 20*Size, 25*Size],true);
                }
                translate([24*Size,0,12*Size])//starting to make the mouth pillars MOUTH L3
                {
                    cube([5*Size, 20*Size, 25*Size],true);
                }
            }
        }
    }
    
    module Nose()
    {
        translate([0,38*Size,-5*Size])
        {
            difference()
            {
                cylinder(10*Size, 8*Size,0);//large part
                cylinder(3*Size,11*Size,0,$fn=4);//small part
            }
        }
    }    
    module Eye()//its an eye
    {
         translate([17*Size,37.*Size,Size*2])
         {
             if(Cool_Eyes == 1)
             {
                 hull()
                 {
                    cylinder(12*Size,10*Size,0);
                    translate([0,-2*Size,Size*17])
                    {
                        rotate([0,-50,0])
                        {
                            cylinder(7*Size, 1.75*Size,0);
                        }
                    }    
                 }
            }
            if(Cool_Eyes == 2)
             {
                cylinder(12*Size,10*Size,0);
                
            }
         }
    } 
    module PumpkinPart()
    {
        scale([Size*1.55, Size, Size*1.75])
        {
            translate([Size*9, 0, 0])
            {    
                sphere(r=Size*20);
            }
        }
    }
        
    module Pumpkin()
    {
        PumpkinPart();
        
        mirror()
        {
            PumpkinPart();
        }
        rotate([0,0,36])
        {
            PumpkinPart();
        }
        
        rotate([0,0,-36])
        {   
            PumpkinPart();
        }
    
        rotate([0,0,72])
        {
            PumpkinPart();
        }
    
        rotate([0,0,-72])
        {
            PumpkinPart();
        }
    
        rotate([0,0,-108])
        {
            PumpkinPart();
        }

        rotate([0,0,108])
        {
            PumpkinPart();
        }
        rotate([0,0,144])
        {
            PumpkinPart();
        }
        
        rotate([0,0,-144])
        {
            PumpkinPart();
        }
    }
color("orange")
{
    if(Parts == 1)
    {
            difference()
            {
                Pumpkin();
                scale([0.9,0.9,0.9])
                {
                    Pumpkin();
                }
                Eye();
                mirror()
                {   
                    Eye();
                }    
                if (Has_Nose == 1)
                {
                    Nose();
                }
                if (Mouth_Expression == 1)
                {
                    Mouth();
                }
                if (Mouth_Expression == 2)
                {
                    translate([0,0,-35])
                    {
                        rotate([0,180,0])
                        {
                            Mouth();
                        }
                    }
                }
                translate([0,0,40*(Size)])
                {
                    sphere(r=30*Size);
                }   
            }
    }
    if (Parts == 2)
    {
        translate([0,0,18*Size])
        {
            cylinder(r1=24*Size,r2=26*Size,h=8*Size);
        }
            intersection()
        {
            difference()
            {
                scale([0.95,0.95,0.95])
                {
                    Pumpkin();
                }
                cube([100,100,40],true);
            }    
            translate([0,0,Size*40])
            {
            sphere(r=Size*30);
            }
            
        }
        translate([1*Size,3*Size,0])
        {
            difference()
            {
                    linear_extrude(height = 100*Size, center = true, convexity = 10, twist = 1000,$fn=100)
                    translate([4*Size, 0, 0])
                    {
                    circle(r = 5*Size);
                    }
                translate([0,0,-22*Size])
                {
                    cube([1000*Size,1000*Size,100*Size],true);
                }
                translate([0,0,94*Size])
                {
                    cube([50*Size,50*Size,100*Size],true);
                }
            }
        }
    }
}