// preview[view:north east, tilt:top]

// how tall to make the piece. mm.
tubeheight= 40; // [10:200]
// diameter of the largest pipe mounth
largestpipe = 56; // [10:100]
// fan size in mm
fansize = 41.5; // [10:200]
// distance from mounting holes centers. mm
mountingholes = 32; //[8:195]
// distance from each of the hexagon sides. mm (0 to disable and screw in directly on the plastic)
nutsize = 6.3;
// diameter of the screw. mm
screwdiam = 3.5;
// thinest wall printable. 2mm is sturdy enough
wallthickness=2;

// value used on $fn (i.e. how many faces to use on cylinders sides)
facerez = 20;

// advanced: how much to overshoot difference()s so that the preview doesn't show
// mangled faces if the subtracted faces matches while previewing in openSCAD.
clearpreview = 1;


module fan(size,tall){
	difference(){
		// + body
		cube([size,size,tall], true);
		// + holes
		// - blades
		translate([0,0,-tall])
			cylinder(h=tall*2, r=size*0.45);
		// - screws
		// TODO: screw holes
	}
}
module pipe(diam){
	difference(){
		circle(r=diam/2);
		circle(r=diam/2-wallthickness);
	}
}



module conector(fansize,pipe,tall){
	difference()
	{
		union()
		{
			translate([-(fansize+wallthickness)/2,-(fansize+wallthickness)/2,tall-5])
				cube([fansize+wallthickness,fansize+wallthickness,5]);
			hull()
			{
				color("green") translate([0,0,tall-5] ) cube([fansize+wallthickness,fansize+wallthickness,1],true);
				color("red")   translate([0,0,0] ) cylinder(1,(pipe/2)+wallthickness, $fn=facerez);
			}
		}
		union()
		{
			translate([-fansize/2,-fansize/2,tall-5])
				cube([fansize,fansize,5+clearpreview]);
			color("blue") hull()
			{
				color("darkgreen") translate([0,0,tall-5] ) cylinder(1,(fansize-2)/2,$fn=facerez);
				color("darkred") translate([0,0,-1] ) cylinder(1,pipe/2,$fn=facerez);
			}
			// nut holder
			translate([0,0,wallthickness]){
			translate([mountingholes/2,  -mountingholes/2,0]) cylinder(d=nutsize,h=tall-5-(2*wallthickness), $fn=6); // hexagon nut holder
			translate([mountingholes/2,  mountingholes/2, 0]) cylinder(d=nutsize,h=tall-5-(2*wallthickness), $fn=6);
			translate([-mountingholes/2, -mountingholes/2,0]) cylinder(d=nutsize,h=tall-5-(2*wallthickness), $fn=6);
			translate([-mountingholes/2, mountingholes/2, 0]) cylinder(d=nutsize,h=tall-5-(2*wallthickness), $fn=6);
			// screw hole
			translate([mountingholes/2,  -mountingholes/2,0]) cylinder(d=screwdiam,h=tall, $fn=facerez);
			translate([mountingholes/2,  mountingholes/2, 0]) cylinder(d=screwdiam,h=tall, $fn=facerez);
			translate([-mountingholes/2, -mountingholes/2,0]) cylinder(d=screwdiam,h=tall, $fn=facerez);
			translate([-mountingholes/2, mountingholes/2, 0]) cylinder(d=screwdiam,h=tall, $fn=facerez);
			}
		}
	}
}
module batteryholder(){ // AA = 50lenght, 14 radius
	union(){
		rotate([0,90]) cylinder(h=50, r=14, center=true);
		translate([0,7,0]) cube([50,14,28], center=true);
	}

}


//pipe(largestpipe);
//color("red") translate([0,0,40]) fan(fansize,1);



conector(fansize,largestpipe,tubeheight);

/* translate([-largestpipe-5, 0,0])
difference()
{
	conector(fansize,largestpipe, 50 );
	translate([-50,0,-10]) cube([100,100,100]);
}

/*
   mirror([0,0,0]){
   translate([0,-fansize+7,50-14])
   color("purple") batteryholder();
   }
   mirror([0,1,0]){
   translate([0,-fansize+7,50-14])
   color("purple") batteryholder();
   }
/* */
