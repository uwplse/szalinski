part=0;//[0:all,1:color 1,2:color 2,3:color 3]

/*[Hidden]*/

 c=
 [[[-1.8, -5, 0], [0, -0, 30], [1, 1.25, 1]], 
[[-0.8, 0, 0.1], [10, -0, 45], [1, 1, 1]], 
[[0.7, 1.2, -0.1], [10, 0, 45], [1, 1, 1]], 
[[1.2, 2, 0.2], [-30, 0, 90], [1, 1, 1]],
 [[0.2, 4, 0.5], [-90, -0, 90], [1, 1, 1]], 
[[-1.3, 2.25, 0.4], [-150, 0, 90], [1, 1, 1]],
 [[-0.3, 0.5, 0.1], [-180, 0, 135], [1, 1, 1]],
 [[0.7, 0, 0], [-190, -0, 135], [1, 1, 1]],
 [[2.2, -7.6, 0], [-180, -0, 150], [1, 1.25, 1]]]
;

v=[for(i=[0:len(c)-1])c[i]+[[0,0,0],[0,0,0],[0,0,0]]] ;
echo( v);
scale(10){
if ( part==0)   {
color(rands(0,1,3))topband();
color(rands(0,1,3))midband();
color(rands(0,1,3))lastband();}

if (part==1 )color(rands(0,1,3))difference(){topband();midband();lastband();}



if (part==2 )color(rands(0,1,3))difference(){midband(); }



if (part==3 )color(rands(0,1,3))difference(){lastband();midband();topband();}




} 
module  topband(){
ShowControl(i(s(i(v,40),15),60))
//translate([0.5,-0.1,0]) 
 rotate([0,0,0]) 
 rotate([90,0,0]) {

 translate([0,0,0.35])
scale([1,3,1/0.025*0.17]) {
sphere(0.025 ,$fn=8 );}
} }

module midband(){
ShowControl(i(s(i(v,40),15),60))
//translate([0.5,-0.1,0]) 
 rotate([0,0,0]) 
 rotate([90,0,0]) 
translate([0,0,0.1]) 
scale([2,3,1/0.025*0.13]) {
sphere(0.025 ,$fn=8 ); }
}
module lastband(){
 ShowControl(i(s(i(v,40),15),60))
//translate([0.5,-0.1,0]) 
 rotate([0,0,0]) 
 rotate([90,0,0]) 
translate([0,0,-0.3])
scale([1,3,1/0.025*0.3]) {
sphere(0.025 ,$fn=8 ); }
}

function i(v,l)=[for(n=[0:1/l:1])listlerp (v,n*(len(v)-1))];
function s(vi,c=1)=c>0?let(v=s(vi,c-1))[for(i=[0:len(v)-1])( v[i]+v[max(0,i-1)]+v[min(len(v)-1,i+1)])/3]:vi;
function listlerp (l,I)=
let(f=len(l)-1,start=max(0,min(f,floor(I))),end=max(0,min(f,ceil(I))),bias=smooth(I%1)) (l[end]* bias + l[start] * (1 - bias));


function smooth (a) =
let (b =max(0, min(1,a)))(b * b * (3 - 2 * b));

module ShowControl(v) { // translate(t(v[0])) sphere(v[0][3]);
 
    for (i = [1: len(v) - 1]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
      hull() {
        translate( v[i][0]) rotate( v[i][1]) scale( v[i][2]) children();
        translate( v[i - 1][0])rotate( v[i-1][1]) scale( v[i-1][2]) children();
      }
    }
}