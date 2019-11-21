/****************************
 * Coin Customizer          *
 * 1.0                      *
 * Jan 2016                 *
 * Stafford Tyo             *
 * Standards Electronics    *
 ****************************
 */

/* [Text] */

//Use only one or two characters, this is not meant for words (too long for a coin)
text=10;

//Height of the text, adjust as necessary to fit it on the coin
text_height=8;

//Stencil Font to use
font="Allerta Stencil"; //[Allerta Stencil,Stardos Stencil,Sirin Stencil]

/* [Coin] */

//Total coin diameter, in mm
coin_diameter=15; //[5:40]

//Number of sides to the coin, the more there are the smoother the circle
coin_facets=20; //[6:100]

//Overall thickness of the coin, best used with a multiple of your extrude height)
coin_thickness=0.9; //[0.2:0.1:4]


// preview[view:south, tilt:top]

//Written by Stafford Tyo, Standards Electronics 2016

a=coin_diameter;
b=coin_facets;
c=text_height;
d=coin_thickness;
e=(str(text));
f=font;

difference() {

cylinder (h=d, d=a, $fn=b);

linear_extrude(height=d*4, center=true, convexity=10) {
text (text=e, font=f, halign="center", valign="center", size=c);

}
}

