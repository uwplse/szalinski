Seed=83533115397;//
Calligraphic=1.9;//
CalligraphicSlant=45;//
Oscale=[1.1,1];//
plate=[85,45];//
thickness=3;
fudge=0.35;//
/*[Hidden]*/
dir=[rnd(-0,-0.5,Seed-435),0.5,0]*10;
golds=["DarkGoldenrod","Goldenrod"];
difference(){
color("DarkGoldenrod")translate([0,plate[1]*fudge,-thickness]) linear_extrude(height = thickness +1,  convexity = 10, scale=0.97,$fn=20)offset(r=3, chamfer=true)offset(r=-3, chamfer=false) square(plate,center=true);
color("Goldenrod")mirror([0,0,1])translate([0,plate[1]*fudge,-1.99]) linear_extrude(height = 2,  convexity = 10, scale=0.97,$fn=20)offset(delta=3, chamfer=true)offset(r=-5, chamfer=false) square(plate,center=true);
}

up=[0,0,-2];
intersection(){
color("DarkGoldenrod")translate([0,plate[1]*fudge,-thickness]) linear_extrude(height = thickness +1,  convexity = 10, scale=0.97,$fn=20)offset(r=3, chamfer=true)offset(r=-3, chamfer=false) square(plate,center=true);
scale([Oscale[0],Oscale[1],1]){
// first run
 for(t=[rnd(-40,-10,Seed+421):rnd(15,20,Seed+763):rnd(10,60,Seed+432)]){
translate([0,0,-rnd(0.2,0.0,Seed+123+t)])color(golds[round(rnd(1,0,Seed-t))]) spiral([-1,0,0],dir,t);
translate([0,0,-rnd(0.2,0.0,Seed+123+t)])color(golds[round(rnd(1,0,Seed-t))])mirror([1,0,0])spiral([-1,0,0],dir,t);
}
//second run
dir2=[-0.5,-0.1-rnd(0.7,0,Seed+344),0]*10;
 { for(t=[rnd(-40,-10,Seed):rnd(15,20,Seed+548):rnd(10,60,Seed+556)]){
translate([0,0,-rnd(0.1,0.0,Seed+123+t)])color(golds[round(rnd(1,0,Seed+t))])spiral([-1,0,0],dir2,t);
translate([0,0,-rnd(0.1,0.0,Seed+123+t)])color(golds[round(rnd(1,0,Seed+t))])mirror([1,0,0])spiral([-1,0,0],dir2,t);
}}

}}
// modules
module spiral(op,dir,t, i=0){
magfield=[0,0,cos(i*t)*3];
ndir=dir*0.85+cross(dir,magfield)*0.1;// blend dirction with force ( nonscientific)
np=op+ndir;
line(op,np);
if(i<25){spiral(np,ndir,t,i+1);}


}



module line(p1, p2) {
  hull() {
    translate(p1) rotate([-5,5,-CalligraphicSlant]) scale([1/Calligraphic,Calligraphic,1])sphere(1,$fn=6);
    translate(p2) rotate([-5,5,-CalligraphicSlant])scale([1/Calligraphic,Calligraphic,1])sphere(1,$fn=6);
  }
}
function rnd(a = 0, b = 1,S) = (rands(min(a, b), max(a, b), 1,S)[0]);
