//Clip Clamp to hold two parts together without screws
//By: David Bunch   12/21/2017
//
//You could also use this clip with hole punched paper
//Adjust size with these Variables
//
/* [Main Variables] */

//1. Length of 1st Side
CL_Len1 = 12;                 //[3:1:30]

//2. Length of 2nd Side
CL_Len2 = 12;                 //[3:1:30]

//3. Gap width between Sides of Clip
CL_Gap = 5;                    //[5:1:40]

//4. Thickness of Octagon Clip
CL_Thk = 4.0;                   //[3:1:20]

//5. Thickness of Octagon Spheres at End
CL_End_Thk = 8.0;               //[6:1:30]

/* [Bend Up at Half Torus Variables] */

//6. Turn ON/OFF Semi Bend at Half Torus
CL_Semi_Bend_ON = 0;            //[0:Off, 1:ON]

//7. How much to Bend Semi Angle upwards (0-180)
CL_Semi_Ang = 90;               //[0:5:180]

//8. Radius of the Bend at Semi circle Torus
CL_Semi_Rad = 6;             //[5:1:30]

/* [Bend Out or In at End of 1st Side Variables] */

//9. Turn ON/OFF Bend at End of 1st Side
CL_End1_Bend_ON = 0;            //[0:Off, 1:ON]

//10. Length of 1st Side at end of this Bend
CL_Len3 = 3.0;                  //[3:1:20]

//11. Direction of Bend on 1st Side
CL_End1_Dir = 1;                //[0:Bend Towards Middle, 1:Bend Away from Middle]

//12. Radius of Angle of Bend on 1st & 2nd Side
CL_End1_Rad = 3.0;              //[3:1:20]

/* [Bend Out or In at End of 2nd Side Variables] */

//13. Turn ON/OFF Bend at End of 2nd Side
CL_End2_Bend_ON = 0;            //[0:Off, 1:ON]

//14. Length of Side at Start of Bend at End
CL_Len4 = 3.0;                  //[3:1:20]

//15. Direction of Bend on 2nd Side
CL_End2_Dir = 0;                //[0:Bend Towards Middle, 1:Bend Away from Middle]

/* [Bend Up at Each End Variables] */

//16. Turn ON/OFF Semi Bend at Half Torus
CL_End_BendUp_ON = 0;            //[0:Off, 1:ON]

//17. Length of Side before Bend UP
CL_Len5 = 3.0;                  //[3:1:20]

//18. How much to Bend Semi Angle upwards (0-180)
CL_End_BendUp_Ang = 45;         //[0:5:180]

//19. Radius of the Bend at Semi circle Torus
CL_End_BendUp_Rad = 12.0;       //[5:1:30]

/* [Hidden] */

CL_End2_Rad = CL_End1_Rad;
CL_End1_OD = CL_End1_Rad * 2.0;
CL_End2_OD = CL_End2_Rad * 2.0;
CL_End_BendUp_OD = CL_End_BendUp_Rad * 2.0;

CL_Semi_Y = CL_Semi_Rad * sin(CL_Semi_Ang);
CL_Semi_Z = CL_Semi_Rad - (CL_Semi_Rad * cos(CL_Semi_Ang));

CL_End_BendUp_Y = CL_End_BendUp_Rad * sin(CL_End_BendUp_Ang);
CL_End_BendUp_Z = CL_End_BendUp_Rad - (CL_End_BendUp_Rad * cos(CL_End_BendUp_Ang));

A_CL_Dir_X1 = [CL_End1_OD,-CL_End1_OD];
A_CL_Dir_X2 = [CL_End2_OD,-CL_End2_OD];
A_CL_Len = [CL_Len1,CL_Len2,CL_Len3];       //Put Lengths in Array to use in For loop
CL_Dir_X1 = A_CL_Dir_X1[CL_End1_Dir];
CL_Dir_X2 = A_CL_Dir_X2[CL_End2_Dir];

CL_End_2 = CL_End_Thk / 2.0;
CL_Oct_End_Rad = CL_End_2 / cos(22.5);
CL_Oct_End_4 = CL_End_2 * tan(22.5);
CL_Oct_End_4_Rad = CL_Oct_End_4 / cos(22.5);
CL_Oct_End_4_OD = CL_Oct_End_4_Rad * 2.0;

CL_Oct_End_OD = CL_Oct_End_Rad * 2.0;
CL_Rad = (CL_Gap + CL_Thk) / 2.0;
CL_OD = CL_Rad * 2.0;
CL_Semi_OD = CL_Semi_Rad * 2.0;
CL_Thk2 = CL_Thk / 2.0;
CL_Thk_Rad = CL_Thk2 / cos(22.5);
CL_Thk_Rad = CL_Thk2 / cos(22.5);
CL_Thk_OD = CL_Thk_Rad * 2.0;
CL_Mid_Ht = CL_Oct_End_4 * 2.0;
CL_End_Ht = (CL_End_Thk - CL_Mid_Ht) / 2.0;
CL_Z_Diff = CL_End_2 - CL_Thk2;

