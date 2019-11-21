//
//Sundial calculator for the Beach.
//
// Precalculating the Equation of time and DST offsets means it can be printed for a specific date 
//  and be lined up perfectly and be accurate for a few days only.
//
// San Francisco Lat,long 37.7833 N, 122.4167 W  ref -120
// London        Lat,long 51.5072 N, 0.1275 W    ref 0  (W is -ve)
// NY            Lat,long 40.7127 N, 74.0059 W   ref -70
// Auckland      Lat,long 36.848461 S, 174.74 E  ref 165
//
// E.g. Google reports Auckland latitude as -36.848461. The -ve means South.
//   In DMS its 36deg 50min 54.4596sec S.

// preview[view:south east, tilt:top]

/* [Location] */
// Label for this location
Label = "San Francisco";
// What is your Latitude as reported by Googling "'yourcity' Latitude" ? Always positive.
Latitude = 37.7833;
// North or South of Equator
Hemisphere = "North"; // [North, South]
// Daylight Savings Time
DST = "yes"; // [yes, no]
// More accuracy. fill in rest of values
Accurate = "yes"; // [yes, no]
// Month
Month = "AUG"; // [JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC]
// Date of Month
Day = 18; //[1:31]
// Longitude (more accurate) -ve numbers West of GMT. E.g. USA
Longitude = -122.4167; 
// Where your time is taken from(look up on special map). Sometimes one increment greater than your longitude.
Local_Meridian = -120; // [-180:15:180]

/* [Style] */
// Overall Size of the Dial. You can make large and scale when you print.
Sundial_diameter = 180; 
// Width of markers. (1-2mm ideal)
Marker_width = 2; // [1:0.5:6]
//Central hole for using string to make Sundial much larger at Beach. (mm)
guide=6; 

/* [printing] */
// Show assembled or ready for printing.
show = "assembled"; // [assembled, for printing]



/* [Hidden] */
Gnomon_width = 5; // Math not right yet to allow changes, style :(
// gnomon length from http://www.mysundial.ca/tsp/gnomon_height.html
gnomon_length = 1.09 * (Sundial_diameter*0.44) * sin (113.44 - Latitude);
//
split_dial = "yes"; // [yes, no]


// constants
pi = 3.14159253590;
Delta = 0.5;
sin_lat = sin(Latitude);

function DMS(d,m,s=0) = d + (m* 1/60) + (s* 1/3600);
function degrees_to_DMS(value) = [floor(value), 
			floor((value - floor(value))*60), 
			floor((value - floor(value) - floor((value - floor(value))*60)/60)*360000)/100];
//echo("dms=",DMS(36,50,54.4596));
//echo("fract = ", degrees_to_DMS(Latitude));

dates = [["JAN",0],  ["FEB",31], ["MAR",59], ["APR",90], 
		 ["MAY",120],["JUN",151],["JUL",181],["AUG",212],
		 ["SEP",243],["OCT",273],["NOV",304],["DEC",334] ];
// how many days from 1st of year (Jan 1 = 0)
function today(month, date) = dates[search([month], dates, num_returns_per_match=1)[0]][1] + date - 1;

// Calculate eqtn of Time (coarse +/- 4 seconds)
_mean_ang_vel = 360 / 365.24;
function _earth_angle(day) = _mean_ang_vel * (day + 10);
function _solistice_to_date(day) = _earth_angle(day) + 1.914 * sin(_mean_ang_vel * (day - 2));
function _speed_diff(day) = (_earth_angle(day) - atan(tan(_solistice_to_date(day)) / cos(23.44))) / 180;
function Eqn_of_time(day) = 720 * (_speed_diff(day) - round(_speed_diff(day)));

// testing EOT
// now_deg = Longitude - Local_Meridian;
// now = Eqn_of_time(today("SEP", 20));
// echo("today", today("JAN", 1));
// echo("EOT", now, now_deg - (now/4), now_deg*4 + now );


