
cube([25.09336, 36.09336, 19]);
translate([1.082, 0.865, 0])
    linear_extrude(height = 23.56, convexity = 5)
        import(file = "victoire.dxf", layer = "0");

