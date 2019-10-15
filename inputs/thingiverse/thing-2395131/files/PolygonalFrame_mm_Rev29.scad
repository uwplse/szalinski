//Polygonal Picture Frame based on Moulding Profile
//DXF Profiles used from this source:
//http://www.hornermillwork.com/cad-library/mouldings
//
//Openscad File created by: David Bunch 6/16/2017
//
/* [Main Variables] */
//A_Type = [108,211,260,3974,3975];
// Type of Frame to Use (DXF files will not work with Customizer)
//Type = -1;       //[-1:Custom,0:N-108.dxf,1:N-211.dxf,2:N-260.dxf,3:N-3974.dxf,4:N-3975]

//1. Units (mm or Inches)
Units = 1;          //[1:mm,25.4:inches]

//2. Number of Sides of Polygon
Sides = 8;          //[2:1:48]
                    //If less than 3 sides, it will draw only 1 Moulding without miter cuts
//3. Length of the outside Mitered side
Ln = 100;                   //[10:2:500]

//4. Optional Base Thickness
B_Thick = 0;     //[0:.5:12]

//5. Default Facet Resolution
I_Res = 24;         //[4:4:96]

/* [Rabbit Cuts] */

//6. Add Rabbit Cut 
Rabbit_Cut_On = 1;      //[0:No,1:Yes]

//7. Width of Rabbit Cut
Rab_Cut_Wid = 6;     //[.5:.5:20]

//8. Depth of Rabbit Cut
Rab_Cut_Depth = 4;   //[.5:.5:20]

//9. Chamfer Top 45 degrees for 3d Printing
Rabbit_Chamfer_ON = 0;  //[0:No,1:Yes]

// -------------------------------------------
// Prefix variables Pr_ are used if Type = -1
// -------------------------------------------

/* [Custom Profiles] */

//10. Width of Profile
Pr_Wi = 38.0;          //[10:1:80]

//11. Thickness of Profile
Pr_Th = 19.0;         //[2:1:50]

/* [Custom Outside Edge Cut] */

//12. Outside Edge Cut (0=None, -1 = Rounded or # of Facets)
Pr_Out_Edge = -1;       //[-1:1:48]
                        //-1 = Rounded Top Edge instead of Chamfer of Fillet Cut

//13. Outside Edge Radius Cut
Pr_O_Rad = 6.4;       //[6.4:.2:16]

//14. Depth of Outside Edge Cut
Pr_O_Depth = 6.4;     //[0:.2:16]

/* [Custom Inside Edge Cut] */

//15. Inside Edge Cut (0=None, -1 = Rounded or # of Facets)
Pr_In_Edge = 4;         //[-1:1:48]
                        //-1 = Rounded Top Edge instead of Chamfer of Fillet Cut

//16. Inside Edge Radius Cut
Pr_I_Rad = 6.4;        //[6.4:.2:16]

//17. Depth of Outside Edge Cut
Pr_I_Depth = 6.4;        //[0:.2:16]

/* [Custom Center Cut] */

//18. Center Cut (0=None or # of Facets)
Pr_Cen = 0;            //[0:1:48]

//19. Inside Edge Radius Cut
Pr_Ce_Rad = 6.4;       //[6.4:.2:16]

//20. Depth of Center Cut
Pr_Ce_Depth = 4;       //[0:.5:12]

/* [Custom Middle towards Outside Cut] */

//21. Between Center & Outside Edge (0=None or # of Facets)
Pr_Mid_Out = 0;         //[0:1:48]
                        //# = Number of facets on Cuts

//22. Middle to Outside Edge Radius Cut
Pr_Mid_O_Rad = 3.2;   //[3.2:.2:12]

//23. Depth of Middle to Outside Edge Cut
Pr_Mid_O_Depth = 1;   //[0:.5:12]

//24. Offset from Center line of Moulding towards Outside Edge
Pr_Mid_O_Offset = 12; //[1:1:40]

