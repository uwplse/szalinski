//rotate_extrude($fn=200) polygon( points=[[0,0],[2,1],[1,2],[1,3],[3,4],[0,5]] );

//This makes a toothbrush handle for anyone struggling with arthritis
w=13;  //Width of your toothbrush handle in milimeters
t=13;  //Thickness of your toothbrush handle
l=75; //Length of your toothbrush handle

$fn=100;
module toofbrush_body(){
rotate_extrude($fn=200) polygon( points=[[0,0],[(25.4*1.5)/2,0],[(25.4*1.5)/2,100],[0,100]]);
sphere(d=25.4*1.5);
}
module toofbrush_hole(){
    difference(){
    toofbrush_body();
    translate([-w/2,-t/2,100-(l-1)])cube([w,t,l]);}
}
toofbrush_hole();

module torus2(r1, r2){
rotate_extrude() translate([r1,0,0]) circle(r2);
}

module oval_torus(inner_radius, thickness=[0, 0]){
{
rotate_extrude() translate([inner_radius+thickness[0]/2,0,0]) ellipse(width=thickness[0], height=thickness[1]);
}
}


module fingergrips(){
translate([0,0,90])torus2(17,6);
translate([0,0,70])torus2(17,6);
translate([0,0,50])torus2(17,6);
translate([0,0,30])torus2(17,6);
}
fingergrips();