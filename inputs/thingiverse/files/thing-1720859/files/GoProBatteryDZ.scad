
/*
    GoPro Battery & SD older
*/

GoProBatteryW = 35;
GoProBatteryD = 13;
GoProBatteryH = 39;

nBattery = 3;
gap = 2;
pinsDim = 4; // Pins diameter

ClosingW = 1;
ClosingD = 10;

// Calculate
// ---------------------------------------------

internalBoxW = GoProBatteryW + gap *2;
internalBoxD = gap * (nBattery+1) + GoProBatteryD*nBattery;
internalBoxH = GoProBatteryH + gap *2;


module GoProBattery()
{
    cube([GoProBatteryW,GoProBatteryD,GoProBatteryH]);
}

module GoProBatterySub()
{
        cube([GoProBatteryW,GoProBatteryD,GoProBatteryH + gap *4]);
}

module GoProBox()
{
    cube([internalBoxW, internalBoxD, internalBoxH]);
}

module Hemisphere(dim)
{
    difference()
    {
        translate([0, dim/2, dim/2])
         sphere(d = dim, $fa=5, $fs=0.1); 
        translate([-dim/2, dim/2, 0])
        # cube([dim, dim, dim]);
    }
}

module Cover ()
{
    difference()
    {
        union()
        {
            cube([internalBoxW, internalBoxD, gap]);
            
            // Closing
            translate([internalBoxW, internalBoxD/2 - ClosingD/2 - (gap/2), -gap*3])
             cube([ClosingW, ClosingD + gap, gap * 4]);
            
            // Pins
            translate([0,-gap, -GoProBatteryH/3 + gap])
             cube([internalBoxW/2, gap, GoProBatteryH/3]);
                
            translate([0,internalBoxD, -GoProBatteryH/3 + gap])
             cube([internalBoxW/2, gap, GoProBatteryH/3]);
        }
    
        translate([internalBoxW,internalBoxD/2 - ClosingD/2, -gap *2])
         rotate([90+180,0,0])
          # cylinder(h= ClosingD, d1=gap, d2=gap, $fs=0.1); 
        
        // Pins
        translate([gap*2, internalBoxD + gap*2, -gap*2])
         rotate([90,0,0])
          #cylinder(h= internalBoxD+ (gap*4), d1=pinsDim + 1.5, d2=pinsDim + 1.5, $fs=0.1);
        
        translate([gap*2 +internalBoxW/2 - 5, internalBoxD + gap*2, -gap*2 - GoProBatteryH/3 + 5])
         rotate([90,0,0])
          #cylinder(h= internalBoxD+ (gap*4), d1=20, d2=20, $fs=0.1);
    }
}

module Test()
{
    color("Blue")
    for (i = [0:nBattery-1]) {
        translate([gap, gap + ( (GoProBatteryD + gap) * i), gap])
        {
            GoProBattery();
        }
    }
}

module GoProBoxCostruction()
{
    union()
    {
        // Costruction 
        difference()
        {
            GoProBox();
            for (i = [0:nBattery-1]) {
                translate([gap, gap + ( (GoProBatteryD + gap) * i), gap])
                {
                #GoProBatterySub();
                }
            }
            
            // Internal
            dim = internalBoxW/1.5;
            translate([internalBoxW/2, internalBoxD - gap, internalBoxH])
            rotate([90,0,0])
             #cylinder(h= internalBoxD - gap*2, d1=dim, d2=dim, $fs=0.1);
        }

        // Pins
        // ----------------------------------------------------------------------------------------------------------------------------
        pinsTrasH = internalBoxH -(pinsDim/2) - (gap*2);
        translate([(pinsDim/2) + gap, -pinsDim/2, pinsTrasH])
         Hemisphere(pinsDim);

        translate([(pinsDim/2) + gap, -pinsDim/2 + internalBoxD, pinsTrasH])
         translate([0, pinsDim,pinsDim])
          rotate([180,0,0])
           Hemisphere(pinsDim);
        
        // Closing
        translate([internalBoxW,internalBoxD/2 - ClosingD/2, internalBoxH - gap*2])
         rotate([90+180,0,0])
          cylinder(h= ClosingD, d1=gap, d2=gap, $fs=0.1);
    }
// ----------------------------------------------------------------------------------------------------------------------------
}

module BoxCostruction()
{
    union()
    {
        difference()
        {
            cube([internalBoxW + gap*2, internalBoxD+ gap*2, internalBoxH+ gap]);
            translate([gap, gap, gap])
            #cube([internalBoxW, internalBoxD, internalBoxH]);
        }
        
        // Pins
        // ----------------------------------------------------------------------------------------------------------------------------
        pinsTrasH = internalBoxH -(pinsDim/2) - (gap*2);
         translate([(pinsDim/2) + gap, -pinsDim/2, pinsTrasH])
          Hemisphere(pinsDim);

        translate([(pinsDim/2) + gap, internalBoxD + gap, pinsTrasH])
         translate([0, pinsDim,pinsDim])
          rotate([180,0,0])
           Hemisphere(pinsDim);
        
        // Closing
        
        translate([internalBoxW + gap*2,internalBoxD/2 - ClosingD/2, internalBoxH - gap*2])
         rotate([90+180,0,0])
          cylinder(h= ClosingD, d1=gap, d2=gap, $fs=0.1);
    }
}

    //BoxCostruction();
    GoProBoxCostruction();
    //Test();

translate([0,-10,gap ])
 rotate([180,0,0])
  Cover ();


