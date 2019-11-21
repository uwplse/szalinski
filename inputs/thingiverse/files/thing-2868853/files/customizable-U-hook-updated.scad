/*----------------------------------------------------------------------------*/
/*-------                         INFORMATIONS                        --------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/

// CUSTOMIZABLE U-HOOK (parametric and very strong hook)
// by Serge Payen, January 2016
// www.sergepayen.fr/en/parametric-u-hook
// "customizable_u_hook" is licenced under Creative Commons :
// Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
// http://creativecommons.org/licenses/by-nc-sa/4.0/

// HOW TO USE THIS FILE :

// -- Solution 1 :
// Open this file with OpenScad software (free and open-source)
// http://www.openscad.org/downloads.html
// Choose your parameters in the SETTINGS chapter (see below)
// Press F5 to compile and see the resulting hook
// Check your hook's global size in the console window (below viewing area)
// If OK, press F6 to render
// Go to : File => Export => Export as STL : choose filename and location
// Save the STL file of your customized hook
// Send this STL file to your 3D printer

// -- Solution 2 :
// This file had been optimized for Thingiverse Customizer
// You will need to have a Thingiverse Account, then :
// Go to object's page on Thingiverse
// Click on the button "Open in Customizer"
// Choose your settings in parameters tabs
// Save the STL file of your customized hook
// Send this STL file to your 3D printer



/*----------------------------------------------------------------------------*/
/*-------                           SETTINGS                          --------*/
/*----------------------------------------------------------------------------*/

/* [HOOK SHAPE] */

// Choose between classic hook with screw-holes (0) or "bracket" system (1)
bracket=0; // [0, 1]

// Choose between square (0) and round bracket (1)
bracket_round=0; // [0, 1]

// Choose to have a second hook (1) or not (0)
second_hook=1; // [0, 1]



/* [MAIN HOOK SIZE] */

// Intern diameter of hook's main U shape
hook_size=35; // [0.1:250]

// Hook's "thickness" = object's width = print's height
thickness=25; // [0.1:250]



/* [SECOND HOOK] */

// Lenght of second hook. Good values are around "Hook Size" x 0.75
second_hook_lenght=30; // [0.1:200]

// Angle of second hook. Best is between 45° and 65°.
second_hook_angle=55; // [0:90]



/* [SPACERS] */

// Space between main hook and bottom screw
spacer_1=20; // [0:200]

// Space between bottom screw and secondary hook
spacer_2=10; // [0:200]

// Space between second hook and top screw
spacer_3=10; // [0:200]

// Space between top screw and hook's rounded top
spacer_4=10; // [0:200]



/* [SCREW-HOLES] */

// Diameter of the screw you plan to use
screw_diam=3; // [0:0.5:20]

// Diameter of screw-head
screw_head=8; // [0:0.5:40]

// Screw-head height (deepness for screw-head hole)
screw_head_h=3; // [0:0.5:20]

// Tolerance, for screw easy-fitting
tolerance=0.5; // [0:0.1:10]



/* [BRACKET] */

// Bracket's main size
bracket_size=40; // [0:250]

// Bracket's back lenght
stop_lenght=15; // [0:250]

// Bracket Stiffness (only with square bracket)
bracket_stiffness=2.5; // [0:100]



/* [EXTRA SETTINGS] */

// Choose to have a screw-hole in square bracket (1), or not (0)
safety_screw=0; // [1, 0]

// Choose to have the hook's "triangle" extremity (1) or not (0)
extremity=1; // [1, 0]

// Choose to have screw-holes (1) or not (0)
screw_holes=1; // [1, 0]

// Choose to have the hook's rounded "top" (1) or not (0)
rounded_top=1; // [1, 0]



