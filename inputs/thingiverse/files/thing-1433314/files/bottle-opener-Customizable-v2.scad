//http://www.thingiverse.com/thing:8244/

//Look like a frog
EyeAndTongue = "yes"; // [yes,no]
CoinPreset = 2; //[0:US Penny (Ideally older than 1986), 1:US Nickle, 2:US Dime, 3:Euro Cent, 4:Euro 2 Cent, 5:Euro 5 Cent, 6:Euro 10 Cent]
Quality = 100; //[24:Normal, 50:Good, 100:Smooth, 200:Overkill]

$fn=Quality;

/*TODO:
- Canadian coins
- DONE: Custom coin dimensions
- Cut out bottom of eyes if coin is larger
*/

/* [Custom Coin] */
//Find the actual diameter, reduce by 0.05mm or so
CustomCoin_Diameter=-1;
//Find the actual thickness, add ~0.23 or so
CustomCoin_Thickness=-1;
//Default: 0, For larger coins, set this higher
CustomCoin_LipStickout=-1;
//Default is 5, increase for smaller bottle caps... or something
CustomCoin_CoinOffset=-1;
//See the cross section of the coin channel, to check if the coin will be held correctly
CoinDebug = "no"; // [no,yes]


/* [Hidden] */
coinData=[
//[diameter, thickness, coin_offset (stickout), sphereHeightMod (LipStickout)]
[19, 1.75, 5, 0], // US Penny (google says: 19.05 mm, 1.52 mm)
            //For the rest, just going by original dimension changes
[21.16, 2.25, 5, 5], // US Nickle (google says: 21.21 mm, 1.95 mm)
[17.9, 1.5, 5, 0], // US Dime (wiki says: 17.91 mm, 1.35 mm)
[16.2, 1.9, 5, 0], // Euro Cent (google says: 16.25 mm, 1.67 mm)
[18.7, 1.9, 5, 0], // Euro 2 Cent (wiki says: 18.75 mm, 1.67 mm)
[21.2, 1.9, 5, 5], // Euro 5 Cent (wiki says: 21.25 mm, 1.67 mm)
[19.7, 2.15, 5, 0], // Euro 10 Cent (wiki says: 19.75 mm, 1.93 mm)
];
selectedCoin_Loaded=coinData[CoinPreset];

selectedCoin=[
override(selectedCoin_Loaded[0], CustomCoin_Diameter),
override(selectedCoin_Loaded[1], CustomCoin_Thickness),
override(selectedCoin_Loaded[2], CustomCoin_CoinOffset),
override(selectedCoin_Loaded[3], CustomCoin_LipStickout)];
echo(selectedCoin);

function override(preset, override) = (override > 0) ? override : preset;

screw_y_spacing=55;
top_screw_x_spacing=18;
screw_diameter=5;
flange_thickness=6;
flange_width=49;
flange_height=78;
sphere_width=45;
sphere_height=60+selectedCoin[3];
sphere_z_offset=8;
sphere_y_offset=-3;
cylinder_offset=-6.5;	// this is the y offset for a cylinder that cuts off some of the overhangs
wall_thickness=4;
roof_thickness=12;
sphere_angle=25;

coin_angle=35;
cap_angle=70;

coin_rotation=8; //Rotation up from bottom edge
coin_stickout=selectedCoin[2]+selectedCoin[3]/2; //positive makes bottle cap not fit?
coin_diam=selectedCoin[0];
coin_thickness=selectedCoin[1];

cap_diam=30;
cap_chamfer=3;
cap_thickness=6;
countersink_depth=3;
fulcrum_diam=6;
fulcrum_y_offset=-4;
fulcrum_z_offset=3;

eye_height=35+selectedCoin[3]/2;
eye_diam=10;
eye_x_angle=sphere_angle;
eye_y_angle=18;
tongue_thickness=10;
tongue_length=19;
tongue_width=25;
tongue_angle=75;
tongue_z_offset=-3;
tongue_groove=5;
pupil_diam=3;
eye_and_tongue=EyeAndTongue == "yes";		//give it a tongue and eyes

difference() {
	scale([flange_width,flange_height,flange_thickness]) cylinder(r=1/2, h=1);
	
	for (offset=[1,-1]) if (offset==1) for (xoff=[1,-1]) translate([xoff*top_screw_x_spacing/2,offset*screw_y_spacing/2,-1]) {
		cylinder(r=screw_diameter/2, h=flange_thickness+2);
		translate([0,0,flange_thickness-countersink_depth+1.01]) cylinder(r1=screw_diameter/2, r2=screw_diameter/2+countersink_depth, h=countersink_depth);
	}
	else translate([0,offset*screw_y_spacing/2,-1]) {
		cylinder(r=screw_diameter/2, h=flange_thickness+2);
		translate([0,0,flange_thickness-countersink_depth+1.01]) cylinder(r1=screw_diameter/2, r2=screw_diameter/2+countersink_depth, h=countersink_depth);
	}
	translate([0,sphere_y_offset-2,8]) rotate([-cap_angle,0,0]) cap_cutout();

}


