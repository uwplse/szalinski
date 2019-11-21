//Customizable Funnel
//8/31/2016     By: David Bunch
//
//1. Outside Diameter of Big Part of Funnel
Big_OD = 70;    //[12:1:200]

//2. Height of Big Part of Funnel before Flare
Big_Ht = 5;     //[0:1:50]

//3. Thickness of Funnel
Thk = 1.65;         //[1:.1:5]

//4. Flare Angle of Big Part of Funnel
Big_Ang = 45;   //[30:1:80]

//5. Outside Diameter of Small Part of Funnel
Small_OD = 22;    //[6:1:100]

//6. Height of Small Part of Funnel
Small_Ht = 26;     //[6:1:50]

//7. Small Flared Angle (75 to 90 degress)
Small_Ang = 85;   //[75:1:90]

//8. Resolution of Funnel 
Ires = 32;           //[4:2:72]

//9. Draw Eyelet to hang Funnel from (yes, or no)
Draw_Eye = "yes";  //[yes,no]

//10. Outside Diameter of Eyelet
Eye_OD = 11;       //[7:1:20]

//11. Inside Diameter of Eyelet
Eye_ID = 7;        //[1:1:18]

//12. Height of Eyelet Hanger
Eye_Ht = 2;        //[.1:.1:3]

//13. How Thick to draw a Lip around Print Base of Funnel
Lip_Thk = 2;        //[0:.5:20]

//14. How High is the Lip
Lip_Ht = 2;         //[.5:.5:6]

/* [Hidden] */

Small_Thk = Thk;       //Thickness at Bottom smaller part can be different from Top
                                        //Generally the same as Thk, but you can change it
Lip_OD = Big_OD + (2 * Lip_Thk);        //Diameter including the Lip Width
Lip_Rad = Lip_OD / 2;                   //Radius of Lip
Big_OD1 = Big_OD - (Thk * 2);       //Only used if Big_Ht > 0
Big_Rad = Big_OD / 2;               //Radius of Top Part of Funnel
Small_Rad = Small_OD / 2;           //Radius of Bottom Part of Funnel
Small_ID = Small_OD - (Small_Thk * 2);    //Inside Diameter of Smallest part of Funnel
Fun_TopHt = (Big_Rad - Small_Rad) * tan(Big_Ang);     //Height of Funnel Top to Center Line
Fun_Thk = Thk / sin(Big_Ang);       //Funnel Thickness based on Angle used
                                    //Need this to calculate actual Inside Diameters of flared part
Fun_Top_ID = Big_OD - (Fun_Thk * 2);        //Inside Diameter of Big part of Funnel
Fun_Top_ID1 = Small_OD - (Fun_Thk * 2);
Bot_Fun_90Ang = 90 - Small_Ang;             //Need smaller Angle
Bot_Fun_Thk = Small_Thk / cos(Bot_Fun_90Ang);
Bot_Fun_ID = Small_OD - (Bot_Fun_Thk * 2);      //Lower flared portion of Funnel Inside Diameter

Tot_Ht = Fun_TopHt + Small_Ht + Big_Ht;     //Total Height of Funnel
//            cylinder(d1=Fun_Top_ID,d2=Bot_Fun_ID,h=Fun_TopHt+.01);
Bot_Flare_Dist = Small_Ht * tan(Bot_Fun_90Ang);
Bot_Fun_OD1 = Small_OD - (Bot_Flare_Dist * 2);
Bot_Fun_ID1 = Bot_Fun_OD1 - (2 * Bot_Fun_Thk);

echo(Bot_Fun_Thk = Bot_Fun_Thk);
echo(Fun_TopHt = Fun_TopHt);
echo(Fun_Thk = Fun_Thk);
echo(Fun_Top_ID = Fun_Top_ID);

echo(Tot_Ht = Tot_Ht);
echo(Bot_Fun_90Ang = Bot_Fun_90Ang);
echo(Bot_Flare_Dist = Bot_Flare_Dist);
echo(Bot_Fun_OD1 = Bot_Fun_OD1);
echo(Bot_Fun_ID = Bot_Fun_ID);
echo(Bot_Fun_ID1 = Bot_Fun_ID1);
Big_OD_Res = (round(((Big_OD * 3.14)/4) / 1.0)*4);  //about 1.0mm segments
Eye_OD_Res = (round(((Eye_OD * 3.14)/4) / .7)*4);
echo(Big_OD_Res = Big_OD_Res);
$fn=Ires;               //Set Resolution so we do not need to add it to cylinder()'s
//$fn = Big_OD_Res;       //If you prefer about 1mm resolution on segments, uncomment this

module DrawFunnel()
{
    difference()
    {
        union()
        {
            if (Big_Ht > 0)
            {
                cylinder(d=Big_OD,h=Big_Ht);
            }
//Flared Outside Big part of Funnel
            translate([0,0,Big_Ht])
            cylinder(d1=Big_OD,d2=Small_OD,h=Fun_TopHt);
//Flared or Straight Small part of Funnel
            translate([0,0,Fun_TopHt+Big_Ht])
            cylinder(d1=Small_OD,d2=Bot_Fun_OD1,h=Small_Ht);     
            if (Draw_Eye == "yes")
            {
                translate([(Lip_Rad + (Eye_ID/2)),0,0])
                difference()
                {
                    cylinder(d=Eye_OD,h=Eye_Ht,$fn=Eye_OD_Res);
                    translate([0,0,-1])
                    cylinder(d=Eye_ID,h=Eye_Ht+2,$fn=Eye_OD_Res);
                }
            }
//See if we need to draw a lip around the Funnel
            if (Lip_Thk > 0)
            {
                cylinder(d=Lip_OD,h=Lip_Ht);
            }
        }
        if (Big_Ht > 0)
        {
            translate([0,0,-1])
            cylinder(d1=Big_OD1,d2=Fun_Top_ID,h=Big_Ht+1.01);
            translate([0,0,Big_Ht])
            cylinder(d1=Fun_Top_ID,d2=Fun_Top_ID1,h=Fun_TopHt+.01);
        } else
        {
            translate([0,0,Big_Ht-.01])
            cylinder(d1=Fun_Top_ID,d2=Bot_Fun_ID,h=Fun_TopHt+.01);
        }
        if (Small_Ang > 0)
        {
            translate([0,0,Big_Ht+Fun_TopHt-10])
            cylinder(d=Bot_Fun_ID,h=10);     //Flared cut small part of Funnel
            translate([0,0,Big_Ht+Fun_TopHt-.01])
            cylinder(d1=Bot_Fun_ID,d2=Bot_Fun_ID1,h=Small_Ht);     //Flared cut small part of Funnel
            translate([0,0,-1])
            cylinder(d=Bot_Fun_ID1,h=Tot_Ht+2);
        } else
        {
            translate([0,0,-1])
            cylinder(d=Small_ID,h=Tot_Ht+2);
        }
//        translate([-Big_OD,0,-1])
//        cube([Big_OD*2,Big_OD,Tot_Ht+2]);       //Cross section to see Thickness width
    }
}
DrawFunnel();
//%cylinder(d=Big_OD,h=Tot_Ht);     //Check Total Height