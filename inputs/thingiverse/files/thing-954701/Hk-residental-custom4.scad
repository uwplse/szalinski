/* [Global] */
// Level of building
level=8; //[1:100]
// how many room in each side
sidelong=1; //[1:10]
// Type Y, type 4? or even hexagon?
type=4; //[1:6]
roofHeight=3; //[0:5]
// Water tower on the top?
watertower=0; //[0:Need,1:No water tower]

/* [Hidden] */

module roofPside(){
    translate([0.3,0.1,0]) rotate( [0,0,-10] ) 
    cube([6,4,roofHeight]); 
        translate([6,-1,0]) cube([1,6,roofHeight]); 
        translate([0,0,0])cube([1,5,roofHeight]);
    
    translate([1,2,0]) cube([5,3,roofHeight]);
}

module roofP(){
#translate([5,0,0]){
translate([0,0,0]) roofPside();
translate([18,0,0])  mirror([1,0,0]) roofPside();
}
}

module room(end){ 
translate([0,0,0])cube([1,5,4]); 
translate([6,-1,0]) cube([1,5,4]); 

translate([0.3,0.1,0]) rotate( [0,0,-10] ) cube([6,4,1.4]); 

translate([1,1.5,0]) cube([3,1,4]);
translate([3.5,0.5,0]) cube([2.5,1,4]);
    
        if(end==true)
                {
                    translate([0,0,4]) {
                        roofPside();
                        translate([0,5,0])cube([7,2.5,roofHeight]);
                        if(type==1){
                            translate([0,0,-4*level-roofHeight+1]) {
                            roofPside();
                            translate([0,5,0])cube([7,2.5,roofHeight]);
            }       }
    }
}
} 

module inside(end){
translate([0,4,0])cube([4,1,4]);
translate([0,2,0])cube([4,3,1.4]);
translate([0,2,0])cube([1,3,4]);
    if(end==true){
        translate([0,2,4]) cube([4,3,roofHeight]);
        translate([-1.5,4,4]) cube([1.5,1,roofHeight]);
        translate([-1.5,5,4]) cube([5,2.5,roofHeight]);
        if(type==1){
          translate([0,0,-4*level-roofHeight+1]) {  
        translate([0,2,4]) cube([4,3,roofHeight]);
        translate([-1.5,4,4]) cube([1.5,1,roofHeight]);
        translate([-1.5,5,4]) cube([5,2.5,roofHeight]);   
          }
        }
    }
}

module row(end){
translate([9.5,4,0]) cube([6,1,4]);
translate([21.5,0,0]) mirror([1,0,0]) room(end);
    
if(end==true)
    {
translate([10.5,3,4]) cube([4,2,roofHeight]);
  translate([10.5,5,4]) cube([4,2.5,roofHeight]);    
      if(type==1){
          translate([0,0,-4*level-roofHeight+1]) {  
          translate([10.5,3,4]) cube([4,2,roofHeight]);
  translate([10.5,5,4]) cube([4,2.5,roofHeight]);    
              }
      }
}
}

module rowMirror(end,close){
translate([-1.5,4,0]) cube([6,1,4]);
translate([3.5,0,0]) room(end);
    
    if(end==true && close==1)   {     
    translate([21.5,3,4]) cube([4,2,roofHeight]);
    translate([21.5,5,4]) cube([4,2.5,roofHeight]);  
            if(type==1){
                translate([0,0,-4*level-roofHeight+1]) { 
                translate([21.5,3,4]) cube([4,2,roofHeight]);
    translate([21.5,5,4]) cube([4,2.5,roofHeight]);  
                }
        }
    }
}


module halfside(end){
   
    inside(end);
for (i=[1:sidelong]) {
translate([(i-1)*22,0,0]) row(end);
    
    if (i==sidelong){
translate([(i-1)*22,0,0]) rowMirror(end,0);
    }
    else{
        
       translate([(i-1)*22,0,0]) rowMirror(end,1); 
    }
}
}


