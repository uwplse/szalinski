//Plate angle
Platerelativerotation = 45;
//Hole pattern: [[X,Y,Radius],[X,Y,Radius],[ [ X,Y,Radius ],[ X,Y,Radius ] ]] : Double bracket holes togethter for slots
Plate1 =  [[0, 0, 25], [-35, 0, 6], [35, 0, 6], [-17.5, -30.3109, 6], [-17.5, 30.3109, 6]];
Plate2 =  [[[-15, 0, -4] ,[100, 0, 4]],[0, -15, 6] ,[0, 15, 6],[20, -15, 6] ,[20, 15, 6] ];
//Plate thicknes
Thickness = 10;
//Material around hole
Aroundhole = 5;
//Skift holepattern
Plate1offset = [-110, 0];
Plate2offset = [50, 0];
//Holepattern rotation
Plate1internalrotation =  0 ;
Plate2internalrotation =  0;
//Symetries
MirrorCopy=0;//[1:yes,0:no]
RotateCopies=3; //[1:12]
RotateCopyAngle=120;//[5:180]
//Boundaries
MaxX=135;
MaxY1=150;
MaxY2=150;
//details
$fn = 40;
echo(Plate1);
Hideguide=1;//[1:yes,0:no]
ChamferHoles=1;


/*[hidden]*/
Plate2relativerotation = [0, Platerelativerotation,0];
if (Hideguide==0)#translate([Plate1offset[0],0,0])profile(Thickness-0.01,Aroundhole,Plate2relativerotation);
for(n=[0:RotateCopyAngle:RotateCopyAngle*RotateCopies-1]){
rotate([0,0,n])

union(){ 
translate([Plate1offset[0],0,0])

union(){

difference(){
intersection(){
hull(){intersection(){

profile(Thickness,Aroundhole,Plate2relativerotation);

union(){plates();
rotate(Plate2relativerotation)plates();}
}

}
profile(Thickness,Aroundhole,Plate2relativerotation);
}

union(){

 intersection(){
translate(-Plate1offset)cube([MaxY1+MaxY2,MaxX,Thickness*1.2],center=true);
 holes();}
rotate(Plate2relativerotation)
intersection(){
translate(-Plate2offset)cube([MaxY1+MaxY2,MaxX,Thickness*1.2],center=true);
 holes();}

}
}}

if(MirrorCopy==1)translate([-Plate1offset[0],0,0])mirror()


union(){
difference(){
intersection(){
hull(){intersection(){
 
profile(Thickness,Aroundhole,Plate2relativerotation);
union(){plates();
rotate(Plate2relativerotation)plates();}
}

}
profile(Thickness,Aroundhole,Plate2relativerotation);
}

union(){

 intersection(){
translate(-Plate1offset)cube([MaxY1+MaxY2,MaxX,Thickness*1.2],center=true);
 holes();}
rotate(Plate2relativerotation)
intersection(){
translate(-Plate2offset)cube([MaxY1+MaxY2,MaxX,Thickness*1.2],center=true);
 holes();}

} }}
}

}


module profile (Thickness,Aroundhole,Plate2relativerotation){rotate([90,0,0]){
linear_extrude(MaxX,center=true,convexity=10){
offset(r=-3)offset(r=Thickness*0.5+2)union(){hull(){
translate([MaxY1,0])square([Aroundhole,1],center=true);
circle(1*0.5);}
hull(){rotate([0,0,-Plate2relativerotation[1]])
translate([-MaxY2,0])square([Aroundhole,1],center=true);
circle(1*0.5);}}}

}}

