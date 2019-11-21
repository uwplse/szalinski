// preview[view:north, tilt:top diagonal]

//What diameter does the broom handle have?
stick_diameter = 25;

//On average, how far apart are your fingers (center to center)?
finger_spacing = 23; //[10:35]

//How much thicker do you want the handle to be than the original broom handle?
padding = "Some"; //[A lot thicker,Some,Only a little]

if(padding=="A lot thicker") assign(pad=12) handle(pad);
if(padding=="Only a little") assign(pad=3) handle(pad);
if(padding=="Some") assign(pad=7) handle(pad);


module handle(padd){
	
	ir=stick_diameter/2;
	or=ir+padd;
	hi=4*finger_spacing+10;
	edge=padd+5;
	res=50*1;
	
	difference(){
		cylinder(r=or,h=hi);
	
		union(){
			for(i=[0:3])translate([(or-ir)/2,0,edge+((hi-2*edge)*(i+.5)/4)]){
				rotate_extrude(convexity = 10, $fn = res)
				translate([or*(2+.4*(12/padd)), 0, 0])
				circle(r = (1+.4*(12/padd))*or, $fn = res);
			}
			translate([0,0,edge])cylinder(r=ir,h=hi-edge);
		}
	}

}