/** *** ***** ******* ***********
//
// IKEA GRUNDTAL Shaver Holder 
// Version 4 - 2017-12-30 : Customizer
// CC-BY-NC-SA December 2017 by ohuf@Thingiverse
//
// www.thingiverse.com/thing:2739758


(English text: scroll down...)

Ein einfacher Halter für einen Einweg-Nassrasierer.
Der Halter passt an das "GRUNDTAL" Eckregal von IKEA (s.Fotos).

Anpassbare Version: Benutze den Customizer um die Länge des Halters festzulegen.
Außerdem lässt sich auf dem Halter ein kurzer, einzeiliger Text aufdrucken - oder eingravieren.

Wenn du einen hergestellt hast, lass es mich über "I Made One" wissen!

Konstruiert in OpenSCAD: viel Spaß beim Remixen!


-- --- ----- ------- -----------

This is a simple shaver holder for an IKEA "GRUNDTAL" bathroom corner shelf. I made this one in OpenSCAD.

See the photos for reference:
This is a customizable version. you can define the length of the holder as well as a short one-liner text. The text can be embossed on the holder or it can be stenciled out. Several different fonts and styles have been pre-defined in the customizer. 


Enjoy, have fun remixing and let me know when you've made one, and what for!

// 
// License: CC-BY-NC-SA by oli@huf.org
// read all about it here: http://creativecommons.org/licenses/by-nc-sa/4.0/
//
** *** ***** ******* ***********/


/* [Text on Holder] */
// - Text to print or stencil out on the hanger. Leave empty for no text.
mytext="Hers";

// - Embossed Text or Stenciled Text
embossed=1; //[1:Embossed, 0:Stenciled]

// - Size of the text; Default is 12
mytextsize=12;

// - Thingiverse suppports the Google Fonts (https://fonts.google.com/). This is a subset.
fontName="Helvetica Light"; // [Helvetica, Helvetica Light, Roboto, Roboto Condensed, Oswald, 	Playfair Display, Indie Flower, Audiowide, Coustard, Manual] 

// - If the font name selection is "Manual", this font will be used. Default is "Roboto Condensed". You could add Style modifiers like this: "Roboto Condensed:style=Bold". See https://fonts.google.com/ for more fonts.
manualFont="Roboto Condensed"; 

/* [Size of the holder] */
// Length of the holder || Länge (Höhe) des Halters
h2 = 75;


/* [Hidden] */
z1=44;		// object's width
cut_w=25;	// width of cut-out for the shaver's handle
d1=14;	// Radius of the lower "hook" for the shaver 
d2=11; 	// Radius of the upper hook where it hangs in the "GRUNDTAL" rack 
mat=1;	// material thickness

$fn=100;
dt1=0.001;
dt2=dt1*2;


//fontName="Helvetica Thin"; // [Helvetica, Helvetica Light, Palatino, Portago, Papyrus, Helvetica Thin, Arial, Arial Narrow, American Typewriter, American Typewriter Semibold]font1="Helvetica Neue";
// Local font list on my Mac ;-)
font2="Helvetica:style=Light";
font3="Palatino Linotype:style=standard";
font4="PortagoITC TT";
font5="Papyrus";
font6="Helvetica Neue:style=Thin"; 	// :-)
font7="Arial";
font8="Arial Narrow";
font9="American Typewriter";
font10="American Typewriter:style=Semibold";

//myfont=font6;		// see font list
myfont=isManualFont() ? manualFont : getFont();



rotate([-90,0,0])
difference(){
	union(){
		difference(){
			union(){
				cylinder(d=d1, h=z1);
			}
			union(){
				// Rasierer-Halte-Haken unten:
				translate([0, 0, -dt1])	// fix for customizer bug
				cylinder(d=d1-2*mat, h=z1+dt2);	
				translate([-d1/2-2,-d1/2, -dt1])	// vorne leicht umzogen, um Rasierer zu halten (support!)
				cube([d1/2+dt2, d1/2+dt2, z1+dt2]);	// Abschnitt vorne (Kreisviertel und mehr)
				translate([-d1/2, 0, -dt1])
				cube([d1/2+dt2, d1/2+dt2, z1+dt2]);		// Abschnitt hinten (Kreisviertel)
				translate([-d1/2,-d1/2, z1/2-cut_w/2])
				cube([d1, d1/2, cut_w]);
			}
		}
		// Hintere Platte nach oben:
		translate([-h2,d1/2-mat, 0])
		cube([h2, mat, z1+dt1]);

		// Halte-Haken Oben:
		translate([-h2, (d1-d2)/2, 0])
		difference(){
			cylinder(d=d2, h=z1);
			union(){
				translate([0, 0, -dt1])	// fix for customizer bug
				cylinder(d=d2-2*mat, h=z1+dt2);	
				translate([0,-d2/2, -dt1])
				cube([d2/2, d2, z1+dt2]);
			}
		}

		//// Text embossed:
		if(embossed==1)
			initial( mytext );

	}

	// Text cut out:
	if(embossed==0){
		translate([0, 1, -dt1])
		initial( mytext );
	}
//initial( "His" );
//	color("red")
//	translate([-12, 10, z1/2])
//	rotate([90, -90, 0])
//	linear_extrude(height = 10) {
//		text("His", font = font1, size = 17, direction = "ltr", halign="center", valign="bottom", spacing = 1 );
//	}

}

module initial ( txt ) {
		color("red")
	translate([-12, d1/2, z1/2])
	rotate([90, -90, 0])
	linear_extrude(height = mat+1+dt2) {
		text(txt, font = myfont, size = mytextsize, direction = "ltr", halign="center", valign="baseline", spacing = 1 );
	}
}



function isManualFont() = fontName == "Manual" ? true : false;

function getFont() = fontName == "Helvetica" ? "Helvetica Neue"
	: fontName == "Helvetica Light" ? "Helvetica:style=Light"
	: fontName == "Palatino" ? "Palatino Linotype:style=standard"
	: fontName == "Portago" ? "PortagoITC TT"
	: fontName == "Papyrus" ? "Papyrus"
	: fontName == "Arial" ? "Arial"
	: fontName == "Arial Narrow" ? "Arial Narrow"
	: fontName == "American Typewriter" ? "American Typewriter"
	: fontName == "American Typewriter Semibold" ? "American Typewriter:style=Semibold"
	: fontName == "Roboto" ? "Roboto:style=Medium" 
	: fontName == "Roboto Condensed" ? "Roboto Condensed"
	: fontName == "Oswald" ? "Oswald"
	: fontName == "Playfair Display" ? "Playfair Display"
	: fontName == "Indie Flower" ? "Indie Flower"
	: fontName == "Audiowide" ? "Audiowide"
	: fontName == "Coustard" ? "Coustard"
	: fontName == "Manual" ? "Manual"
	: fontName;

