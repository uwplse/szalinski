//+-------------------------------------------------+
//|OPENSCAD Bouton de mercercie - haberdasher Button|
//|        2015 gaziel@gmail.com                    |
//+- -----------------------------------------------+   

//your choice...   
type="love";//[round,square,flower,cat,bunny,MMice,love]

//external diameter or length of the button
bd=10;

//thinkness
bep=1;

//border ? Yes of course!
border="yes";//[yes,no]

//allowance
borderep=1;

//size  for the border 
borderd=1;

//number of holes
hn=2;//[2,4,6]

//hole diameter
hd=1;

//holes repartition diameter
hr=4;

$fn=50/2;

bouton();

module bouton(){
    difference(){
        corps();
        for (i=[1:hn]){
            rotate([0,0,(i*360)/hn])translate([(hr+hd)/2,0,0]) cylinder(d=hd,h=bep+1,center=true);
        }
    } 
}
module corps(){
   if (type=="round"){
       cylinder(d=bd,h=bep,center=true);
       if (border=="yes"){
           difference(){
               translate([0,0,bep/2])cylinder(d=bd,h=borderep,center=true);
               translate([0,0,bep/2])cylinder(d=bd-borderd,h=borderep+1,center=true);
           }
        }          
   }
  if (type=="square"){
   cube([bd,bd,bep],center=true);
   if (border=="yes"){
       difference(){
           translate([0,0,bep/2]) cube([bd,bd,borderep],center=true);
           translate([0,0,bep/2])cube([bd-borderd,bd-borderd,borderep+1],center=true);
       }
    }          
}
  if (type=="flower"){
   for (i=[1:6]){
    rotate([0,0,(i*360)/6])translate([bd/3,0,0]) cylinder(d=bd/3,h=bep,center=true);
   }
   cylinder(d=bd/1.6,h=bep,center=true);
   if (border=="yes"){
       difference(){
           union(){
                  for (i=[1:6]){
translate([0,0,bep/2])    rotate([0,0,(i*360)/6])translate([bd/3,0,0]) cylinder(d=bd/3,h=borderep,center=true);
   }
  translate([0,0,bep/2]) cylinder(d=bd/1.6,h=borderep,center=true);
           }
                      union(){
                  for (i=[1:6]){
translate([0,0,bep/2])    rotate([0,0,(i*360)/6])translate([bd/3,0,0]) cylinder(d=(bd/3)-borderd,h=borderep+1,center=true);
   }
  translate([0,0,bep/2]) cylinder(d=(bd/1.6)-borderd/2,h=borderep+1,center=true);
           }

       }
    }          
}
    if (type=="cat"){
        cylinder(d=bd,h=bep,center=true);
        difference(){
            union(){
                rotate([0,0,33])scale([0.5,1.5,1])cylinder(d=bd,h=bep,center=true);
                rotate([0,0,-33])scale([0.5,1.5,1])cylinder(d=bd,h=bep,center=true);
            }    
            translate([-bd/2,0,-bd/2])cube(bd);
            
        }
       if (border=="yes"){
           difference(){
               translate([0,0,bep/2])cylinder(d=bd,h=borderep,center=true);
               translate([0,0,bep/2])cylinder(d=bd-borderd,h=borderep+1,center=true);
           }
        }          
   }
   
       if (type=="bunny"){//bof
        cylinder(d=bd,h=bep,center=true);
        difference(){
            union(){
                translate([bd/2,-bd/2,0])rotate([0,0,33])scale([0.5,1.2,1])cylinder(d=bd,h=bep,center=true);
                translate([-bd/2,-bd/2,0])rotate([0,0,-33])scale([0.5,1.2,1])cylinder(d=bd,h=bep,center=true);
            }    
           
            
        }
       if (border=="yes"){
           difference(){
               translate([0,0,bep/2])cylinder(d=bd,h=borderep,center=true);
               translate([0,0,bep/2])cylinder(d=bd-borderd,h=borderep+1,center=true);
           }
        }          
   }
   
      if (type=="MMice"){
        cylinder(d=bd,h=bep,center=true);
        difference(){
            union(){
                translate([bd/2,-bd/2,0])rotate([0,0,33])cylinder(d=bd/1.618,h=bep,center=true);
                translate([-bd/2,-bd/2,0])rotate([0,0,-33])cylinder(d=bd/1.618,h=bep,center=true);
            }       
         }
       if (border=="yes"){
           difference(){
               translate([0,0,bep/2])cylinder(d=bd,h=borderep,center=true);
               translate([0,0,bep/2])cylinder(d=bd-borderd,h=borderep+1,center=true);
           }
        }          
   }
     if (type=="love"){
       translate([0,-bd/8,0])rotate([0,0,45]){
         cube([bd,bd,bep],center=true);
         translate([bd/2,0,0])cylinder(d=bd,h=bep,center=true);
         translate([0,bd/2,0])cylinder(d=bd,h=bep,center=true);
       }      
       if (border=="yes"){
           difference(){
               translate([0,0,bep/2]) union(){ 
                 translate([0,-bd/8,0])rotate([0,0,45]){
                 cube([bd,bd,bep],center=true);
                 translate([bd/2,0,0])cylinder(d=bd,h=bep,center=true);
                 translate([0,bd/2,0])cylinder(d=bd,h=bep,center=true);
                 }
               }
               translate([0,0,bep/2]) union(){ 
                 translate([0,-bd/8,0])rotate([0,0,45]){
                 cube([bd-borderd,bd-borderd,bep+1],center=true);
                 translate([bd/2,0,0])cylinder(d=bd-borderd,h=bep+1,center=true);
                 translate([0,bd/2,0])cylinder(d=bd-borderd,h=bep+1,center=true);
                 }
               }  
            }
       }
     }
 }