/* [Custom Middle towards Inside Cut] */

//25. Between Center & Inside Edge (0=None # of Facets)
Pr_Mid_In = 0;          //[0:1:48]
                        //# = Number of facets on Cuts

//26. Middle to Inside Edge Radius Cut
Pr_Mid_I_Rad = 3.2;    //[3.2:.2:12]  

//27. Depth of Middle to Inside Edge Cut
Pr_Mid_I_Depth = 1;    //[0:.5:12]

//28. Offset from Center line of Moulding towards Inside Edge
Pr_Mid_I_Offset = 10;  //[1:1:40]

/* [Custom Cut along Miter Joint] */

//29. Cut Along Miter Edge (0=None # of Facets)
Pr_Miter_Edge = 0;      //[0:1:48]
                        //# = Number of facets on Cuts

//30. Miter Edge Radius Cut 
Pr_Mit_Rad = 12;      //[6:1:32]  

//31. Depth of Miter Edge Cut
Pr_Mit_Depth = 2;     //[0:.5:12]

//32. Depth of Miter Edge Cut
Pr_Mit_Cut_Len = 200;   //[100:20:400]
// -------------------------------------------

/* [Hidden] */
Type = -1;       //[-1:Custom,0:N-108.dxf,1:N-211.dxf,2:N-260.dxf,3:N-3974.dxf,4:N-3975]
Len = Ln / Units;
Base_Thick = B_Thick / Units;

Rabbit_Cut_Wid = Rab_Cut_Wid / Units;
Rabbit_Cut_Depth = Rab_Cut_Depth / Units;

Pr_Wid = Pr_Wi / Units;
Pr_Thk = Pr_Th / Units;

Pr_Out_Rad = Pr_O_Rad / Units;
Pr_Out_Depth = Pr_O_Depth / Units;

Pr_In_Rad = Pr_I_Rad / Units;
Pr_In_Depth = Pr_I_Depth / Units;

Pr_Mid_Out_Rad = Pr_Mid_O_Rad / Units;
Pr_Mid_Out_Depth = Pr_Mid_O_Depth / Units;
Pr_Mid_Out_Offset = Pr_Mid_O_Offset / Units;

Pr_Cen_Rad = Pr_Ce_Rad / Units;
Pr_Cen_Depth = Pr_Ce_Depth / Units;

Pr_Mid_In_Rad = Pr_Mid_I_Rad / Units;
Pr_Mid_In_Depth = Pr_Mid_I_Depth / Units;
Pr_Mid_In_Offset = Pr_Mid_I_Offset / Units;

Pr_Miter_Rad = Pr_Mit_Rad / Units; 
Pr_Miter_Depth = Pr_Mit_Depth / Units;
Pr_Miter_Cut_Len = Pr_Mit_Cut_Len / Units;
Pr_Miter_Cut_Len = Pr_Mit_Cut_Len / Units;

//Used for Cutting the tops of the Miter joints
Max_Pr_Wid = 200;       //Maximum Width of Profiles
Max_Pr_Thk = 200;       //Maximum Thickness of Profiles

Ang1 = 360 / Sides;
Ang2 = Ang1 / 2;
Ang3 = 90 - Ang2;

Len2 = Len / 2;
Wid2 = Len2 / tan(Ang2);

Rad = Len2 / cos(Ang3);         //Radius of Overall Frame
OD = Rad * 2;                   //Diameter of Overall Frame

Pr_Out_OD = Pr_Out_Rad * 2;     //Outer Edge Profile Cut Diameter
Pr_In_OD = Pr_In_Rad * 2;       //Inner Edge Profile Cut Diameter

//Array of numbered Profiles
A_Type = [108,211,260,3974,3975];
//These are the corresponding Widths of the A_Type profiles
A_Width = [15.875,63.5,32.5438,38.0162,15.1555];

