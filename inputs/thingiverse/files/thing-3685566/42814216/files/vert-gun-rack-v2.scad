//Pistol riser and base insert

// Which part are your priting?
part = "both"; // [both:Both, vert:Vertical Muzzle Support Only, base:Base Insert]

//These can be modified:

// Muzzle Top Height
muzzletoph=125;      
    //height of the top of the horizontal muzzle above the base - this is the total height of the vertical back support. It can be less than the full height if you only want it to cradle part of the muzzle.

// Muzzle Bottom Height
muzzlebottomh=98;
    //height of the base of the horizontal muzzle above the base - this is where the muzzle slot will start.

// Muzzle Width
muzzlew=29;     //[5:0.5:40.5]
    //width of the muzzle slot

// Muzzle Roundness
muzzleslotroundness=3;  //[0:.5:20]
    //How rounded you want the cutout of the muzzle slot to be. 0 = square edges, 1/2 value of muzzlew = round bottom cutout

// Plaque Text
plaquetext="SW99";
    //The writing on the plaque. The shorter the better (use abbreviations.) 

// Plaque Text Size
plaquetextsize=9; //[3:10]
    //The font size. Lower this if using more than 5 letters.

// Grip Base Length
baselength=52;  //[10:60]
    //Length of the pistol grip base.

// Grip Base Width
basewidth=32;     //[5:0.5:40.5]
    //Width of the pistol grip base. Must be less than width-thick*4

// Grip Base Angle
baseangle=6;    //[-3:15]
    //Angle of the base - positive value raises the butt end higher. Zero is flat. Negative values may bottom out the cut.

// Grip Base Roundness
baseroundness=3;  //[0:.5:20]
    //How rounded you want the base cutout to be. 0 = square edges, 1/2 value of basewidth = round bottom cutout ends.


/* [Hidden] */
//Don't touch these values:
slop=.4;
thick=2.4;
width=50;
smooth=30;


// preview[view:south east]

module bsnapwing()
{
    //Straight wings
    translate([thick,0,0])roundedcube([width,thick,thick*3],false,thick/2,"zmax");
    //Angled wings
    difference()
    {
        translate([-width/3*2,0,-width/4])rotate([0,30,0])roundedcube([width,thick,width],false,thick/2);
        translate([-100,-thick/2,-99])cube([200,thick*2,100]);
        translate([-100+thick,-thick/2,0])cube([100,thick*2,100]);
    }
    //Snap Nubs
    difference()
    {
        translate([width-thick,-thick*.8,thick+slop/2])rotate([-90,0,0])cylinder(d=thick*2,h=thick,$fn=smooth);
        translate([width-thick*5+slop,0,-thick])rotate([0,0,-40])cube([20,5,20]);
    }
}

module plaque()
{
    roundedcube([width/2,width-thick*2,thick],true,thick/2);
    rotate([0,0,90])linear_extrude(height = 2)
    {
		text(plaquetext, size = plaquetextsize, halign = "center", valign = "center", $fn = smooth);
    }
}


    //holes for pistol back snap wings - test
    //translate([width-thick,-width/2,thick+slop/2])rotate([-90,0,0])cylinder(d=thick*2,h=1,$fn=smooth);

//Pistol base insert
module basei()
{
    difference()
    {
        roundedcube([baselength+thick*2,width-thick*2,thick*5],false,thick/2,"zmax");
        translate([thick+(baseangle/10),((width-thick*2)-basewidth)/2,thick])rotate([0,-baseangle,0])
        union()
        {
            roundedcube([baselength,basewidth,100],false,baseroundness);
            translate([baselength/2,basewidth/2,-thick/4])linear_extrude(height = 5)
                {text(plaquetext, size = plaquetextsize, halign = "center", valign = "center", $fn = smooth);}
        }
    }

    //Ridges
    for(i=[thick/4:thick*3:baselength-thick/4])
    translate([i+thick,0,thick])cylinder(d=thick*1.48,h=thick*2,center=true,$fn=smooth);
}



//Vertical Riser
module vertrise()
{
    difference()
    {
        roundedcube([thick*2,width-thick*2,muzzletoph+thick*2],false,thick/2,"zmax");
        translate([thick,thick,-thick])cube([thick*2,width-thick*4,muzzletoph+thick*2]);
        //back hook for pistol base
        translate([sqrt(thick*thick+thick*thick)/4-thick-slop/3,-slop/2,thick*1.5])rotate([0,45,0])cube([thick,width-thick*2+slop,thick]);
        //Hole/slot for muzzle
        translate([0,(width-thick*2)/2,muzzletoph])roundedcube([thick*20,muzzlew,(muzzletoph-muzzlebottomh)*2],true,muzzleslotroundness);
        //Anything fancy - do it here:
    }
    
    //Extra support around the bottom hook
    translate([thick,0,0])roundedcube([1,width-thick*2,thick*3],false,.5,"zmax");
    
    //bottom snap wings
    bsnapwing();
    translate([0,width-thick*2,0])rotate([180,0,0])mirror([0,0,180])bsnapwing();
    
    //plaque
    translate([11.5,width/2-thick,17.966])rotate([0,30,0]) plaque();
}

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
    // This module was written by Daniel Upshaw!
    // More information: https://danielupshaw.com/openscad-rounded-corners/

    // Set to 0.01 for higher definition curves (renders slower)
    $fs = 0.15;
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}

print_part();

module print_part()
{
    if (part == "both"){
        vertrise();
        translate([0,-width-thick*2,baselength+thick*2])rotate([0,90,0])basei();
    }   else if (part == "vert"){
        vertrise();
    }   else if (part == "base"){
        basei();
    }   else {
        vertrise();
        translate([0,-width-thick*2,baselength+thick*2])rotate([0,90,0])basei();
    }
}        
