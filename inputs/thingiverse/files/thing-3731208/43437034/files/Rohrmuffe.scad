// Hoehe des unteren Ring (1) in mm
ring1height=50; // [20:100]

//Hoehe des oberen Ring (2) in mm
ring2height=50; // [20:100]

// Hoehe des Uebergangs zwischen den Ringen
hoehe=20; // [10:80]

// Wanddicke in mm
wanddicke=5; // [2:10]

// Innendruchmesser Ring (1) in mm
durchmesser=155; // [5:500]

// Aussendruchmesser Ring (2) in mm
aussendurchmesser=150; // [10:500]

/* [Hidden] */
$fn=180;

// preview[view:south, tilt:top diagonal]

/* [Global] */

module ring1(hoehe,id,wd)
{
difference()
	{   
cylinder(h=hoehe, d=id+(wd*2),center=false);
cylinder(h=hoehe+0.001 ,d=id,center=false);
	}
}


module ring2(hoehe,id,wd)
{
difference()
	{   
cylinder(h=hoehe,d=id,center=false);
cylinder(h=hoehe+0.001,d=id-(2*wd),center=false);
	}
}

module verjuengung(rh,id1,id2,wd)
{
difference()
	{
cylinder(h=rh,d1=id1+(wd*2),d2=id2,center=false);
cylinder(h=rh,d1=id1,d2=id2-(wd*2),center=false);
	}
}

module kante(id,wd)
{
difference()
	{
cylinder(h=5,d1=id,d2=id-(wd),center=false); 
cylinder(h=5+0.001,d=id-(2*wd),center=false); 
	}
}


union ()
{
translate([200,0,0]) ring1(ring1height,durchmesser,wanddicke);
translate([200,0,ring1height]) verjuengung(hoehe,durchmesser,aussendurchmesser,wanddicke);
translate([200,0,ring1height+hoehe]) ring2(ring2height,aussendurchmesser,wanddicke);
translate([200,0,ring1height+hoehe+ring2height]) kante(aussendurchmesser,wanddicke);
}