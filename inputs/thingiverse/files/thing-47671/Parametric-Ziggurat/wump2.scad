//r1=bottom radius, r2=top radius, h=height
bottom_radius=5;//[1:10]
top_radius=8;//[1:10]
layers=6;//[1:10]
height=4.3;
increase=.01;


thing();
module thing(){
$fn=148;

translate([0,0,-height])
for ( i = [0 : layers]  ){
translate([0,0,(i-1)*height+increase+(height+(i-1)*increase)])


if (i>0){

cylinder(r1=bottom_radius,r2=top_radius,h=height+i*increase);

}
}
}


/*cylinder(10,13,h=10);//h=1


translate([0,0,10])//z=h
cylinder(10,13,h=15);//h=3/2h

translate([0,0,25])//2h+h/2
cylinder(10,13,h=20);//2h

translate([0,0,45])//4h+h/2
cylinder(10,13,h=25);//5/2h


translate([0,0,65])//6h+h/2
cylinder(10,13,h=30);//3h

translate([0,0,95])//9h+h/2
cylinder(10,13,h=35);//3h+h/2*/





