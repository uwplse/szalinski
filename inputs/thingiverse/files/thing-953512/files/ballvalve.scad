// Ball Valves
// Ball valves are great for projects, but I'm always a little floored by the price.  
// Like $15 bucks for 5 cents worth of plastic?  Really?  And my idea calls for... about 30 of them so...
//
// This is licensed under creative commons, attribution, share-alike.
// To fulfil the "attribution" requirement, please link to:
//	http://www.thingiverse.com/thing:953512
//
// INSTRUCTIONS:
// 1) print the ball and 2 seals with max resolution and sand to mate
// 2) other parts can be less precise
// 3) Insert both seals, then the ball and handle.  Glue housing insert in place last of all.
// NOTE: a better strategy might be to buy some cheap seals and design the valve around them!
// NOTE: the main chamber and the ball will probably require supports
//
// TODO:
// 1) Add fit tolerances
// 2) Pipe attachment (see http://www.thingiverse.com/thing:436659)
// 3) O-ring for handle shaft.  Right now it will likely leak! (see http://www.thingiverse.com/thing:225603)
// 4) Handle attachment to ball 
// 5) Add servo alternative (again, see http://www.thingiverse.com/thing:436659)

/* [main] */

// what do you want to see?
view=1; //[1:assembled,2:housing,3:housing_insert,4:handle,5:seal (2 required),6:ball]

// show parts cut away for visualization (turn off before printing)
cutaway=1; // [0:false,1:true]

// resolution 1=low(aka 1x) 2=mid 3=high 4=very high
resfactor=2;

// How to attach to pipe
pipe_connection=0; // [0:TODO Not yet implemented]

// inside diameter for fluid
flow_dia=20;

// 0=auto, based on flow_dia
ball_dia=0;

// Thickness of the seat around the perimeter
seat_thickness=3;

// Thickness of the seat vertically
seat_h=4;

// Thickness of the housing walls
housing_thickness=2;

// How tall the 90 degree stop is
stop_cutout_h=2;


/* [handle] */

handle_screw_dia=3;

handle_countersink_dia=8;

// if 0, auto-calculate
handle_shaft_dia=0;

// within housing
handle_inset=5;

// beyond housing
handle_outset=10;

handle_len=60;

// if 0, auto-calculate
handle_w=0;

// thickness of the handle
handle_thick=3;


/* [hidden] */

assembledPosition=(view==1?1:0);

// auto-calculations for sizes
ball_dia=ball_dia>0?ball_dia:flow_dia*2.0;
handle_shaft_dia=handle_shaft_dia>0?handle_shaft_dia:ball_dia*2/3;
handle_w=handle_w>0?handle_w:handle_shaft_dia*2/3;

// figure out the diameter of the seat
seat_dia=flow_dia+seat_thickness*2;

// chord math.  See: https://en.wikipedia.org/wiki/Sagitta_%28geometry%29
function sagitta(r,l)=r-sqrt(r*r-l*l);
flow_sagitta=sagitta(ball_dia/2,flow_dia/2);
seat_sagitta=sagitta(ball_dia/2,seat_dia/2);

// make $fn more automatic
function myfn(r)=max(3*r,12)*resfactor;
module cyl(r=undef,h=undef,r1=undef,r2=undef){cylinder(r=r,h=h,r1=r1,r2=r2,$fn=myfn(r!=undef?r:max(r1,r2)));}
module circ(r=undef){circle(r=r,$fn=myfn(r));}
module ball(r=undef){sphere(r=r,$fn=myfn(r));}


module valveBall(ball_dia){
	translate([0,0,(ball_dia/2-flow_sagitta)*(1-assembledPosition)]) rotate([0,90*assembledPosition,0]) difference(){
		ball(r=ball_dia/2);
		translate([0,0,-ball_dia/2]) cyl(r=flow_dia/2,h=ball_dia*2);
	}
}

module seat(ball_dia){
	translate([(ball_dia/2+seat_h-seat_sagitta)*assembledPosition,0,0]) rotate([0,(-90)*assembledPosition,0]) difference(){
		cyl(r=seat_dia/2,h=seat_h); // main shape
		translate([0,0,-seat_h/2]) cyl(r=flow_dia/2,h=seat_h*2); // hole
		translate([0,0,ball_dia/2+seat_h-seat_sagitta]) ball(r=ball_dia/2); // ball
	}
}

