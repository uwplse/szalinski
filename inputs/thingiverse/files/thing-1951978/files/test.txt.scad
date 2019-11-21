//!OpenSCAD

//all units are mm

//Cell Size
cellsize = 3;

//Cell Spacing (must be larger than cellsize or things get wierd)
cellspacing = 9;

//Edge padding
padding = 3;

//Cells Wide
cellsw = 3;

//Cells High
cellsh = 4;

//Shape
isCircle = 0; //[0:Square, 1:Circle]

//Thickness
thickness = 3;

//Edge Radius
radius = 4;

width = (cellsize * cellsw)  + ((cellspacing-cellsize) * (cellsw-1)) + (padding*2);
height = (cellsize * cellsh)  + ((cellspacing-cellsize) * (cellsh-1)) + (padding*2);

//--------

module cell(size, thickness, isCircle) {
    if(isCircle) {
        translate([size/2, size/2, 0])
        cylinder(r = size/2, h = thickness + 0.2, $fn = 72, center=false);
    } else {
        cube(size=[size, size, thickness + 0.2], center=false);
    }
}

module roundedBox(size, radius)
{
    //cube(size, false);
    union() {
        translate([radius,0,0]) {
            cube(size - [2*radius,0,0], false);
        }
        translate([0,radius,0]) {
            cube(size - [0,2*radius,0], false);
        }
        
        for (x = [radius, size[0] -  radius],
             y = [radius, size[1] - radius]) {
          translate([x,y,0]) cylinder(r=radius, h=size[2], center=false, $fn=36);
        }
    }
}

module grid(w, h, sz, spacing, thickness, isCircle) {
	union(){
		for(i = [0 : w-1]){
			for(j = [0 : h-1]){
				translate([i * spacing, j * spacing, -0.1])
				cell(size=sz, thickness=thickness, isCircle=isCircle);
			}
		}
	}
}

translate([-width/2, -height/2, 0])
difference(){
	roundedBox(size=[width, height, thickness], radius=radius);
	translate([padding, padding, 0]) 
	    grid(w=cellsw, h=cellsh, sz=cellsize, spacing=cellspacing, thickness=thickness, isCircle=isCircle);
	
};