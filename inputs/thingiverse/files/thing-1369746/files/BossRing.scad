echo(version=version());

text="BOSS";
ring_size=22;
letter_size = 25;
font="Times New Roman";
ring_thickness=3;
ring_width=6;
letter_height = 5;


module ring()
{
    difference()
    {
        cylinder(d=ring_size+ring_thickness*2, h=ring_width);
        translate([0,0,-.05])
        cylinder(d=ring_size, h=ring_width+.1);
    }
}


$fn=256;

module letter(l) {
  translate([0,0,-letter_height / 2])
  {
    linear_extrude(height = letter_height, convexity = 10) {
   
        text(l, size = letter_size, font = font, halign = "center", valign = "center", spacing=1);
    }
  }
}


module BossRing()
{
    translate([0,0,letter_height/2-.2])
    letter(text);

    intersection()
    {
        translate([0,0,-letter_height])
        hull()
        {
            translate([0,0,letter_height/2])
            letter(text);
        }

        translate([0,0,-ring_thickness/2])
        scale([10000,ring_width,ring_thickness])
        cube(1, center=true);
    }

    ring_outer_size=(ring_size+ring_thickness+.1);
    translate([-1*ring_outer_size,0,/*-ring_thickness*/0])
    translate([0,ring_width/2,-ring_size/2-ring_thickness])
    for(i=[0:1:2])
        translate([i*ring_outer_size,0,0])
        rotate([90,90,0])
        ring();
}

rotate([180,0,0])
BossRing();