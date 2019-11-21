$fn=50;
base_thickness=8;
clamp_thickness=5;
front_clamp_height=16;
clamp_back_height=25;
clamp_gap=27;
clamp_inner_cornice_radius=3;

base(base_thickness);

//Front Clamp
rotate([90,0,90])
    roundedCube([clamp_thickness,front_clamp_height+base_thickness,112],clamp_thickness/2);
translate([0,clamp_thickness,base_thickness])
    cornice(clamp_inner_cornice_radius,112);


//back clamp
translate([0,clamp_gap+clamp_thickness,base_thickness])
    clamp_back(clamp_back_height, clamp_thickness,21);
translate([0,clamp_thickness+clamp_gap,base_thickness])
    rotate([90])
        cornice(clamp_inner_cornice_radius,21);
//back clamp
translate([112-21,clamp_gap+clamp_thickness,base_thickness])
    clamp_back(clamp_back_height, clamp_thickness,21);
translate([112-21,clamp_thickness+clamp_gap,base_thickness])
    rotate([90])
        cornice(clamp_inner_cornice_radius,21);


module base(thickness){
    difference(){
            roundedCube([112, 72, thickness], 5);
            translate([56,22,0])cylinder(thickness,3.5,3.5);
            translate([56,22,thickness/2])cylinder(thickness,6,6);
            translate([21,30,0])roundedCube([70,32,thickness],5,$fn=25);
    }
    cube([112,thickness,thickness]);
}

module roundedCube(size, r)
{
	x = size[0];
	y = size[1];
	z = size[2];

    hull(){
        translate([r, r, 0]) cylinder(z,r, r);
        translate([x-r, r, 0]) cylinder(z,r, r);
        translate([r, y-r, 0]) cylinder(z,r, r);
        translate([x-r, y-r, 0]) cylinder(z,r, r);
    }
}

module cornice(radius, length){
    
    difference(){
        cube([length, radius, radius]);
        translate([0,radius,radius])rotate([0,90,0])cylinder(length, radius, radius);
    }
    
    
}

module clamp_back(height, thickness, width){
    
    difference(){
        cube([width, height+thickness,height-(thickness/2)]);
        translate([0,height+thickness,height])rotate([0,90,0])cylinder(width, height, height);
    }
    translate([0,thickness/2,height-(thickness/2)])rotate([0,90,0])cylinder(width,thickness/2,thickness/2);
    
}