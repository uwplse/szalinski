detail=25;//[12:100]
$fn=detail;
Orientation =2;//[1:Horizontal,0: Vertical,2: Both]
Bearing_Radius=21;
Bearing_Width=20;
boltholeradius=4;
boltheadradius=10;
boltholeCC=52*1;
footheight=16;
footwidth=23;
material=6;
chamfer=2;



//Bearing_Radius=rnd(7,25);
//Bearing_Width=rnd(10,30);
//boltholeradius=rnd(Bearing_Width/6,Bearing_Width/4 );
//boltheadradius=rnd(boltholeradius*1.3,boltholeradius*2);
//
//boltholeCC=rnd(Bearing_Radius *2 ,Bearing_Radius*4);
// footheight=rnd(Bearing_Radius/4 ,Bearing_Radius/2 );
//footwidth=rnd(1,Bearing_Radius/2 );
//material=rnd(3,Bearing_Radius/4 );
//chamfer=rnd(1,2);
//$fn=30;
bcc=max(boltholeCC,material*2+Bearing_Radius*2+boltheadradius*2);


 fw=max(boltheadradius*2,footwidth);


//Bearing radius
r=Bearing_Radius;
//Bearing width
w=Bearing_Width;
//Bolt radius
br=boltholeradius;
//Height flange ears
fh=footheight;
//Material thickness around bearing
bm=material;
//Material thickness around flange
m=material;
//Bolt distance
bd=boltholeCC/2;
//Go easy with deatil, minkowski sums ahead,
$fa=15*1;
cc=max(bd,r+bm+boltheadradius);
bar=fh;


rotate([0,0,170])color("LightSteelBlue")if (Orientation==1) rotate([0,0,30])flange();
else if(Orientation==0) rotate([0,0,30])standing();
else {
translate([0,-Bearing_Radius*1.6,0])standing();
 translate([0,Bearing_Radius*1.6,0])flange();}

module standing(){


 difference(){
translate([0,0,Bearing_Radius+material]){rotate([90,0,0])roundcyl(Bearing_Radius+material ,Bearing_Width  ,center=true);}
bearinghole();
}
difference(){
union(){
 translate([0,0,Bearing_Radius+material]){rotate([90,0,0])roundcyl(Bearing_Radius+material*0.5,Bearing_Width  ,center=true);}
 linear_extrude(material*2 ) {
 square([Bearing_Radius*2+material*2,min(Bearing_Width,fw)],center=true);}
union(){
 smallfoothouse();
hull(){
intersection(){smallfoothouse();
 hull(){
scale([1,5,1.5])foot();}
}
foot();}
}
mirror([1,0,0])union(){
 smallfoothouse();
hull(){
intersection(){smallfoothouse();
 hull(){
scale([1,5,1.5])foot();}
}
foot();}
}}
 
holes1();}
}

module holes1(){
//holes
bearinghole();

//bolt hole
translate([bcc*0.5,0,0])cylinder(footheight*2,boltholeradius,boltholeradius,center=true);
translate([-bcc*0.5,0,0])cylinder(footheight*2,boltholeradius,boltholeradius,center=true);

