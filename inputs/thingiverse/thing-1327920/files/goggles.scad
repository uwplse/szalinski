//Lens diameter
gdiam=47.5;
//Pupil distance
pd=70;
//Thickness
th=2;

gheight=50;
slantr=gdiam*2;
lensheight=10;

eye_cap_length=10;
eye_cap_tooth_diam=5;
eye_tooth_count=12;
$fn=128;

module EyeCylinder()
{
          difference()
        {
            cylinder(d=gdiam+th*2, h=gheight);
            LensHole();
        }  
}

module  LensHole()
{
    translate([0,0,-.1])
    cylinder(d=gdiam, h=gheight+.2);
}

module Eye()
{
    difference()
    {
        EyeCylinder();

        translate([slantr*.53,0,-slantr*.6])
        rotate([27,0,0])
        rotate([90-10,-45,0])
        cylinder(r=slantr, h=100, center=true);
    }
}

module TwoLens()
{
    Eye();
    translate([pd,0,0])
    mirror([1,0,0])
    Eye();
    
    difference()
    {
        union()
        {
                
            // Lens main connector
            translate([0,0,gheight-lensheight-5])
            translate([0,gdiam/2+th/2,0])
            scale([pd,th/2,lensheight+5])
            cube(1);

            // Lens secondary connector
            delta=0;//12
            translate([0,0,gheight-lensheight-2])
            translate([delta,gdiam/2-2,0])
            scale([pd-2*delta,th/2,lensheight+2])
            cube(1);
            
            translate([0,0,gheight-lensheight-2])
            translate([delta*1.3,gdiam/2-2,0])
            scale([pd-2*delta*1.3,3,12])
            cube(1);
        }
            
        translate([pd/2,0,-pd/2.5])
        rotate([90,0,0])
        cylinder(d=pd*2.05, h=200, center=true);
        
        LensHole();    
        translate([pd,0,0])
        LensHole();    
        
    }
}

module MainGoggles()
    difference()
    {
        TwoLens();
        translate([pd/2,-3,9])
        scale([2*pd,15,4])
        cube(1, center=true);
    }


module EyeCap()
{
    difference()
    {
        union()
        {
            cylinder(d=gdiam+th*2*2, h=eye_cap_length);    
            
            /*gear (number_of_teeth=eye_tooth_count,
            circular_pitch=180*(gdiam+4*2*th)/eye_tooth_count,
            gear_thickness=eye_cap_length,
            rim_thickness=eye_cap_length,
            rim_width=0,
            twist=3,
            pressure_angle=15
            );*/
            // Rotation teeth
            for(i=[0:1:eye_tooth_count])
            rotate([0,0,14+i*360/eye_tooth_count])
            translate([gdiam/2+th*2,0,0])
            cylinder(h=eye_cap_length, d=eye_cap_tooth_diam);
        }
        translate([0,0,th])
        EyeCylinder();
        
        // Cut eye hole
        translate([0,0,-.1])
        cylinder(d=gdiam-th*2, h=eye_cap_length*2);    
        
        // Cut inner part
        translate([0,0,2*th])
        cylinder(d=gdiam+.1, h=eye_cap_length*2);
        
        // Cut hole for connectors
        translate([gdiam/2,-4,th])
        cylinder(d=eye_cap_tooth_diam*3, h=eye_cap_length);
    }
}

module InnerFixer()
difference()
{
    cylinder(d=gdiam, h=eye_cap_length/2);
    translate([0,0,-.1])
    cylinder(d=gdiam-2*th, h=gheight+.2);
}


// Glasses
translate([0,0,gheight])
mirror([0,0,1])
MainGoggles();

// Eye caps
translate([0,gdiam+th*6,0])
EyeCap();
translate([gdiam+th*8,gdiam+th*6,0])
EyeCap();

// Fixing rings
translate([0,-gdiam-th*3,0])
InnerFixer();
translate([gdiam+th*8,-gdiam-th*3,0])
InnerFixer();

