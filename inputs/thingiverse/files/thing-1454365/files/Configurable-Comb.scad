/* +----------------------------------+
   |        CONFIGURABLE COMB         |
   +----------------------------------+
   | First release: 12 DEC 2016       |
   | Author: Henrik Sozzi             |
   | Country: Italy                   |
   | E-Mail: henrik_sozzi@hotmail.com |
   +----------------------------------+-----------------------+
   | Twitter: https://twitter.com/henriksozzi                 |
   | Thingiverse: http://www.thingiverse.com/energywave/about |
   | 3DHUB: https://www.3dhubs.com/milan/hubs/3d-lab          |
   | Shapeways: http://3dlabshop.com                          |
   +----------------------------------------------------------+
   | LICENSE: Creative Commons - Attribution - Non-Commercial |
   | All uses not included in the license like, but not       |
   | limited to, commercial use should be authorized by the   |
   | author in a written form. If not authorized all other    |
   | uses are forbidden and persecuted by law.                |
   +----------------------------------------------------------+
*/

/* [Main] */

// Thickness of the comb
Thickness=2; // [0.4:0.1:5]

// Height of the body
BodyHeight=7; // [1:1:50]

/* [Teeth] */

// Width of the teeth
TeethWidth=1.2; // [0.4:0.1:5]

// Length of the teeth
TeethLength=20; // [2:1:50]

// Space between teeth
TeethSpacing=2; // [0.5:0.5:30]

// Number of teeth
TeethNumber=30; // [1:100]

/* [Handle] */

// Is handle present?
HandlePresent=1; // [0:no, 1:yes]

// Is handle terminated with a rounded end?
HandleRounded=1; // [0:no, 1:yes]

// Handle length
HandleLength=60; // [2:1:300]

// Height of the handle
HandleHeight=15; // [1:1:50]



TotTeethLength=(TeethWidth + TeethSpacing) * TeethNumber - TeethSpacing;

linear_extrude(height=Thickness, convexity=10){
    //Teeth body
    square([TotTeethLength, BodyHeight]);
    //Handle
    if (HandlePresent){
        translate([TotTeethLength,BodyHeight-HandleHeight,0])
            square([HandleLength, HandleHeight]);
        if (HandleRounded)
            translate([TotTeethLength+HandleLength,BodyHeight-HandleHeight+HandleHeight/2,0])
                circle(d=HandleHeight);
    }

    //Teeth
    for (t=[0:TeethNumber-1])
        translate([(TeethWidth+TeethSpacing)*t,-TeethLength,0])
            square([TeethWidth, TeethLength]);
}