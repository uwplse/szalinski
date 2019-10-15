a=3.5;

difference(){
difference(){
difference(){

rotate(a=90,v=[0,1,0],h=10){
 for(i=[1:12])
 {
    assign(angle=i*30)
    {
        rotate(angle,[1,0,0])
 difference(){
cylinder(h=a,r=a,$fn=6);
cylinder(h=a,r=a-0.2,$fn=6);
}
    }
}
}

translate([0,0,-3]){
cylinder(h=12,r=a,$fn=10);
}
}

}

translate([0,0,-10]){
difference(){
cylinder(h=100,r=a*2,$fn=100);

cylinder(h=100,r=a,$fn=100);
}
}
}


