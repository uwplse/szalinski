//Variables
fragmentCount = 40;

footDiameter = 24;
footHeight = 3.5;
footRadius = 8.5;

baseDiameter = 18;
baseHeight = 4.5;

nailHeadDiameter = 5;
nailDiameter = 2;

//Create solid
$fn=fragmentCount;
union()
{
    //Create foot
    difference()
    {
        roundedcylinder(footHeight,footDiameter/2,footRadius,0);
        cylinder(footHeight*1.1, nailHeadDiameter/2, nailHeadDiameter/2*1.2, false);
    }

    //Create base
    difference()
    {
        translate([0,0,-baseHeight])cylinder(baseHeight, baseDiameter/2, baseDiameter/2);
        translate([0,0,-baseHeight])cylinder(baseHeight, nailDiameter/2, nailDiameter/2*1.2, false);
    }
}

module roundedcylinder(zDim, rDim, rTop, rBottom)
{    
    union()
    {
        //Top rounded edge
        intersection()
        {
            if (rTop>zDim)            
            {
                translate([0,0,zDim-rTop/(rTop/zDim)])translate([0,0,-rTop])difference()
                {
                    minkowski()
                    {
                        cylinder(rTop,rDim-rTop,rDim-rTop,false);
                        difference()
                         {
                             sphere(rTop);
                             translate([-rTop,-rTop,-rTop])cube([rTop*2,rTop*2,rTop]);
                         }     
                     }
                     translate([-rDim,-rDim,0])cube([rDim*2,rDim*2,rTop]);
                 }         
             }
             else
             {
                 translate([0,0,zDim-rTop])translate([0,0,-rTop])difference()
                 {
                    minkowski()
                    {
                        cylinder(rTop,rDim-rTop,rDim-rTop,false);
                        difference()
                         {
                             sphere(rTop);
                             translate([-rTop,-rTop,-rTop])cube([rTop*2,rTop*2,rTop]);
                         }     
                     }
                     translate([-rDim,-rDim,0])cube([rDim*2,rDim*2,rTop]);
                 }
             }
             cylinder(zDim,rDim,rDim,false);       
         }   
         
        //Bottom rounded edge
         intersection()
         {
            if(rBottom>zDim)
            {
                translate([0,0,0+rBottom/(rBottom/zDim)])translate([0,0,-rBottom])difference()
                {
                    minkowski()
                    {
                        cylinder(rBottom,rDim-rTop,rDim-rTop,false);
                        translate([0,0,rBottom])difference()
                         {
                             sphere(rBottom);
                             translate([-rBottom,-rBottom,0])cube([rBottom*2,rBottom*2,rBottom]);
                         }     
                     }
                     translate([-rDim,-rDim,rBottom])cube([rDim*2,rDim*2,rBottom]);
                }    
            }
            else
            {
                translate([0,0,rBottom])translate([0,0,-rBottom])difference()
                {
                    minkowski()
                    {
                        cylinder(rBottom,rDim-rTop,rDim-rTop,false);
                        translate([0,0,rBottom])difference()
                         {
                             sphere(rBottom);
                             translate([-rBottom,-rBottom,0])cube([rBottom*2,rBottom*2,rBottom]);
                         }     
                     }
                     translate([-rDim,-rDim,rBottom])cube([rDim*2,rDim*2,rBottom]);
                }
            }
            cylinder(zDim,rDim,rDim,false);                   
        }
    }
}