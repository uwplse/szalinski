//  Windows users must "escape" the backslashes by writing them doubled, or replace the backslashes with forward slashes.

// optimum slicing of round edges:
// for a 0.2mm layer height $fn= 16 * d
// 16 = roundup ( 1mm * pi / 0.2mm )

dd=113-20;
f1=360;
d1=25;

translate([0,95,30])
difference()
{
    union()
    {
        *translate([-117.78,-95.5,-31]) // front arc
        difference()
        {
            cylinder(h=2,d=124.09,center=true, $fn=f1);
            cylinder(h=2.02,d=124.09-2*d1,center=true,$fn=f1);
            rotate([0,0,-62.62+180])
            translate([-125/2,0,-1.01])
            cube([125,65,2.02],center=false);
            rotate([0,0,62.62+90])
            translate([0,-125/2,-1.01])
            cube([65,125,2.02],center=false);
        };
        
        translate([117.78,-95.5,-31]) // hind arc
        difference()
        {
            cylinder(h=2,d=124.09,center=true, $fn=f1);
            cylinder(h=2.02,d=124.09-2*d1,center=true,$fn=f1);
            rotate([0,0,-62.62])
            translate([-125/2,0,-1.01])
            cube([125,65,2.02],center=false);
            rotate([0,0,62.62-90])
            translate([0,-125/2,-1.01])
            cube([65,125,2.02],center=false);
        };
        
        //translate([-75,-120.5,-31]) // left front
        //rotate([0,0,0])
        //cylinder(h=2, d=d1, center=true, $fn=f1);
        *translate([-95,-139.5,-31]) // left front
        rotate([0,0,0])
        cylinder(h=2, d=d1, center=true, $fn=f1);

        *translate([-95.5,-139.8,0]) // left front
        rotate([0,0,15])
        translate([-63,92,-59.1])
        rotate([0,0,180])
        scale([0.5,0.5,0.5])
        import("lion_left.stl", convexity=3);

        //translate([75,-120.5,-31]) // left hind
        //rotate([0,0,0])
        //cylinder(h=2, d=d1, center=true, $fn=f1);
        translate([95,-139.5,-31]) // left hind
        rotate([0,0,0])
        cylinder(h=2, d=d1, center=true, $fn=f1);

        translate([94.5,-139.8,0]) // left hind
        rotate([0,0,15])
        translate([-63,92,-59.1])
        rotate([0,0,180])
        scale([0.5,0.5,0.5])
        import("lion_left.stl", convexity=3);

        //translate([-75,-70.5,-31]) // right front
        //rotate([0,0,0])
        //cylinder(h=2, d=d1, center=true, $fn=f1);
        *translate([-95.5,-51.5,-31]) // right front
        rotate([0,0,0])
        cylinder(h=2, d=d1, center=true, $fn=f1);

        *translate([-96.8,-51.1,0]) // right front
        rotate([0,0,-5])
        translate([-64,33,-59.1])
        rotate([0,0,180])
        scale([0.5,0.5,0.5])
        import("lion_right.stl", convexity=3);

        //translate([75,-70.5,-31]) // right hind
        //rotate([0,0,0])
        //cylinder(h=2, d=d1, center=true, $fn=f1);
        translate([95,-51.5,-31]) // right hind
        rotate([0,0,0])
        cylinder(h=2, d=d1, center=true, $fn=f1);

        translate([93.8,-51.1,0]) // right hind
        rotate([0,0,-5])
        translate([-64,33,-59.1])
        rotate([0,0,180])
        scale([0.5,0.5,0.5])
        import("lion_right.stl", convexity=3);
                

    };

    color("grey") //PSU & bottom holes
    translate([0,-113/2-20-19,-5])
    {
        *cube([215,113,50],center=true);
        
        translate([75,113/2-31.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);
        
        translate([75,113/2-81.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);
        
        translate([-75,113/2-31.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);
        
        translate([-75,113/2-81.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);   
    };
};
//