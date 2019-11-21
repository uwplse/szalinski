$fn=50;


/* [Dimensions Strain Relief] */
reliefHeight=11.5;
reliefDia=11;
grooveCnt=3;
ribWidth=1.6;
ribZOffset=2.1;

/* [Dimensions Body] */
bodyDims=[21,15,25];
plateDims=[34,15,3.6];

screwDist=24.5;

cableDia=5;

/* [Dimensions ThumbScrews] */
thmbScrwDia=8;
thmbScrwDpth=1;
thmbScrwLngth=21;
thmbScrwTips=24;
sltWdth=2;
sltDeep=5;

/* [Dimensions Decor] */
numGrvs =6;
//Offset from window
grvZOffset=0;
grvHght=0.5;

/* [Hidden] */
ovHeight=reliefHeight+bodyDims.z+plateDims.z;
fudge=0.1; //fudge for correct rendering

VGACon();

module VGACon(){
  
  difference(){
    body();
    for (i=[-1,1])
      translate([i*screwDist/2,0,19]) cylinder(d=8.5,h=ovHeight-19.5);
  }
  
  antiKink();
  
  for (i=[-1,1])
      translate([i*screwDist/2,0,19]) thumbScrew();
    
  
  module body(){
    difference() {
      union(){
        translate([0,0,3.6/2]) rndRect([34,15,3.6],2,center=true); //plate
        for (i=[-1,1]) //screwshafts
          translate([i*(33-8.5)/2,0,0]) cylinder(d=8.5,h=19);
        translate([0,0,25/2]) rndRect([21,15,25],3.5,center=true);
        translate([0,0,25]) rndCube([21,15,7],3.5,center=true);
        //cylinder(d=11,h=ovHeight);
      }
      
      for (i=[-1,1])
        translate([0,i*bodyDims.y/2,bodyDims.z/6+plateDims.z]) rotate([90,0,0]){
          rndRect([bodyDims.x/2,bodyDims.z/3,1],center=true);
        //ribs
          for (j=[0:numGrvs-1]) 
            translate([0,bodyDims.z/6+0.5+grvZOffset+grvHght*2*j,0]) 
              rndRect([bodyDims.x/2,grvHght,1],grvHght/2,center=true);
        }
    }
  }    
  
  module antiKink(){
    difference(){
      cylinder(d=reliefDia,h=ovHeight);
      translate([0,0,-fudge/2]) cylinder(d=cableDia,h=ovHeight+fudge);
      translate([0,0,ovHeight-ribZOffset]) strainCuts();
    }
  }
  
  module thumbScrew(){
    difference(){
      linear_extrude(height=thmbScrwLngth,scale=0.8,convexity=3) 
        star(thmbScrwTips,(thmbScrwDia-thmbScrwDpth)/2,thmbScrwDia/2);
      if (sltWdth) translate([0,0,thmbScrwLngth]) cube([sltWdth,thmbScrwDia,sltDeep*2],true);
    }
  }
  
}



module rndRect(dims=[1,1,1],rad=1,center=false){
  cntrOffset= center ? [0,0,0] : [dims.x/2,dims.y/2,dims.z/2];
  translate(cntrOffset)
  hull() for (i=[-1,1],j=[-1,1])
    translate([i*(dims.x/2-rad),j*(dims.y/2-rad),0]) cylinder(r=rad,h=dims.z,center=true);
}

module rndCube(dims=[1,1,1],rad=1,center=false){
  cntrOffset= center ? [0,0,0] : [dims.x/2,dims.y/2,dims.z/2];
  
  translate(cntrOffset)
    hull() for (x=[-1,1],y=[-1,1],z=[-1,1])
      translate([x*(dims.x/2-rad),y*(dims.y/2-rad),z*(dims.z/2-rad)]) sphere(rad);
}

*strainCuts();
module strainCuts(){
  grooveWidth=(reliefDia-ribWidth+fudge)/2;
  translate([0,0,-grooveCnt*2*(ribWidth)+ribWidth*1.5])
  for (i=[0:grooveCnt-1],j=[-1,1]){
    translate([0,j*(grooveWidth+ribWidth+fudge)/2,i*ribWidth*2]) cube([reliefDia,grooveWidth,ribWidth],true);
  }
}

*star(5,20,40);
module star(n,ri,ro,polys=[]){
  // polartransformation
  // x= xM + r * cos(phi);
  // y= yM + r * sin(phi);
  if (len(polys)<(n*2)){
    phiO = (180/n)*len(polys);
    xO = ro*cos(phiO);
    yO = ro*sin(phiO);
    phiI = (180/n)*len(polys) + 180/n;
    xI = ri*cos(phiI);
    yI = ri*sin(phiI);
    star(n,ri,ro,concat(polys,[[xO,yO],[xI,yI]]));
  }
  else
    polygon(polys);
}
