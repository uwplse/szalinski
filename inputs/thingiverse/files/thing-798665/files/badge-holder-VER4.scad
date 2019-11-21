//************************************************************************************
//*
//*  This creates a badge holder with a RSA securID in the back
//*
//* The global variables can be edited as required for better resolution, a tighter
//*  or looser fit or a diferent fillet size.
//*
//* Keith Welker 1/13/18 (VERSION 4)
//************************************************************************************
// dimensions (all in mm unless stated otherwise)
//configuration


//a small offset to clear up any cutouts.
DELTA = .001; 

//holder thickness
HT = 1; 

//badge width
badge_W = 58;
//badge length
badge_L = 86;
//badge thickness
badge_T = 1.75; 
//badge corner radius
badge_CR = 3; 
//lanyard hole width
badge_LW = 13; 
//lanyard hole height
badge_LH = 3.25; 
//this is the top thickness between the badge top and lanyard hole
badge_LO = 2.5; 
//window thickness (overlap to hold the badge)
WO = 3; 

//RSA securID
//width (not including end diamter)
securID_W = 22.5;
//leghth (including end diamter)
securID_L = 59;
//cylinder end diameter
securID_D = 27.5;
//thickness of main section
securID_T = 11;
//thickness of cylinder end section
securID_CT = 12;
//width of the LCD (for a cutout)
securID_LCD_W = 8;
//length of the LCD (for a cutout)
securID_LCD_L = 35;

FN = 180;
clearance = 1.5;

holder();

//************************************************************************************
//* this module creates the holder
//************************************************************************************
module holder()
{

    union()
    {
        //the badge holder
        difference()
        {
            // badge holder section 
            badge(badge_L+HT, badge_W+2*HT, badge_T+2*HT, badge_CR*.35);
            // subtract the badge cutout 
            translate([0,HT,HT])
            badge(badge_L, badge_W, badge_T, badge_CR);
            // cleanup the opening 
            translate([-DELTA,HT,HT])
            cube([badge_W, badge_W, badge_T]);
            // subtract the badge window
            os2 = ((badge_W+2*HT)/2)-((badge_W-2*WO)/2);
            translate([WO,os2,-DELTA])
            badge(badge_L-2*WO, badge_W-2*WO, HT+2*DELTA, badge_CR);
            //the lanyard hole
            translate([badge_LO,HT+(badge_W/2)-(badge_LW/2),badge_T+HT-DELTA])
            lanyard_hole(badge_LH, badge_LW, HT+2*DELTA);

         }
        //the SecurID holder
         os3a = (badge_L+HT) - (securID_L+HT);
         os3b = ((badge_W+2*HT)/2)- ((securID_D+2*HT)/2);
         translate([os3a,os3b,badge_T+2*HT])
        difference()
        {
            // SecurID holder section 
            securID(securID_L+HT, securID_W+2*HT, securID_D+2*HT, securID_T+HT, securID_CT+HT);    
            // subtract the SecurID cutout 
            translate([0,HT,-DELTA])
            securID(securID_L, securID_W, securID_D, securID_T, securID_CT);
            //cleanup the cutout (to avoid using the dremel)
            translate([0,HT,0])
            cube([securID_D/2,securID_D-clearance,securID_CT]);
            // subtract the LCD window
            os4 = ((securID_D+2*HT)/2)-(securID_LCD_W/2); //
            translate([securID_L-securID_LCD_L,os4,securID_T-HT])
            cube([securID_LCD_L,securID_LCD_W,2*HT+abs(securID_CT-securID_T)+2*DELTA]);
        }
            
    }
}



//************************************************************************************
//* this module creates the badge, SecurID, and lanyard
//************************************************************************************
module parts()
{

    badge_W_lanyard(badge_L, badge_W, badge_T, badge_CR, badge_LH, badge_LW, badge_LO);
        
    offset1 = lan_D+ badge_T; //(badge_L/2) - (securID_L-(badge_L/2));
    translate([offset1,(badge_W/2)-securID_D/2,badge_T*2])
    securID(securID_L, securID_W, securID_D, securID_T, securID_CT);    

    translate([0,(badge_W/2)-lan_D/2,badge_T*2])
    lanyard(lan_D, lan_T);

}

//************************************************************************************
//* this module creates the lanyard
//************************************************************************************
module lanyard(diameter, thk)
{
    radius = diameter/2;
    translate([(radius),radius,0])
    cylinder(thk, r=radius, $fn = FN);
    
}
//************************************************************************************
//* this module creates the badge with the lanyard cutout
//************************************************************************************
module securID(l, w, diameter, thk_m, thk_cyl)
{
    radius = diameter/2;
    union()
    {
        //Create the main section
        translate([(radius),radius-w/2,0])
        cube([l-radius, w, thk_m]);
        //Create the cylinder section
        translate([(radius),radius,0])
        cylinder(thk_cyl, r=radius, $fn = FN);

    }
}

//************************************************************************************
//* this module creates the badge (to use for diference in the holder module)
//************************************************************************************
module badge(l, w, thk, radius)
{

    //Create the badge
    union()
    {
        //fill the main section of the badge
        translate([(radius),0,0])
        cube([l-(2*radius), w, thk]);
        //fill between the top cylinders
        translate([0,radius,0])
        cube([2*radius, w-(2*radius), thk]);
        //fill between the bottom cylinders
        translate([l-2*radius,radius,0])
        cube([2*radius, w-(2*radius), thk]);
        //the top cylinders
        translate([(radius),radius,0])
        cylinder(thk, r=radius, $fn = FN);
        translate([(radius),w-radius,0])
        cylinder(thk, r=radius, $fn = FN);
        //the bottom cylinders
        translate([(l-radius),radius,0])
        cylinder(thk, r=radius, $fn = FN);
        translate([(l-radius),w-radius,0])
        cylinder(thk, r=radius, $fn = FN);
    }

}


//************************************************************************************
//* this module creates the lanyard hole (to use for diference)
//************************************************************************************
module lanyard_hole(h, w, thk)
{

    radius = h/2; //full fillet on each corner
    //Create the badge
    union()
    {
        //fill the main section of the hole
        translate([0,radius,0])
        cube([h, w-(2*radius), thk]);
        //the cylinders
        translate([radius,radius,0])
        cylinder(thk, r=radius, $fn = FN);
        translate([radius,w-radius,0])
        cylinder(thk, r=radius, $fn = FN);

    }

}

//************************************************************************************
//* this module creates the badge with the lanyard cutout
//************************************************************************************
module badge_W_lanyard(l, w, thk, radius, lh, lw, os)
{
    difference()
    {
        //Create the badge first
        badge(l, w, thk, radius);
        //then subtract off the lanyard hole
        translate([os,(w/2)-lw/2,0])
        lanyard_hole(lh,lw,thk, os);
    }
}