DXF_Name = str("N-",A_Type[abs(Type)],".dxf");
echo(Wid2 = Wid2);
echo(Sides = Sides);
echo(Rad = Rad);
echo(Ang1 = Ang1);
echo(Ang2 = Ang2);
echo(Ang3 = Ang3);
echo(Len2 = Len2);
echo(Type = Type);
echo(DXF_Name = DXF_Name);
$fn = I_Res;

module Moulding()
{
    if (Type != -1)
    {
        translate([0,-Wid2,0])
//Orient Moulding along X-Axis initially
        difference()
        {
            rotate([0,90,0])
            rotate([0,0,90])
            linear_extrude(height = Len, center = true, convexity = 10)
            import(DXF_Name);
            M_Cuts();
            Miter_Cut();
        }
    } else
    {
        translate([0,-Wid2,0])
//Orient Moulding along X-Axis initially
        difference()
        {
            rotate([0,90,0])
            rotate([0,0,90])
            translate([0,0,-Len2])
            cube([Pr_Wid,Pr_Thk,Len]);

            M_Cuts();
            Out_Edge();
            Center_Cut();
            In_Edge();
            Mid_Out_Cut();
            Mid_In_Cut();
            Miter_Cut();
//            translate([10,0,0])
//            {
//                %M_Cuts();
//                %Out_Edge();
//                %Center_Cut();
//                %In_Edge();
//                %Mid_Out_Cut();
//                %Mid_In_Cut();
//            }
        }
    }
}
module M_Cuts()
{

//Only Miter cut if Sides are at least 3 sides
    if (Sides > 2)
    {
        for (m = [0,1])
        {
            mirror([m,0,0])
            translate([-Len2,0,-1])
            rotate([0,0,Ang3])
            cube([Len,Max_Pr_Wid,Max_Pr_Thk]);
        }
    }
    if (Rabbit_Cut_On == 1)
    {
        if (Type == -1)
        {
            Rab_Y_Offset = Pr_Wid - Rabbit_Cut_Wid;
            translate([-Len2-1,Rab_Y_Offset,-1])
            cube([Len + 2,Pr_Wid,Rabbit_Cut_Depth + 1]);
            if (Rabbit_Chamfer_ON == 1)
            {
                translate([0,Pr_Wid,Rabbit_Cut_Depth])
                rotate([0,90,0])
                cylinder(d=Rabbit_Cut_Wid * 2,h = Len + 1,center=true,$fn=4);
            }
        } else
        {
            Profile_Wid = A_Width[Type] / Units;
            echo(Profile_Wid = Profile_Wid);
            Rab_Y_Offset = Profile_Wid - Rabbit_Cut_Wid;
            translate([-Len2 - 1,Rab_Y_Offset,-1])
            cube([Len + 2,Profile_Wid,Rabbit_Cut_Depth + 1]);
            if (Rabbit_Chamfer_ON == 1)
            {
                translate([0,Profile_Wid,Rabbit_Cut_Depth])
                rotate([0,90,0])
                cylinder(d=Rabbit_Cut_Wid * 2,h = Len + 1,center=true,$fn=4);
            }
        }
    }
}
module In_M_Cuts()
{
    for (m = [0,1])
    {
        mirror([m,0,0])
        translate([-Len2-.01,0,-1])
        rotate([0,0,Ang3])
        cube([Len+.02,Max_Pr_Wid,Max_Pr_Thk]);
    }
}
module Out_Edge()
{
    if (Pr_Out_Edge > 0)
    {
        translate([0,0,Pr_Thk + Pr_Out_Rad - Pr_Out_Depth])
        rotate([0,90,0])
        cylinder(d=Pr_Out_OD,h=Len+2,center=true,$fn=Pr_Out_Edge);
    } else if (Pr_Out_Edge == -1)
    {
        translate([0,0,Pr_Thk + Pr_Out_Rad - Pr_Out_Depth])
        rotate([0,90,0])
        translate([-Pr_Out_Rad,-Pr_Out_Rad,0])
        difference()
        {
            translate([0,0,-Len2-1])
            cube([Pr_Out_OD,Pr_Out_OD,Len+2]);
            translate([Pr_Out_OD,Pr_Out_OD,0])
            cylinder(d=Pr_Out_OD,h=Len+4,center=true);
        }        
    }
}
module In_Edge()
{
    if (Pr_In_Edge > 0)
    {
        difference()
        {
            translate([0,Pr_Wid,Pr_Thk + Pr_Out_Rad - Pr_In_Depth])
            rotate([0,90,0])
            cylinder(d=Pr_In_Rad * 2,h=Len+2,center=true,$fn=Pr_In_Edge);
        }
    } else if (Pr_In_Edge == -1)
    {
        translate([0,Pr_Wid,Pr_Thk + Pr_In_Rad - Pr_In_Depth])
        rotate([0,90,0])
        translate([-Pr_In_Rad,-Pr_In_Rad,0])
        difference()
        {
            translate([0,0,-Len2-1])
            cube([Pr_In_OD,Pr_In_OD,Len+2]);
            translate([Pr_In_OD,0,0])
            cylinder(d=Pr_In_OD,h=Len+4,center=true);
        } 
    }
}
module Radius_Cut(P_Rad = Pr_Cen_Rad, P_Depth = Pr_Cen_Depth, P_Res = Pr_Cen, M_Ht = Len)
{
    if (P_Res > 0)
    {
        rotate([0,90,0])
        rotate([0,0,90])
        translate([0,P_Rad,0])
        {
            linear_extrude(height = M_Ht + 1, center = true, convexity = 10)
            translate([-P_Rad,0,0])
            square(P_Rad * 2,false);
            linear_extrude(height = M_Ht + 1, center = true, convexity = 10)
            circle(d=P_Rad * 2, $fn=P_Res);
        }
    }
}
//Cutout along center of Profile
module Center_Cut()
{
    if (Pr_Cen > 0)
    {
        translate([0,Pr_Wid/2,Pr_Thk - Pr_Cen_Depth])
        Radius_Cut(Pr_Cen_Rad,Pr_Cen_Depth,Pr_Cen);
    }
}
//Cutout between Center of Profile & Outside Edge
module Mid_Out_Cut()
{
    if (Pr_Mid_Out > 0)
    {
        translate([0,(Pr_Wid / 2) - Pr_Mid_Out_Offset,Pr_Thk - Pr_Mid_Out_Depth])
        Radius_Cut(Pr_Mid_Out_Rad,Pr_Mid_Out_Depth,Pr_Mid_Out);
    }
}
//Cutout between Center of Profile & Inside Edge
module Mid_In_Cut()
{
    if (Pr_Mid_In > 0)
    {
        translate([0,(Pr_Wid / 2) + Pr_Mid_In_Offset,Pr_Thk - Pr_Mid_In_Depth])
        Radius_Cut(Pr_Mid_In_Rad,Pr_Mid_In_Depth,Pr_Mid_In);
    }
}
//Cutout along the miter joints
module Miter_Cut()
{
    if (Pr_Miter_Edge > 0)
    {
        if (Sides > 2)
        {
            for (m = [0,1])
            {
                mirror([m,0,0])
                translate([-Len2,0,Pr_Thk - Pr_Miter_Depth])
                rotate([0,0,Ang3])
                Radius_Cut(Pr_Miter_Rad,Pr_Miter_Depth,Pr_Miter_Edge,Pr_Miter_Cut_Len);
            }
        }
    }
}
module DrawFinal()
{
    if (Sides < 3)
    {
        Moulding();     //Only draw one moulding
    } else
    {
        union()
        {
//Create all the segmented sides
            for (a = [0:Sides - 1])
            {
                rotate([0,0,a * Ang1])
                Moulding();
            }
            if (Base_Thick != 0)
            {
                rotate([0,0,-(90 + Ang2)])
                cylinder(d=OD,h=Base_Thick,$fn=Sides);
            }
        }
    }
}
DrawFinal();