translate([0,sphere_y_offset,flange_thickness+sphere_z_offset])
difference() {
    union()
    {
	rotate([-sphere_angle,0,0]) scale([sphere_width,sphere_width,sphere_height]) sphere(r=1/2);
        
        //negating the outside translate
        // This is to make sure the eyes won't interfere with the coin placement
        translate([0,-sphere_y_offset,-flange_thickness-sphere_z_offset])
            eye_and_tongue_module();
    }
	rotate([-sphere_angle,0,0]) {
		translate([0,0,-(roof_thickness-wall_thickness)]) scale([sphere_width-wall_thickness,sphere_width-wall_thickness,sphere_height-roof_thickness]) sphere(r=(1/2));
		translate([-sphere_width/2,-sphere_width,-sphere_height/2]) cube([sphere_width,sphere_width,sphere_height]);
	}
	translate([0,cylinder_offset,0]) cylinder(r=sphere_width/2-wall_thickness, h=sphere_height);
	translate([-sphere_width/2,-sphere_width/2,-sphere_height-sphere_z_offset]) cube([sphere_width,sphere_width,sphere_height]);
	rotate([-coin_angle,0,0]) translate([0,0,sphere_height/2+coin_diam/2-roof_thickness-coin_stickout]) rotate([coin_rotation,0,0]) coin_cutout();
    
    if (CoinDebug == "yes")
    {
        rotate([-coin_angle,0,0]) translate([-20,0,sphere_height/2+coin_diam/2-roof_thickness-coin_stickout-20]) rotate([0,0,-90]) cube([20,40,40]);
    }
    
    //Connection Debug:
    //translate([-30,-10,-7.5])
    //    cube([60,40,40]);
}

module eye_and_tongue_module()
{
if (eye_and_tongue) {
	for (eye=[-1,1]) rotate([-eye_x_angle,eye*eye_y_angle,0]) translate([0,0,eye_height]) difference() {
		sphere(r=eye_diam/2);
		translate([0,0,eye_diam/2]) sphere(r=pupil_diam/2);
	}
}
}
if (eye_and_tongue) {
	difference() {
		translate([0,sphere_width/2+sphere_y_offset-wall_thickness*2,flange_thickness+tongue_z_offset]) rotate([tongue_angle,0,0]) difference() {
			scale([tongue_width,tongue_thickness,tongue_length*2]) sphere(r=1/2);
			translate([0,0,-tongue_length/2]) cube([tongue_width+2, tongue_thickness+2, tongue_length], center=true);
			rotate([8,0,0]) scale([1,1,1]) translate([0,tongue_thickness/2+tongue_groove/3,0]) cylinder(r=tongue_groove/2, h=tongue_length);
			
		}
		translate([0,0,-flange_thickness/2]) cube([flange_width+2,flange_height+2,flange_thickness*2], center=true);
	}
} else {
	translate([0,fulcrum_y_offset,flange_thickness-fulcrum_diam/2+fulcrum_z_offset]) rotate([0,90,0]) translate([0,0,-sphere_width/2+wall_thickness/2]) cylinder(r=fulcrum_diam/2, h=sphere_width-wall_thickness);
}

//translate([0,sphere_y_offset,flange_thickness+sphere_z_offset]) rotate([-coin_angle,0,0]) translate([0,0,sphere_height/2+coin_diam/2-roof_thickness-coin_stickout])  rotate([coin_rotation,0,0]) coin();

//translate([0,+sphere_y_offset,13]) rotate([-cap_angle+15,0,0]) cap();


module coin()
{
	translate([0,coin_thickness/2,0]) rotate([90,0,0]) cylinder(r=coin_diam/2, h=coin_thickness);

}

module coin_cutout()
{
	translate([0,coin_thickness/2,0]) rotate([90,0,0]) union() {
		cylinder(r=coin_diam/2, h=coin_thickness);
		translate([-coin_diam/2,-coin_diam,0]) cube([coin_diam,coin_diam,coin_thickness]);

	}

}

module cap()
{
	rotate([90,0,0]) cylinder(r=cap_diam/2, h=cap_thickness, center=true);
}

module cap_cutout()
{
	rotate([90,0,0])
    {
		cylinder(r1=cap_diam/2, r2=cap_diam/2+cap_chamfer, h=cap_thickness, center=true);
        //don't leave sharp edge on cap cutout
        //  Fixed by just extending straight down
        translate([0,0,cap_thickness/2-0.001])
            cylinder(r=cap_diam/2+cap_chamfer, h=cap_thickness);
    }
}
