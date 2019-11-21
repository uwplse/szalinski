
cube([30.09336, 36.09336, 19]);
translate([1.1, 0.837, 0])
    linear_extrude(height = 23.56, convexity = 5)
        import(file = "pouceenlair.dxf", layer = "0");