module plates(){
  linear_extrude(Thickness*2, center = true,convexity=10)  
difference(){

hull(){
translate(-Plate1offset)offset(r=Aroundhole)rotate([0,0,Plate1internalrotation]) makeplate(Plate1,0);
translate(-Plate2offset)offset(r=Aroundhole) rotate([0,0,Plate2internalrotation]) makeplate(Plate2,0);
}
union(){
translate(-Plate1offset)offset(r=-1)offset(r=1) rotate([0,0,Plate1internalrotation])makeplate(Plate1,0);
translate(-Plate2offset)offset(r=-1)offset(r=1) rotate([0,0,Plate2internalrotation])makeplate(Plate2,0);
}
}

}
module holes(){
 

 

 

translate(-Plate1offset)  rotate([0,0,Plate1internalrotation])
for (i = [0: len(Plate1) - 1]) {
       if (len(Plate1[i][0]) == undef) {
       translate([Plate1[i][0], Plate1[i][1],  Thickness*0.5-ChamferHoles]) 
linear_extrude( abs(Plate1[i][2]) , convexity=10, scale = 2)  circle(abs(Plate1[i][2]) );       translate([Plate1[i][0], Plate1[i][1], 0]) 
linear_extrude(Thickness*2, center = true,convexity=10, scale = 1)  circle(abs(Plate1[i][2] ));       translate([Plate1[i][0], Plate1[i][1],-Thickness*0.5+ChamferHoles]) 
mirror([0,0,1])linear_extrude( abs(Plate1[i][2])  ,convexity=10, scale = 2)  circle(abs(Plate1[i][2] ));
      } 


else {
         hull() {
            for (j = [0: len(Plate1[i]) - 1]) {
               translate([Plate1[i][j][0], Plate1[i][j][1],  Thickness*0.5-ChamferHoles])  linear_extrude( abs(Plate1[i][j][2]) , convexity=10, scale = 2)     circle(abs(Plate1[i][j][2]) );
            }
         }
 hull() {
            for (j = [0: len(Plate1[i]) - 1]) {
               translate([Plate1[i][j][0], Plate1[i][j][1], 0])  linear_extrude(Thickness*2, center = true,convexity=10, scale = 1)   circle(abs(Plate1[i][j][2]) );
            }
         }
 hull() {
            for (j = [0: len(Plate1[i]) - 1]) {
               translate([Plate1[i][j][0], Plate1[i][j][1],-Thickness*0.5+ChamferHoles]) 
 mirror([0,0,1])linear_extrude( abs(Plate1[i][j][2])  ,convexity=10, scale = 2)  circle(abs(Plate1[i][j][2]) );
            }
         }

      }
   }
///////////////////


translate(-Plate2offset)  rotate([0,0,Plate2internalrotation])
for (i = [0: len(Plate2) - 1]) {
       if (len(Plate2[i][0]) == undef) {
       translate([Plate2[i][0], Plate2[i][1],  Thickness*0.5-ChamferHoles]) 
linear_extrude( abs(Plate2[i][2]) , convexity=10, scale = 2)  circle(abs(Plate2[i][2]) );   
    translate([Plate2[i][0], Plate2[i][1], 0]) 
linear_extrude(Thickness*2, center = true,convexity=10, scale = 1)  circle(abs(Plate2[i][2]) );       translate([Plate2[i][0], Plate2[i][1],-Thickness*0.5+ChamferHoles]) 
mirror([0,0,1])linear_extrude( abs(Plate2[i][2])  ,convexity=10, scale = 2)  circle(abs(Plate2[i][2]) );
      } 


else {
         hull() {
            for (j = [0: len(Plate2[i]) - 1]) {
               translate([Plate2[i][j][0], Plate2[i][j][1],  Thickness*0.5-ChamferHoles])  linear_extrude( abs(Plate2[i][j][2]) , convexity=10, scale = 2)      circle(abs(Plate2[i][j][2]) );
            }
         }
 hull() {
            for (j = [0: len(Plate2[i]) - 1]) {
               translate([Plate2[i][j][0], Plate2[i][j][1], 0])  linear_extrude(Thickness*2, center = true,convexity=10, scale = 1)   circle(abs(Plate2[i][j][2]) );
            }
         }
 hull() {
            for (j = [0: len(Plate2[i]) - 1]) {
               translate([Plate2[i][j][0], Plate2[i][j][1],-Thickness*0.5+ChamferHoles]) 
 mirror([0,0,1])linear_extrude( abs(Plate2[i][j][2])  ,convexity=10, scale = 2)  circle(abs(Plate2[i][j][2]) );
            }
         }

      }
   }




}  
 

 
module makeplate(P, A) {
   for (i = [0: len(P) - 1]) {
       if (len(P[i][0]) == undef) {
         translate([P[i][0], P[i][1], 0]) circle(P[i][2] + A);
      } else {
         hull() {
            for (j = [0: len(P[i]) - 1]) {
               translate([P[i][j][0], P[i][j][1], 0]) circle(P[i][j][2] + A);
            }
         }
      }
   }
}


function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

function rndc(seed) =seed==undef? [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]]:[rands(0, 1, 1,seed)[0], rands(0, 1, 1,seed+101)[0], rands(0, 1, 1,seed+201)[0]];

