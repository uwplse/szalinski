/////////////////Parameters
/* [Sizes] */
// number of sides
ns = 9; // [6:16]
// holder every n sizes
hn = 3; // [2:4]
// outer diameter
do	= 180; // [50:250]
// inner diameter should be smaller than half of outer diameter
di = 90; // [25:150]
// roll diameter inside, if 0 then no isnide roll and inner diameter =roll
rs = 45; // [0:140]
/* [Printer_Opts] */
// height of walls and spool
wh = 3; // [1:10]
// width of walls - outer and inside
ww = 5; // [2:10] 
// height of spool inside 
sh = 50; // [20:100]
// spacing to fit parts
fit= 0.15; 
/* [Global] */
// which spool parts to show
show = "b"; // [i:Inner spool,o:Outer spool,b:Both spools]
/* [Hidden] */

//////////////////Calculations

$fn=120;
ms = 0.05; 

or = do/2;
ir = di/2;

irs = (rs!=0)? rs/2 : ir;

aw = 360/ns;
aw2 = aw/2;
bw = (180-aw)/2;
bw2 = (180-aw2)/2;

//echo("aw:",aw," bw:",bw," aw2",aw2); 

g = irs+ww+wh+ww+fit;
a = sqrt(2*g * g - 2 * g * g * cos(aw2));
x = g*(ww-2*a)/(2*(a-g));
//echo("g:",g," a:",a," x:",x); 

go = or-ww-ww/2;

ao = a*go/g - ww;
as = sin(bw2)*ao;
ac = cos(bw2)*ao;

gi = ir+wh/2;
ai = sqrt(2*gi*gi - 2*gi*gi*cos(aw));
//echo("gi:",gi," ai:",ai," x:",x); 



module ring() {

	difference() {
		cylinder(h=wh,r=or,center=true);
		cylinder(h=wh+ms,r=irs,center=true);


		intersection() {
			for(i = [aw:aw:360+ms]) {
				rotate([0,0,i]) translate([g+x,0,0]) 
					hull() {
						cylinder(h=wh+ms,r=x,center=true);
						translate([go-g-x+ww,0,0]) 
							cylinder(h=wh+ms,r=ww/2,center=true);
						translate([go-g-x-ac,-as,0]) 
							cylinder(h=wh+ms,r=ww/2,center=true);
						translate([go-g-x-ac,as,0]) 
							cylinder(h=wh+ms,r=ww/2,center=true);
					}
			}
			cylinder(h=wh+ms+ms,r=or-ww,center=true);
		}
	}
}

module inner_ring() {

	ring();
	translate([0,0,sh/2]) {
		difference() {
			cylinder(h=sh+wh,r=ir+wh,center=true);
			cylinder(h=sh+wh+ms,r=ir,center=true);
			for(i = [aw:aw:360+ms]) {
				rotate([0,0,i]) 
					translate([gi,0,-wh/2]) difference() {
						cube([4*wh+ms, ai-ww-wh/2,sh+wh-ww-ww],center=true);
						if (i/aw/hn == floor(i/aw/hn)) {
							translate([0,0,-wh/2])
								cube([4*wh, ai-ww-wh,sh-ww-ww+ms],center=true);
						}
					}
			}
		}
		intersection() {
			rotate_extrude($fn=200) 
				polygon( points=[[ir,sh/2-4*wh],[ir+2*wh-fit,sh/2-3*wh],[ir,sh/2-wh]] );
			for(i = [aw:aw:360+ms]) {
				rotate([0,0,i]) 
					translate([gi,0,wh/2]) {
//						echo(i,aw,hn,i/aw/hn,floor(i/aw/hn));
						if (i/aw/hn == floor(i/aw/hn)) 
							translate([0,0,-wh/2])
								cube([wh*4, ai-ww-wh,sh-ww-ww-wh+ms],center=true);
						
				}
			}
		}
		if (rs!=0) translate([0,0,-sh/2]) 
			difference() {
				translate([0,0,sh/2]) 
					cylinder(h=sh+wh,r=rs/2+wh,center=true);
				translate([0,0,sh/2]) 
					cylinder(h=sh+wh+ms+ms,r=irs,center=true);
		}
	}
}

module outer_ring() {
	ring();

	translate([0,0,3*wh-ms]) {
		difference() {
			cylinder(h=7*wh,r=ir+wh+wh+fit,center=true);
			cylinder(h=7*wh+ms,r=ir+wh+fit,center=true);
			for(i = [aw:aw:360+ms]) {
				rotate([0,0,i]) 
					translate([ir+wh,0,-wh/2]) 
						cube([sin(aw)*gi+ms, ai-ww,4*wh],center=true);
					
			}
		}
	}
}

if(show=="i" || show=="b")
	inner_ring();

if (show=="o") 
	outer_ring();

if (show=="b") 
	translate([0,0,sh+wh+fit]) rotate([180,0,0]) #outer_ring();
