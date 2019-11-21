/* [3D printer air filter settings]*/
// Markham Thomas   Jan 9th, 2018
// Openscad code to generate a fan box to hold a 120mm 12v PC chassis fan
// Uses a shopvac filter (solid plastic on one end and open at the other) 195mm in dia with 20mm rubber ring
// The 120mm fan goes into the fan box and blows into the shopvac filter creating a vacuum.  1 1/4" shopvac hose goes onto the box and into the 3d printer enclosure
// add a small amount to account for shrinkage
shrink_fix = 0.4;       //[0.1:.1:0.6]
// width of the fan on X axis
xwide = 120 + shrink_fix; //[10:5:200] 
// width of the fan on Y axis
ywide = 120 + shrink_fix; //[10:5:200]
// wall thickness
thickness = 2;          //[1:1:4]
// height of the fan (vertical) plus dead space (fan size again is good fit)
boxheight = 50;         //[10:10:80]
// diameter of the hose opening (larger than your hose diameter by 30%)
tubecutout = 40;        //[20:1:100]
// diamter of the flexible hose (internal ID, smaller than tubecutout)
plastic_tube_id = 33;   //[20:1:100]
// fan shroud thickness at thinest point
fan_outer_dia = 5;      //[1:1:20]
// square fan assumed, enter fan length (should be same as width)
fan = 120 + shrink_fix; //[10:5:200]
// diameter of the air filter
air_filter_dia = 190;   //[100:10:300]
// resolution of the cylinder used for the vacuum hose
resolution = 44;               //[12:4:88]

$fn = resolution;
translate([air_filter_dia, 0, -boxheight]) {
// rings on tube nozzle to help hold the vacuum hose on
for (i=[0,4,9]) {
    translate([xwide/2,ywide/2,boxheight+18+i]) {
        difference() {
            cylinder(h=2,r=(plastic_tube_id+thickness+2)/2);
            cylinder(h=2,r=(plastic_tube_id)/2);
        }
    }
}

// tube nozzle (tapered part after straight part to help seal)
translate([xwide/2,ywide/2,boxheight]) {
    difference() {
        cylinder(h=20,r1=(tubecutout+thickness)/2,r2=plastic_tube_id/2);
        cylinder(h=20,r1=(tubecutout)/2,r2=(plastic_tube_id-thickness-2)/2);
    }
}

// straight part of tube nozzle
translate([xwide/2,ywide/2,boxheight+18]) {
    difference() {
        cylinder(h=12,r1=plastic_tube_id/2,r2=plastic_tube_id/2);
        cylinder(h=12,r=(plastic_tube_id/2)-thickness);
    }
}

// top plate with tube nozzle cutout
translate([0,0,boxheight]) {
    difference() {
        cube([xwide+thickness*2,ywide+thickness*2,thickness]);
        translate([xwide/2,ywide/2,0]) cylinder(r=tubecutout/2,h=thickness);
    }
}
}
// Note: had to adjust to get the box edges to meet up.  I adjusted by 2mm so if you change the thickness adjust this value also
// origin X wall
cube([xwide+thickness,thickness, boxheight]);
// origin Y wall
cube([thickness,ywide+thickness,boxheight]);  // wall thickness
// farside from origin X wall
translate([0,ywide+thickness,0]) cube([xwide+thickness,thickness, boxheight]);
// farside from origin Y wall
translate([xwide+thickness,0,0]) cube([thickness,ywide+thickness*2, boxheight]);

// the bottom circular plate that connects to the shopvac rubber ring
difference() {
    translate([xwide/2,ywide/2,0]) cylinder(h=thickness, r=air_filter_dia/2,center=false);
    cube([fan+thickness,fan+thickness,thickness],false);
}