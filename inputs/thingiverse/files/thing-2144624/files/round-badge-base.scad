union(){
    
difference(){
    cylinder(h=5, r1=25, r2=25, center=false);    
    cylinder(h=5, r1=23, r2=23, center=false);    
}
cylinder(h=4, r1=23, r2=23, center=false);
difference(){
    cylinder(h=5, r1=22, r2=22, center=false);    
    cylinder(h=5, r1=20, r2=20, center=false);    
}
cylinder(h=1, r1=25, r2=25, center=false);
}