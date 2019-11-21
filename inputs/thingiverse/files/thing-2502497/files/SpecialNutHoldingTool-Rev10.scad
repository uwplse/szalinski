//Special Allen Wrench style Nut Holder
//This holds a locknut in place to get threads started
//8/24/2017 By: David Bunch
//
//CUSTOMIZER VARIABLES

//1. Allen Wrench Size across the Flats
Allen_Handle_Flat = 5;      //[4:4mm, 5:5mm, 6:6mm, 8:8mm, 10:10mm]

//2. Length of Allen Wrench Handle
Allen_Handle_Len = 50;      //[30:5:100]

//3. Straight or Curved Handle
Handle_Type = 1;            //[0:Straight, 1:Curved]

//4. Radius of Allen Wrench Handle
Allen_Curve_Rad = 19;       //[12:1:30]

//5. Dimension across Nut Flats
NutFlat = 6.86;             //[5.55:M3 Nut, 6.86:M4 Nut, 7.86:M5 Nut, 9.83:M6 Nut, 6.35:#4 Nut, 7.94:#5 Nut, 7.94:#6 Nut, 8.73:#8 Nut, 9.53:#10 Nut]

//6. Additional amount to add to Socket opening
Tolerance = .25;            // [-.4:.05:.4]

//7. Height of Socket
Socket_Ht = 5;              //[5:.5:10]

//8. Height of transition of socket to Allen Wrench
Sockt_T_Ht = 4;             //[0:.5:6]

//9. How far to recess Nut socket
Nut_Depth = 4;              //[1:.5:6]

//10. Added height to end of Allen Wrench
Add_Ht = 7;                 //[0:.5:30]

//11. Rotation amount of Socket head
Rot_Head = 45;              //[0:1:60]

//12. Thickness of Socket Wall
Thk = 2;                    //[1.8:.2:4]
                            //(1.65mm minimum recommended)

//13. Slice End for More Clearance
Slice_ON = 1;               //[0:NO, 1:YES]

//14. Add Socket (In case you only want an Allen Wrench)
Socket_ON = 1;               //[0:NO, 1:YES]
/* [Hidden] */

//#4 thru #10 Nut dimensions taken from:
//https://www.boltdepot.com/Hex_machine_screw_nuts_Zinc_plated_steel.aspx?nv=l

Al_C_Rad = Handle_Type * Allen_Curve_Rad;       //How to get 0 radius for straight handle
Allen_Handle_Flat_Rad = Allen_Handle_Flat / 2;
Allen_Handle_OD = ((Allen_Handle_Flat / 2) /cos(30)) * 2;
Allen_Handle_Rad = Allen_Handle_OD / 2;
Allen_Curve_Res = Allen_Curve_Rad * 3.14;
echo(Allen_Curve_Res = Allen_Curve_Res);

