
bottomheigh=10;
radius=100;

bodyheigh=10;
rauiussmall=90;

thickness=8;
holedeep=10;

stickheigh=500;
stickradius=10;

branchlong=200;
branchradius=10;

branch02heigh=100;
///////////////////////////////////RENDER

//middle stick
stick();

//branch01
rotate(a=90,v=[0,1,0]){
translate([-stickheigh,0,0])
branch();
}    
//branch02
rotate(a=90,v=[1,0,0]){
translate([0,stickheigh-branch02heigh,0])
branch();
}
//body
difference(){
    
translate([0,0,bottomheigh])
body();
    
translate([0,0,bodyheigh])
linear_extrude(heigh=holedeep)
hole();    

}
//bottom
bottom();

///////////////////////////////////MODULE

module bottom(){
cylinder(h=bottomheigh,r=radius);
}

module body(){
cylinder(h=bodyheigh,r1=radius,r2=rauiussmall);   
}
module hole(){
difference(){
circle(r=rauiussmall-6);
circle(r=rauiussmall-6-thickness);
}
}
module stick(){
cylinder(h=stickheigh,r=stickradius);
}
module branch(){
  cylinder(h=branchlong,r=branchradius,center=true);  
}
