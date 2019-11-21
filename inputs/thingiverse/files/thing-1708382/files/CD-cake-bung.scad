/* *** *** ***
CD cake lid bung
By MisterC

This size fits TDK cakes, possibly others
   *** *** *** */

// Your text here, up to 8 characters fits best
text_string="PLA";

// Text indented by default, set to false for embossed
text_engrave=true;  //[true,false]

// These sizes fit nicely, adjust if you want
text_size=8;    // height of text
text_thk=3;     // thickness of text
/* Note actual thickness is half this as the
write routine places the text centrally */

use <write/Write.scad>

// Sizes for TDK cakes
bung_thk=5;     // Thickness
bung_dia=34;    // Diameter
no_ribs=6;      // Number of ribs
rib_w=1;        // Rib width
rib_l=6;        // Rib length


// Overall definition
$fa=1;

module DoText()
{
translate([0,0,bung_thk])
write(text_string,h=text_size,t=text_thk,center=true);
}


// And now the model
difference()
{
    // Hub
    cylinder(bung_thk,d=bung_dia);

    // Cut out ribs
    for (ang=[30:360/no_ribs:360])
        rotate([0,0,ang])
        translate([(bung_dia-rib_l)/2,0,bung_thk/2])
        cube([rib_l,rib_w,bung_thk+1],true);
    // cut out text if required
    if (text_engrave) DoText();
}
// emboss text if required
if (!text_engrave) DoText();



