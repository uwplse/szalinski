// Version 1.1 of the Business Card Makeer
// Changelog
// - fixed fonts. Style doesn't work
// - Smaller steps in spaing
// - steps in offset
/* [Basic details] */
name = "3D Print co."; // Companyname
thin_line = 60; // [60:Line, 80:Wide line,0:No line]
line2 = "Your Name";
line3 = "design@thecapital.nl";

/* [Fonts] */
// Bigger is better. Minimum recommended size is 6 for any detail.
Font_line_1 = "Stardos Stencil"; // ["Allerta Stencil":Alerta,"Sirin Stencil":Sirin, "Stardos Stencil":Stardos]
Fontsize_line_1 = 8.2; // [6:0.2:24]

// For the font detail of Sirin Stencil choose a font size > 10. You might be able to compensate with spacing under > extras-and-spacing
Font_line_2 = "Sirin Stencil"; // ["Allerta Stencil":Alerta,"Sirin Stencil":Sirin, "Stardos Stencil":Stardos]
Fontsize_line_2 = 10.2 ; // [6:0.2:24]


Font_line_3 = "Standard";// ["Standard":Standard, "Allerta Stencil":Alerta,"Sirin Stencil":Sirin, "Stardos Stencil":Stardos]
// You can try a really small font like 4 but the letters will not be open. Good thing about that is that 'islands' will not fall out.
Fontsize_line_3 = 4.2; // [4:0.2:24]

/* [Extras and Spacing] */
// You can use spacine
Spacing_line_1 = 1.1; // [0.5:0.01:2.0]
offset_line_1 = 15; // [0:0.5:24]
Spacing_line_2 = 1.06; // [0.5:0.01:2.0]
offset_line_2 = -2; // [-24:0.5:24]
Spacing_line_3 = 1.22; // [0.5:0.01:2.0]
offset_line_3 = -20; // [-24:0.5:0]


Plastic_thickness = 0.42;


/* [Hidden] */
// preview[view:south, tilt:top]

use <AllertaStencil-Regular.ttf>
use <SirinStencil-Regular.ttf>
use <StardosStencil-Bold.ttf>
$fn=60;


linear_extrude(height=Plastic_thickness){
difference(){
    offset(2){square([81,51], center = true);};
    translate([0,offset_line_1,0]){
    text(name, size=Fontsize_line_1, halign="center", font=Font_line_1, spacing=Spacing_line_1);
    }    
    if (thin_line){
        translate([0,10]){
            square([thin_line,1], center=true);
        }
    }
    translate([0,offset_line_2,0]){
    text(line2, size=Fontsize_line_2, halign="center", font=Font_line_2, spacing=Spacing_line_2);
    }
    translate([0,offset_line_3,0]){
    text(line3, size=Fontsize_line_3, halign="center", font=Font_line_3, spacing=Spacing_line_3);
    
}}}
;