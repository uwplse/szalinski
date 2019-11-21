size=1;//[1:10]
height=1;//[1:10]
step=1;//[1:10]
resolution=100;//[16:128]

module heart(size=12,le=12){
color([.5,0,7]){
linear_extrude(height=le){
square([size,size]);
translate([size/2,0,0])
circle(r=size/2);
translate([size,size/2,0])
circle(r=size/2);
}
}
}


 coolShape1(step);
module coolShape1(step=1){
$fn=resolution;
for(i=[-1:step/10:5]){
rotate(i*360/6,[0,0,5])
translate([1,0,1])
heart(size,height);
}
}
