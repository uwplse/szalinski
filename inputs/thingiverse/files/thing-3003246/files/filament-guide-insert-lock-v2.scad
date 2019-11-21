inner_diameter = 7.5;
outer_diameter = 18;
height = 11;
gap_fin = 2;

module pin_solid(h=10, r=4, lh=3, lt=1) {
  union() {
    // shaft
    cylinder(h=h-lh, r=r, $fn=30);
    // lip
    // translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r2=r, r1=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r, r2=r-(lt/2), $fn=30);

    // translate([0, 0, h-lh]) cylinder(h=lh*0.50, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/3), $fn=30);    

    translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r=r+(lt/2), $fn=30);    
    translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/2), $fn=30);    

    // translate([0, 0, h-lh]) cylinder(h=lh, r1=r+(lt/2), r2=1, $fn=30);
    // translate([0, 0, h-lh-lt/2]) cylinder(h=lt/2, r1=r, r2=r+(lt/2), $fn=30);
  }
}

module part_insert() {
    difference() {
        union() {
            cylinder(r=inner_diameter/2, h=height, $fn=30);

            cylinder(r1=inner_diameter/2, r2=outer_diameter/2, h=3);
            translate([0, 0, 3])
            cylinder(r=outer_diameter/2, h=2);
            translate([gap_fin/2, -outer_diameter/3, 0])
                rotate(a=[0, 0, 180])
                    cube([gap_fin, (outer_diameter-inner_diameter)/3, height*2/3]);
            pin_solid(height, (inner_diameter/2) + 0.1, 3, 1);
         }
        cylinder(r1=(inner_diameter), r2=2, h=5, $fn=30);
        cylinder(r=(inner_diameter-2)/2, h=height+1, $fn=30);
         translate([0, 0, -2])
            cylinder(r=outer_diameter*2, h=4);
        translate([-(inner_diameter-2)/6, -inner_diameter/2, 1])
            cube([(inner_diameter-2)/3, (outer_diameter*2/3)+2, (height/2)+5]);
        translate([-(inner_diameter-2)/6, -inner_diameter/2+1-3, 5.1])
            cube([(inner_diameter-2)/3, (outer_diameter*2/3)+2, (height/2)+5]);
    }
}
part_insert();
// pin_solid(h, r+(t/2), lh, lt);