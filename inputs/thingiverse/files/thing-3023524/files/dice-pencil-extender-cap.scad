// dice pencil extender cap
// version 0.0.1
// by pixelhaufen
// is licensed under CC BY-SA 3.0 -> https://creativecommons.org/licenses/by-sa/3.0/

//------------------------------------------------------------------
// User Inputs

/*[dice and extender]*/

// shape of the pencil
shape = "hexagon"; // [hexagon,round]

// generate the extender part
extender = "yes"; // [yes,no]
// requires extender
dice = "yes"; // [yes,no]
// pencil diameter
inner_diameter = 7; // [3:0.1:10]
// height of the extender
height = 70; // [22:1:80]
// use a multiple of your nozzle
shell = 1.2; // [0.1:0.05:5]

/*[filler]*/
// generate a filler
filler = "yes"; // [yes,no]
// protect the point requires filler
cap = "yes"; // [yes,no]
// depth of the hole for the pencil
depth = 22; // [0:1:79]


/*[Hidden]*/
$fn = 150; // can't be modified on thingiverse
incircle = inner_diameter/2;
spacing = 0.2;


//------------------------------------------------------------------
// Main

if(filler=="yes")
{
    if(cap=="yes")
    {
        difference()
        {
            if(shape=="round")
            {
                cylinder(r1=incircle, r2=incircle, h=height-depth-1, center=false);
            }
            if(shape=="hexagon")
            {
                hexagon(incircle,height-depth-1);
            }

            translate([0,0,height-depth-8])
            {
                cylinder(r1=0.5, r2=1.5, h=8, center=false);
            }
        }
    }
    else
    {
        hexagon(incircle,height-depth-1);
    }
    
    if(extender=="yes")
    {
        translate([0,(incircle*2+shell+spacing+2),0])
        {
            extender();
        }
    }
}
else
{
    if(extender=="yes")
    {
        extender();
    }
}


//------------------------------------------------------------------
// Modules

module extender()
{
    difference()
    {
        hexagon(incircle+shell+spacing,height);
        
        union()
        {
            translate([0,0,1])
            {
                if(shape=="round")
                {
                    cylinder(r1=incircle+spacing, r2=incircle+spacing, h=height, center=false);
                }
                if(shape=="hexagon")
                {
                    hexagon(incircle+spacing,height);
                }
            }
            
            if(dice=="yes")
            {
                //     6,1,4,5,2,3,  h
                holes([1,1,1,1,1,1], 1);
                holes([1,0,1,1,0,0], 4);
                holes([1,0,0,1,0,0], 7);
            
                holes([1,0,0,0,0,0], 13);
                holes([1,0,1,1,0,1], 16);
                holes([1,0,1,1,1,1], 19);
            }
        }
    }
}

module holes(hx, height)
{
    for(x = [0:len(hx)])
    {
        pos = 360/len(hx) * x;
        
        if(hx[x]==1)
        {
            rotate([0, 0, pos])
            {
                translate([-1,0,height])
                {
                    cube([2, incircle+shell+spacing, 2], center=false);
                }
            }
        }
    }
}

module hexagon(incircle, height)
{
    r=incircle/(sqrt(3)/2);
    linear_extrude(height = height, center = false, convexity = 10, twist = 0)
    {
        angles=[ for (i = [0:6-1]) i*(360/6) ];
        coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
        polygon(coords);
    }
 }
 