/*------------------------------------------------------------------------------

NOTE about GENERAL DIMENSIONS AND CUSTOM HEIGHTS SETTINGS :

To respect general shape's efficiency, global size is relative to "hook_size".
Change "hook_size" for a bigger or smaller hook, then choose more options.
Different values for "spacer_1,2,3,4" will change size on Y-axis.

When compiling, OpenScad will return the total dimensions in the console window.
Keep in mind the hook is printed "laying on his side" on print bed.
In the first few lines of console window (below viewing area), you can read :
ECHO : TOTAL_SIZE_ON_X_AXIS = x (total width : adjust "hook_size" and/or bracket)
ECHO : TOTAL_SIZE_ON_Y_AXIS = y (total lenght : adjust with "spacer_1/2/3/4")
ECHO : TOTAL_SIZE_ON_Z_AXIS = z (total height : adjust "thickness")
It will also return informations about all other strategic sizes.
Console will also display warning messages if some values are illogic.

------------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*-------                             CODE                            --------*/
/*----------------------------------------------------------------------------*/

/*____________________________________________________________________________*/
/* [HIDDEN] */
// shortcuts
stiffness=hook_size/4;
big_r=hook_size/5;
small_r=stiffness/2;
height_bottom=hook_size;
width_global=hook_size+stiffness*2;
half_width=width_global/2-stiffness/2;
screw_hole=screw_diam+tolerance*2;
screw_house=screw_head+tolerance*2;
bracket_move=bracket_size/2+width_global/2;
bracket_round_diam=bracket_size+stiffness*2;
min_height1=spacer_1+screw_house/2+stiffness;
min_height2=min_height1+spacer_2/2+screw_house/2;
min_height2_hg=spacer_1+stiffness+spacer_2/2;
min_height3=min_height2+spacer_3/2+spacer_2/2;
min_height3_hg=min_height2_hg+spacer_3/2+spacer_2/2;
min_height4=min_height3+spacer_4/2+spacer_3/2+screw_house;
min_height4_hg=min_height3_hg+spacer_3/2+spacer_4/2;
space_global=spacer_1+spacer_2+spacer_3+spacer_4;
$fn=150;

// remove specific colors for each module
color ("Gold")
translate ([hook_size/2,-hook_size/3,thickness/2])
rotate ([0,0,0])
uhook ();

echo (TOTAL_SIZE_ON_Z_AXIS=thickness);
echo (MAIN_HOOK_INTERN_DIAMETER=hook_size);

if (bracket)
{
    echo (BRACKET_SIZE=bracket_size);
    echo (BRACKET_STIFFNESS=bracket_stiffness);
    echo (STOP_LENGHT=stop_lenght);
}
else
{
    echo (SCREW_HOLES_DIAMETER=screw_diam);
    echo (SCREW_HEAD_DIAMETER=screw_head);
    echo (SCREW_HEAD_HEIGHT=screw_head_h);
}

if ((bracket)&&(safety_screw))
{
    echo (SAFETY_SCREW_DIAMETER=screw_diam);
    echo (SAFETY_SCREW_HEAD_DIAMETER=screw_head);
    echo (SAFETY_SCREW_HEAD_HEIGHT=screw_head_h);
}

if (second_hook)
{
    echo (SECOND_HOOK_LENGHT=second_hook_lenght);
    echo (SECOND_HOOK_ANGLE=second_hook_angle);
}






/*____________________________________________________________________________*/
// final union of all modules
module uhook ()
{
    union ()
    {

        // hook's base, this part don't depend on hook's type
        belly ();

        translate ([0,-height_bottom/2-stiffness,0])
        bottom ();

        translate ([half_width,stiffness,0])
        rotate ([0,90,0])
        tip ();



        // conditionnal part, depending on hook's type
        if (bracket)
        {
            translate ([-half_width,stiffness+spacer_1/2,0])
            addH1 ();
            translate ([-half_width,min_height2_hg,0])
            addH2 ();
        }
        else
        {
            translate ([-half_width,stiffness+spacer_1/2,0])
            addH1 ();
            translate ([-half_width,min_height1,0])
            screw ();
            translate ([-half_width,min_height2,0])
            addH2 ();
        }