//-------------------------------------------------------------------
module half_round(rad, angle, height=2) {
	// make the half round that attaches to the time markers.
	// Holds it all together
	rotate([0,0,angle])
	difference() {
		cylinder(r=rad/2, h=height, $fn=100);
		translate([0,0,-Delta])
			cylinder(r=rad/2-Marker_width, h=height+Delta*2, $fn=100);
		translate([rad/2+Marker_width/2, 0, 0])
			cube(size=rad+Delta*2, center=true);
	}
}


module gnomon(lat) {
	// needs special calc for each Latitude
	difference() {
		translate([-(1.5*Gnomon_width*cos(lat)),0,-cos(90-lat)*Gnomon_width*1.4])
		rotate([0,-lat,0])
		scale([3,1,1])
			cylinder(d=5, h=gnomon_length, $fn=3);
		//
		translate([-Sundial_diameter, -5, -40])
			cube(size=[Sundial_diameter, 10, 40]);
	}
}


module guide_hole(diam, height=Marker_width) {
	// hole for pin to enable making Sundial much larger 
	//  and for larger gnomon placement.
	difference() {
		cylinder(d=guide+12, h=height, $fn=6);
		translate([0,0,-Delta])
			cylinder(d=guide, h=height+Delta*2, $fn=6);
		translate([Delta,0,-Delta]) //some slack
			gnomon(Latitude);
	}
}

// Hour helper labels
module one(dist) {
	translate([-Marker_width/1.5,0,-dist])
		rotate([0,0,45])
		cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
}
module two(dist) {
	translate([-Marker_width/1.5,0,-dist]) {
		rotate([0,0,45])
			cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
		translate([0,Sundial_diameter/40,0])
			rotate([0,0,45])
			cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
	}
}
module four(dist) {
	translate([-Marker_width/1.5,0,-dist]) {
		rotate([0,0,45])
			cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
		translate([0,Sundial_diameter/30,0])
		rotate([12,0,0])
			rotate([0,0,45])
			cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
		translate([0,Sundial_diameter/80,0])
		rotate([-12,0,0])
			rotate([0,0,45])
			cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
		// underline
		translate([0,Sundial_diameter/55+Sundial_diameter/45,Sundial_diameter/21])
		rotate([90,0,0])
			rotate([0,0,45])
			cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
	}
}
module nine(dist) {
	translate([-Marker_width/1.5,0,0]) {
		translate([0,0,-dist]) {
			rotate([0,0,45])
			cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
		translate([0,Sundial_diameter/30,0])
		rotate([18,0,0])
			rotate([0,0,45])
			cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
		translate([0,Sundial_diameter/55,0])
		rotate([-18,0,0])
			rotate([0,0,45])
			cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
		// underline
		translate([0,Sundial_diameter/55+Sundial_diameter/40,Sundial_diameter/21])
		rotate([90,0,0])
			rotate([0,0,45])
			cylinder(h=Sundial_diameter/20, d=Marker_width, $fn=4);
		}
	}
}


module pins(pos) {
	// to anchor Style into Sand.
	pin_length = max(Sundial_diameter/8, 18);
	translate([pos, 0, -pin_length+Delta ])
		//cylinder(h=pin_length, d2=Marker_width, d1=Marker_width*0.4, $fn=6);
		translate([0,0,pin_length])
		rotate([0,180,0])
		linear_extrude(height=pin_length, scale=[0.2,1])
			square([Gnomon_width, Gnomon_width*0.87],center=true);
}


module style() {
	gnomon(Latitude);
	size_factor = Sundial_diameter/8;
	// support structure
	difference() {
		// support block
		translate([-Sundial_diameter/5.04, -Gnomon_width*0.87/2, 0])
			cube(size=[size_factor*1.3, Gnomon_width*0.87, Sundial_diameter*0.3*sin(90-Latitude)]);
		// Basically same as Gnomon but cube to cut away
		rotate([0,-Latitude,0])
		scale([3,1,1])
		translate([-Sundial_diameter/(Sundial_diameter/10)/2.8, -Gnomon_width/2-Delta, -size_factor/5])
			cube(size=[size_factor/1.2, Gnomon_width+Delta*2, gnomon_length*1.4], $fn=3);
	}
	// pins to anchor style in sand
	pins(-Sundial_diameter/6);
	pins(-Sundial_diameter/12);
}