Nut_Flat_OD = NutFlat + Tolerance;      //Add Tolerance fit to OD across Flat sides of Nut
Out_Flat_OD = Nut_Flat_OD + Thk + Thk;  //Outside Diameter
Out_Flat_Rad = Out_Flat_OD / 2;
Flat_Rad = Nut_Flat_OD / 2;
Nut_OD = (Flat_Rad /cos(30)) * 2;       //Diameter of 6 sided Nut we are holding
Out_OD = (Out_Flat_Rad /cos(30)) * 2;   //Outside of Socket Diameter
Allen_Curve_OD = Allen_Curve_Rad * 2;
echo(Nut_Flat_OD = Nut_Flat_OD);
echo(Nut_OD = Nut_OD);
echo(Out_OD = Out_OD);
echo(Allen_Handle_OD = Allen_Handle_OD);
echo(Allen_Handle_Flat_Rad = Allen_Handle_Flat_Rad);
$fn=24;
//Transition of the Socket to the Allen Wrench
module Socket_Trans()
{
    hull()
    {
        rotate([-Rot_Head,0,0])
        rotate([0,0,30])
        cylinder(d=Out_OD,h=.1,$fn=6);
        translate([0,0,-Sockt_T_Ht-Add_Ht-.01])
        rotate([0,0,Handle_Type*30])
        cylinder(d=Allen_Handle_OD,h=Add_Ht+.01,$fn=6);
    }
}
//Create the Socket End
module Socket_End()
{
    difference()
    {
        union()
        {
            rotate([-Rot_Head,0,0])
            difference()
            {
                union()
                {
                    difference()
                    {
                        rotate([0,0,30])
                        cylinder(d=Out_OD,h=Socket_Ht,$fn=6);
                        translate([0,0,Socket_Ht-Nut_Depth])
                        rotate([0,0,30])
                        cylinder(d=Nut_OD,h=Nut_Depth+1,$fn=6);
                        translate([0,0,Socket_Ht-.6])
                        rotate([0,0,30])
                        cylinder(d1=Nut_OD,d2=Nut_OD+1,h=.61,$fn=6);
                    }
                }
            }
            Socket_Trans();
        }
        if (Rot_Head > 0)
        {
            if (Slice_ON == 1)
            {
                rotate([-Rot_Head,0,0])
                translate([-Out_OD/2,-Out_OD-(Allen_Handle_OD/2),-Sockt_T_Ht-1])
                cube([Out_OD,Out_OD,Socket_Ht+Sockt_T_Ht+2]);
            }
        }
    }
}
module SP_AllenWrench()
{
    difference()
    {
        union()
        {
//Draw the Allen Wrench Handle with the 90 degree curve
            rotate([-90,0,0])
            {
                rotate([0,90,0])
                cylinder(d=Allen_Handle_OD,h=Allen_Handle_Len,$fn=6);
                translate([Allen_Handle_Len,-Allen_Curve_Rad,0])
                if (Handle_Type == 1)
                {
                    difference()
                    {
                        rotate_extrude(angle=360, convexity=10,$fn=Allen_Curve_Res)
                        translate([Allen_Curve_Rad,0,0])
                        rotate([0,0,30])
                        circle(d=Allen_Handle_OD,$fn=6);
//workardound for Thingiverse customizer not liking partial rotate_extrudes
                        translate([-Allen_Curve_OD,-Allen_Curve_OD,-Allen_Handle_OD])
                        cube([Allen_Curve_OD,Allen_Curve_OD*2,Allen_Handle_OD*2]);
                        translate([-1,-Allen_Curve_OD,-Allen_Handle_OD])
                        cube([Allen_Curve_OD,Allen_Curve_OD,Allen_Handle_OD*2]);
                    }
                }
            }
            if (Socket_ON == 1)
            {
//Add the Socket end to the top of the Allen Wrench part
                {
                    if (Handle_Type == 1)
                    {
                        translate([Allen_Handle_Len+Al_C_Rad-.02,0,Al_C_Rad+Sockt_T_Ht+Add_Ht])
                        difference()
                        {
                            Socket_End();
//Cut again after rotating
                            if (Slice_ON == 1)
                            {
                                translate([-Out_OD/2,-Out_OD-(Allen_Handle_OD/2),-Sockt_T_Ht-Add_Ht-1])
                                cube([Out_OD,Out_OD,Socket_Ht+Sockt_T_Ht+Add_Ht+2]);
                            }
                        }
                    } else
                    {
                translate([Allen_Handle_Len+Sockt_T_Ht+Add_Ht,0,0])
                        rotate([0,90,0])
                        rotate([0,0,90])
                        difference()
                        {
                            Socket_End();
//Cut again after rotating
                            if (Slice_ON == 1)
                            {
                                translate([-Out_OD/2,-Out_OD-(Allen_Handle_OD/2),-Sockt_T_Ht-Add_Ht-1])
                                cube([Out_OD,Out_OD,Socket_Ht+Sockt_T_Ht+Add_Ht+2]);
                            }
                        }
                    }
                }
            } else
            {
                if (Handle_Type == 1)
                {
                    translate([Allen_Handle_Len+Allen_Curve_Rad-.02,0,Allen_Curve_Rad+Sockt_T_Ht+Add_Ht])
                    translate([0,0,-Sockt_T_Ht-Add_Ht])
                    rotate([0,0,30])
                    cylinder(d=Allen_Handle_OD,h=Add_Ht,$fn=6);
                }
            }
            
        }
        translate([0,0,-(Allen_Handle_Flat / 2)-5])
        cylinder(d=Allen_Handle_Len*4,h=5,$fn=12);
    }
}
//Move the wrench up to build platform
translate([0,0,Allen_Handle_Flat/2])
SP_AllenWrench();