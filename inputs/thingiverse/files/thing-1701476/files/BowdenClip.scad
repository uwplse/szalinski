thickness=1.61;
mirror=1; // [1:Left tube, 0:Second tube]
/* [Hidden] */
$fn=120;

mirror([0,mirror,0]) {
linear_extrude(height=thickness){
difference(){
hull(){circle(d=12);
    translate([17,0]){
        circle(d=6);}
        ;}{
        circle(d=8);
        translate([0,-4]){
            square([7,8], center=true);};}
}}

//    linear_extrude(height=15){
    translate([24.2,0,0]){
        difference(){
            cylinder(d=10, h=14);translate([0,0,-1])
            cylinder(d=7.5, h=16);
        }
    }
    

translate([20,-1,0]){
rotate([90,0,180]){
intersection(){
    cube([14,14,3]);
    cylinder(d=28, h=2);
    
};}
}
}