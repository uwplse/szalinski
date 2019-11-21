/******************************************************************************/
/**********                     INFO                                 **********/
/******************************************************************************/
/*
Rail Button 1.0 April 2016
by David Buhler

Rail buttons or guides for model and high power rockets launching from 1010 or 
1515 size slot aluminum extrusions. ( https://www.8020.net/ ). These are not as 
strong as the delrin or nylon versions but hey you can easily make this yourself.
The 1515 guides are set to use 8-32 screws but could be opened up a bit for 
10-32 screws with a 3/16" drill bit.

Use support so the upper disk of the button is supported and straight. This is 
the portion that is inserted inside the rail and most critical for fit. 
Alternatively you could print these upside down and have the inside rail portion 
cleanly built. Your choice. I used three walls (1.2mm) . 

Attribution-NonCommercial 3.0 (CC BY-NC 3.0)
http://creativecommons.org/licenses/by-nc/3.0/

*/

/******************************************************************************/
/**********                     Settings                             **********/
/******************************************************************************/
//adjust the follow to meet your needs,  all measurements in mm.

/* [Select Button] */
button_to_make="1515";//[1010,1515,manual]

/* [Manual Button Diameters] */
man_button_outer_dia=11.1;//
man_button_inner_dia=5.8;//
man_thickness=1.9;//
man_button_middle=3.8;//
man_screw_size=3.05;//



/******************************************************************************/
/**********                   Variable Calcs                         **********/
/****                     no need to adjust these                      ********/
/******************************************************************************/
/* [HIDDEN] */
//1010 button, 
button_outer_dia=11.1;
button_inner_dia=5.8;
thickness=1.9;
button_middle=3.8;
screw_size=3.05;

//1515 button
button_outer_dia_1515=16;
button_inner_dia_1515=7.6;
thickness_1515=3;
button_middle_1515=6;
screw_size_1515=5;

/******************************************************************************/
/**********                  Make It Happen Stuff                    **********/
/******************************************************************************/
if (button_to_make=="1010"){
    difference(){
        union(){
            cylinder(r=button_outer_dia/2,h=thickness,$fn=40);//bottom disk
            translate([0,0,thickness]) 
                cylinder (r=button_inner_dia/2,h=button_middle,$fn=40);//middle slot
            translate([0,0,button_middle+thickness]) 
                cylinder (r=button_outer_dia/2,h=thickness,$fn=40);//top disk
        }
        translate([0,0,-1]) 
            cylinder (r=screw_size/2,h=50,$fn=40);//screw hole
        translate([0,0,button_middle+thickness]) 
            cylinder (r1=screw_size/2,r2=screw_size+3,h=button_middle+1,$fn=40);//screw head bevel
    }
}
else if(button_to_make=="1515"){
    difference(){
        union(){
            cylinder(r=button_outer_dia_1515/2,h=thickness_1515,$fn=40);//bottom disk
            translate([0,0,thickness_1515]) 
                cylinder (r=button_inner_dia_1515/2,h=button_middle_1515,$fn=40);//middle slot
            translate([0,0,button_middle_1515+thickness_1515]) 
                cylinder (r=button_outer_dia_1515/2,h=thickness_1515,$fn=40);//top disk
        }
        translate([0,0,-1]) 
            cylinder (r=screw_size_1515/2,h=50,$fn=40);//screw hole
        translate([0,0,button_middle_1515+thickness_1515]) 
            cylinder (r1=screw_size_1515/2,r2=screw_size_1515+3,h=button_middle_1515+1,$fn=40);//screw head bevel
    }
}
else if(button_to_make=="manual"){
    difference(){
        union(){
            cylinder(r=man_button_outer_dia/2,h=man_thickness,$fn=40);//bottom disk
            translate([0,0,man_thickness]) 
                cylinder (r=man_button_inner_dia/2,h=man_button_middle,$fn=40);//middle slot
            translate([0,0,man_button_middle+man_thickness]) 
                cylinder (r=man_button_outer_dia/2,h=man_thickness,$fn=40);//top disk
        }
        translate([0,0,-1]) 
            cylinder (r=man_screw_size/2,h=50,$fn=40);//screw hole
        translate([0,0,man_button_middle+man_thickness]) 
            cylinder (r1=man_screw_size/2,r2=man_screw_size+3,h=man_button_middle+1,$fn=40);//screw head bevel
    }
}
/******************************************************************************/
/**********                         Modules                          **********/
/******************************************************************************/
