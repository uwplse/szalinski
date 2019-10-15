//
//  fixing bar for Raspberry Pi 7 inch display
//
//  you need two of these and four e.g. 10mm M3 screws
//  make sure the screws do not bottom out, or you may destroy the LCD panel!
//
//  design by egil kvaleberg, 20 may 2019
//

padw = 8.0; // general width of bar and size of square pads
padh = 6.0; // heigth of pads, use 6.0 for thin panels, but can be decreased to 0.0 for really thick ones
barh = 5.0; // height of bar itself, the larger the stronger. screw length needs to be adjusted accordingly, of course.

hdist = 65.0; // distance between holes
hoffs = 2.5; // not centered
hdia = 3.3; // hole diameter
hlen = 103.0; // bar length less pads

rotate([90,0,0]) {
    difference () {
        translate([-hlen/2-padw, -padw/2, padh])
          cube([hlen+2*padw, padw, barh]);
        for (dx = [-1,1]) translate([hoffs+dx*hdist/2,0,0]) 
          cylinder(d=hdia, h=padh+barh+1, $fn=16);
    } 
    for (dx = [-1,1]) translate([dx*(hlen/2+padw/2)-padw/2, -padw/2, 0])
      cube([padw, padw, padh]);
}
