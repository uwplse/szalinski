/* [Phones] */

Phone_1=0; // [0:iPhone 5, 1:iPhone 5 in Belkin Grip Candy Sheer, 2: iPhone 5 in Incipio Dual Pro, 3:iPhone 4/4s, 4:iPhone 4/4s in elago S4 Glide, 5:iPhone 4/4s in iFrogz Luxe Lean, 99:Custom]
Phone_2=-1; // [-1:None, 0:iPhone 5, 1:iPhone 5 in Belkin Grip Candy Sheer, 2: iPhone 5 in Incipio Dual Pro, 3:iPhone 4/4s, 4:iPhone 4/4s in elago S4 Glide, 5:iPhone 4/4s in iFrogz Luxe Lean, 99:Custom]
Phone_3=-1; // [-1:None, 0:iPhone 5, 1:iPhone 5 in Belkin Grip Candy Sheer, 2: iPhone 5 in Incipio Dual Pro, 3:iPhone 4/4s, 4:iPhone 4/4s in elago S4 Glide, 5:iPhone 4/4s in iFrogz Luxe Lean, 99:Custom]

// Dock Wall Thickness

/* [Advanced Settings] */
wall_thickness=4; //[1:6]
rounding_radius=2;

// Screw hole height
screw_height=20; //[0:35]
// Screw Diameter
screw_diameter=4; //[1:6]
// Countersink Size
screw_countersink_size=3;
//  Countersink Depth
screw_countersink_depth=3;


actual_depth=20.25;
/* [Custom Dimensions] */
/* Custom 1 Width */
Custom1_width=59.4;
/* Custom 1 Depth */
Custom1_depth=8.25;
//What kind of connector does your phone have?
Custom1_connector="Lightning"; /* ["Lightning", "Dock"] */
//How far should the connector body stick out of the bottom of the dock?
Custom1_stickout=0;
 
/* Custom 2 Width */
Custom2_width=59.4;
/* Custom 2 Depth */
Custom2_depth=8.25;
//What kind of connector does your phone have?
Custom2_connector="Lightning"; /* ["Lightning", "Dock"] */
//How far should the connector body stick out of the bottom of the dock?
Custom2_stickout=0;
 
/* Custom 3 Width */
Custom3_width=59.4;
/* Custom 3 Depth */
Custom3_depth=8.25;
//What kind of connector does your phone have?
Custom3_connector="Lightning"; /* ["Lightning", "Dock"] */
//How far should the connector body stick out of the bottom of the dock?
Custom3_stickout=0;
 

/* [hidden] */
custom1=[Custom1_width, Custom1_depth, 40, Custom1_connector, Custom1_stickout];
custom2=[Custom2_width, Custom2_depth, 40, Custom2_connector, Custom2_stickout];
custom3=[Custom3_width, Custom3_depth, 40, Custom3_connector, Custom3_stickout];

button_cutout_radius=8;
button_height=10;
circle_precision=1;
usb_connector_height=20;

dock_connector_thickness=6.0;
dock_connector_width=27;
dock_connector_height=9;

lightning_connector_height=12;
lightning_connector_width=8.25;
lightning_connector_thickness=5.5;

/* Turn of rounding for fast preview */
preview_tab="none";


extra=0.1;
overlap=0.05;
dimensions=[ /* [phone_width, phone_depth, pocket_height, connector, connector_stickout] */
	/* iphone 5 */
	[59.4,8.25,40,"lightning",0],
	/* iphone 5 in belkin case */
	[64.25,10.75,40,"lightning",2.5],
	/* iPhone 5 in incipio Dual Pro */
	[65.25, 13.5, 40, "lightning", 0],
     /* iphone 4/4s */
	[59.25, 9.75, 40, "dock", 0],
     /*  iphone 4/4s in elago S4 Glide */
     [63.5, 12.25, 40, "dock", 0],
	/*  iphone 4/4s in ifrogz */
     [61.5, 12, 40, "dock", 0]
	];

if (Phone_1==99)
	iphone_dock(custom1,rounding=rounding_radius);
else 
	iphone_dock(dimensions[Phone_1], rounding=rounding_radius);
if (Phone_2 != -1) {
	translate([(Phone_1==99 ? custom1[0] : dimensions[Phone_1][0])+wall_thickness*2-overlap,0,0]) 	{
		if (Phone_2==99 )
			iphone_dock(custom2, rounding=rounding_radius);
            else 
			iphone_dock(dimensions[Phone_2], rounding=rounding_radius);
		if (Phone_3 != -1)
			translate([(Phone_2==99 ? custom2[0] : dimensions[Phone_2][0])+wall_thickness*2-overlap,0,0])
				if (Phone_3==99)
					iphone_dock(custom3, rounding=rounding_radius);
				else
					iphone_dock(dimensions[phone3], rounding=rounding_radius);
	}
}

module iphone_dock(setup=[59.4, 8.25, 40, "lightning", 0], rounding=false) {
	phone_width=setup[0];
	phone_depth=setup[1];
	pocket_height=setup[2];
	connector=setup[3];
	connector_stickout=setup[4];

	case_width=phone_width+wall_thickness*2;
	case_depth=phone_depth+wall_thickness*2;
	case_height=pocket_height+wall_thickness+dock_connector_height;

