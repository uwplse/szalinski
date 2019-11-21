//	Based on Thingiverse Customizer Template v1.3 by MakerBlock
//	http://www.thingiverse.com/thing:44090

/*
    Must hold 1/4 cup liquid
    1/4 cup = 59.14706 cubic centimeters
    60 cc = 60,000 cubic milliters
    Interal radius of mug is (OD-mugWall*2)/2 = 26
    Area of circle = pi*r^2
    Thus, area of center of mug is 26*26*3.15 (rounded) = 2129.4 mm^2
    60,000/2129.4 = 28.177
    This is the necessary height of the liquid inside
*/


/* [Secret Trick Setting] */
    //	Position of secret trick
        Position_Of_Secret_Trick = 6;	//	[1:11]
/* [Optional Mug Settings] */
    //	This section is displays the box options
    //  Mug Inner Diameter
        Mug_Inner_Diameter = 64;    //  [40:100]
    //  Mug height
        Mug_Height = 70;     //  [60:100]
    //	Thickness around mug parts
        Mug_Thickness = 3;	//	[2:Thin (2 mm), 3:Thick (3 mm), 4:Thicker (4 mm), 5:Thickest (5 mm)]

/* [Hidden] */
    //  General Settings
        fn = pow(2,5);  //  6
        fn2 = pow(2,4); //  5
        fn3 = pow(2,4); //  3
        cl = 0.01;
    //  Hard Coded Mug Settings
        handleW = 15;
        handleExtend = 20;
        mugBaseLower = 0.5;
    //  Mug Settings
        th = Mug_Thickness;
        mugWall = th*3;
        mugID = Mug_Inner_Diameter;
        mugIR = Mug_Inner_Diameter/2;
        mugOD = Mug_Inner_Diameter+mugWall;
        mugOR = mugOD/2;
        mugH = Mug_Height;
    //	Number of holes in rim
        Number_Of_Holes_Around_Mug_Rim = 12;	//	[4,8,16]
        spillN = Number_Of_Holes_Around_Mug_Rim; // pow(2,4);
    //  Display
        // preview[view:east, tilt:top diagonal]

mug();

//  Mug
module mug()
    {
    difference()
        {
        mug_solid();
        * translate([1000/2,0,0]) cube(1000, center=true);
        mug_negative();
        * mug_contents();
        }
    }

//  Mug Contents
module mug_contents()
    {
    translate([0,0,mugWall]) 
        cylinder(r=mugIR, h=mugH+handleExtend-handleW-mugWall*3-th, 
            center=false, $fn=fn);
    * echo(PI * pow(mugIR,2) * 
        (mugH+handleExtend-handleW-mugWall*3-th));
    }

//  Mug Negative
module mug_negative()
    {
    //  Cutting the suction method
        //  Center
        translate([0,0,mugWall/2]) cylinder(r=th/2, h=mugWall, $fn=fn2, center=false);
        //  Center to bottom of handle
        hull()
            {
            translate([0,0,mugWall/2]) sphere(r=th/2, $fn=fn2);
            translate([0,mugOR-mugWall/2,mugWall/2]) sphere(r=th/2, $fn=fn2);
            }
        //  Base of handle to bottom middle of handle
        hull()
            {
            translate([0,mugOR-mugWall/2,mugWall/2]) sphere(r=th/2, $fn=fn2);
            translate([0,mugOR-mugWall/2+handleExtend+mugWall/2,
                mugWall/2+handleExtend+mugWall/2]) 
                    sphere(r=th/2, $fn=fn2);
            }
        //  Middle of handle
        hull()
            {
            translate([0,mugOR-mugWall/2+handleExtend+mugWall/2,
                mugWall/2+handleExtend+mugWall/2]) 
                    sphere(r=th/2, $fn=fn2);
            translate([0,mugOR-mugWall/2+handleExtend+mugWall/2,
                mugH-mugWall/2-handleExtend]) 
                    sphere(r=th/2, $fn=fn2);
            }
        //  Top of handle
        hull()
            {
            translate([0,mugOR-mugWall/2+handleExtend+mugWall/2,
                mugH-mugWall/2-handleExtend]) 
                    sphere(r=th/2, $fn=fn2);
            translate([0,mugOR-mugWall/2,mugH]) sphere(r=th/2, $fn=fn2);
            }
    //  Adding spill holes
    difference()
        {
        union()
            {
            for (i=[0:360/spillN]) translate([0,0,mugH+handleExtend-handleW-mugWall*2]) 
                rotate([0,0,360/spillN*i])
                {
                //  Radial holes
               rotate([90,0,0]) cylinder(r=th/2, h=mugOD+1, center=true, $fn=fn2);
                //  Top holes
                translate([0,mugOR-mugWall/2,0]) 
                    cylinder(r=th/2, h=(handleW+mugWall*2), center=false, $fn=fn2);
                }
       translate([0,mugOR-mugWall/2,
            mugH+handleExtend-handleW-mugWall*3]) 
           cylinder(r=th/2, h=(handleW+mugWall*2), 
                center=false, $fn=fn2);
            }
        //  Minus the connection to the handle
    translate([0,mugOR-mugWall/2,
            mugH+handleExtend-handleW-mugWall*2]) 
        rotate([90,0,0]) 
        difference()
            {
            cylinder(r=th*3/2, h=mugWall*2, $fn=fn2, center=true);
            cylinder(r=th/2, h=mugOD+th, center=true, $fn=fn2);
            }
        }
    //  Adding the connection to the hole that must be blocked
        //  Rounded edges to top and bottom
       for (i=[-1,1]) translate([0,mugOR-mugWall/2,
            mugH+handleExtend-handleW-mugWall*2+mugWall*0.5*i]) 
            sphere(r=th/2, $fn=fn2);
        //  Connecting the top and bottom
        translate([0,mugOR-mugWall/2,
            mugH+handleExtend-handleW-mugWall*2]) 
        difference()
            {
            rotate([90,0,0]) rotate_extrude($fn=fn2) 
                translate([th*3/2,0,0]) 
                circle(r=th/2, $fn=fn2);
            translate([th*4,0,0]) cube(th*8, center=true);
            }
    //  Adding hole that must be blocked
    
    //  Circular cut out
        translate([0,0,mugH+handleExtend-handleW-mugWall*3])
            {
            //  Ring
            rotate_extrude($fn=fn) 
            translate([mugOR-mugWall/2,0,0]) 
                circle(r=th/2, $fn=fn2);
            //  Secret trick
#            rotate([0,0,-360/spillN*Position_Of_Secret_Trick])
            translate([0,mugOR-mugWall/2,0]) 
                cylinder(r=th/2, h=(handleW+mugWall*2), 
                    center=false, $fn=fn2);
            }
    }

