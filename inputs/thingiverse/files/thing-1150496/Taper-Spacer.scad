//Spacer to replace multiple Spacers used with V-Slot Wheels & also create a wider Spacer
// 11/23/2015 By: David Bunch
//

//CUSTOMIZER VARIABLES

//1. Maximum Outside Diameter of Spacer
SpacerMaxOD = 14;

//2. Minimum Outside Diameter of Spacer
SpacerMinOD = 8.8;

//3. Height of Spacer
SpacerTotHt = 8.8;        //My print heights are usually about .3mm higher than specified

//4. Height of Base before Taper
SpacerBaseHt = 2.5;

//3. Diameter of Bolt Hole
M5 = 5.5;

//4. How Many Spacers to print (1,2,3 or 4)
Qty = 4;

//5. Resolution of Spacer
iRes = 72;

TaperHt = SpacerTotHt - SpacerBaseHt;        //Calculate height of Taper
$fn= iRes;

//CUSTOMIZER VARIABLES END

module TaperSpacer(S_ODBig = SpacerMaxOD, S_ODSmall = SpacerMinOD, S_THT = SpacerTotHt, S_BHT = SpacerBaseHt)
{
    color("cyan")
    {
        difference()
        {
            union()
            {
                cylinder(d=S_ODBig,h=S_BHT);
                translate([0,0,S_BHT])
                cylinder(d1=S_ODBig,d2=S_ODSmall,h=S_THT-S_BHT);
            }
            translate([0,0,-.1])
            cylinder(d=M5,h=S_THT+.2);
        }
    }
}
if (Qty == 1)
{
    TaperSpacer();
}
if (Qty > 1)
{
    rotate([0,0,0])
    translate([SpacerMaxOD-3,0,0])
    TaperSpacer();
    rotate([0,0,90])
    translate([SpacerMaxOD-3,0,0])
    TaperSpacer();
    if (Qty > 2)
    {
        rotate([0,0,180])
        translate([SpacerMaxOD-3,0,0])
        TaperSpacer();
        if (Qty > 3)
        {
            rotate([0,0,-90])
            translate([SpacerMaxOD-3,0,0])
            TaperSpacer();
        }
    }
}