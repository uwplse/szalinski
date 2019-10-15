//Streaming Device TV Mount

//by replayreb
//GPL License

//https://www.thingiverse.com/thing:3255257

//(in mm)
wall_thickness = 2;

mounting_hole_diameter = 6.5;

device_width = 160;
//(depth = length of device from front to back)
device_depth = 99;
device_height = 26.5;

//(Enter value greater than width of device if you want top completely enclosed)
top_bezel_width = 3.5;

//(Use if you want centered cutout for ports, otherwise enter value greater than width of device and customize cutout below) 
port_bezel_width = 3.5;

//(Use next four values to customize port cutout size and offset, otherwise zero these out)
port_cutout_width = 0;
port_cutout_height = 0;

//(experiment here to offset port cutout)
port_cutout_width_offset = 0;
port_cutout_height_offset = 0;

//Make mount
difference(){
	//Case
	cube([device_width+wall_thickness*2,device_height+wall_thickness*2,device_depth+wall_thickness*2], center = true);

	//Device cutout
	translate([0, 0, wall_thickness])
	cube([device_width,device_height,device_depth], center = true);

	//Top cutout
	translate([0, -device_height/2, top_bezel_width+wall_thickness])
	cube([device_width-top_bezel_width*2,device_height,device_depth], center = true);

	//Uniform port cutout using bezel value
    translate([0, 0, -device_depth/2])
	cube([device_width-port_bezel_width*2, device_height-port_bezel_width*2, device_depth], center = true);
    
    //Custom port cutout
	translate([port_cutout_width_offset, port_cutout_height_offset, -device_depth/2])
	cube([port_cutout_width,port_cutout_height,device_depth], center = true);
}

//Make mounting bracket
difference(){
    hull(){
        difference(){
            cube([device_width+wall_thickness*2,device_height+wall_thickness*2,device_depth+wall_thickness*2], center = true);

            translate([0, -wall_thickness, 0])
            cube([device_width+wall_thickness*2,device_height+wall_thickness*2,device_depth+wall_thickness*2], center = true);
        }

        difference(){
            translate([0, 0, device_depth/2+12.7])
            rotate([90, 0, 0])
            cylinder(device_height+wall_thickness*2, d=25.4, center = true);

            translate([0, -wall_thickness, device_depth/2])
            cube([device_width+wall_thickness*2,device_height+wall_thickness*2,device_depth+wall_thickness*2], center = true);
        }
    }

    translate([0, 0, device_depth/2+18-mounting_hole_diameter/2])
    rotate([90, 0, 0])
    cylinder(device_height*2, d=mounting_hole_diameter, center = true);
}