/*
* Parametric Harry Potter Deathly Hallows Sign
*
*   Author: Bryan Smith - bryan.smith.dev@gmail.com
*   Created Date: 9/13/16
*   Updated Date: 9/13/16
*   Version: 1.0
*
*
*  Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License
*       (https://creativecommons.org/licenses/by-nc-nd/3.0/legalcode)
*/

///////////////////////////////////////////////////////////////////
// Parameters
///////////////////////////////////////////////////////////////////
//How thick to make the charm in mm.
charmThickness=2;

//How wide and tall to make the charm in mm. (excluding the clasp)
charmSize=30;

//Generate a clasp for a necklace?
clasp = "yes"; // [yes,no]

//What size of hole in the clasp in mm.
claspHoleSize=3;

//How thick to make the clasp outline in mm.
claspThickness=2;

///////////////////////////////////////////////////////////////////
// Render
///////////////////////////////////////////////////////////////////
deathlyHallowsSign(charmSize,charmThickness, clasp, claspHoleSize,claspThickness);

///////////////////////////////////////////////////////////////////
// DeathlyHallowsSign - Generates the Deathly Hallows Sign Geometry
///////////////////////////////////////////////////////////////////
module deathlyHallowsSign(size=30,thickness=2,clasp = "yes", holeSize=1.5, claspThick) {
    scale(size/30)                              //Scale to desired size in mm based on 30mm initial design
    linear_extrude(thickness/(size/30), $fn = 200)        //Extrude to the desired thickness.
    union(){                                    //Let make all three items, one.
        if (clasp == "yes"){                             //If we want a necklace clasp we need to generate one
            translate([0,30+thickness*3,0]) 
            hollow(claspThick/(size/30)) circle(r=holeSize/(size/30));
        }
        translate([0,7.5,0]) square([2,45],true);       //Bar: Elder Wand
        hollow(3) rotate(90) circle(r=32.5, $fn=3);     //Circle: Resurrection Stone
        hollow(3) circle(r=15,center = true);           //Triangle: Cloak of Invisibility
    }
}

///////////////////////////////////////////////////////////////////
// Hollow - Hollows out a shape/solid leaving an outline
///////////////////////////////////////////////////////////////////
module hollow(outline = 1) {
    difference() {
        offset(outline / 2) children();
        offset(-outline / 2) children();
    }
}

