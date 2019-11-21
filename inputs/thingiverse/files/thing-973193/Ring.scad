radius = 30;


projection(cut = true) ring();

module ring(){
linear_extrude( height = 5, center=false, convexity = 10, twist = 0, $fn = 10) 
translate([-5,radius+2,0]){
scale([radius/60,radius/60,radius/60]){
polygon(points = [[-10,10],[-20,20],[-10,40],[30,40],[40,20],[30,10],[20,0],[0,0]]
,paths = [
[0,1,2,3,4,5,6,7]]
);
}
}

difference(){
cylinder(h = 5, r= radius +(radius/5), $fn =100,  center = false);
    translate([0,0,-10]){
cylinder(h = 40, r= radius, $fn= 100,  center = false);
    }
}
}
 