        if ((bracket)&&(second_hook))
        {
            translate ([-width_global/2,min_height2_hg+spacer_2/2,-thickness/2])
            arm ();
            translate ([-half_width,min_height3_hg+hook_size,0])
            addH3 ();
            translate ([-half_width,min_height4_hg+hook_size,0])
            addH4 ();
            if (bracket_round)
            {
            translate ([-width_global/2-bracket_round_diam/2+stiffness,min_height4_hg+hook_size+spacer_4/2,0])
            sHook ();
            //width calculation
            width_total=width_global-stiffness+bracket_round_diam;
            echo (TOTAL_SIZE_ON_X_AXIS=width_total);
            //height calculation
            height_global=hook_size*2+stiffness*2+space_global+bracket_round_diam/2;
            echo (TOTAL_SIZE_ON_Y_AXIS=height_global);
            }
            else
            {
                translate ([-half_width,min_height4_hg+hook_size+spacer_4/2+stiffness/2,0])
                head ();
                translate ([-bracket_move,min_height4_hg+hook_size+spacer_4/2+stiffness-bracket_stiffness/2,0])
                hang ();
                //width calculation
                width_total=width_global+bracket_size+bracket_stiffness;
                echo (TOTAL_SIZE_ON_X_AXIS=width_total);
                //height calculation
                height_global=hook_size*2+stiffness*3+space_global;
                echo (TOTAL_SIZE_ON_Y_AXIS=height_global);
            }

        }

        else if (second_hook)
        {
            translate ([-width_global/2,min_height2+spacer_2/2,-thickness/2])
            arm ();
            translate ([-half_width,min_height3+hook_size,0])
            addH3 ();
            translate ([-half_width,min_height3+hook_size+spacer_3/2+screw_house/2,0])
            screw ();
            translate ([-half_width,min_height4+hook_size,0])
            addH4 ();
            translate ([-half_width,min_height4+hook_size+spacer_4/2+stiffness/2,0])
            head ();
            //height calculation
            height_global=hook_size*2+stiffness*3+screw_house*2+space_global;
            echo (TOTAL_SIZE_ON_Y_AXIS=height_global);
        }
        else if (bracket)
        {
            translate ([-half_width,min_height3_hg,0])
            addH3 ();
            translate ([-half_width,min_height4_hg,0])
            addH4 ();
            if (bracket_round)
            {
                translate ([-width_global/2-bracket_round_diam/2+stiffness,min_height4_hg+spacer_4/2,0])
                sHook ();
                //width calculation
                width_total=width_global-stiffness+bracket_round_diam;
                echo (TOTAL_SIZE_ON_X_AXIS=width_total);
                //height calculation
                height_global=hook_size+stiffness*2+space_global+bracket_round_diam/2;
                echo (TOTAL_SIZE_ON_Y_AXIS=height_global);
            }
            else
            {
                translate ([-half_width,min_height4_hg+spacer_4/2+stiffness/2,0])
                head ();
                translate ([-bracket_move,min_height4_hg+spacer_4/2+stiffness-bracket_stiffness/2,0])
                hang ();
                //width calculation
                width_total=width_global+bracket_size+bracket_stiffness;
                echo (TOTAL_SIZE_ON_X_AXIS=width_total);
                //height calculation
                height_global=hook_size+stiffness*3+space_global;
                echo (TOTAL_SIZE_ON_Y_AXIS=height_global);
            }

        }
        else
        {
            translate ([-half_width,min_height3,0])
            addH3 ();
            translate ([-half_width,min_height3+spacer_3/2+screw_house/2,0])
            screw ();
            translate ([-half_width,min_height4,0])
            addH4 ();
            translate ([-half_width,min_height4+spacer_4/2+stiffness/2,0])
            head ();
            //height calculation
            height_global=hook_size+stiffness*3+screw_house*2+space_global;
            echo (TOTAL_SIZE_ON_Y_AXIS=height_global);
        }

    }

}