 hull(){
 translate([bcc*0.5,0,footheight*0.99])
roundcyl(boltheadradius ,chamfer*3 ,boltheadradius  );

 translate([bcc*0.5+boltheadradius*3,0,footheight*0.99+Bearing_Radius +material*2])
roundcyl(boltheadradius*2 ,Bearing_Radius*2 ,boltheadradius*4 );

translate([bcc+fw*0.5 ,0,footheight*0.99])
roundcyl(boltheadradius*2,Bearing_Radius ,boltheadradius*4 );
}
 mirror([1,0,0])hull(){
 translate([bcc*0.5,0,footheight*0.99])
roundcyl(boltheadradius ,chamfer*3 ,boltheadradius  );

 translate([bcc*0.5+boltheadradius*3,0,footheight*0.99+Bearing_Radius +material*2])
roundcyl(boltheadradius*2 ,Bearing_Radius*2 ,boltheadradius*4 );

translate([bcc+fw*0.5 ,0,footheight*0.99])
roundcyl(boltheadradius*2,Bearing_Radius ,boltheadradius*4 );
}

}
module bearinghole(){
translate([0,0,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius,(Bearing_Width+chamfer*2)  ,center=true);
translate([0,-Bearing_Width*0.499,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius+material*0.5,Bearing_Width ,Bearing_Radius*2+material*2 );
mirror([0,1,0])translate([0,-Bearing_Width*0.499,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius+material*0.5,Bearing_Width ,Bearing_Radius*2+material*2);
}


module roundcyl(r,h,r2=0,center=false){
if(center==true)
rotate_extrude(convex=10){
 offset(delta=+chamfer,chamfer=true) offset(delta=-chamfer,chamfer=true)translate([0,-h*0.5]) 
polygon([[0,0],[r,0],[r2==0?r:r2,h],[0,h]]);
translate([0,-h*0.5])square([r*0.5,h]);

}
else
rotate_extrude(convex=10){
 offset(delta=+chamfer,chamfer=true) offset(delta=-chamfer,chamfer=true)translate([0,0])
polygon([[0,0],[r,0],[r2==0?r:r2,h],[0,h]]);
translate([0,0])square([r*0.5,h]);

}
}

module foot(){
intersection(){translate([Bearing_Radius+material,-fw*0.5,0])cube([(boltheadradius+bcc)*0.5,fw,footheight]);
 hull(){
linear_extrude(footheight
//-(fw-Bearing_Width)/2 
){
 translate([bcc*0.5,0,0])circle(boltheadradius-chamfer);
 square([bcc  ,fw-chamfer*2],center=true);
 }

linear_extrude(footheight-chamfer ) {
 translate([bcc*0.5,0,0])circle(boltheadradius );
square([bcc  ,fw],center=true);

//translate([0,0,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius +material,Bearing_Width ,center=true);
}}}}
module smallfoot(){
intersection(){translate([Bearing_Radius+material,-fw*0.5,0])cube([(boltheadradius+bcc)*0.5,fw,footheight]);
hull(){
linear_extrude(footheight
//-(fw-Bearing_Width)/2 
)
offset(delta=-chamfer,chamfer=true) 
offset(delta=+chamfer,chamfer=true)
 offset(delta=-chamfer,chamfer=true)
square([bcc ,fw],center=true);

linear_extrude(footheight-chamfer )  offset(delta=+chamfer,chamfer=true) offset(delta=-chamfer,chamfer=true)square([bcc ,fw],center=true);
//translate([0,0,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius +material,Bearing_Width ,center=true);
}}}
module smallfoothouse(){
hull(){
smallfoot();

//linear_extrude(footheight)
////offset((fw-Bearing_Width)/2)
//offset(delta=(fw-Bearing_Width)/2,chamfer=true)square([bcc,Bearing_Width],center=true);
 
house();


}};
module house(){
intersection(){
 union(){translate([-material,-fw*0.5,Bearing_Radius]){
cube([(boltheadradius*2+bcc)*0.5,fw,(Bearing_Radius+material)*2]);}
translate([Bearing_Radius*0.5,-fw*0.5,0]){
cube([(boltheadradius+bcc)*0.5,fw,(Bearing_Radius+material)*2]);}
}
translate([0,0,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius+material,Bearing_Width ,center=true);}
 linear_extrude(material  ) {
 translate([Bearing_Radius+material,0,0])square([Bearing_Radius ,Bearing_Width],center=true);}
}


function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 



module flange(){

 



color("LightSteelBlue")
intersection(convexity=10){
 cylinder(max(fh ,w ),cc+br+m ,cc+br+m );

difference(){
union(){
minkowski(convexity=10){
linear_extrude(max(0.0001,bar-m),convexity=10)offset(-m*2)offset(m*2){
offset(max(0,(bm-m)))centerhouse();
hull(){
bolthouse();

}}
bullet(m);
}

minkowski(){
linear_extrude(max(0.0001,min(bar-m*2,max(m,bar*0.5-m))),convexity=10)offset(-m*2)offset(m*2)hull(){
bolthouse();
offset(max(0,(bm-m)))centerhouse();
}bullet(m);}

 hull(){
minkowski(){ 
linear_extrude(max(0.0001,w-bm),convexity=10){centerhouse();}
bullet(bm);}

minkowski(){
linear_extrude(max(0.0001,bar-m),convexity=10){
offset(-m*2)offset(m*2)offset(max(0,(bm-m)))
centerhouse(); }bullet(m);
}


}


}





 linear_extrude(w*3+fh,center=true,convexity=10)centerhole();
 linear_extrude(w*3+fh,center=true,convexity=10)bolthole();
}
 }

}


module centerhouse()
{
circle(r);
}
module centerhole()
{
circle(r);
}
module centerbolthouse()
{
circle(br+m);
}
module bolthole()
{
translate([cc,0,0])circle(br);
translate([-cc,0,0])circle(br);
}

module bolthouse()
{
translate([cc,0,0])circle(br);
translate([-cc,0,0])circle(br);
}

module bullet(m)
{
 rotate_extrude($fn=12,convexity=10) union(){
square([m*(2/3),m ]);
square([m ,m*(2/3)]);
intersection(){
$fn=16;
square(m,m,m);

translate([m*(2/3),m*(2/3),0])circle(m/3);
}}}