//Calculate resolution of curve facets
CL_OD_Res = (round(((CL_OD * 3.14)/4)/.7)*4);
CL_Semi_OD_Res = (round((((CL_Semi_OD + CL_Thk) * 3.14)/4)/.7)*4);
CL_End1_OD_Res = (round((((CL_End1_OD + CL_Thk) * 3.14)/4)/.7)*4);
CL_End_BendUp_OD_Res = (round(((CL_End_BendUp_OD * 3.14)/4)/.7)*4);

echo(CL_Semi_Y = CL_Semi_Y);
echo(CL_Semi_Z = CL_Semi_Z);
echo(CL_End_2 = CL_End_2);
echo(CL_Oct_End_Rad = CL_Oct_End_Rad);
echo(CL_Rad = CL_Rad);
echo(CL_Thk_OD = CL_Thk_OD);
echo(CL_Thk2 = CL_Thk2);
echo(CL_Thk_Rad = CL_Thk_Rad);
echo(CL_Z_Diff = CL_Z_Diff);
echo(CL_OD_Res = CL_OD_Res);
echo(CL_Oct_End_OD = CL_Oct_End_OD);
echo(CL_Oct_End_4 = CL_Oct_End_4);
echo(CL_Oct_End_4_Rad = CL_Oct_End_4_Rad);
echo(CL_Mid_Ht = CL_Mid_Ht);
echo(CL_End_Ht = CL_End_Ht);
echo(CL_Semi_OD_Res = CL_Semi_OD_Res);
echo(CL_End1_OD_Res = CL_End1_OD_Res);
module Half_Torus()
{
    difference()
    {
        rotate_extrude(angle=360, convexity=10,$fn=CL_OD_Res)
        translate([CL_Rad, 0,0]) 
        rotate([0,0,22.5])
        circle(d=CL_Thk_OD,$fn=8);
//Because thingiverse Customizer does not like partial torus objects, we cut full torus
        translate([-CL_OD,-CL_OD,-CL_Thk_OD])
        cube([CL_OD*2,CL_OD,CL_Thk_OD*2]);
    }
}
module Semi_Circ()
{
    if (CL_Semi_Bend_ON == 0)
    {
        Half_Torus();          //Draw half Torus
    } else
    {
        translate([0,CL_Semi_Y,CL_Semi_Z-.001])
        rotate([CL_Semi_Ang,0,0])
        Half_Torus();          //Draw half Torus
    }
}
//This routine cuts out a portion of a Full torus
//Because thingiverse Customizer does not like partial torus objects
module CutCube(CC_Len = CL_Semi_OD, CC_HT = CL_Thk_OD*2, CC_Ang = CL_Semi_Ang)
{
    if (CC_Ang <= 180.0)
    {
        translate([-CC_Len,-CC_Len,-1])
        cube([CC_Len*2,CC_Len,CC_HT+2]);
    } if (CC_Ang <= 270)
    {
        translate([0,-CC_Len,-1])
        cube([CC_Len,CC_Len,CC_HT+2]);
        if (CC_Ang < 270)
        {
            if (CC_Ang < 90.0)
            {
                translate([0,0,-1])
                rotate([0,0,CC_Ang])
                cube([CC_Len,CC_Len*2,CC_HT+2]);
                translate([-CC_Len,-CC_Len,-1])
                cube([CC_Len,CC_Len*2,CC_HT+2]);
            } else
            {
                rotate([0,0,CC_Ang])
                translate([0,0,-1])
                cube([CC_Len,CC_Len,CC_HT+2]);
            }
        }
    }
}
module Semi_Bend()
{
    translate([CL_Rad,0,0])
    rotate([0,90,0])
    translate([-CL_Semi_Rad,0,0])
    difference()
    {
        rotate_extrude(angle=360, convexity=10,$fn=CL_Semi_OD_Res)
        translate([CL_Semi_Rad, 0,0]) 
        rotate([0,0,22.5])
        circle(d=CL_Thk_OD,$fn=8);

        translate([0,0,-CL_Thk_OD])
        CutCube(CL_Semi_OD*2, CL_Thk_OD*2, CL_Semi_Ang);
    }
}
module End_BendUP()
{
    translate([CL_Rad,-CL_Len5,0])
    rotate([0,0,180])
    rotate([0,90,0])
    translate([-CL_End_BendUp_Rad,0,0])
    difference()
    {
        rotate_extrude(angle=360, convexity=10,$fn=CL_End_BendUp_OD_Res)
        translate([CL_End_BendUp_Rad, 0,0]) 
        rotate([0,0,22.5])
        circle(d=CL_Thk_OD,$fn=8);

        translate([0,0,-CL_Thk_OD])
        CutCube(CL_End_BendUp_Rad*4, CL_Thk_OD*2, CL_End_BendUp_Ang);
    }
}
module End_Bend()
{
    difference()
    {
        rotate_extrude(angle=360, convexity=10,$fn=CL_End1_OD_Res)
        translate([CL_End1_Rad, 0,0]) 
        rotate([0,0,22.5])
        circle(d=CL_Thk_OD,$fn=8);
        translate([-CL_End1_OD,-CL_End1_OD,-CL_Thk_OD])
        cube([CL_End1_OD*2,CL_End1_OD,CL_Thk_OD*2]);
        translate([-CL_End1_OD,-CL_End1_OD,-CL_Thk_OD])
        cube([CL_End1_OD,CL_End1_OD*2,CL_Thk_OD*2]);
    }
}
module Full_Bend()
{
    translate([-CL_End1_Rad,0,0])
    rotate([0,0,-180])
    End_Bend();
    translate([-CL_End1_Rad,-CL_End1_Rad*2,0])
    End_Bend();
    translate([-CL_End1_Rad,-CL_End1_Rad,0])
    rotate([0,90,0])
    translate([0,0,-.05])
    CylSide(CL_Thk_OD, .1);
}
//This is used because a sphere with $fn=8
//does not calculate the way an 8 sided cylinder does.
module Oct_Sphere()
{
    translate([0,0,-CL_End_Ht])
    hull()
    {
        translate([0,CL_Z_Diff,0])
        union()
        {
            translate([0,0,CL_End_Ht])
            CylSide(CL_Oct_End_OD, CL_Mid_Ht-.001);
            translate([0,0,CL_End_Ht+CL_Mid_Ht])
            rotate([0,0,22.5])
            cylinder(d1=CL_Oct_End_OD,d2=CL_Oct_End_4_OD,h=CL_End_Ht,$fn=8);
        }
        translate([0,0,0])
        rotate([0,0,22.5])
        cylinder(d=CL_Thk_OD,h=.1,$fn=8);
    }
}
module CylSide(Cy_OD = CL_Thk_OD, Cy_Len = CL_Len1)
{
    rotate([0,0,22.5])
    cylinder(d=Cy_OD,h=Cy_Len + .01,$fn=8);
}

