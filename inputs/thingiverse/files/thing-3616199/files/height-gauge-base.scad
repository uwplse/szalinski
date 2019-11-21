//to be used with thing...   https://www.thingiverse.com/thing:3616080

rule_width=29;
rule_thickness=2.5;

height_base(rule_width,rule_thickness);

module height_base(l1,l2){

$fn=100;

difference() { 

union() { 
linear_extrude (height = l1/2){
round2d(OR=l1/3,IR=0){
hull () { 
circle (d = l1*1.5);
translate ([-l1, 0, 0])  square ([ l1,l1 ],center = true);
}}}}



translate ([-l1*0.7, 0, -1]) linear_extrude (height = l1) round2d(OR=l2/4,IR=0) rotate (a = [0, 0, 90]) square ([l2,l1 ],true);
}


}

height_base(29,2.5);



module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}