	translate([case_width/2,case_depth/2,0]) difference() {
		if (rounding!=0 && preview_tab == "none") {
			minkowski() {
				difference() {
					translate([-case_width/2,-case_depth/2,0]) rotate([90,0,90]) 
						linear_extrude(height=case_width) 
							polygon(points=[[rounding_radius,rounding_radius],[actual_depth-rounding_radius,rounding_radius],[actual_depth-rounding_radius,case_height-rounding_radius*2.5],[rounding_radius,case_height-actual_depth-rounding_radius/2]]);
						translate([0,0,pocket_height/2+wall_thickness+dock_connector_height-rounding_radius])
							cube([phone_width+rounding_radius*2,phone_depth+rounding_radius*2,pocket_height+rounding_radius], center=true);
						translate([0,-case_depth/2+wall_thickness/2,wall_thickness+dock_connector_height+button_height])
							button_cutout();
					}
				sphere(rounding_radius, $fs=circle_precision);
			}
		} else {
			difference() {
				translate([-case_width/2,-case_depth/2,0]) rotate([90,0,90]) 
					linear_extrude(height=case_width) 
						polygon(points=[[0,0],[actual_depth,0],[actual_depth,case_height],[0,case_height-actual_depth]]);
						translate([0,0,pocket_height/2+wall_thickness+dock_connector_height])
							cube([phone_width,phone_depth,pocket_height], center=true);
						translate([0,-case_depth/2+wall_thickness/2,wall_thickness+dock_connector_height+button_height])
							button_cutout();
			}
		}
		if (connector=="dock") {
			usb_connector(h=wall_thickness+dock_connector_height);
			translate([0,0,wall_thickness+connector_stickout]) dock_connector();
		} else if (connector=="lightning") {
			translate([0,0,wall_thickness-(lightning_connector_height-dock_connector_height)+connector_stickout])
				lightning_cutout();
		}
		translate([0,case_depth/2,wall_thickness+dock_connector_height+screw_height])
			rotate([90,0,0]) {
				translate([0,0,-wall_thickness]) cylinder(r=screw_diameter/2, h=wall_thickness*2, $fs=circle_precision);
					translate([0,0,wall_thickness-screw_countersink_depth]) 
						cylinder(r1=screw_diameter/2, r2=screw_diameter/2+screw_countersink_size, h=screw_countersink_depth+0.01);
		}
	}
}

module dock_connector() {
		translate([0,0,dock_connector_height/2]) union() {
			cube([dock_connector_width-dock_connector_thickness,dock_connector_thickness,dock_connector_height], center=true);
			for (offset=[-1,1]) translate([offset*(dock_connector_width/2-dock_connector_thickness/2),0,0]) cylinder(r=dock_connector_thickness/2, h=dock_connector_height, $fs=circle_precision, center=true);
		}
}

module usb_connector(height=20) {
	connector_thickness=8.0;
	connector_width=15.0;
	rounding=1.6;

	translate([0,0,height/2]) {
		cube([connector_width-rounding*2, connector_thickness, height], center=true);
		cube([connector_width, connector_thickness-rounding*2, height], center=true);
		for (yoffset=[-1,1]) for (xoffset=[-1,1]) translate([xoffset*(connector_width/2-rounding),yoffset*(connector_thickness/2-rounding),0]) cylinder(r=rounding, h=height, $fs=circle_precision, center=true);
	}
}

module lightning_connector() {
	thickness=lightning_connector_thickness;
	width=lightning_connector_width;
	height=lightning_connector_height;
	cord=4;
	translate([0,0,height/2])
		cube([width-thickness, thickness, height], center=true);
	for (n=[-1,1])
		translate([n*(width/2-thickness/2),0,0])
			cylinder(r=thickness/2, h=height);
	translate([0,0,-25])
		cylinder(r=cord/2,h=26);
}

module lightning_cutout(height=30) {
	width=lightning_connector_width;
	thickness=lightning_connector_thickness;
	lightning_connector();
	translate([0,0,lightning_connector_height-height])
		rotate([0,0,90]) {
			translate([0,0,height/2])
				cube([width-thickness, thickness, height], center=true);
			for (n=[-1,1])
				translate([n*(width/2-thickness/2),0,0])
					cylinder(r=thickness/2, h=height);
	}
}

module button_cutout() {
		translate([0,wall_thickness,0])
			rotate([90,0,0])
				cylinder(r=button_cutout_radius+rounding_radius, h=wall_thickness*2, $fs=circle_precision);
		translate([-button_cutout_radius-rounding_radius,-wall_thickness,0])
			cube([button_cutout_radius*2+rounding_radius*2, wall_thickness*2, 100]);
		
}
module button_cutout_rounding() {
	button_cutout_height=case_height-case_depth-button_height-wall_thickness-dock_connector_height;
	union() {
		rotate([90,0,0]) difference() {
			rotate_extrude(convexity=4, $fn=30)
				translate([button_cutout_radius+rounding_radius,0,0])
					circle(r=rounding_radius, $fs=circle_precision);
			translate([-button_cutout_radius-rounding_radius*2,0,-rounding_radius])
				cube([button_cutout_radius*2+rounding_radius*4,button_cutout_radius*2+rounding_radius*2,rounding_radius*2]);
		}
		for (xloc=[-button_cutout_radius-rounding_radius,button_cutout_radius+rounding_radius]) translate([xloc,0,0]) {
			cylinder(r=rounding_radius, h=button_cutout_height, $fs=circle_precision);
			translate([0,0,button_cutout_height]) sphere(r=rounding_radius, $fs=circle_precision);
		}
		
	}
}