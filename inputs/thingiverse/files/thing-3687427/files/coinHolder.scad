$fn=30;
/* [PlacementOptions] */
// check this for two quarter holders.
secondQuarterHolderEnabled = false;
// check this for to for a dollar holder.
DollarHolderEnabled = true;

height = 20; // [1:50]
wallThickness = 1; // [1:5]
oversizePercent = 1.03; //[1.00:2.00]

// XY values are .1mm 
DollarX = 0;   // [-1000:1000]
// XY values are .1mm 
DollarY = 0;   // [-1000:1000]
// degree rotation for opening
DollarR = 313; // [0:360]

Quarter1X = 271; // [-1000:1000]
Quarter1Y = 0;   // [-1000:1000]
Quarter1R = 313; // [0:360]

// second quarter slot
Quarter2X = 0; // [-1000:1000]
Quarter2Y = 0; // [-1000:1000]
Quarter2R = 0; // [0:360]

DimeX = 931; // [-1000:1000]
DimeY = 0;   // [-1000:1000]
DimeR = 313; // [0:360]

NickelX = 514; // [-1000:1000]
NickelY = 0; // [-1000:1000]
NickelR = 313; // [0:360]

PennyX = 731; // [-1000:1000]
PennyY = 0; // [-1000:1000]
PennyR = 313; // [0:360]

module CoinHolder(coinDiameter, coinHeight)
{
    diameter= coinDiameter * oversizePercent;
    rotate([0,0,45])
    {
        difference()
        {
            linear_extrude(height)
            {
                circle(d=diameter + 2*wallThickness);
            }
            translate([0,0,coinHeight])
            {
                linear_extrude(height)
                {
                    union()
                    {
                        translate([0,diameter/2])square([diameter*2, diameter/3], center=true);
                        circle(d=diameter);
                    }
                }
            }
        }
    }    
}

module DollarHolder    (){CoinHolder(26.55 , 2   );}
module HalfDollarHolder(){CoinHolder(30.61 , 2.15);}
module QuarterHolder   (){CoinHolder(24.26 , 1.75);}
module DimeHolder      (){CoinHolder(17.92 , 1.35);}
module NickelHolder    (){CoinHolder(21.21 , 1.95);}
module PennyHolder     (){CoinHolder(19.05 , 1.55);}

if(DollarHolderEnabled) translate([DollarX/10,DollarY/10,0])     rotate([0,0,DollarR])   DollarHolder();
translate([Quarter1X/10,Quarter1Y/10,0]) rotate([0,0,Quarter1R]) QuarterHolder();
if(secondQuarterHolderEnabled) translate([Quarter2X/10,Quarter2Y/10,0]) rotate([0,0,Quarter2R]) QuarterHolder();
translate([NickelX/10,NickelY/10,0])     rotate([0,0,NickelR])   NickelHolder();
translate([PennyX/10,PennyY/10,0])       rotate([0,0,PennyR])    PennyHolder();
translate([DimeX/10,DimeY/10,0])         rotate([0,0,DimeR])     DimeHolder();
