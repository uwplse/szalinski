// preview[view:south, tilt:top]
Seed=2388385;//
Unseeded=1;//[1,0]
Update=1;//[0:1]
strokewidth=1;
/*[Hidden]*/
RSeed=round(rands(0,999999,1)[0]);
if(Unseeded==0)translate([0,-70,10])color("Black")text(str(RSeed), halign ="center");
Calligraphic=rnd(1.5,3,32487334);//
CalligraphicSlant=rnd(0,90,3248763);//
Oscale=[1,1];//
plate=[185,125];//
thickness=3;
fudge=-0.05;//

v2=rnd(2,4,3248736);
v3=rnd(0.8,1.2,324873);
v4=rnd(1,1.8,32554487);
v5=rnd(0.9,1.1,3244448);
v6=rnd(0.95,1,323334);
v7=rnd(0,360,32346877);
v8=rnd(0,360,363453218);
v9=rnd(0.2,1,3635985);
v10=rnd(0.2,1,3494885);
v11=rnd(0.6,26,3345985);
v12=rnd(0.5,1.5,4594885);
p1=[rnd(-10,01,36345948),rnd(-10,01,33459485),0];
p2=[rnd(-10,01,4598585),rnd(-10,01,63594885),0];
dir=([sin(v7),cos(v7),0])*8*v6;
lim=round(rnd(15,30,2307413585));
fork=5;
golds=["DarkGoldenrod","Goldenrod"];
*difference(){
color("DarkGoldenrod")translate([0,plate[1]*fudge,-thickness]) linear_extrude(height = thickness +1,  convexity = 10, scale=0.97,$fn=20)offset(r=3, chamfer=true)offset(r=-3, chamfer=false) square(plate,center=true);
color("Goldenrod")mirror([0,0,1])translate([0,plate[1]*fudge,-1.99]) linear_extrude(height = 2,  convexity = 10, scale=0.97,$fn=20)offset(delta=3, chamfer=true)offset(r=-5, chamfer=false) square(plate,center=true);
}

up=[0,0,-2];
intersection(){
*color("DarkGoldenrod")translate([0,plate[1]*fudge,-thickness]) linear_extrude(height = thickness +1,  convexity = 10, scale=0.97,$fn=20)offset(r=3, chamfer=true)offset(r=-3, chamfer=false) square(plate,center=true);
scale([Oscale[0],Oscale[1],1]){
// first run
 for(t=[rnd(-40,-10,421):90*v9:rnd(10,60,432)]){
translate([0,0,-rnd(0.2,0.0,123+t)])color(golds[round(rnd(1,0,498475-t))])translate(p1) spiral([-1,0,0],dir,t);
translate([0,0,-rnd(0.2,0.0,123+t)])color(golds[round(rnd(1,0,239847-t))])mirror([1,0,0])translate(p1)spiral([-1,0,0],dir,t);
}
//second run
dir2=([sin(v8),cos(v8),0])*8*v6;
 { for(t=[rnd(-40,-10,Seed):90*v10:rnd(10,60,556)]){
translate([0,0,-rnd(0.1,0.0,123+t)])color(golds[round(rnd(1,0,t))])translate(p2)spiral([-1,0,0],dir2,t,CalligraphicSlant);
translate([0,0,-rnd(0.1,0.0,123+t)])color(golds[round(rnd(1,0,t))])mirror([1,0,0])translate(p2)spiral([-1,0,0],dir2,t,CalligraphicSlant);
}}

}}
// modules
module spiral(op,dir,t,cs, i=0){
magfield=[0,0,cos(i*v11 +t*v12 )*v2];
ndir=dir*0.85*v3+cross(dir,magfield)*0.1*v4;// blend dirction with force ( nonscientific)
np=op+ndir;
line(op,np,cs);
if(i<lim){spiral(np,ndir,t,cs,i+1);
if(i<lim*0.6)if(i%(lim/fork)==2){spiral(np,[-ndir[1],ndir[0],ndir[2]],-t+45,cs+45,i+1);}
}


}



module line(p1, p2,cs=CalligraphicSlant) {
  hull() {
    translate(p1) rotate([-5,5,-cs]) scale([strokewidth/Calligraphic,Calligraphic*strokewidth,1])sphere(1,$fn=6);
    translate(p2) rotate([-5,5,-cs])scale([strokewidth/Calligraphic,Calligraphic*strokewidth,1])sphere(1,$fn=6);
  }
}
function rnd(a = 0, b = 1,S=1) =Unseeded==0? (rands(min(a, b), max(a, b), 1,RSeed+S)[0]): (rands(min(a, b), max(a, b), 1,Seed+S)[0]);
