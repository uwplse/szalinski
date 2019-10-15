/** *** ***** ******* ***********
//
// Deodorant Roll-On Upside-Down Stand
// Version 2 - 03.01.2018 
// CC-BY-NC-SA January 2018 by ohuf@Thingiverse
//
// Cylindrical version: www.thingiverse.com/thing:2743048
// Cubic version: www.thingiverse.com/thing:2743147
// Customizer: www.thingiverse.com/thing:2743081


(Deutscher Text: Siehe unten...)

Do you know those deodorant bottles with a spherical cap?
They are a perfect example for form __not__ following function!

Having them upright is a terrible waste of time in the morning, especially when they're half-empty - or half-full, depending on your view on that kind of things: you have to wait till the fluid on the inside hat reached the roll-on ball ....

So I designed this simple upside-down stand.
There are two main designs: a cubic or a cylindrical body. Those can be mixed-and-matched wit a square or circular base plate.
There is also a purist cubic version online: []()


Enjoy, have fun remixing it and let me know when you've made one, and what it looks like!


-- --- ----- ------- -----------
[DE:]

Ich nutze diese Deo-Roll-On's, die einen halbkugelförmigen Deckel haben. Das Design der Verpackung ist ein perfektes Gegenbeispiel zu "Form folgt Funktion": Sobald die Flasche nur noch halbleer (oder halbvoll) ist, dauert es eine gefühlte Ewigkeit, bis der Inhalt an der Kugel angekommen ist - vor allem morgens, wenn der Kopf noch nicht so schnell ist ;-)
Durch den runden Deckel lässt sich die Fasche aber nicht kopfüber lagern.

Ich habe diesen einfachen Ständer entworfen, mit dem sich Deo-Roll-On's kopfüber lagern lassen.
Der Customizer erlaubt die Auswahl zwischen zwei prinzipiellen Designs: kubisch oder zylindrisch. Diese beiden lassen sich wahlweise mit einer kreisförmigen oder einer quadratischen Bodenplatte kombinieren.

Wenn du einen hergestellt hast, lass es mich über "I Made One" wissen!

Konstruiert in OpenSCAD: viel Spaß beim Remixen!

// 
// License: CC-BY-NC-SA 03.01.2018 oli@huf.org
// read all about it here: http://creativecommons.org/licenses/by-nc-sa/4.0/
//
** *** ***** ******* ***********/


// - Diameter of the circular bottle. Same as the diameter of the spherical cap
dia_in=42;

//- Vertical size of the stand
height=45;

// - Form of the stand
base_type="circular";	//[circular, cubic]
//base_type="cubic";

// - Form of the base plate
foot_type="circular";		//[circular, cubic, none]
//plate_type="cubic";	
//plate_type="none";	

// - Additional size of the base plate
foot_size=16;

/*[Hidden]*/
$fn=200;
mat=2;
dt1=0.001;
dt2=2*dt1;

dia_out=dia_in+mat;
base_width=dia_out+foot_size;
//dia_out=height;	// "purist" cubic version :-) - print with plate_type=none

difference(){
	if(base_type=="circular"){
		cylinder(d=dia_out, h=height);
	} else {
		translate([-dia_out/2, -dia_out/2, 0])
		cube([dia_out, dia_out, height]);
	}
	union(){
		translate([0, 0, mat+dia_in/2])
			sphere(d=dia_in);
		translate([0, 0, mat+dia_in/2])
			cylinder(d=dia_in, h=height+dt1);
	}
}

if(foot_type=="circular"){
	cylinder(d=base_width, h=mat);
} else if(foot_type=="cubic"){
	translate([-base_width/2, -base_width/2, 0])
	cube([base_width, base_width, mat]);
}







