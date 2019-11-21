//Bracelet Radius
radius=50;
//Number of Segments
no_segs=22; 
//Width
width=20;   

/* [Hidden] */

step=360/no_segs;

ang=-step/2;

p1=[7.5,width/2,-radius+5.1];
p2=[2.5,0,-radius+5.1];
p3=[6.5,width/2,-radius+5.1];
p4=[1.5,0,-radius+5.1];

p1_t=[p1[0]*cos(ang)-p1[2]*sin(ang), p1[1], p1[0]*sin(ang)+p1[2]*cos(ang)]; 
p2_t=[p2[0]*cos(ang)-p2[2]*sin(ang), p2[1], p2[0]*sin(ang)+p2[2]*cos(ang)];
p3_t=[p3[0]*cos(ang)-p3[2]*sin(ang), p3[1], p3[0]*sin(ang)+p3[2]*cos(ang)];
p4_t=[p4[0]*cos(ang)-p4[2]*sin(ang), p4[1], p4[0]*sin(ang)+p4[2]*cos(ang)];

p1_t_=[p1[0]*cos(ang)-p1[2]*sin(ang), -p1[1], p1[0]*sin(ang)+p1[2]*cos(ang)]; 
p2_t_=[p2[0]*cos(ang)-p2[2]*sin(ang), -p2[1], p2[0]*sin(ang)+p2[2]*cos(ang)];
p3_t_=[p3[0]*cos(ang)-p3[2]*sin(ang), -p3[1], p3[0]*sin(ang)+p3[2]*cos(ang)];
p4_t_=[p4[0]*cos(ang)-p4[2]*sin(ang), -p4[1], p4[0]*sin(ang)+p4[2]*cos(ang)];


p5=[6.5,width/2,-radius+.9];
p6=[1.5,0,-radius+.9];
p7=[7.5,width/2,-radius+.9];
p8=[2.5,0,-radius+.9];

p9=[-2.5,width/2,-radius+5.1];
p10=[-7.5,0,-radius+5.1];
p11=[-1.5,width/2,-radius+5.1];
p12=[-6.5,0,-radius+5.1];

p5_t=[p5[0]*cos(2*ang)-p5[2]*sin(2*ang), p5[1], p5[0]*sin(2*ang)+p5[2]*cos(2*ang)]; 
p6_t=[p6[0]*cos(2*ang)-p6[2]*sin(2*ang), p6[1], p6[0]*sin(2*ang)+p6[2]*cos(2*ang)];
p7_t=[p7[0]*cos(2*ang)-p7[2]*sin(2*ang), p7[1], p7[0]*sin(2*ang)+p7[2]*cos(2*ang)];
p8_t=[p8[0]*cos(2*ang)-p8[2]*sin(2*ang), p8[1], p8[0]*sin(2*ang)+p8[2]*cos(2*ang)];

p5_t_=[p5[0]*cos(2*ang)-p5[2]*sin(2*ang), -p5[1], p5[0]*sin(2*ang)+p5[2]*cos(2*ang)]; 
p6_t_=[p6[0]*cos(2*ang)-p6[2]*sin(2*ang), -p6[1], p6[0]*sin(2*ang)+p6[2]*cos(2*ang)];
p7_t_=[p7[0]*cos(2*ang)-p7[2]*sin(2*ang), -p7[1], p7[0]*sin(2*ang)+p7[2]*cos(2*ang)];
p8_t_=[p8[0]*cos(2*ang)-p8[2]*sin(2*ang), -p8[1], p8[0]*sin(2*ang)+p8[2]*cos(2*ang)];

n=1;
p9_t =[ p9[0]*cos(n*ang)- p9[2]*sin(n*ang),  p9[1],  p9[0]*sin(n*ang)+ p9[2]*cos(n*ang)]; 
p10_t=[p10[0]*cos(n*ang)-p10[2]*sin(n*ang), p10[1], p10[0]*sin(n*ang)+p10[2]*cos(n*ang)];
p11_t=[p11[0]*cos(n*ang)-p11[2]*sin(n*ang), p11[1], p11[0]*sin(n*ang)+p11[2]*cos(n*ang)];
p12_t=[p12[0]*cos(n*ang)-p12[2]*sin(n*ang), p12[1], p12[0]*sin(n*ang)+p12[2]*cos(n*ang)];

p9_t_ =[ p9[0]*cos(n*ang)- p9[2]*sin(n*ang),  -p9[1],  p9[0]*sin(n*ang)+ p9[2]*cos(n*ang)]; 
p10_t_=[p10[0]*cos(n*ang)-p10[2]*sin(n*ang), -p10[1], p10[0]*sin(n*ang)+p10[2]*cos(n*ang)];
p11_t_=[p11[0]*cos(n*ang)-p11[2]*sin(n*ang), -p11[1], p11[0]*sin(n*ang)+p11[2]*cos(n*ang)];
p12_t_=[p12[0]*cos(n*ang)-p12[2]*sin(n*ang), -p12[1], p12[0]*sin(n*ang)+p12[2]*cos(n*ang)];

union(){
for(i=[0:step:360]){

rotate([0,i,0])

union(){

translate([0,0,-radius])linear_extrude(1)polygon(points=[
[-7.5,0], [-2.5,width/2], [7.5,width/2], [2.5,0],
[7.5,-width/2],[-2.5,-width/2]]);

rotate([0,step/2,0])translate([0,0,-radius+5])linear_extrude(1)polygon(points=[
[-7.5,0], [-2.5,width/2], [7.5,width/2], [2.5,0],
[7.5,-width/2],[-2.5,-width/2]]);


    polyhedron(points=[
[-1.5,width/2,-radius+.9], p1_t, p2_t, [-6.5,0,-radius+.9],
[-2.5,width/2,-radius+.9], p3_t, p4_t, [-7.5,0,-radius+.9]], faces=[[1,0,2],[2,0,3],[4,5,7],[7,5,6],[5,4,1],[1,4,0],[2,3,6],[6,3,7],[3,0,7],[7,0,4],[6,5,2],[2,5,1]]);


    polyhedron(points=[
[-1.5,-width/2,-radius+.9], p1_t_, p2_t_, [-6.5,0,-radius+.9],
[-2.5,-width/2,-radius+.9], p3_t_, p4_t_, [-7.5,0,-radius+.9]], faces=[[0,1,2],[0,2,3],[5,4,7],[5,7,6],[4,5,1],[4,1,0],[3,2,6],[3,6,7],[0,3,7],[0,7,4],[5,6,2],[5,2,1]]);

    polyhedron(points=[
p9_t, p5_t, p6_t, p10_t,
p11_t, p7_t, p8_t, p12_t], faces=[[1,0,2],[2,0,3],[4,5,7],[7,5,6],[5,4,1],[1,4,0],[2,3,6],[6,3,7],[3,0,7],[7,0,4],[6,5,2],[2,5,1]]);

    polyhedron(points=[
p9_t_, p5_t_, p6_t_, p10_t_,
p11_t_, p7_t_, p8_t_, p12_t_], faces=[[0,1,2],[0,2,3],[5,4,7],[5,7,6],[4,5,1],[4,1,0],[3,2,6],[3,6,7],[0,3,7],[0,7,4],[5,6,2],[5,2,1]]);

}
}
}
