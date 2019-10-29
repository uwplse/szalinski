// binary feeler gauge
// version 0.0.1
// by pixelhaufen
// is licensed under CC BY-SA 3.0 -> https://creativecommons.org/licenses/by-sa/3.0/

// for heights without feeler combine them
// * 1 = 2^0
// * 2 =       2^1
// + 3 = 2^0 + 2^1
// * 4 =             2^2
// + 5 = 2^0 +       2^2
// + 6 =       2^1 + 2^2
// + 7 = 2^0 + 2^1 + 2^2
// * 8 =                   2^3
// + 9 = 2^0 +             2^3
// + ...
// + 15 = 2^0 + 2^1 + 2^2 + 2^3
// * 16 =                       + 2^4
// ...

//------------------------------------------------------------------
// User Inputs

case = "yes"; // [yes,no]
unit_type = "1 mm"; // [1 mm, 100 um, both]
feeler = "all"; // [all, single, none]
// 2^
height_of_feeler = 3; // [0:8]

/*[Hidden]*/
$fn = 50;
number = height_of_feeler;
unit = return_unit(unit_type);

//------------------------------------------------------------------
// Main

// feeler
if (feeler=="single")
{
    if (unit_type != "both")
    {
        translate([12,-60,0])
            feeler(unit,number);
    }
    else
    {
        // error
        echo ("Feeler unit type can't be both for single feeler.");
    }
}
else if (feeler=="all")
{
    if(unit_type == "1 mm" || unit_type == "both")
    {
        for (i = [0:number])
        {
            translate([12+i*20,-60,0]) feeler(1,i);
        }
    }
    if(unit_type == "100 um" || unit_type == "both")
    {
        for (i = [0:number])
        {
            translate([-12-i*20,-60,0]) feeler(.1,i);
        }
    }
}

// case
if(case=="yes")
{
    rotate([-90,0,0])
    translate([0,-60,15])
        case(unit,number);
}

//------------------------------------------------------------------
// Function

function return_unit(unit_type) = 
    unit_type=="1 mm"
    ? 1
    : unit_type=="100 um"
        ? 0.1
        : 1.1;

//------------------------------------------------------------------
// Modules

module case(unit,number)
{
    height=pow(2,number+1)*unit+2.2-unit;
    width=17.2;
    
    translate([0,0,height/2])
    difference()
    {
        union()
        {
            cylinder(r1=width/2,r2=width/2,h=height,center=true);
            translate([0,30,0]) cube([width,60,height],center=true);
            
        }
        translate([0,65,0]) cylinder(r1=width/2,r2=width/2,h=height+0.1,center=true);
        union()
        {
            cylinder(r1=(width-2)/2,r2=(width-2)/2,h=height-2,center=true);
            translate([0,30,0]) cube([width-2,61,height-2],center=true);
            
        }
    }
}

module feeler(unit,number)
{
    height=pow(2,number)*unit;
    width=15;
    
    translate([0,0,height/2])
    difference()
    {
        union()
        {
            cylinder(r1=width/2,r2=width/2,h=height,center=true);
            translate([0,30,0]) cube([width,60,height],center=true);
            translate([0,60,0]) cylinder(r1=width/2,r2=width/2,h=height,center=true);
        }
        
        loop = number-1;
        if(number > 0)
        {
            for (i = [0:loop])
            {
                translate([0,i*6,0]) cube([3,3,height+0.1],center=true);
            }
        }
    }
}
