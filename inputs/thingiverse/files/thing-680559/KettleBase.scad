//Diameter of the connection station of the Kettle (mm)
station_diameter = 167;

// With of cable protuding from connection station (mm)
cable_width=12;

/* [advaced configurations] */
//wall and floor thickness
wall=3;

r1=station_diameter/2+wall;
r2=r1-wall;
r3=110/2;

//total height
h1=17;
//height of sensor pocket
h2= 12;

/*cable trap params*/
//number of cable traps
cn=1;
cr=cable_width;

//FSR dimensions
//radius of FSR sensor area
FSRr=11;
r4=FSRr+1;
// width of FSR sensor connector section
FSRw=10;


module main(){
	difference(){
		cylinder(r = r1, h = h1, $fn=100);
		translate([0,0,h2]) cylinder(r = r2, h = h1-h2, $fn=100);
		translate([0,0,wall]) cylinder(r = r3, h = h1-wall);
		cylinder(r = r4, h=wall);
	}
}

module traps(){
	ch = h1-h2-cr;
	for( a = [0:360/cn:360]) {
       rotate([0,0,a]) translate([r1,0,0]) rotate([0,-90,0])
			hull(){
				cylinder(r=cr,h=wall*2);
				translate([cr/2,-cr,0]) cube([ch,cr*2,wall*2]);
			}
	}
}

module kettleBase(){
	difference(){
		main();
		translate([0,0,h2+cr]) traps();
		for( a = [0:360/3:360]) {
       rotate([0,0,a]) translate([r1-FSRr-wall*2,0,0])
			FSRtrap(r1-FSRr*2-wall*2,wall/2);
	}
	}
}

module FSRtrap(l,h){
	union(){
		cylinder(r=FSRr,h=h);
		translate([-l-FSRr,-FSRw/2,0]) cube([l+FSRr,FSRw,h]);
	}
}
kettleBase();