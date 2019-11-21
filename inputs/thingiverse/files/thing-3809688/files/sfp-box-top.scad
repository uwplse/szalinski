sfp_col=4;
sfp_row=5;



x=sfp_col*19.75+5;
y=sfp_row*14.75+5;

module shell(){
    h=35;
    w=1.5;
    translate([0,0,0]){
cube([x,w,h]);
cube([w,y,h]);
translate([0,y-w,0]){
cube([x,w,h]);
}
translate([x-w,0,0]){
cube([w,y,h]);
}
}
}
shell();
color([1,0,0])
cube([x,y,3]);