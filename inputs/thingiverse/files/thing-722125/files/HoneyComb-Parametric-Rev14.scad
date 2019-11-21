//Draw a Honeycomb grid based on 8 variables
//By: David Bunch 3/12/15

//Made more customizable 8/24/2016

//1. Face to Face Inside Distance of Honeycomb
ID = 10;            //Diameter from Face to Face or inscribed circle

//2. Total Height of Honeycomb
Ht = 20;            //Height of Outside of Honeycomb
                    //Height inside will be = Ht-Thk

//3. Thickness of wall between Honeycombs
W_Thk = 1.6;        //Thickness of Walls

//4. Thickness of Base of Honeycomb
B_Thk = 1.5;        //Thicknes of Base

//5. Number of Rows of Honeycomb
Rows = 5;           //[1:20]

//6. Number of Columns of Honeycomb
Cols = 4;           //[1:20]

//7. Honeycomb Pattern Style
P_Style = 0;        //[0:2]
                    //0= Every other row has 1 less Containers
                    //1 = Every other row has same number of containers
                    //2 = Every other row has 1 more container
//8. Open Tray (Only works with P_Style = 0)
Open_Tray = 0;           //[0:1]
                    
/* [Hidden] */

W_Thk2 = W_Thk / 2;                 //Half the Wall Thickness
OD_Face = ID + W_Thk + W_Thk;       //Outside Face to Face Dimension
OD_Face2 = OD_Face / 2;             //Half Outside Face to Face Dimension
Face2 = tan(30) * OD_Face2;
Yoffset = (OD_Face2 - W_Thk2) / tan(30);  //Y distance between Hex in Next Row
Xoffset = OD_Face2 - W_Thk2;        //X distance between Hex in Next Row
Rad = OD_Face2 / cos(30);           //Radius of Outside Face Width
RadID = (ID / 2) / cos(30);         //Radius of Inside Face Width
RadID2 = RadID / 2;
OD_W = (W_Thk * 2) / cos(30);       //Diameter of Wall Thickness
Rad_W = OD_W / 2;                   //Radius of Wall Thickness
Rad_W2 = Rad_W / 2;                 //Half the Radius Wall Thickness
X_Space = Xoffset * 2;
LenCut = (Cols - 1) * X_Space;
WidCut = (Rows) * Yoffset - W_Thk - RadID2;

echo(ID = ID);
echo(Ht = Ht);
echo(W_Thk = W_Thk);
echo(B_Thk = B_Thk);
echo(Rows = Rows);
echo(Cols = Cols);
echo(OD_Face = OD_Face);
echo(OD_Face2 = OD_Face2);
echo(Face2 = Face2);
echo(Xoffset = Xoffset);
echo(Yoffset = Yoffset);
echo(Rad = Rad);
echo(RadID = RadID);
echo(RadID2 = RadID2);
echo(OD_W = OD_W);
echo(Rad_W = Rad_W);
echo(WidCut = WidCut);
module Hex()
{
    rotate([0,0,30])
    difference()
    {
        cylinder(d=Rad*2,h=Ht,$fn=6);
        if (B_Thk > 0)
        {
            translate([0,0,B_Thk])
            cylinder(d=RadID * 2,h=Ht+2,$fn=6);
        } else
        {
            translate([0,0,-1])
            cylinder(d=RadID * 2,h=Ht + 2,$fn=6);
        }
    }
}
module WallHex()
{
    rotate([0,0,30])
    cylinder(d=OD_W,h=Ht + 2,$fn=6);
}
module HexRowCol()
{
    for (j=[0:Rows - 1])
    {
        A_Odd = j % 2;
        translate([(j % 2) * Xoffset,j * Yoffset,0])
        {
            if (P_Style == 2 && A_Odd == 1)
            {
                translate([-X_Space,0,0])
                Hex();              //Add extra hex to the left on Odd Rows
            }
            for (i=[0:Cols - 1])
            {
                translate([X_Space * i,0,0])
                Hex();
            }
        }
    }
}
module HexRowCol0()
{
    for (j=[0:Rows - 1])
    {
        A_Odd = j % 2;
        //echo(A_Odd = A_Odd);
        translate([(j % 2) * Xoffset,j * Yoffset,0])
        for (i=[0:Cols - 1])
        {
            if (j%2 == 0)
            {
                translate([X_Space * i,0,0])
                Hex();
            } else {
                if (i != (Cols - 1))
                {
                    translate([X_Space * i,0,0])
                    Hex();
                } 
            }
        }
    } 
}
module TrayCut()
{
    for (j=[0:Rows - 1])
    {
        A_Odd = j % 2;
        translate([(j % 2) * Xoffset,j * Yoffset,0])
        {
            if (A_Odd == 0)
            {
                if (j == 0)
                {
                    translate([0,-RadID2,B_Thk])
                    cube([LenCut,RadID + RadID2,Ht + 2]);
                } else  if (j == (Rows - 1))
                {
                    translate([0,-RadID,B_Thk])
                    cube([LenCut,RadID + RadID2,Ht + 2]);
                } else
                {
                    translate([0,-RadID,B_Thk])
                    cube([LenCut,RadID + RadID,Ht + 2]);
                }
                if (j < (Rows - 1))
                {
                translate([W_Thk,RadID - Rad_W2,B_Thk])
                WallHex();                 //Top Left Cleanup of this Row
                translate([LenCut - W_Thk,RadID - Rad_W2,B_Thk])
                WallHex();                 //Top Right Cleanup of this Row
                }
            } else
            {
                translate([W_Thk2 - Xoffset,RadID - Rad_W2 + W_Thk2,B_Thk])
                WallHex();      //Bottom Left cleanup of this Row
            
                translate([LenCut - W_Thk2 - Xoffset,RadID - Rad_W2 + W_Thk2,B_Thk])
                WallHex();      //Bottom Right cleanup of this Row
            }
        }
    } 
    translate([W_Thk2,-RadID2,B_Thk])
    cube([LenCut - W_Thk,WidCut,Ht + 2]);
}
difference()
{
    if (P_Style == 0)
    {
        HexRowCol0();

    } else
    {
        HexRowCol();
    }
    if (P_Style == 0 && Open_Tray == 1)
    {
        TrayCut();
    }
//Uncomment the next 2 lines to cut section thru 1st Hex
//    translate([-ID,-ID,-1])
//    cube([ID,ID,Ht + 2]);
}