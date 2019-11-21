
cube([36.09336, 36.09336, 19]);
translate([1.039, 0.820, 0])
    linear_extrude(height = 23.56, convexity = 5)
        import(file = "coeur.dxf", layer = "0");

