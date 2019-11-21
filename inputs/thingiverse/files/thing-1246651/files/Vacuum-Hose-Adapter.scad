//FollyMaker
//Vacuum Hose Adapter Beta 0.2 Testing
//Gather the parameters
/* [Parameters] */

//--Example is ShopVac Nominal 2.5" machine port to 1.5" accessory.  -- For the large end, is the measurement the adapter's outside or inside diameter?
LargeEndMeasured = "outside"; //[outside, inside]
//Diameter of Large End? (mm)
LargeEndDiameter = 40;
// Length of Large End? (mm)
LargeEndLength = 15;
//For the small end, is the measurement the adapter's outside or inside diameter?
SmallEndMeasured = "outside"; //[outside, inside]
//Diameter of Small End? (mm)
SmallEndDiameter = 17;
// Length of Small End? (mm)
SmallEndLength = 25;
// Length of Taper Section? (mm)
TaperLength = 25;
 // Create an Inside Stop at the lower end of smaller end of this adapter? (To keep the connected fitting from being sucked in.)
 InsideStop= "no"; //[no,yes]
 //What is the thickness of the adapter's walls?
 WallThickness = 1.4;
 
 $fn=60 *1;
 
     WT=WallThickness;
     LL=LargeEndLength;
     SL=SmallEndLength;
     TL=TaperLength;
     
     LD=  LargeEndMeasured =="inside" ? LargeEndDiameter + 2*WT : LargeEndDiameter;
     SD=  SmallEndMeasured =="inside" ? SmallEndDiameter + 2*WT : SmallEndDiameter;
     LID=  LargeEndMeasured =="inside" ? LD : LD - 2*WT;
     SID=  SmallEndMeasured =="inside" ? SD : SD - 2*WT;
     LID = LD - 2*WT;
     SID = SD - 2*WT;
     DR = LD + 3*WT;
     
 
module TransCylinder(D1, D2, H, Z)
    {
        translate([0, 0, Z])
        {
            cylinder(d1=D1, d2=D2, h=H, center=false);
        }
    }
   
difference()
{
      union()
        { 
            TransCylinder(LD, LD, LL, 0);
            TransCylinder(LD, DR, WT, LL);
            TransCylinder(DR, DR, WT, LL + WT);
            TransCylinder(LD, SD, TL, LL + 2*WT);
            TransCylinder(SD, SD, SL, LL + TL + 2*WT);
          } 
     union()
        {
            TransCylinder(LID, LID, LL, 0);
            TransCylinder(LID, LID, WT, LL);
            TransCylinder(LID, LID,  WT, LL + WT);
            TransCylinder(LID, SID, TL, LL + 2*WT);
            if (InsideStop=="yes")
                {
                TransCylinder(SID, SID-(2*WT), WT, LL +TL + 2*WT);
                TransCylinder(SID, SID, SL, LL +TL + 3*WT);
                    }
                else
                    {          
                    TransCylinder(SID, SID, SL, LL +TL + 2*WT);
                    }
        }
}   