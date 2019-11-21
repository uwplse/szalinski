/**************
Chain generator
(http://www.thingiverse.com/thing:28405)

Author: Stefan Langemark

Generates open or closed chains with configurable
dimensions. Print without support.

Open chains (two ends):
straight_chain()
spiral_chain()

Closed chains (no end):
circular_chain()

Common parameters:
l - length of link
d - width of link
t - thickness of material
links - number of links in chain
The length of the chain when stretched is links*(l-2*t)

The spiral and circular chains need a bit wider chains
than the straight chain to make room for the curvature.

***************/


/**************
 Select output here!
***************/

// Shape of chain
type = "straight"; // [straight,circular,spiral]

// Number of links. Needs to be an even number for circular type!
links = 10; 

// Length of link
l = 22;

// Width of link (increase to 15 for circular or spiral type)
d = 12;

// Diameter of cross section
t = 3.5;

// Initial radius for spiral type
r0 = 20;

// Increase of radius per turn for spiral type
pitch = 12;

if (type == "straight") straight_chain(links, l,d,t);
if (type == "circular") circular_chain(links, l,d,t);
if (type == "spiral") spiral_chain(links, l,d,t,r0,pitch);

/*
Open chain in a spiral.
Additional parameters:
r0 - initial radius (mm).
pitch - increase of radius per turn (mm/turn).
*/
module spiral_chain(links=30,l=22,d=15,t=3.5,r0=20,pitch=12)
{
	spacing=l/2+1;
	for (i=[0:links-1])
	assign(angle = inv_arch_len(spacing*i,r0,pitch),
		angle2 = inv_arch_len(spacing*(i+1),r0,pitch))
	assign(p = arch_spiral(angle,pitch),
		p2 = arch_spiral(angle2,pitch))
	{
		translate(p)
		rotate([0,0,atan2(p2[1]-p[1],p2[0]-p[0])])
		translate([spacing/2,0,0])
		rotate([60+60*(i%2),0,0])
		link(l,d,t);
	}
}

// Straight chain segment
module straight_chain(links=5, l = 22, d = 12, t = 3.5)
{
	spacing=l/2+.5;
	for (i=[0:links-1]) {
		translate([i*spacing,0,0])rotate([60+60*(i%2),0,0])link(l,d,t);
	}
}

// Closed chain in a circle
module circular_chain(links=14, l = 22, d = 15, t = 3.5)
{
	a = 360/links;
	spacing=l/2+1; // tweak this to make chains with few links
	r=spacing/2/tan(a/2);
	echo("radius",r);
	for (i=[0:links-1]) {
		rotate([0,0,i*a])translate([0,-r,0])rotate([60+60*(i%2),0,0])link(l,d,t);
	}
}

// Single chain link. Centered, with l,d,t in axes x,y,z, respectively.
module link(l,d,t)
{
	union() {
	for (a=[0:7])
	{
		assign(
			off1 = (l-d)/2*((a-.5>2&&a-.5<6)?-1:1),
			off2 = (l-d)/2*((a+.5>2&&a+.5<6)?-1:1))
		{
			intersection() {
				translate([0,0,-t/2])
				pie((a-.5)*360/8,
					(a+.5)*360/8,l,t,
					[off1,0],[off2,0]);
				translate([(off1+off2)/2,0,0])
				rotate([0,0,a*360/8])
				rotate([-90,0,0])
				translate([(d-t)/2,0,-l/2])
				cylinder($fn=6,r=t/2,h=l);
			}
		}
	}
}
}

function pol(r,a) = [r*cos(a),r*sin(a)];
module pie(a1,a2,r,h,o1,o2)
{
	if (o1==o2) {
	linear_extrude(height=h)
		polygon([o1,o1+pol(r,a1),o1+pol(r,a2)]);
	} else {
	linear_extrude(height=h)
		polygon([o1,o1+pol(r,a1),o2+pol(r,a2),o2]);
	}
}

// Approximate angle of archimedes spiral of length len (mm) from radius r0, given pitch a (mm/turn).
function inv_arch_len(len,r0,a) = 180/3.1416*sqrt(len*2/(a/2/3.1416)+(r0*2*3.1416/a)*(r0*2*3.1416/a));

// Point on archimedes spiral at angle given pitch a (mm/turn).
function arch_spiral(angle,a) = [a*angle/360*cos(angle),a*angle/360*sin(angle),0];
