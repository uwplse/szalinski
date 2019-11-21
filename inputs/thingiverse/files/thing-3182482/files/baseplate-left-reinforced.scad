
thickness = 1;
height = 5;
left_side=1;    //change to zero to make right side

difference()
{

union()
    {
    rotate([0,180*left_side,0])
    translate([.2,3.35,0])
    color("green")import("Base_Plate_Left.stl",convexity=10);

    rotate([0,180*left_side,0])
    translate([0,0,-height*left_side])
    {
        row();
        translate([0,-19]) row();
        translate([0,19]) row();
        translate([0,19*2]) row();
        translate([0,19*3]) row();

        column();
        translate([19,-2.25]) column();
        translate([19*2,-3.5]) translate([9.5,17.75,3])cube([thickness,77,height],center=true);
        translate([-19,0]) column();
        translate([-19*2,-3.37]) translate([9.5,17.75,3])cube([thickness,81.7,height],center=true);
        translate([-19*3,-6]) translate([9.5,17.75,3])cube([thickness,76,height],center=true);
        translate([-19*4,-6]) translate([9.5,17.9,3])cube([thickness,76.7,height],center=true);


        //odd keys
        translate([-2.5,-40])cube([20,thickness,height]);
        translate([-2.5,-21.8])cube([20,thickness,height]);
        translate([-2.5,-40])cube([thickness,21,height]);
        translate([16.7,-43])cube([thickness,22,height]);


        translate([17,-43])cube([20,thickness,height]);
        translate([17,-24.2])cube([20,thickness,height]);
        translate([36,-43])cube([thickness,19,height]);


        rotate(-30) translate([53,-20]) cube([thickness,39,height]);
        rotate(-30) translate([73,-19]) cube([thickness,34,height]);
        rotate(-30) translate([53,-20])cube([21,thickness,height]);
        rotate(-30) translate([53,-1])cube([21,thickness,height]);
        rotate(-30) translate([53,18])cube([21,thickness,height]);
    }
}

    //screw post clearance
    translate([68.5,52,0])cylinder(d=8,h=height+1,$fn=20);
    translate([68.75,-28.75,0])cylinder(d=8,h=height+1,$fn=20);
    translate([-50,54.5,0])cylinder(d=8,h=height+1,$fn=20);
    translate([-73.75,-21.5,0])cylinder(d=8,h=height+1,$fn=20);
    translate([-53.5,-56.25,0])cylinder(d=8,h=height+1,$fn=20);
}

module row()
{

translate([-19*3,-7,3])
cube([19,thickness,height],center=true);

translate([-19*2,-7,3])
cube([19,thickness,height],center=true);

translate([-19,-2.3,3])
cube([19,thickness,height],center=true);

translate([0,0,3])
cube([19,thickness,height],center=true);

translate([19,-2.3,3])
cube([19,thickness,height],center=true);

translate([19*2,-4.7,3])
cube([19,thickness,height],center=true);
}

module column() translate([9.5,17.75,3])cube([thickness,79.25,height],center=true);
