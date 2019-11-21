OD=50;  // outside diameter
ID=40;  // inside diameter

RH=75; // hanger radius

FN=360;  // rendering fineness

MD=10;  // mounting hole diameter

rotate([-90,0,90])
union() // arc
{
    translate([0,0,OD/2])
    difference()
    {
        rotate_extrude($fn=FN) 
        {
            translate([RH,0,0])
            union()
            {
                translate([0,ID/2+(OD-ID)/4,0])
                circle(d=(OD-ID)/2,$fn=FN/2);
                translate([0,-ID/2-(OD-ID)/4,0])
                circle(d=(OD-ID)/2,$fn=FN/2);
                difference()
                {
                    circle(d=OD,$fn=FN);
                    circle(d=ID,$fn=FN);
                    translate([0,-OD/2,0])
                    square([OD,OD]);
                };
            };
        };
        translate([-(2*RH+OD)/2,0,-(OD+ID)/2])
        cube([2*RH+OD,RH+OD,OD+ID]);
    };
    
    difference() // stratificaton
    {
        translate([0,0,OD/2-(OD-ID)/4])
        cylinder(r=RH-ID/2,h=(OD-ID)/2,$fn=FN);
        translate([-(2*RH+OD)/2,0,-(OD+ID)/2])
        cube([2*RH+OD,RH+OD,OD+ID]);
    };
    
    translate([0,-RH-MD*2,0]) // mount
    difference()
    {
        union()
        {
            cylinder(d=3*MD,h=(OD-ID)/2,$fn=FN);

            translate([0,0,(OD-ID)/4])
            rotate_extrude($fn=FN)
            translate([3*MD/2,0,0])
            circle(d=(OD-ID)/2,$fn=FN/2);

            translate([-3*MD/2,0,0])
            cube([3*MD,4*MD,(OD-ID)/2]);
            
            translate([3*MD/2,4*MD,(OD-ID)/4])
            rotate([90,0,0])
            cylinder(d=(OD-ID)/2,h=4*MD,$fn=FN/2);
            
            translate([-3*MD/2,4*MD,(OD-ID)/4])
            rotate([90,0,0])
            cylinder(d=(OD-ID)/2,h=4*MD,$fn=FN/2);
        };
        translate([0,0,-(OD-ID)/4])
        cylinder(d=MD,h=OD-ID,$fn=FN);
        
        translate([0,RH+MD*2,-(OD-ID)/4])
        cylinder(r=RH,h=OD-ID,$fn=FN);
    };
};