//First Side of Clip
module Side1()
{
    translate([-CL_Rad, 0,0])
    rotate([90,0,0])
    {
        translate([0,0,-.01])
        CylSide(CL_Thk_OD, CL_Len1+.01);
        if (CL_End1_Bend_ON == 0)
        {
            translate([0,0,CL_Len1])
            Oct_Sphere();
        } else
        {
            translate([CL_Dir_X1,0,CL_Len1])
            mirror([CL_End1_Dir,0,0])
            rotate([-90,0,0])
            Full_Bend();
            translate([CL_Dir_X1 ,0,CL_Len1 + CL_End1_OD])
            translate([0,0,-.01])
            CylSide(CL_Thk_OD, CL_Len3);
            translate([CL_Dir_X1,0,CL_Len1 + CL_End1_OD + CL_Len3])
            Oct_Sphere();
        }
    }
}
//Second Side of Clip
module Side2()
{
    mirror([1,0,0])
    translate([-CL_Rad, 0,0])
    rotate([90,0,0])
    {
        translate([0,0,-.01])
        CylSide(CL_Thk_OD, CL_Len2+.01);
        if (CL_End2_Bend_ON == 0)
        {
            translate([0,0,CL_Len2])
            Oct_Sphere();
        } else
        {
            translate([CL_Dir_X2,0,CL_Len2])
            mirror([CL_End2_Dir,0,0])
            rotate([-90,0,0])
            Full_Bend();
            translate([CL_Dir_X2 ,0,CL_Len2 + CL_End1_OD])
            translate([0,0,-.01])
            CylSide(CL_Thk_OD, CL_Len4);
            translate([CL_Dir_X2,0,CL_Len2 + CL_End1_OD + CL_Len4])
            Oct_Sphere();
        }
    }
}
module DrawFinal()
{
    union()
    {
        Semi_Circ();
        if (CL_End_BendUp_ON == 0)
        {
            Side1();
            Side2();
        } else
        {
            End_BendUP();        //The Bend up at 1st End
            translate([-CL_Rad, 0,0])
            rotate([90,0,0])
            CylSide(CL_Thk_OD, CL_Len5);    //Len5 is 1st length with End_BendUP option
    
            mirror([1,0,0])
            End_BendUP();        //The Bend up at 2nd End
            translate([CL_Rad, 0,0])
            rotate([90,0,0])
            CylSide(CL_Thk_OD, CL_Len5);    //Len5 is 1st length with End_BendUP option
    
            translate([0,-CL_Len5 - CL_End_BendUp_Y,CL_End_BendUp_Z])
            rotate([-CL_End_BendUp_Ang,0,0])
            {
                Side1();
                Side2();
            }
        }
        for (m = [0,1])
        {
            if (CL_Semi_Bend_ON == 1)
            {
                mirror([m,0,0])
                Semi_Bend();        //The Bend up at the semi torus
            }
        }
    }
}
DrawFinal();