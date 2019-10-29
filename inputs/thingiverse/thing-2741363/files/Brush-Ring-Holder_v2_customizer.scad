
/** *** ***** ******* ***********
//
// Generic Ring Object Storage/Dispenser - Ringhalter
// 
// Version 2 - 11.09.2017 : Customizer
// CC-BY-NC-SA October 2017 by ohuf@Thingiverse
//
// www.thingiverse.com/thing:2741363


(English text: scroll down...)

Ein generischer, zweiteiliger Halter / Spender für Ringe und "ringartige Objekte": Dichtungen, Muttern, Marierungsringe....
Die Ringe werden auf einen Dorn aufgezogen. zwei Platten oben und unten verhindern ein Herausrutschen der Ringe.

Der Clou an der Sache ist, dass durch die Konstruktionsweise das Entnehmen eines beliebigen Ringes in der "Kette" möglich ist, ohne alle oberen Ringe herunternehmen zu müssen!

Wenn du einen hergestellt hast, lass es mich über "I Made One" wissen!

Konstruiert in OpenSCAD: viel Spaß beim Remixen!


-- --- ----- ------- -----------

This is a simple 2-part Holder/Storage/Dispenser for rings and "ring-like objects".
The rings are being put over a central pin. The special thing about this Holder is the dispenser-function: You can take out any one of the rings in the "chain" without first removing the rings above it: just pull the base plates, separate the ring(s) you need, separate the two pins and remove the rings you want.

See the photos for how to use it...

You can use the customizer to create your own Ring Dispenser...


Enjoy, have fun remixing and let me know when you've made one, and what for!

// 
// License: CC-BY-NC-SA 11.09.2017 oli@huf.org
// read all about it here: http://creativecommons.org/licenses/by-nc-sa/4.0/
//
** *** ***** ******* ***********/





/* [Size] */

// The outer diameter of the pin. This must be equal to or smaller than the inner diameter of your rings.
d_outer = 13;

// - The overall height. This defines how many objects you can store
height = 33;

// - Correctional factor for inner tube: if your printer is *very exact* then leave this at "0". However, if the two parts have a fit too tight to slide, you can increase this by small steps (e.g.: 0.2mm). Increase means higher gap!
corr = 0;

// The outer diameter of your objects. This defines the size of the base plate.
base_plate_size = 20;	

//  - You can select which part you want to design (Default: Both!)
create=1; // [1:Both Parts, 0:Inner Only, 2:Outer Only]


/* [Hidden] */

// roundness:
$fn=50;

// the wall thickness
d_wall = 3;


// hidden
d_inner = d_outer-d_wall-corr;


if(create>0){
	// outer part:
	union(){
		difference(){
			cylinder(d=d_outer, h=height);
			cylinder(d=d_outer-d_wall+corr/2, h=height+0.005);
		}
		cube([base_plate_size, base_plate_size, d_wall], center=true);
	}
}

if(create<2){
	// inner part:
	translate([base_plate_size+10, 0, 0])
	union(){
		difference(){
			cylinder(d=d_outer-d_wall-corr/2, h=height-0.5);
			cylinder(d=d_outer-2*d_wall, h=height-0.5+0.005);
		}
		cube([base_plate_size, base_plate_size, d_wall], center=true);
	}
}