//  Mug Solid
module mug_solid()
    {
    //  Mug
    difference()
        {
        union()
            {
            //  Outer wall of mug
            translate([0,0,mugWall/2]) 
                cylinder(r=mugOR, h=mugH-mugWall/2, $fn=fn, center=false);
            //  Rounded top rim
            translate([0,0,mugH]) rotate_extrude($fn=fn) 
                translate([mugOR-mugWall/2,0,0]) circle(r=mugWall/2, $fn=fn);
            //  Rounded bottom rim
            translate([0,0,mugWall/2]) hull() rotate_extrude($fn=fn) 
                translate([mugOR-mugWall/2,0,0]) circle(r=mugWall/2, $fn=fn);
            //  Handle, solid
            render() minkowski() 
                {
                handle();
                sphere(r=th, $fn=fn3);
                }
            }
        //  Cutting out interior
        translate([0,0,mugWall+mugWall/2])
            cylinder(r=mugOR-mugWall, h=mugH, $fn=fn, center=false);
        //  Cutting out rounded bottom, with a slight depression to let liquid drain
        hull()
            {
            //  Rounded base cutout
            translate([0,0,mugWall+mugWall/2]) hull() rotate_extrude($fn=fn) 
                translate([mugOR-mugWall-mugWall/2,0,0]) 
                    circle(r=mugWall/2, $fn=fn);
            //  Slight depression to allow draining of liquid
            translate([0,0,mugWall+mugWall/2-mugWall/2])
                scale([(mugOR-mugWall-mugWall/1.5)*2,(mugOR-mugWall-mugWall/1.5)*2,1]) 
                    sphere(r=mugBaseLower, $fn=fn);
            }
        }
    }

//  Handle
module handle()
    {
    hull()
        {
        translate([0,mugOR,mugWall]) rotate([90,0,0]) handle_crosssection();
        translate([0,mugOR,mugWall]) rotate([-45,0,0]) handle_crosssection();
        }
    hull()
        {
        translate([0,mugOR,mugWall]) rotate([-45,0,0]) handle_crosssection();
        translate([0,mugOR+handleExtend,mugWall+handleExtend]) rotate([0,0,0])
            handle_crosssection();
        }
    hull()
        {
        translate([0,mugOR+handleExtend,mugWall+handleExtend]) rotate([0,0,0])
            handle_crosssection();
        translate([0,mugOR+handleExtend,mugH-mugWall/2-handleExtend]) rotate([0,0,0]) 
            handle_crosssection();
        }
    hull()
        {
        translate([0,mugOR+handleExtend,mugH-mugWall/2-handleExtend]) rotate([0,0,0]) 
            handle_crosssection();
        translate([0,mugOR,mugH-mugWall/2]) rotate([45,0,0]) handle_crosssection();
        }
    hull()
        {
        translate([0,mugOR,mugH-mugWall/2]) rotate([45,0,0]) handle_crosssection();
        translate([0,mugOR,mugH-mugWall/2]) rotate([90,0,0]) handle_crosssection();
        }
    }

module handle_crosssection()
    {
    linear_extrude(height=cl, center=false) offset(r=-th)
        hull() for (i=[0:1]) mirror([i,0,0]) translate([(handleW-mugWall)/2,0,0]) 
            circle(r=mugWall/2, $fn=fn3);
    }