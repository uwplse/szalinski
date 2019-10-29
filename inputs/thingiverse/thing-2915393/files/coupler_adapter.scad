// inner diameter (e.g. lead screw diameter)
d_inner=8;
// outer diameter (i.e. existing coupler inner diameter)
d_outer=10;
// height of adapter (can scale in slicer too)
h = 15;

// inner tolerance in mm (substract from wall)
i_inner = 0.2;
// outer tolerance in mm (substract from wall)
i_outer = 0.2;

difference() {
    cylinder(d=d_outer-i_outer, h=h, $fn=50);
    
    translate([0,0,-1]) {
        cylinder(d=d_inner+i_inner, h=h+2, $fn=50);
    }
}


echo ((d_outer-d_inner-i_outer-i_inner)/2, "mm");