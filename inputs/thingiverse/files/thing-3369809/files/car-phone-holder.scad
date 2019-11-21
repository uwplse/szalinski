//use <..\lib\Round-Anything\polyround.scad>;
use <..\lib\Round-Anything\MinkowskiRound.scad>;
use <..\lib\Poor_mans_openscad_screw_library\polyScrewThread_r1.scad>;


//With of the phone
phoneWRaw = 81;
//Depth of your phone
phoneDRaw = 10;





PI=3.141592;

phoneWTol = 1;
phoneDTol = 1;

thickness=2;
phoneFrameSide=5;
phoneFrameBottom=12;

phoneW = phoneWRaw + phoneWTol;
phoneD = phoneDRaw + phoneDTol;

phoneH = 40;

clipMountH= 20;
clipMountW= 20;

clipMountD = 3.5;


clip_screw_thickness=3.5;
clip_screw_h=30;
clip_screw_innder_handle_h  = 4;
clip_screw_d_sum=clipMountW;
clip_screw_d_inner = clip_screw_d_sum-2*clip_screw_thickness;
clip_screw_tol=0.2;
 

//rendering phone case
phone_holer();

//rendering screw holder
translate([10,-15,0])
union(){
  clip_screw_inner();
  translate([clip_screw_d_sum+1,0,0]) rotate([0,0,60]) clip_screw_outer();
}



module clip_screw_outer(){
  difference(){
    union(){
    cylinder(h=clip_screw_h-clip_screw_innder_handle_h,d=clip_screw_d_sum,$fn=6);
    
       rotate([0,0,30])translate([-(clip_screw_d_sum/2+clipMountD+thickness*2),-(clipMountW/2),0]) union(){
      cube([clip_screw_d_sum/2+clipMountD+thickness*2 , clipMountW  ,clipMountD]);
      cube([clipMountD , clipMountW , clipMountH+clipMountD]);
    }
  }
  
    screw_thread(clip_screw_d_inner,   // Outer diameter of the thread
      4,   // Step, traveling length per turn, also, tooth height, whatever...
      55,   // Degrees for the shape of the tooth (XY plane = 0, Z = 90, btw, 0 and 90 will/should not work...)
      clip_screw_h,   // Length (Z) of the tread
      PI/2,   // Resolution, one face each "PI/2" mm of the perimeter, 
      0);  // Countersink style:
  }
}

module clip_screw_inner(){
  difference(){
  union(){
    cylinder(h=clip_screw_innder_handle_h,d=clip_screw_d_sum,$fn=6);
     translate([0,0,clip_screw_innder_handle_h]) scale([1,1,0.3]) sphere(d=clip_screw_d_sum,$fn=6);
     screw_thread(clip_screw_d_inner-2*clip_screw_tol,   // Outer diameter of the thread
                  4,   // Step, traveling length per turn, also, tooth height, whatever...
                  55,   // Degrees for the shape of the tooth (XY plane = 0, Z = 90, btw, 0 and 90 will/should not work...)
                  clip_screw_h,   // Length (Z) of the tread
                  PI/2,   // Resolution, one face each "PI/2" mm of the perimeter, 
                  0);  // Countersink style:
  }
   translate([0,0,-clip_screw_h/2]) cube([clip_screw_h,clip_screw_h,clip_screw_h],center=true);
  }
}

module clip_mount(clip_tol){
  //clip mount
  difference(){
    cube([clipMountW+thickness*2+clip_tol*2,clipMountD+thickness*2+clip_tol*2,clipMountH]);
    translate([thickness+clip_tol,thickness+clip_tol,0]) cube([clipMountW+clip_tol,clipMountD+clip_tol,clipMountH]);
  }
}


module phone_holer(){
  
  clip_tol=0.4;
  
  phoneWSum=phoneW+(thickness*2);
  phoneDSum=phoneD+(thickness*2);
  
  clipWSum = clipMountW+thickness+2+clip_tol*2;
  
  
  translate([(phoneWSum-clipWSum)/2,phoneD+thickness,0]) clip_mount(0.4);
  
  difference(){
    
    //outer cube
    rad = 2.5;
    
    minkowskiOutsideRound(rad,1)
    cube([phoneWSum, phoneDSum, phoneH+(thickness*2)+rad]);
    //upper cut off
    translate([0,0,phoneH+(thickness*2)]) cube([phoneWSum, phoneDSum, rad]);
    
    //pattern
    pAmount=7;
    wEntirePart=phoneWSum/pAmount;
    wPart=wEntirePart/3;
    
    translate([0,(phoneH-2*phoneFrameSide)/2+0.01,(phoneH-2*phoneFrameSide)/2+phoneFrameSide+thickness])
    for (i =[0:pAmount])
      translate([1.5*wPart+(wEntirePart*i),0,0])
      rotate([90,0,0])
      scale([wPart,phoneH-phoneFrameSide,1])
      cylinder(d=1, h=thickness+0.02,$fn=64);
    /*
    patternW=4;
    for (x =[0:7])
      translate([phoneFrameSide+x*12,thickness*2+phoneD,phoneFrameSide+thickness])
      rotate([90,0,0])
      translate([patternW/2,(phoneH-2*phoneFrameSide)/2,0])
      scale([patternW,phoneH-phoneFrameSide,1])
      cylinder(d=1, h=thickness,$fn=64);
    */
    
    //charger cut
    cutVar=2;
    translate([phoneWSum/2,-cutVar,0]) cylinder(r1=phoneD+thickness,r2=cutVar+phoneD+thickness, h=phoneFrameBottom+thickness, $fn=64);
    
    //inner (phone) cube
    translate([thickness,thickness,thickness]) cube([phoneW, phoneD, phoneH]);
    
    //front phone frame
    translate([phoneFrameSide+thickness,0,phoneFrameBottom+thickness]) cube([phoneW-(2*phoneFrameSide), thickness, phoneH]);
    
    
    //stick in helper
    polyhedron( 
    [
    //lower part
    [thickness, thickness, phoneH+thickness],//0
    [thickness+phoneW, thickness, phoneH+thickness],//1
    [thickness+phoneW, thickness+phoneD, phoneH+thickness],//2
    [thickness, thickness+phoneD, phoneH+thickness],//3
    
    //upper part
    [0, 0, phoneH+(thickness*2)],//4
    [phoneWSum, 0, phoneH+(thickness*2)],//5
    [phoneWSum, phoneDSum, phoneH+(thickness*2)],//6
    [0,phoneDSum, phoneH+(thickness*2)]//7
    ],
    
    [
    [0,1,2,3],  // bottom
    [4,5,1,0],  // front
    [7,6,5,4],  // top
    [5,6,2,1],  // right
    [6,7,3,2],  // back
    [7,4,0,3]
    ]); //7, CubeFaces );
    
    
  }
}




/*
module clip(clipX,clipY,clipZ){
  stlClipY=25;
  stlClipZ=3.5;
  stlClipX=3+9.5;
  
  scale([1,clipY/stlClipY,1])
  
  union(){
  difference(){
    translate([-stlClipX,0,0])import_stl("Vent_Clip_v2.stl", convexity = 5); 
    translate([-stlClipX,0,0])cube([stlClipX,stlClipY,stlClipZ]);
    }
  
  translate([-clipX,0,0])cube([clipX,stlClipY,clipZ]);
  }
}
*/