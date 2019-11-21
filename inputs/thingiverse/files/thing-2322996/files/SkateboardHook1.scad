
wheel_gap_mm=90;
prong_width_mm=30;
prong_thickness=10;
prong_reach=65;
prong_raise=prong_reach/4;
base_thickness=10;
base_height=50;



difference() {

rotate([90,0,0]) {
linear_extrude(height=wheel_gap_mm+prong_width_mm+prong_width_mm,center=true, convexity=10, twist=0) {
polygon(points=[[0,0],
                [base_thickness,0],
                [prong_reach,prong_raise],
                [prong_reach,prong_raise+prong_thickness],
                [base_thickness,prong_thickness],
                [base_thickness,base_height],
                [0,base_height]], 
         paths=[[0,1,2,3,4,5,6]]);
}
}

// Rounded support at bottom of bracket
rotate([90,0,0]) {
translate( v = [base_thickness+prong_thickness,prong_thickness,0] ) {
cylinder (h=wheel_gap_mm,r=prong_thickness, center=true, $fn=100);
}}

// Remove material between prongs
//translate( v = [(base_thickness*2),0,-(prong_width_mm)]) {
rotate([90,0,0]) {
translate( v = [prong_reach-base_thickness,prong_raise,0]) {
cube(size=[prong_reach,prong_raise*2,wheel_gap_mm], center=true);
}
}

// Remove cylinders for screw holes
translate( v = [0,(wheel_gap_mm*.8)/2,base_height*.6] ) {
  rotate([0,90,0]) { 
      cylinder(h=base_thickness, r=4); 
  }
}
translate( v = [0,-(wheel_gap_mm*.8)/2,base_height*.6] ) {
  rotate([0,90,0]) { 
      cylinder(h=base_thickness, r=4); 
  }
}

}