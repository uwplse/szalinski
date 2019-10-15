////////////////////////////////////////////////
///////carry handle for prusa i3 Pro Steel//////
/*author:Rudiger Vanden Driessche
ruudoleo@skynet.be
date:10/09/2015
PLA 3h printtime 19m 1.75mm filament


*/
///parameters///////
/* [Triangle measured]*/
roundingradius=2;
triangleside=26.5;//horizontal side
triangledist=58.5;//cornerdistance over 2 triangles
tolerance=0.2;

/* [Prusa -3 frame] */
framethickness=3;
framewidth=50;
framelenght=120;

/* [fingergrab] */
fingerwidth=100;
fingerheight=30;
backplatethickness=7;
fingerrounding=5;
fingergrabrounding=10;

/* [holes backplate] */
holedistance=42.5;
holedia=3.2;

/* [filamentguides] */
filamentdia=3.1;
filamentbore=6;
filamentoffset=7.5;

/* [adjust rounding] */
roundoffset=3.3;//moves rounding towards vingergrab
handleoffset=2.8;//moves fingergrabplate lower and closer
frameextend=2.8;//increases height frame


/*[hidden]*/
//calculate triangles from measurements
r=roundingradius;
ak=triangleside-2*r-2*tolerance;
ag=ak+sin(60)*2*r*2;
hk=sin(60)*ak;
hg=sin(60)*ag;
dist=(triangledist+2*r+ak)/2;

//calculate distances for fingergrab
safety=0.1;//prevent holes not fully through
fingergrabborderx=framelenght-fingerwidth;
fingergrabbordery=filamentoffset*2+filamentdia;
fingergrabheight=fingergrabbordery*2+fingerheight;

/////render//////
/////////////////
rotate([0,180,0]){
    translate([0,0,-framethickness-backplatethickness]){
3triangles();
translate([0,0,framethickness]){
    difference(){
        
     union(){   
    baseplate();
      }//end union 
      
     union(){ 
     2holes();
       2screwheads();  
     }//end union
     
    }//end difference
}//end translate



translate([0,framewidth/2+handleoffset,handleoffset]){
rotate(a=-45,v=[1,0,0]){
fingergrab();
}//end rotate
}//end translate
}//end translate
}//end rotate


/////modules/////

module rounded_rectangle(l,w,d,r){
hull(){    
translate([-l/2+r,+w/2-r,0])
cylinder(r=r,h=d,center=true,$fn=100);
translate([+l/2-r,+w/2-r,0])
cylinder(r=r,h=d,center=true,$fn=100); 
translate([-l/2+r,-w/2+r,0])
cylinder(r=r,h=d,center=true,$fn=100); 
translate([+l/2-r,-w/2+r,0])
cylinder(r=r,h=d,center=true,$fn=100); 

}  
}
module toprounded_rectangle(l,w,d,r){
hull(){    
translate([-l/2+r,+w/2-r,0])
cylinder(r=r,h=d,center=true,$fn=100);
translate([+l/2-r,+w/2-r,0])
cylinder(r=r,h=d,center=true,$fn=100); 
translate([-l/2+r,-w/2+r,0])
cube([r*2,r*2,d],center=true,$fn=100); 
translate([+l/2-r,-w/2+r,0])
cube([r*2,r*2,d],center=true,$fn=100); 
}  
}

module bottomrounded_rectangle(x,y,z,r){
hull(){    
translate([-l/2+r,+w/2-r,0])
 cube([r*2,r*2,d],center=true,$fn=100);
translate([+l/2-r,+w/2-r,0])
cube([r*2,r*2,d],center=true,$fn=100);
    
translate([-l/2+r,-w/2+r,0])
cylinder(r=r,h=d,center=true,$fn=100);
translate([+l/2-r,-w/2+r,0])
cylinder(r=r,h=d,center=true,$fn=100); 
}//end hull  
}//end module

