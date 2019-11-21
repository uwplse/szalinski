
cube([36.09336, 36.09336, 19]);
translate([0.848, 0.838, 0])
    linear_extrude(height = 23.56, convexity = 5)
        import(file = "smiley.dxf", layer = "0");

