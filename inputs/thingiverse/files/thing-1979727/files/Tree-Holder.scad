// Width of the tree base
numerical_slider = .05; // [.1:.85]
cylinder(h=1.5,r1=2.25,r2=1,$fn=100);
translate ([0,0,1.5]) {
    difference () {
        cylinder(h=1.25,r1=numerical_slider+.16,r2=numerical_slider+.16,$fn=50);
        cylinder(h=1.25,r1=numerical_slider+.05,r2=numerical_slider+.05,$fn=50);
    }
}