module fullside(end){
    translate([9,-7.5,0]){
        
translate([(sidelong-1)*22,0,0]){
translate([19,5,0]) cube([2,5,4]);
translate([21,5,0]) cube([2,5,0.8]);
translate([21,5,3]) cube([2,5,1]);
translate([21,5,0]) cube([2,1,3]);
translate([21,9,0]) cube([2,1,3]);
}
 translate([1.5,0,0]){
halfside(end);
translate([0,15,0]) mirror([0,1,0])halfside(end);
}
}
}

//translate([-9,7.5,0]) fullside();
//MAIN

scale(0.37){

//base
if(type>2){
for (i=[1:type]) {
rotate([0,0,360/type*i]) translate([0,-9,-1.5]) cube([32.5+22*(sidelong-1),18,1.5]);
rotate([0,0,360/type*i]) translate([0,-7.5,-5]) cube([32+22*(sidelong-1),15,3.5]); 
}}
if(type==2){
    mirror([1,0,0]) translate([-9,-9,-1.5]) cube([20.5+22*sidelong,18,1.5]);
    rotate([0,0,-90]) mirror([1,0,0]) translate([-9,-9,-1.5]) cube([20.5+22*sidelong,18,1.5]);
    mirror([1,0,0]) translate([-8,-8,-5]) cube([18.5+22*sidelong,16,3.5]);
    rotate([0,0,-90]) mirror([1,0,0]) translate([-8,-8,-5]) cube([18.5+22*sidelong,16,3.5]);
}

//core structure
for (j=[1:level]) {
    translate([0,0,4*(j-1)]){
        
        if(type>2)
                cylinder(r=10, h=4, $fn=type);

        if(type==2){
                mirror([1,0,0]) translate([-5,-5,0]) cube([14,9,4]);
               rotate([0,0,90]) mirror([1,0,0]) translate([-9,-5,0]) cube([14,9,4]);}
    
    if(type==2){
        for (i=[1:type]) {
            if (j==level) {
                rotate([0,0,90*i]) fullside(true);
                translate([-10,-5.5,4]) cube([15,10,roofHeight]);
                rotate([0,0,90]) translate([-5.5,-5.5,4]) cube([15,10,roofHeight]); 
            }
            rotate([0,0,90*i]) fullside(false);
        }
        }
    else{
        for (i=[1:type]) {        
            //roof floor
                if (j==level) {
                    rotate([0,0,360/type*i]) fullside(true);
                if(type>2){
                    translate([0,0,4]) cylinder(r=16.5, h=roofHeight, $fn=type);}
                    }
                else{
                    rotate([0,0,360/type*i]) fullside(false);         
                    }
                    rotate([0,0,360/type*i]) translate([9,-2.5,0]) cube([1,5,4]);
            if(j%3==0 && type!=1)
                cylinder(r=14, h=2, $fn=type);
        }
    }}
}

//watertower

if (watertower==0 && type!=1 ){
translate([0,0,4*level+roofHeight]) {
    if(type==2){
        translate([-9,-3,0]) cube([14,6,6]);
        rotate([0,0,90]) translate([-2,-3,0]) cube([14,6,6]);
        rotate(360/2,0,0) translate([9,-4,0]) cube([3.5,8,8]);
        rotate(360/4,0,0) translate([9,-4,0]) cube([3.5,8,8]);
        translate([-2.5,-2.5,6]) cube([6,6,1]);
    }else{
cylinder(r=10, h=6, $fn=type);
translate([0,0,6]) cylinder(r=6, h=2, $fn=60);}


if (type!=2){
for (i=[1:type]){
rotate(360/type*i,0,0) translate([9,-4,0]) cube([3.5,8,8]);
 rotate(360/type*i,0,0) translate([4,-2.5,6]) cube([6,5,1]);   
}
}

}
}
}
