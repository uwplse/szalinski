// Version 2.0 of the Business Card Maker
// http://www.thingiverse.com/thing:1728443

// Changelog
// 2.0
// Remixed http://www.thingiverse.com/thing:1713563 (version 1)
// Now having text embossed and debossed

// All text is optional. You can change the order of the lines in the "Extras-and-spacing" submenu
/* [Basic details] */


name = "COMPANY"; // Company name
thin_line = 60; // [60:Line, 80:Wide line,0:No line]
line2 = "Your Name"; // Open letters
line3 = "+1-234-567-1234"; // Embossed text
line4 = "3dcards@thecapital.nl"; // Debossed bold text


/* [Fonts] */
// Bigger is better. Minimum recommended size is 6 for any detail.
Font_line_1 = "Allerta Stencil"; // ["Allerta Stencil":Alerta,"Sirin Stencil":Sirin, "Stardos Stencil":Stardos]
Fontsize_line_1 = 10; // [6:0.1:24]

// For the font detail of Sirin Stencil choose a font size > 10. You might be able to compensate with spacing in de extra's tab
Font_line_2 = "Stardos Stencil"; // ["Allerta Stencil":Alerta,"Sirin Stencil":Sirin, "Stardos Stencil":Stardos]
Fontsize_line_2 = 9 ; // [6:0.1:24]


Font_line_3 = "Liberation Mono";// ["Allerta Stencil":Alerta,"Sirin Stencil":Sirin, "Stardos Stencil":Stardos,"Liberation Mono":Mono, "Liberation Sans":Sans, "Liberation Serif":Serif]
// You can try a really small font like 4 but the letters will not be open. Good thing about that is that 'islands' will not fall out.
Fontsize_line_3 = 5; // [3:0.1:24]

Font_line_4 = "Liberation Sans";// ["Allerta Stencil":Alerta,"Sirin Stencil":Sirin, "Stardos Stencil":Stardos,"Liberation Mono":Mono, "Liberation Sans":Sans, "Liberation Serif":Serif]
Fontsize_line_4 = 5; // [3:0.1:24]

/* [Extras and Spacing] */
// You can use spacing
Spacing_line_1 = 0.92; // [0.5:0.01:2.0]
offset_line_1 = 14; // [0:0.5:24]
Spacing_line_2 = 1; // [0.5:0.01:2.0]
offset_line_2 = -2; // [-24:0.5:24]
Spacing_line_3 = 1.2; // [0.5:0.01:2.0]
offset_line_3 = -14.5; // [-24:0.5:0]
Spacing_line_4 = 1; // [0.5:0.01:2.0]
offset_line_4 = -22.5; // [-24:0.5:0]

Plastic_thickness = 0.52;


/* [Hidden] */
// preview[view:south, tilt:top]

use <AllertaStencil-Regular.ttf>
use <SirinStencil-Regular.ttf>
use <StardosStencil-Bold.ttf>
$fn=120;

difference(){
    union(){
        linear_extrude(height=Plastic_thickness){
          difference(){
            offset(4){square([76,46], center = true);};
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
          }
        };
        color("DarkBlue"){
        linear_extrude(height=Plastic_thickness+0.2){
        translate([0,offset_line_3,0]){
            text(line3, size=Fontsize_line_3, halign="center", font=Font_line_3, spacing=Spacing_line_3);
        }}}
    }
        translate([0,offset_line_4,Plastic_thickness-0.2]){
            linear_extrude(height=Plastic_thickness){
                text(line4, size=Fontsize_line_4, halign="center", font=str(Font_line_4,":style=Bold"), spacing=Spacing_line_4);
    }
}

    
}

    
;