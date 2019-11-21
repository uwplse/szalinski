//Part to render
part="plate"; // [plate,base,top]

//Card width
w=89;
//Card length
l=52;
//Card height/thickness
h=.25;

//Extra thickness all around in X,Y
extraxy=9.5;
//Extra thickness in Z (applied to base and top separately, so total thickness is 2*extraz+h)
extraz =6.5;

// Fraction of X,Y dims of card to make the window.
visible_percent=85; // [0:100]
visible_frac = visible_percent/100;

// Should the logo be cut into the base?
logo=true; // [true,false]

// What is one layer height?  (Set to 0 do disable the single-layer solid bridge.)
layer_height=.25;

//Nominal bolt diameter
bolt_dia=3;

//Head diameter for recessed head.  If non-recessed is desired, just set equal to  bolt_dia.
cap_head_dia=5.5;

//Height of cap head.  Don't let it get much greater than 1/2 of extraz!
cap_head_h=3;

//This diameter seems to be about right for easily fitting an M3 hex nut.
hex_nut_dia=6.4;
//Height to sink the hex nut.  Don't let it get much greater than 1/2 of extraz!
hex_nut_h=2.5;

$fs=1/10;
$fa=10/10;


// OSHW Logo Generator
// Open Source Hardware Logo : http://oshwlogo.com/
// -------------------------------------------------
//
// Adapted from Adrew Plumb/ClothBot original version
// just change internal parameters to made dimension control easier
// a single parameter : logo diameter (millimeters)
//
// oshw_logo_2D(diameter) generate a 2D logo with diameter requested
// just have to extrude to get a 3D version, then add it to your objects
//
// cc-by-sa, pierre-alain dorange, july 2012

module gear_tooth_2d(d) {
	polygon( points=[ 
			[0.0,10.0*d/72.0], [0.5*d,d/15.0], 
			[0.5*d,-d/15.0], [0.0,-10.0*d/72.0] ] );
}

module oshw_logo_2d(d=10.0) {
	rotate(-135) {
		difference() {
			union() {
				circle(r=14.0*d/36.0,$fn=20);
				for(i=[1:7]) assign(rotAngle=45*i+45)
					rotate(rotAngle) gear_tooth_2d(d);
			}
			circle(r=10.0*d/72.0,$fn=20);
			intersection() {
	  			rotate(-20) square(size=[10.0*d/18.0,10.0*d/18.0]);
	  			rotate(20)  square(size=[10.0*d/18.0,10.0*d/18.0]);
			}
    		}
  	}
}

// usage : oshw_logo_2d(diameter)


// END OSHW Logo Generator
// Downloaded from http://www.thingiverse.com/thing:27097


iter_vecs = [ [0,0,0],[w+extraxy,0,0],[w+extraxy,l+extraxy,0],[0,l+extraxy,0]];


module ridge(width, height)
{
	difference()
	{
		translate([extraxy/4,extraxy/4,h+extraz])
		{
			cube([w+extraxy/2,l+extraxy/2,2*height]);
		}
		translate([width/2+extraxy/4,width/2+extraxy/4,h+extraz])
		{
			cube([w+extraxy/2-width,l+extraxy/2-width,height]);
		}
	}
}

module base()
{
	difference()
	{
		union()
		{
			translate([-extraxy,0,0])cube([w+extraxy*3,l+extraxy,extraz+h]);
			translate([0,-extraxy,0])cube([w+extraxy,l+extraxy*3,extraz+h]);
			for(i = iter_vecs)
			{
				translate(i)cylinder(r=extraxy, h=extraz+h);
			}
			difference()
			{
				translate([-2.5-extraxy,(l/2+extraxy/2),(extraz+h)/2])cube([11,14,extraz+h],center=true);
				translate([-2.5-extraxy,(l/2+extraxy/2),(extraz+h)/2])cube([5,8,extraz+h],center=true);
			}
			//ridge(ridge_width);
		}
		translate([extraxy/2, extraxy/2, extraz]){cube([w,l,h]);}
		for(i = iter_vecs)
		{
			translate(i){translate([0,0,2.5+layer_height])cylinder(r=bolt_dia/2, h=extraz+h); cylinder(r=hex_nut_dia/2, hex_nut_h, $fn=6);}
		}
	if(logo == true)
	{
		translate([(w/2+extraxy/2),(l/2+extraxy/2),0]){
			linear_extrude(height=extraz+h)
				oshw_logo_2d(min(l,w));
		}
	}

	}
}

module top()
{
	difference()
	{
		union()
		{
			translate([-extraxy,0,0])cube([w+extraxy*3,l+extraxy,extraz+h]);
			translate([0,-extraxy,0])cube([w+extraxy,l+extraxy*3,extraz+h]);
			for(i = iter_vecs)
			{
				translate(i)cylinder(r=extraxy, h=extraz+h);
			}
		}
		//translate([0,0,-h*2])ridge(ridge_width*1.2, ridge_height*1.2);
		translate([extraxy/2+w*(1-visible_frac)/2, extraxy/2+l*(1-visible_frac)/2, 0]){cube([w*visible_frac,l*visible_frac,extraz+h]);}
		for(i = iter_vecs)
		{
			translate(i){cylinder(r=bolt_dia/2, h=extraz+h); translate([0,0,extraz+h-3])cylinder(r=cap_head_dia/2, h=cap_head_h);}
		}
	}
}


module plate()
{
	top();
	translate([0,l+extraxy*4,0]) base();
}

if(part == "plate")
	plate();
else if(part == "top")
	top();
else if(part == "base")
	base();