module label(angle) {
	msg = (Accurate=="no") ? str(Label) :str(Label," ",Month," ",Day);
	rotate([0,0,270+angle])
	translate([Sundial_diameter/20,0,0])
	resize([Sundial_diameter/3,0,0])
	linear_extrude(height=Marker_width)
		text(msg, valign="baseline");
}


module sundial() {
	// dial lines
	hour_factor = 2.2;
	// TZ and EOT and DST adjustments
	TZ_offset = Longitude - Local_Meridian + Eqn_of_time(today(Month, Day))/4 ;
	TZ_DST_offset = (DST=="yes") ? TZ_offset+15 : TZ_offset;
	echo(str("Longitude and EOT adjustment is ", (Longitude - Local_Meridian)* 4 + Eqn_of_time(today(Month, Day)), " minutes"));
	if (DST=="yes")
		echo("Daylight adj = +1 hour");
		echo();
	for (h=[-6:0.5:6]) {
		hra_ = 15 * h; // in degrees
		hra = (Accurate=="no") ? hra_ : hra_ - TZ_DST_offset;
		hla = atan(sin_lat * tan(hra));
		hla_corrected = (sign(hra)==sign(hla)) ? hla : -90-(90-hla);
		//echo("Results",h,hla, hra, tan(hra),"#",hla_corrected);
		// rods
		rotate([hla_corrected,90,0]) {
			length_factor = (h == round(h)) ? 0.4 : 0.25 ; // half hour marker is shorter
			translate([0,0,(h == round(h)) ? -Sundial_diameter/hour_factor: -Sundial_diameter/hour_factor*0.96 ])
			translate([0,0,Sundial_diameter*(1-length_factor)/5/hour_factor])
			scale([2,1,1])
				cylinder(h=Sundial_diameter/2*length_factor, d=Marker_width, $fn=12);
		}
		// 6 hour marker extensions
		if (h == -6 || h==6) {
			rotate([hla_corrected,90,0])
			translate([0,0,-guide/2-Sundial_diameter/5])
			scale([2,1,1])
				cylinder(h=Sundial_diameter/5, d=Marker_width, $fn=12);
		}
		// numbers
		dist = Sundial_diameter/2.1;
		time = (Hemisphere=="North") ? h : h*-1;
		if (time==1) {
			rotate([hla_corrected,90,0])
			one(dist);    }
		if (time==4) {
			rotate([hla_corrected-2,90,0])
			four(dist);   }
		if (time==-3) {
			rotate([hla_corrected-2,90,0])
			nine(dist);   }
		// above-sand holder arcs to keep it together
		if (h == -6) {
			//translate([0,0,Marker_width/4])
				half_round(Sundial_diameter/2, 270-hla_corrected, Marker_width);
			//translate([0,0,Marker_width/4])
				half_round(Sundial_diameter/1.5, 270-hla_corrected, Marker_width);
			// Label
			label(270-hla_corrected);
		}
	}
}

//-------------------------------------------------------------------
// Tell user the DMS Latitude so they can check if 
//  they have the right representation of their desired Altitude.
echo();
echo(str("Latitude of ", Latitude, " expressed in DMS is:"));
lat_mds =  degrees_to_DMS(Latitude);
echo(str(lat_mds[0]," Degrees ", lat_mds[1]," Minutes ", lat_mds[2], " Seconds."));
echo();


if (show == "assembled") {
	// show it in place
	sundial();
	style(Latitude);
	guide_hole(guide);
} else {
	// lay it down for printing in parts
	translate([0,0,Marker_width])
	rotate([180,0,0])
	sundial();
	guide_hole(guide);
	translate([-Sundial_diameter/2, gnomon_length/2, Marker_width])
		rotate([90,0,Latitude])
		style(Latitude);
}



// Numbers 4,2*length_factor
// split the main dial for small printers.