/*____________________________________________________________________________*/
// hook's bottom shape, with a hole inside
module bottom ()
{
    color ("Gold")
    difference ()
    {
        // bottom
        intersection ()
        {
            cube ([width_global,height_bottom+0.1,thickness], center=true);

            translate ([-stiffness,height_bottom/2,0])
            cylinder(r=hook_size/2+stiffness*2, h=thickness+0.1, center=true);

        }

        // hole
        hull ()
        {
            translate ([-big_r/2-stiffness/4,0,0])
            cylinder (r=big_r, h=thickness+0.2, center=true);

            translate ([big_r,stiffness/2,0])
            cylinder (r=small_r, h=thickness+0.2, center=true);

        }

    }

}


/*____________________________________________________________________________*/
// main hook's U-shape
module belly ()
{
    color ("Crimson")
    difference ()
    {
        // base cube
        cube ([width_global,hook_size/2,thickness], center=true);

        // half-cylindric hole
        translate ([0,hook_size/4,0])
        cylinder (r=hook_size/2, h=thickness+0.1, center=true);

    }
}


/*____________________________________________________________________________*/
// screw-hole module
module screw ()
{
    if (thickness>screw_house*8)
    {
        color ("Silver")
        difference ()
        {
            //base cube
            cube ([stiffness,screw_house,thickness], center=true);

            if (screw_holes)
            {
                // screw1 hole
                translate ([0,0,thickness/4])
                rotate ([0,90,0])
                cylinder (d=screw_hole, h=stiffness+0.1, center=true);

                // screw1-head hole 1
                translate ([stiffness/2-screw_head_h/2+0.1,0,thickness/4])
                rotate ([0,90,0])
                cylinder (d=screw_house, h=screw_head_h, center=true);

                // screw2 hole
                translate ([0,0,-thickness/4])
                rotate ([0,90,0])
                cylinder (d=screw_hole, h=stiffness+0.1, center=true);

                // screw2-head hole 1
                translate ([stiffness/2-screw_head_h/2+0.1,0,-thickness/4])
                rotate ([0,90,0])
                cylinder (d=screw_house, h=screw_head_h, center=true);
            }
        }

    }
    else
    {
        color ("Silver")
        difference ()
        {
            //base cube
            cube ([stiffness,screw_house,thickness], center=true);

            if (screw_holes)
            {
                // screw hole
                rotate ([0,90,0])
                cylinder (d=screw_hole, h=stiffness+0.1, center=true);

                // screw-head hole
                translate ([stiffness/2-screw_head_h/2+0.1,0,0])
                rotate ([0,90,0])
                cylinder (d=screw_house, h=screw_head_h, center=true);
            }

        }
    }

}


/*____________________________________________________________________________*/
// hook's triangle extremity
module tip ()
{
    if (extremity)
    color ("Gold")
    difference ()
    {
        hull ()
        {
            translate ([thickness/2-thickness/10,0,0])
            cylinder (d=thickness/5, h=stiffness, center=true);
            translate ([-thickness/2+thickness/10,0,0])
            cylinder (d=thickness/5, h=stiffness, center=true);

            translate ([thickness/7,thickness/5,0])
            cylinder (d=thickness/5, h=stiffness, center=true);
            translate ([-thickness/7,thickness/5,0])
            cylinder (d=thickness/5, h=stiffness, center=true);
        }

        translate ([0,-thickness/4,0])
        cube ([thickness+0.1, thickness/2, thickness], center=true);

    }
    else
    {
        hull ()
        {
            translate ([thickness/2-thickness/10,0,0])
            cylinder (d=thickness/5, h=stiffness, center=true);
            translate ([-thickness/2+thickness/10,0,0])
            cylinder (d=thickness/5, h=stiffness, center=true);
        }
    }

}


/*____________________________________________________________________________*/
// secondary hook
module arm ()
{
    color ("Orange")
    union ()
    {
        cube ([stiffness, hook_size, thickness]);

        translate ([0,stiffness,0])
        union ()
        {
            rotate ([0,0,-second_hook_angle])
            union ()
            {
                hull ()
                {
                    cube ([stiffness, second_hook_lenght, thickness]);
                    rotate ([0,0,second_hook_angle])
                    translate ([0,-stiffness,0])
                    cube ([stiffness, stiffness, thickness]);
                }

