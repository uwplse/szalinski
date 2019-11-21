//support pour suspendre  l'écran du retro pro de la salle info
// du plascilab

$fn=100;
vue=0;

module planche1(){
difference(){ 
  square(120);  
  translate([60,60]) circle(d=63);
  translate([48,-1]) square([24,32]);
  for(i=[1:5]){
      translate([10*i+(i-1)*12,108]) square([12,6]);
  };
   for(i=[0:1]){
      translate([27+i*60,15]) square([6,6]);
  };
};

}

module planche2(){
difference(){ 
  square([120,240]);  
  for(i=[1:6]){
      translate([10*(i-1)+(i-1)*12,228]) square([10,12]);
      translate([10*(i-1)+(i-1)*12,0]) square([10,12]);
  };
  for(i=[1:2]){
      translate([90,80*i]) circle(d=6);
      translate([30,80*i]) circle(d=6);
  };
};

}
module planche3(){
difference(){ 
  square([120,216]);  

  for(i=[0:1]){
      translate([90,68+80*i]) circle(d=6);
      translate([30,68+80*i]) circle(d=6);
  };
};

}
module pion(){
    square([6,12]);
}

/*****************3D ***********************************/
module planche1_3D(){
    linear_extrude(6) planche1();
}

module planche2_3D(){
    linear_extrude(6) planche2();
}

module planche3_3D(){
    linear_extrude(6) planche3();
}

module pion_3D(){
    linear_extrude(6) pion();
}

vue=0;
if (vue==0){
    
   color("blue") rotate([90,0,90]) planche1_3D();
   translate([6,0,0]) rotate([90,0,90]) planche1_3D();
   color("blue")  translate([228,0,0])rotate([90,0,90]) planche1_3D();
   translate([234,0,0]) rotate([90,0,90]) planche1_3D();
   color("red") translate([240,0,108]) rotate([0,0,90]) planche2_3D();
   color("green") translate([228,0,114]) rotate([0,0,90]) planche3_3D();
    color("red") translate([12,27,15]) rotate([0,0,90]) pion_3D();
     color("red") translate([12,87,15]) rotate([0,0,90]) pion_3D();
    color("red") translate([240,27,15]) rotate([0,0,90]) pion_3D();
     color("red") translate([240,87,15]) rotate([0,0,90]) pion_3D();
};

if (vue==1){
planche2();
translate([140,0]) planche1();
translate([280,0]) planche1();
translate([280,130]) planche1();
translate([140,130]) planche1();
translate([-150,0]) planche3();
};