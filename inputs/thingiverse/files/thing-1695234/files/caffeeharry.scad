//outer diameter (mm)
da=65;
//inner diameter (mm)
di=53;

//wall thikness (0.8 works great!)
w=0.8;
//funnel´s entrence / funnel´s biggest diameter (120 seems perfect for all sizes)
bd=120;
dd=bd/2;


d1=di;
d2=da+1;

$fn=80/1;

///////////////////////
////////Funnel/////////
///////////////////////
rotate(a=180,v=[0,1,0])    
translate([0,0,-40])
difference(){
    
    
union(){

cylinder (40,d1/2,dd+2*w);
    
//translate([0,0,-5])
//difference(){    
//cylinder(5,d1/2,d1/2);
//cylinder(5,(d1-w*2)/2,(d1-w*2)/2);
//}

translate([0,0,-5])
difference(){
cylinder (40,(d2+2*w)/2,(d2+2*w)/2);
cylinder (40,d2/2,d2/2);
}
}
cylinder (40.01,d1/2-2*w,dd);
cylinder(5,(d1-w*2)/2,(d1-w*2)/2);
}


/////////////////////////
///////Tamper////////////
/////////////////////////

translate([dd+di/2+3,0,0]){
    difference(){
union(){    
cylinder(10,(d1/2)-2,(d1/2)-2);
     translate([0,0,10])
    cylinder(10,(d1/2)-2,7);
    translate([0,0,10])
cylinder(25,9.5,7);
translate([0,0,35])
cylinder(10,7,9.5);    
  
translate([0,0,45])
sphere(9.5);  
  }
    translate([0,0,45])  
      rotate(a=90,v=[1,0,0])
      cylinder(200,3,3,center=true);
  }

}