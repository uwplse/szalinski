/*[Sheat Settings]*/
//in mm
wall_thickness=1.5; //[0.48:0.01:3]
//
width=24; //[1:1:100]
//
height=30; //[1:1:100]
//smoothness
$fn=100; //[30:5:200]
//heigth of sheat in mm
handle_lenght=115; //[10:.1:200]




//handle holder
difference(){
scale([1,width/height,1]){
cylinder(handle_lenght + wall_thickness,d=max(height,width)+2*wall_thickness,center=true);
}
scale([1,width/height,1]){
translate([0,0,0.8])
cylinder(handle_lenght,d=max(height,width),center=true);
}
}

//base
scale([2,1,1]){
translate([0,0,-(handle_lenght/2 +1)]){
difference(){
cylinder(h=0.8,d=3*max(height,width),center=true);
//reduce amount of material required
for( i = [0:60:360])
translate([max(height,width)*sin(i), max(height,width)*cos(i), 0])
cylinder(h=0.8,d=25,center=true);

}
}
}