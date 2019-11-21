/* [Dimensions] */
// hight (when lying flat)
height=12;
// outer diameter
outer_diameter=40;
// inner diameter
inner_diameter=10;
// diameter of balls
ball_diameter=9.5;
// width of air between balls and bearing
w=0.4;
// air between rings on the outside
a=4.5;
// radius of outer rounding
rr=1;
// percentage of air between balls (higher=>less balls)
ab=15;

/* [Resolution and View] */
// resolution of roundings in steps/360°
fn = 128; // [64,128,256]
// resolution of balls in steps/360°
fnb = 64; // [16,32,64,128]
// resolution of small roundings in steps/360°
fns = 32; // [8,16,32,64]

/* [Design-Check] */
// Say yes, check your layout and then say no, before you create .stl:
view_sectioned = 1; // [0:no, 1:yes]
// Say yes to get information about the object instead of the object:
view_info = 0; // [0:no, 1:yes]
// If there is an error you don't understand, and you want to view anyway:
force_view = 0;

// [hidden]
tol=0.01;
rw=ball_diameter/2+w;
dd=(outer_diameter-inner_diameter)/2;
t=dd-2*w-ball_diameter;
o=asin(a/2/rw);

V_bearing=concat(
[[0,height/2],[0,-height/2]],
verschiebe2D(kreislinie(r=rr,sw=270,w=360,fn=fns),[dd/2-a/2-rr, -height/2+rr]),
verschiebe2D(kreislinie(r=ball_diameter/2+w,sw=270-o,w=90+o,fn=-fnb),[dd/2,0]),
verschiebe2D(kreislinie(r=rr,sw=0,w=90,fn=fns),[dd/2-a/2-rr,height/2-rr])
);

sError = ErrorMsg();

if ((sError != "") && (!force_view))
{
	DisplayText(sError);
}
else
{
	if (view_info)
	{
		DisplayText(str("Overhang (90°=vertical): ", 90-o));
	}
	else
	{
		difference()
		{
			main();
			if (view_sectioned)
			{
				translate([-outer_diameter/2-tol,-outer_diameter/2-tol,-tol])
					cube([outer_diameter+2*tol,outer_diameter/2+2*tol,height/2+2*tol]);
			}
		}
	}
}

module main()
{
	rotate_extrude($fn=fn, convexity=16)
	{
		translate([inner_diameter/2,0,0])
			polygon(V_bearing);
		translate([outer_diameter/2,0,0])
			polygon(skaliere2D(V_bearing,[-1,1]));
	}
	balls();
}
echo("V_innerradiusses:",V_innerradiusses);

module balls()
{
	// n = findbiggestsmaller(V_innerradiusses*(1+ab/100),(inner_diameter+t)/ball_diameter,3);
	n = balls_by_ri(ri=(inner_diameter+t)/2,rb=(ball_diameter/2)*(1+ab/100));
	echo("Balls:", n);
	winkel=360/n;
	for (i=[0:1:n-1])
	{
		rotate([0,0,i*winkel])
			translate([inner_diameter/2+dd/2,0,0])
				sphere(r=ball_diameter/2,$fn=fnb);
	}
}

function ErrorMsg() =
(
	(outer_diameter < inner_diameter) ? "Outer diamter smaller than inner diameter.\rTry the other way round." :
	(t <= 0) ? "Inner an outer diameter to close for balls with space.\rTry more outer diamter." : 
	(height < (rb+w)) ? "Height too small for balls.\rTry more height." :
	(height/2-rr < (ball_diameter/2+w)*cos(o)) ? "outer rounding hits chamfer! Try more height." :
	((a+2*rr) > dd) ? "Inner an outer diameter to close for outer rounding and distance! Try more outer diamter." :
	""
);

/*
V_innerradiusses = [ for(i=[0:1:100]) ((i>2)?(sqrt(1+sqr(tan(90-(360/i/2))))-1):0) ];
function findbiggestsmaller(V, x, i) = (V[i+1] > x) ? i : findbiggestsmaller(V, x, i+1);
*/

function sqr(x) = x*x;
function balls_by_ri(ri,rb) = round((180/(90-atan(sqrt(sqr((ri/rb+1))-1))))-0.5);
/**
 * function kreislinie(r,sw,w,fn)
	by Faber Unserzeit (Philipp Klostermann)
	returns a vector with the 2-dimensional coordinates of an arc with radius r 
    starting at angle sw ending at angle w with a resolution of fn/360°.
    fn can be a negative number to produce clockwise arcs.
**/
function kreislinie(r,sw,w,fn) = 
	let(
		step = 360/fn,
		startw = sw,
		endw = (w*fn < startw*fn) ? w+360 : w
	)
	concat([ for (a=[startw : step:endw-step]) 
		[ cos(a)*r, sin(a)*r ]],[[cos(w)*r, sin(w)*r] ]);
	
function verschiebe2D(V,D) = [ for (v=V) v+D ];
function skaliere2D(V,D) = [ for (v=V) [ v[0]*D[0], v[1]*D[1] ] ];
	
module DisplayText(s)
{
	rotate([0,0,45])
		rotate([80,0,0])
			text(s, font = "Liberation Sans");
	echo (s);
}