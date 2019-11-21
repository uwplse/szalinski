
disk_thickness = 2.5;
disk_radius = 58;
centertower_height = 9;
outer_nut_count = 3;




union(){
    centernut_height = 5;
    centernutradius = 14.9 /2;
    outernutheight = 3;
    outernutradius = 8.1 / 2;
    outerstuffmargin = 8; 
    
    difference(){
        union(){
            cylinder(h = disk_thickness, r = disk_radius, center = false, $fn = 50);
            translate([0, 0, disk_thickness]) cylinder(h = centertower_height, r =centernutradius + 4, center = false, $fn = 50);
            }
        cylinder(h = disk_thickness + centertower_height, d = 8.1, center = false, $fn = 50);
     make_ring_of(disk_radius - outerstuffmargin, outer_nut_count) cylinder(h = disk_thickness, r = 2, center = false, $fn = 50);
    }

    translate([0, 0, disk_thickness + centertower_height]) difference(){
        cylinder(h = centernut_height, r1 =centernutradius + 4, r2 =centernutradius + 2, center = false, $fn = 50);
        cylinder(h = centernut_height, r = centernutradius,center = false, $fn = 6);

    }

    
    translate([0, 0, disk_thickness]) make_ring_of(disk_radius - outerstuffmargin, outer_nut_count)  difference(){
        cylinder(h = outernutheight, r1 =outernutradius + 3, r2 =outernutradius + 1, center = false, $fn = 50);
        cylinder(h = outernutheight, r = outernutradius,center = false, $fn = 6);
    }
}
//cylinder(h = plateheight, r = 40, center = false, $fn = 6);



module make_ring_of(radius, count)
{
    for (a = [0 : count - 1]) {
        angle = a * 360 / count;
        translate(radius * [sin(angle), -cos(angle), 0])
            rotate([0, 0, angle])
                children();
    }
}

