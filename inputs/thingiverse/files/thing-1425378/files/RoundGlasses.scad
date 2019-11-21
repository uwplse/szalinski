//Lens diameter
gdiam=47.5;
//Temple size (width of glasses).
tsize=135;
//Pupil distance
pd=70;
//Glasses thickness
th=4;
//Temple length
lscales=150;
//Thickness of the lenses
gheight=5;

$fn=64;

module EyeCylinder()
{
        difference()
        {
            union()
            {
                cylinder(d=gdiam+th*2, h=gheight);
                NosePad();
            }
            LensHole();
        }  
}

module  LensHole()
{
    translate([0,0,-.1])
    cylinder(d=gdiam, h=gheight*2.2, center=true);
}

module NosePad()
{
    rotate([0,0,-25])
    intersection()
    {
        translate([gdiam/2,0,th/2])
     
        scale([1,1,.35])
        rotate([0,90,0])
        cylinder(r=15, h=th*2, center=true);

        scale(100) // The lower half only
        translate([-.5,-.5,-1])
        cube(1);
        
        cylinder(d=gdiam+th*2, h=gheight*15, center=true); // Inside the lens cylinder
    }
}

module Eye()
{
    EyeCylinder();
    translate([0,0,gheight])
    mirror([0,0,1])
    {
        offs=(tsize-pd)/2;
        
        translate([-offs,0,0])
        scale([offs-(gdiam+2*th)/2, gheight, gheight])
        translate([.65,0,.5])
        cube(1, center=true);
        
        
        translate([-offs,0,])
        scale([gheight,gheight,lscales])
        translate([0,0,.5])
        cube(1,center=true);
    }
}

module TwoEyes()
{
    translate([-pd/2,0,gheight]) // Center
    mirror([0,0,1])
    union()
    {
        Eye();
        translate([pd,0,0])
        mirror([1,0,0]) // Not necessary for a round lens
        Eye();
    }
}

module RoundGlasses()
{
    difference()
    {
        cylinder(d=gdiam+th*2, h=gheight);
        LensHole();
        translate([-pd/2,0,0])
        LensHole();
        translate([pd/2,0,0])
        LensHole();
        translate([-pd/2,-pd,-pd/2])
        cube(pd);
    }
    TwoEyes();
}

RoundGlasses();


        