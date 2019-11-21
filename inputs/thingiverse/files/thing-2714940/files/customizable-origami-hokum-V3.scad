/*
 * Customizable Origami - Hokum
 * 
 * created 2017-11-23
 * version v1.0
 *
 * Changelog
 * --------------
 * v2.0:
 *      - final design
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - NonCommercial - ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */


// preview[view:north, tilt:top]

// The maximum size of creation. Or the minimum, depending on your viewpoint.
hokum_pokum = 10; //[20:300]

// Higher.
dont_use_its_dangerous = 10; //[0.2:0.2:100]

// No idea what this does
No_idea_what_this_does = 5; 

// Flip model
flip_model = "no"; //[yes,no]


module TheThing()
{
    cube([hokum_pokum,dont_use_its_dangerous,No_idea_what_this_does]);
}

if(flip_model == "yes") {
    mirror([0,1,0]) {
        rotate([180,180,0]) {    
            TheThing();
        }
    }
} else {
    TheThing();
}

