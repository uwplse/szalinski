
cube([57.09336, 36.09336, 19]);
translate([1.207, 2.042, 0])
    linear_extrude(height = 23.56, convexity = 5)
        import(file = "vgauche.dxf", layer = "0");