module fingergrab(){
difference(){
   
translate([0,fingergrabheight/2,framethickness+backplatethickness/+handleoffset]){
toprounded_rectangle(framelenght,fingergrabheight,backplatethickness,fingergrabrounding);
}//end translate

{for (i=[-1.5:+1.5]){
    
translate([i*fingerwidth/4,(fingerheight+fingergrabbordery*2)/2,framethickness+backplatethickness/+handleoffset]){
toprounded_rectangle(fingerwidth/4-2,fingerheight,backplatethickness+safety,fingerrounding);
}//end translate
}//end for


//filamentguides
//center
translate([0,filamentoffset,framethickness+backplatethickness/2]){
cylinder(d=filamentbore,h=backplatethickness*2,center=true,$fn=100);    
}//end translate

//right
translate([framelenght/2-filamentoffset,filamentoffset,framethickness+backplatethickness/2]){
cylinder(d=filamentbore,h=backplatethickness*2,center=true,$fn=100);
 rotate(a=45,v=[0,0,1]){
    translate([((filamentbore+filamentoffset)*1.73)/2,0,0])
     cube([(filamentbore+filamentoffset)*1.73,filamentdia,backplatethickness*2],center=true);
 }//end rotate     
}//end translate

//left
translate([-framelenght/2+filamentoffset,filamentoffset,framethickness+backplatethickness/2]){
cylinder(d=filamentbore,h=backplatethickness*2,center=true,$fn=100); 

rotate(a=-45,v=[0,0,1]){
    translate([-((filamentbore+filamentoffset)*1.73)/2,0,0])
     cube([(filamentbore+filamentoffset)*1.73,filamentdia,backplatethickness*2],center=true);
 }//end rotate 
 
}//end translate

}//subtractor
}//end difference 
}

module baseplate(){
    translate([0,0,backplatethickness/2])
cube([framelenght,framewidth+frameextend,backplatethickness],center=true);
    //rounding (by trial and error)
hull(){
translate([0,framewidth/2,backplatethickness/2])
rotate(a=90,v=[0,1,0]){
cylinder(r=backplatethickness/2,h=framelenght,center=true,$fn=100);
 }//end rotate    
    translate([0,framewidth/2+backplatethickness/2+roundoffset,backplatethickness/2])
rotate(a=90,v=[0,1,0]){
cylinder(r=backplatethickness/2,h=framelenght,center=true,$fn=100);
   
}//end rotate
}//end hull
}


module 2screwheads(){
   translate([holedistance/2,0,backplatethickness-0.4*holedia+0.5*safety])   
    cylinder(d=holedia*2,h=0.8*holedia+safety,center=true,$fn=6);
   translate([-holedistance/2,0,backplatethickness-0.4*holedia+0.5*safety])
cylinder(d=holedia*2,h=0.8*holedia+safety,center=true,$fn=6);
}//end module

module 2holes(){
   translate([holedistance/2,0,backplatethickness/2])
cylinder(d=holedia,h=backplatethickness+safety,center=true,$fn=100);
   translate([-holedistance/2,0,backplatethickness/2])
cylinder(d=holedia,h=backplatethickness+safety,center=true,$fn=100);
}//end module

module 3triangles(){
translate([0,0,framethickness/2]){
rotate (a=180,v=[1,0,0]){
translate([0,0,0])
rounded_triangle();
}
translate([dist,0,0])
rounded_triangle();
translate([-dist,0,0])
rounded_triangle();
}
}//end module

module rounded_triangle(){
hull(){
rotate(a=90,v=[0,0,1])
   cylinder(r=r,h=framethickness,center=true,$fn=3);
   translate([-ak/2,-hk/2,0])
cylinder(r=2,h=framethickness,center=true,$fn=100);
   translate([ak/2,-hk/2,0])
cylinder(r=2,h=framethickness,center=true,$fn=100);
   translate([0,hk/2,0])
cylinder(r=2,h=framethickness,center=true,$fn=100);
}
}//end module