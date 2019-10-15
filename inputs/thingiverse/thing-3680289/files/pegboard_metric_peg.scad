// change "large" value 
width=300;
w=width;
large=50;
diam=30;
p1=30; //peg board large
p2=40; // peg board high

$fn=100;

translate([-150,0,0]){
rotate([0,90,0]){
cylinder(w,d=diam);
}}


cylinder(large,d=diam);

translate([0,0,large]){
rotate([-90,0,0]){
cylinder(p2,d=diam);
    sphere(d=diam);
    translate([-w/2,+diam+large,+p2]){sphere(d=diam);}
    translate([+w/2,+diam+large,+p2]){sphere(d=diam);}
    translate([0,0,p2]){sphere(d=diam);}
}}
    
    
    translate([-w/2,0,-diam]){
rotate([-90,0,0]){
cylinder(p2,d=diam);
    sphere(d=diam);
    
}}
    translate([-w/2,0,0]){
rotate([-180,0,0]){
cylinder(p1,d=diam);
    sphere(d=diam);
}}

translate([w/2,0,-diam]){
rotate([-90,0,0]){
cylinder(p2,d=diam);
    sphere(d=diam);
}}
     translate([+w/2,0,0]){
rotate([-180,0,0]){
cylinder(diam,d=diam);
    sphere(d=diam);
}}   
    