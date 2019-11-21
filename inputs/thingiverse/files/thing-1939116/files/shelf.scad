// simplistic shelf plank wall mount

// triangle wall leg
height = 100;                                       // [50:200]
// triangle plank leg
arm = 140;                                          // [50:250]
// percentage of leg extension beyond triangle
protrude = 25;                                      // [0:100]
// width of mount
width = 20;                                         // [8:64]    
// structural strength 
strength = 4;                                       // [2:16]
// plank slot
plank = 4;                                          // [1:12]        
// diameter holes for fixing plank
screw_plank = 3.5;                                  // [0:0.1:8]
// diameter holes for wall mounting
screw_rear = 4.5;                                   // [0:0.1:12]
// percentage of width for wall mount hole distance
spacing_h = 20;                                     // [0:50]
// percentage of height for wall mount hole distance
spacing_v = 18;                                     // [0:50]

little = 0+0.01;

function percent(percentage, x) = x * percentage / 100;

difference()  {
    linear_extrude(width)  {                                                        // main structure
        square([strength, percent(100+protrude, height)]);                          // wall leg
        square([strength*3, strength]);                                             // plank clamp
        translate([0, strength+plank])
        square([percent(100+protrude, arm), strength]);                             // plank leg
        translate([arm, strength+plank])

        rotate([0, 0, 90-atan((height-strength-plank)/arm)])
        square([strength, sqrt(pow(arm, 2) + pow(height-strength-plank, 2))]);      // diagonal support
    }

    translate([arm*1.2-strength*2, strength+plank-little/2, width/2])
    rotate([270, 0, 0])
    cylinder(d=screw_plank, h=strength+little);                                     // front plank fixation

    translate([strength*2, -little/2, width/2])
    rotate([270, 0, 0])
    cylinder(d=screw_plank, h=strength+plank+strength+little);                      // rear plank fixation

    translate([-little/2, percent(spacing_v, height), percent(spacing_h, width)])
    wall_mount();                                                                   // top left wall mount

    translate([-little/2, percent(spacing_v, height), width-percent(spacing_h, width)])
    wall_mount();                                                                   // top right wall mount

    translate([-little/2, percent(100+protrude, height)-percent(spacing_v, height), width/2])
    wall_mount();                                                                   // bottom wall mount
}

module wall_mount()  {
    rotate([0, 90, 0])
    cylinder(d=screw_rear, h=strength+little);
}
