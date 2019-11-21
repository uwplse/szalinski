// YokaiWatchMedal.scad

pegList = [[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]];

union() {
    difference() {
        cylinder(3.6,21,21,$fn=128);
        translate([7.5,0,3.6]) cube([19,60,3], center=true);
        translate([7.5,0,3.1]) cube([16,60,3], center=true);
        translate([0,13,-2])
            linear_extrude(height = 5, center = true, convexity = 10, twist = 0)
                polygon(points = [[5, 0], [-5, 0], [0, 5]]);
        translate([0,-16,-2]) scale([1,0.4,1]) cylinder(3,6,6,$fn=32);
    }
    startPos = [1.45,13.3,1.5];
    for (a=[1:4])
        for (b=[1:4])
            if ((pegList[b-1])[a-1])
                translate(startPos + [((a-1)*4),((b-1)*-6),0])
                    rotate([90,0,90])
                        linear_extrude(height = 4, center = true, convexity = 10, twist = 0)
                            polygon(points = [[1, 0], [-1, 0], [-0.3, 2.5], [0.3, 2.5]]);
        
}
