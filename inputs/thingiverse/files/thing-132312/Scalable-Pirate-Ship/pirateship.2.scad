//A remix of OpenSCAD Pirate Ship
//by MakerBlock, published Oct 24, 2011
//http://www.thingiverse.com/thing:12856
//A few tweaks for use with customizer by Ari M. Diacou on 8-12-2013

//The thickness of the thin structures
thickness=0.6;
//Approximate size of the ship
shipscale=50;
//What level of curviness is acceptable?
fn=64;

th=thickness;

ship();

module ship(size=shipscale)
	{
	sails(size);
	hull(size);
	rudder(size);
	bowsprit(size);
	//Uncomment the next line to see cube(size) for comparasion:
	//% translate([0,0,size/4]) cube(size, center=true);
	}

module rudder(rh)
	{
	intersection()
		{
		translate([0,rh*-25/64,rh*-10/64]) cube([th,rh*5/32,rh*13/64], center=true);
		translate([0,rh*-33/64,rh*-1/64]) rotate([0,90,0]) cylinder(r=rh*8/32,h=th,$fn=fn);	
		}
	}

module bowsprit(bs)
	{
	translate([0,bs*37/64,bs*3/64]) rotate([290,0,0]) intersection() 
		{
		scale([0.5,1,1]) cylinder(r1=bs*8/64,r2=th,h=bs/3,$fn=fn/4,center=true);	
		translate([0,bs/2,0]) cube(bs,center=true);
		}
	}

module hull(hl)
	{
	difference()
		{
		translate([0,hl*-1/32,-hl*3/32]) union()
			{
			scale([0.7,2.1,1]) translate([0,0,-hl/12]) 
				cylinder(r1=hl/6, r2=hl/4, h=hl/6, $fn=fn,center=true);
	
			difference()
				{
				scale([0.7,2.1,1]) translate([0,0,hl/12]) 
					cylinder(r=hl/4, h=hl/6, $fn=fn,center=true);
				difference()
					{
					scale([0.7,2.1,1]) translate([0,0,hl/12+th/4]) 
						cylinder(r=(hl/4) -th, h=hl/6, $fn=fn,center=true);
					translate([0,-hl*13/32,hl/32]) cube([hl,hl/4,hl/4],center=true);
					translate([0,-hl*12/32,-hl*2/32]) cube([hl,hl/4,hl/4],center=true);
					translate([0,hl*14/32,-hl*2/32]) cube([hl,hl/4,hl/4],center=true);
					translate([0,-hl*15/32,hl/32]) cube([hl,hl/8,hl/2],center=true);
					}
				translate([0,hl/4.5,hl/1.7]) cube(hl, center=true);
				translate([0,hl*1/32,hl*9/32]) cube(hl/2, center=true);
				}
			}
		translate([0,-hl*17/32,hl/32]) cube([hl,hl/8,hl/2],center=true);
		}
	}
	
module sails(mh)
	{
	translate([0,0,mh*-4/62]) 
		{
		translate([0,0,mh*28/32]) cylinder(r1=mh*2/64,r2=mh*2.5/64,h=mh*3/64,$fn=fn/4,center=true);
		translate([0,0,mh*53/64]) cylinder(r1=th/2,r2=mh*2/64,h=mh*3/64,$fn=fn/4,center=true);
		translate([0,mh/4,0]) rigging(mh*5/6);
		translate([0,0,0]) rigging(mh);
		translate([0,-mh/5,0]) rigging(mh*4/6);
		translate([0,mh*15/32,mh*8/32]) rotate([205,0,0]) scale([1,1,2]) rotate([0,90,0]) 
			cylinder(r=mh/5,h=th,$fn=3,center=true);
		translate([0,mh*-1/32,-mh*1/32]) cube([th,mh*14/16,mh/8],center=true);
		}
	}

module rigging(mh=30)
	{
	cylinder(r=th*2/3,h=mh*11/12,$fn=fn/4);
	rotate([0,-90,0]) 
	translate([mh/2,0,0]) union() 
		{
		translate([0,-mh/64,0]) intersection()
			{
			difference()
				{
				scale([1,0.67,1]) translate([-mh/6,0,0]) 
					cylinder(r=mh/1.5,h=th,$fn=3,center=true);
				translate([0,-mh*5/6,0]) rotate([0,0,27.5]) scale([2,1,1]) 
					cylinder(r=mh/1.5,h=th+1,$fn=fn,center=true);
				}
			translate([0,-mh*1/1.9,0]) rotate([0,0,-27.5]) scale([2,1,1]) 
				cylinder(r=mh/1.5,h=th+1,$fn=fn,center=true);
			}
		translate([0,mh/16,0]) mast(mh);
		}
	}

module mast(mh=30)
	{
	translate([-mh/4,0,0]) sail(mh/4);
	translate([mh/8,-th*1.5,0]) sail(mh/8);
	translate([mh*5/16,-th*2,0]) sail(mh/16);
	}

module sail(size)
	{
	intersection()
		{
		scale([1.5,1,1]) translate([0,-size,0]) difference()
			{
			cylinder(r=size, h=size*5/2,$fn=fn,center=true);
			cylinder(r=size-th, h=size*5/2+1,$fn=fn,center=true);
			}
		cube(size*2,center=true);
	*	translate([size*2,0,0]) scale([2,1,1]) 
			rotate([0,45,0]) cube(size*3,center=true);
		translate([size/3,0,0]) scale([2,1,1]) rotate([90,0,0]) 
			cylinder(r=size*1,h=size*2,$fn=fn,center=true);
		}
	}
