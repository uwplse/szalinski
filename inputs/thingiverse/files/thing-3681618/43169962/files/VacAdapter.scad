// version 2
// brian palmer, June 2019
// built in 3 parts. side a, adapter ring, and side b
// ID measurement type creates a female adapter, OD measurement creates a male adapter.
// Providing a taper value add a taper to make a press fit adapter. The direction of the taper is automatically adjusted depending on the gender of the adapter.

$fn=100;

/* [Side A] */
// side a (in mm) default 38.1 - 1.5" OD
sideADiameter=38.1; 
sideADiameterType="OD"; // [ID: ID - Female,OD: OD - Male]
// amount to taper side a. default is .25. 0 = no taper
sideATaper=.25;

/* [Side B] */
// side b (in mm) default 50.8 mm - 2" ID
sideBDiameter=50.8; 

sideBDiameterType="ID"; // [ID: ID - Female,OD: OD - Male]
// amount to taper side b. default is .25. 0 = no taper
sideBTaper=.25; 

/* [Wall] */
wallWidth=8;

/* [Overall Length] */
// Control length of adapter. (sideADiameter OD * overallLength)
overallAdjuster=1.5;

if (sideADiameterType == "ID")
{
   if (sideBDiameterType == "ID")
   {
       // ID, ID
       vacAdapter(sideADiameter + wallWidth, sideATaper, sideBDiameter + wallWidth, sideBTaper, wallWidth);
   } else {
       // ID, OD
       vacAdapter(sideADiameter + wallWidth, sideATaper, sideBDiameter, -sideBTaper, wallWidth);
   }
} else  {
   if (sideBDiameterType == "ID")
   {
       // OD, ID
       vacAdapter(sideADiameter, -sideATaper, sideBDiameter + wallWidth, sideBTaper, wallWidth);
   } else {
       // OD, OD
       vacAdapter(sideADiameter, -sideATaper, sideBDiameter, -sideBTaper, wallWidth);
   }
} 

module vacAdapter(sideADiameterOD, sideATaperAdjustment, sideBDiameterOD, sideBTaperAdjustment,wallWidth)
{
    colarLen = sideADiameterOD * (overallAdjuster/3);

    difference() {
        // outside wall
        adapter(sideADiameterOD, sideATaperAdjustment, sideBDiameterOD, sideBTaperAdjustment, colarLen);
        // inside wall
        adapter(sideADiameterOD-wallWidth, sideATaperAdjustment, sideBDiameterOD-wallWidth, sideBTaperAdjustment, colarLen);
    }
}

module adapter(sideADiameterOD, sideADiameterTaperAdjustment, sideBDiameterOD, sideBDiameterTaperAdjustment, colarLen) 
{
    union() {
        // side a
        cylinder(h=colarLen, d1=sideADiameterOD+sideADiameterTaperAdjustment, d2=sideADiameterOD-sideADiameterTaperAdjustment, center=false);
                
        translate([0,0,colarLen]) {
            // adapter ring
            cylinder(h=colarLen, d1=sideADiameterOD-sideADiameterTaperAdjustment, d2=sideBDiameterOD-sideBDiameterTaperAdjustment, center=false);
            translate([0,0,colarLen]) {
                // side b
                cylinder(h=colarLen, d1=sideBDiameterOD-sideBDiameterTaperAdjustment, d2=sideBDiameterOD+sideBDiameterTaperAdjustment, center=false);
            }        
        }
    }
}