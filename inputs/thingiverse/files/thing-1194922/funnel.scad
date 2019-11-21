

// Mode. Use "printing" for actual printing.
mode = "design";  // [design, printing]

// Diameter at the bottom of the funnel. Tweak for good tube fit.
bottom_hole_diameter = 7;

// Controls the inner shape of the hold.
k1 = 4;

// Controls the outer shape of the funnel.
k2 = 2;

// Diameter at the top of the funnel.
top_hole_diameter = 11;

// Wall thickness at bottom of funnel
bottom_wall = 4;

// Wall thickness at top of funnel.
top_wall = 3;

// Height of a cylindrical extension at the bottom.
straight_height = 1;

// Height of the funnel part.
funnel_height = 11;

// Hole chamfer at the bottom.
chamfer = 0.3;

/* [ Hidden ] */
eps1 = 0.001;
eps2 = 2*eps1;

module solid_funnel(d1, d2, h, k, n) {
  h0 = h - eps1;
  for (i =[0:n-1]) {
    //echo(i);
    h_1 = h0 * i / n; 
    h_2 = h0 * (i+1) / n;

    offset_1 = (d2 - d1) * pow(h_1,k)/pow(h0,k);
    offset_2 = (d2 - d1) * pow(h_2,k)/pow(h0,k);

    d_1 = d1 + 2*offset_1;
    d_2 = d1 + 2*offset_2;
    // Extending vertically by eps1 to maintain manifold with next slice.
    translate([0, 0, h_1]) cylinder(d1=d_1, d2=d_2, h=eps1+h/n); 
  }
}

module hollow_funnel(od1, od2, id1, id2, h, k1, k2) {
  difference() {
    solid_funnel(od1, od2, h, k2, floor($fn/4));
    translate([0, 0, -eps1]) solid_funnel(id1, id2, h+eps2, k1, floor($fn/4));
  }
}

module main() {
  // Funnel
  translate([0, 0, straight_height-eps1]) hollow_funnel(bottom_hole_diameter+2*bottom_wall, top_hole_diameter+2*top_wall, bottom_hole_diameter, top_hole_diameter, funnel_height, k1, k2);

  // Hollow tube extension at the bottom.
  difference() {
    cylinder(d=bottom_hole_diameter+2*bottom_wall, h=straight_height);  
    translate([0, 0, -eps1]) cylinder(d=bottom_hole_diameter, h=straight_height+eps2);  
    translate([0, 0, -eps1]) cylinder(d1=bottom_hole_diameter+2*chamfer, d2=bottom_hole_diameter, h=chamfer+eps2);
  }
}

if (mode == "design") {
  $fn=30;
  render(convexity = 2) difference() {
    main();
    rotate([0, 0, -75]) translate([0, 0, -eps1]) cube([100, 100, 100]);
  }
} else {
  $fn=90;
  main();  
}