                rotate ([0,90,0])
                translate ([-thickness/2,second_hook_lenght,stiffness/2])
                tip ();
            }
        }
    }

}


/*____________________________________________________________________________*/
// hook's rounded top
module head ()
{
    color ("Gold")
    intersection ()
    {
        cube ([stiffness,stiffness,thickness], center=true);
        if (rounded_top)
        translate ([-stiffness/2,-stiffness/2,0])
        cylinder (r=stiffness, h=thickness+0.2, center=true);
    }

}


/*____________________________________________________________________________*/
// Square bracket, rectangular part to clip on a door's top
module hang ()
{
    union ()
    {
        //bracket part 1, on one side of safety screw
        color ("Crimson")
        translate ([bracket_size/4+screw_house/4,0,0])
        cube ([bracket_size/2-screw_house/2,bracket_stiffness,thickness], center=true);

        //safety screw
        if (safety_screw)
        {
            color ("Silver")
            difference ()
            {
                cube ([screw_house,bracket_stiffness,thickness],center=true);
                rotate ([90,0,0])
                cylinder (d=screw_hole, h=bracket_stiffness+0.1, center=true);
                translate ([0,bracket_stiffness/2-screw_head_h/2,0])
                rotate ([90,0,0])
                cylinder (d=screw_house, h=screw_head_h+0.1, center=true);
            }

            //bracket part 2, on the other side of safety screw
            color ("Crimson")
            translate ([-bracket_size/4-screw_house/4,0,0])
            cube ([bracket_size/2-screw_house/2,bracket_stiffness,thickness], center=true);

            //stop
            color ("Orange")
            translate ([-bracket_size/2-bracket_stiffness/2,0,0])

            union ()
            {
                // rounding part between bracket top part and stop
                intersection ()
                {
                    cube ([bracket_stiffness,bracket_stiffness,thickness],center=true);
                    translate ([bracket_stiffness/2,-bracket_stiffness/2,0])
                    cylinder (r=bracket_stiffness, h=thickness, center=true);
                }

                difference ()
                {
                    // stop main cube
                    color ("DeepSkyBlue")
                    translate ([0,-stop_lenght/2-bracket_stiffness/2,0])
                    cube ([bracket_stiffness,stop_lenght,thickness], center=true);

                    // rounding stop's bottom extremity
                    if (stop_lenght>=bracket_stiffness)
                    translate ([0,-stop_lenght,0])
                    difference ()
                    {
                        cube ([bracket_stiffness+0.1,bracket_stiffness+0.1,thickness+0.1],center=true);
                        translate ([bracket_stiffness/2,bracket_stiffness/2,0])
                        cylinder (r=bracket_stiffness, h=thickness+0.2, center=true);
                    }
                }

            }

        }

        else
        {
            union ()
            {
                //bracket main size (top part)
                color ("Crimson")
                cube ([bracket_size,bracket_stiffness,thickness],center=true);

                // rounding part between bracket top part and stop
                translate ([-bracket_size/2-bracket_stiffness/2,0,0])
                intersection ()
                {
                    cube ([bracket_stiffness,bracket_stiffness,thickness],center=true);
                    translate ([bracket_stiffness/2,-bracket_stiffness/2,0])
                    cylinder (r=bracket_stiffness, h=thickness, center=true);
                }

                difference ()
                {
                    color ("DeepSkyBlue")
                    // stop main cube
                    translate ([-bracket_size/2-bracket_stiffness/2,-stop_lenght/2-bracket_stiffness/2,0])
                    cube ([bracket_stiffness,stop_lenght,thickness], center=true);

                    // rounding stop's bottom extremity
                    if (stop_lenght>=bracket_stiffness)
                    translate ([-bracket_size/2-bracket_stiffness/2,-stop_lenght,0])
                    difference ()
                    {
                        cube ([bracket_stiffness+0.1,bracket_stiffness+0.1,thickness+0.1],center=true);
                        translate ([bracket_stiffness/2,bracket_stiffness/2,0])
                        cylinder (r=bracket_stiffness, h=thickness+0.2, center=true);
                    }
                }

            }
        }

    }
}