module housing_insert(ball_dia,handle_shaft_dia){
	lead_in=30;
	difference(){
		translate([lead_in*assembledPosition,0,0]) rotate([0,(-90*assembledPosition),0]) difference(){
			cyl(r=ball_dia/2,h=lead_in); // total outside shape
			translate([0,0,lead_in]) ball(r=ball_dia/2); // cut out for ball
			translate([0,0,-lead_in/2]) cyl(r=flow_dia/2,h=lead_in*2); // flow port
			translate([0,0,lead_in-ball_dia/2-seat_h+seat_sagitta]) cyl(r=seat_dia/2,h=ball_dia); // seat
		}
		cyl(r=handle_shaft_dia/2,h=ball_dia); // handle
	}
}

module housing(ball_dia,handle_shaft_dia){
	lead_in=30;
	rotate([0,90*assembledPosition,0]) translate([0,0,((-ball_dia/2)*assembledPosition)+lead_in*(1-assembledPosition)]) difference(){
		union() { // body
			translate([0,0,-lead_in]) cyl(r=ball_dia/2+housing_thickness,h=lead_in*2+ball_dia/2);
			translate([-handle_outset,0,ball_dia/2]) rotate([0,-90,0]) cyl(r=handle_shaft_dia/2+housing_thickness,h=ball_dia/2); // shaft hole
		}
		// inside core
		translate([0,0,ball_dia/2]) cyl(r=ball_dia/2,h=lead_in); // outlet with clearance for housing_insert
		translate([0,0,-lead_in]) cyl(r=flow_dia/2,h=lead_in*2); // inlet
		translate([0,0,ball_dia/2]) ball(r=ball_dia/2); // ball clearance
		translate([0,0,seat_sagitta-seat_h]) cyl(r=seat_dia/2,h=ball_dia); // seat recess
		translate([0,0,ball_dia/2]) rotate([0,-90,0]) cyl(r=handle_shaft_dia/2,h=ball_dia); // shaft hole
		// stop
		translate([-(ball_dia/2+handle_outset-stop_cutout_h),0,0]) rotate([0,-90,0]) cube([ball_dia,ball_dia,stop_cutout_h*2]);
	}
}

module handle(ball_dia,handle_shaft_dia,handle_w){
	handle_total=handle_thick+handle_outset+handle_inset;
	translate([0,0,(ball_dia/2+handle_inset)*assembledPosition+handle_total*(1-assembledPosition)]) mirror([0,0,1-assembledPosition]) difference(){
		union(){
			cylinder(r=handle_shaft_dia/2,h=handle_inset,$fn=4);
			translate([0,0,handle_inset]) cyl(r=handle_shaft_dia/2,h=handle_outset+handle_thick);
			translate([0,0,handle_inset+handle_outset]) linear_extrude(handle_thick) hull(){ // handle
				translate([-handle_len,0,0]) circ(r=handle_w);
				circ(r=handle_w);
			}
			translate([0,0,handle_inset+handle_outset-stop_cutout_h]) intersection(){ // stop
				cyl(r=handle_shaft_dia/2+housing_thickness,h=stop_cutout_h);
				translate([-handle_shaft_dia,0,0]) cube([handle_shaft_dia,handle_shaft_dia,stop_cutout_h]);
			}
		}
		translate([0,0,-handle_total/2]) cyl(r=handle_screw_dia/2,h=handle_total*2); // screw hole
		translate([0,0,handle_total-handle_thick]) cyl(r=handle_countersink_dia/2,h=handle_total*2); // screw countersink
	}
}

module main(){
	if(view==1||view==3) color([0.5,0.5,0.5]) difference() {
		housing_insert(ball_dia=ball_dia,handle_shaft_dia=handle_shaft_dia);
		if(cutaway==1) translate([-100,-195,-100]) cube([200,200,200]);
	}
	if(view==1||view==6) color([0,0,1]) valveBall(ball_dia=ball_dia);
	if(view==1) color([1,1,1]) seat(ball_dia=ball_dia);
	if(view==1||view==5) color([1,1,1]) mirror([1,0,0]) seat(ball_dia=ball_dia);

	if(view==1||view==2) difference() {
		housing(ball_dia=ball_dia,handle_shaft_dia=handle_shaft_dia);
		if(cutaway==1) translate([-100,-200,-100]) cube([200,200,200]);
	}
	if(view==1||view==4) handle(ball_dia=ball_dia,handle_shaft_dia,handle_shaft_dia,handle_w=handle_w);
}

main();