/*____________________________________________________________________________*/
// Rounded bracket, to clip hook on a tube
module sHook ()
union ()
{
    // difference to erase bottom half
    difference ()
    {
        // difference between extern and intern diameters
        color ("Crimson")
        difference ()
        {
            cylinder (d=bracket_round_diam, h=thickness, center=true);
            cylinder (d=bracket_size,h=thickness+0.1, center=true);
        }

        //cube to erase bottom half
        translate ([0,-bracket_round_diam/4,0])
        cube ([bracket_round_diam+0.1,bracket_round_diam/2,thickness+0.1], center=true);
    }

    // rounded extremity
    color ("DeepSkyBlue")
    hull ()
    {
        translate ([-bracket_round_diam/2+stiffness/2,0,0])
        cylinder (d=stiffness, h=thickness, center=true);
        translate ([-bracket_round_diam/2+stiffness/2,-stop_lenght+stiffness/2,0])
        cylinder (d=stiffness, h=thickness, center=true);
    }

}



/*____________________________________________________________________________*/
// spacer_1 : custom height above main hook, below bottom screw
module addH1 ()
{
    color ("Cyan")
    cube ([stiffness,spacer_1,thickness], center=true);
}


/*____________________________________________________________________________*/
// spacer_2 : custom height above bottom screw, below secondary hook
module addH2 ()
{
    color ("DeepSkyBlue")
    cube ([stiffness,spacer_2,thickness], center=true);
}


/*____________________________________________________________________________*/
// spacer_3 : custom height above secondary hook, below top screw
module addH3 ()
{
    color ("DodgerBlue")
    cube ([stiffness,spacer_3,thickness], center=true);
}


/*____________________________________________________________________________*/
// spacer_4 : custom height above top screw, below rounded top
module addH4 ()
{
    color ("DarkBlue")
    cube ([stiffness,spacer_4,thickness], center=true);
}


/*____________________________________________________________________________*/
/*____________________________________________________________________________*/
/*____________________________________________________________________________*/
// Warning messages

if ((bracket)&&(safety_screw)&&(bracket_round!=true))
{
    if (thickness<screw_house*2)
    echo (" WARNING : Safety Screw Hole seems too big compare to Thickness ");
    if (screw_head_h>bracket_stiffness)
    echo (" WARNING : Safety Screw Head Height seems too big compare to Bracket Stiffness ");
    if (screw_head<=screw_diam)
    echo (" WARNING : Screw Head Diameter should be bigger than Screw Diameter ");
    if (bracket_size<=screw_house)
    echo (" WARNING : Bracket Size seems too small compare to Screw Holes ");
    if (stop_lenght<bracket_stiffness)
    echo (" WARNING : Stop Lenght should be bigger than Bracket Stiffness ");
}

if (bracket!=true)
{
    if (thickness<screw_house*2)
    echo (" WARNING : Screw Holes seems too big compare to Thickness ");
    if (screw_head<=screw_diam)
    echo (" WARNING : Screw Head Diameter should be bigger than Screw Diameter ");
    if (screw_head_h>stiffness/2)
    echo (" WARNING : Screw Head Height seems too big compare to Hook Size");
}

if ((bracket!=true)&&(second_hook!=true))
{
    if (spacer_2+spacer_3<screw_house)
    echo (" WARNING : Screws seems too close. Push up value of Spacer 2 or 3 ");
}

if (second_hook)
{
    if (second_hook_lenght>hook_size)
    echo (" WARNING : Second Hook Lenght should be smaller than Hook Size ");
    if (second_hook_lenght<hook_size/3)
    echo (" WARNING : Second Hook Lenght seems very small compare to Hook Size ");
    if (second_hook_angle<45)
    echo (" WARNING : Best values for Second Hook Angle are between 45° and 65° ");
    if (second_hook_angle>65)
    echo (" WARNING : Best values for Second Hook Angle are between 45° and 65° ");
}
