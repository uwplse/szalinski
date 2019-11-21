/* Global] */

// Size of Balls
ballsize=6; 

// Total width of outer slider
width=32; 

// Sidewalls of outer slider needs to be larger then half the ballsize
sidewall=5; 

// Bottom wall height (your screws will need to be longer then this)
bottomwall=6; 

// Total length of sliders 
length=220; 

// space between outer and inner slider on each side (2 is good for 6mm balls) smaller values will it make harder to insert the balls, bigger values could make them fall out easily. 
spacing=2;

// diameter of screw holes (triangle head will then be twice the size
screwsize=4;

// number of screws (use more for longer slides)
nscrew=3; // [1:1:12]

clearance=0.15; // extra space for balls so they are not too tight. also depends on the resolution of your printer. 

makelatch=0;  // [0:No,1:Yes]

latchheight=1.5; // only used when latch is enabled.

/* [Hidden] */
ball=ballsize+clearance; 
ball2=ballsize+2*clearance; 

s2=spacing/2;
height=bottomwall+ball+3*s2; 
width2=width-2*sidewall-2*spacing;
h2=ball+2*s2;

dist=length/(nscrew+1);
screw=[ for(i=[1:1:nscrew]) i*dist ];
bsc=[ for(i=[0:1:nscrew]) i*dist ];    
latchlen=4*s2+h2;
latchwidth=max(width2 - sidewall, width2/2);

module cuthole(wi,le,ba) {
  rot=atan2(le,wi);  
  borung=min(wi+ba,le+ba);  
  union() {  
    difference( ) {  
       cube([wi,le,height]);   
       rotate([0,0,rot]) translate([0,-ba/2,0]) cube([2*wi+2*le,ba,height*3]); 
       translate([0,le,0]) rotate([0,0,-rot]) translate([-wi-le,-ba/2,-height]) cube([2*wi+2*le,ba,  height*3]);
       translate([wi/2,le/2,-s2]) cylinder(d=borung,h=2*height,$fn=32);     
     }
     
    b2=max(borung/2,borung-sidewall);
    translate([wi/2,le/2,0]) cylinder(d=b2,h=height,$fn=32);       
  }   
}    

//cuthole(300,500,100);

module cutout() {
    translate([sidewall+s2,ball2/2+spacing,bottomwall+ball2/2+spacing]) sphere(d=ball2,$fn=32); 
    translate([width-sidewall-s2,ball2/2+spacing,bottomwall+ball2/2+spacing]) sphere(d=ball2,$fn=32);
    translate([sidewall+s2,ball+2*spacing,bottomwall+ball/2+spacing]) rotate([-90]) cylinder(d=ball,h=length,$fn=32) ;
    translate([width-sidewall-s2,ball+2*spacing,bottomwall+ball/2+spacing]) rotate([-90]) cylinder(d=ball,h=length,$fn=32) ;    
}    



difference() {
    cube([width,length,height]);
    translate([sidewall,-0.5,bottomwall]) cube([width-2*sidewall,length+1,height]);
    cutout();
    for (sc=screw) { translate([width/2,sc,-s2]) cylinder(d=screwsize,h=height*2,$fn=32); }
    for (sc=screw) { translate([width/2,sc,bottomwall-screwsize/2]) cylinder(d1=screwsize,d2=3*screwsize,h=screwsize); }
    for(sc=bsc) { translate([sidewall+2*s2,sc+screwsize+sidewall/2,-s2]) cuthole(width2,dist-sidewall-2*screwsize,sidewall/2); } 
};


 translate([0,0,bottomwall+h2+s2*1.5]) rotate([0,180,0])   difference() {
   h3=h2+s2/2;
   borung=min(screwsize*2.5,width2-sidewall); 
   translate([sidewall+spacing,0,bottomwall+s2]) cube([width2,length,h3]);
  cutout();
  for (sc=screw) { translate([width/2,sc,-s2]) cylinder(d=screwsize,h=height*2,$fn=32); }
  for (sc=screw) { translate([width/2,sc,bottomwall+s2+h3-bottomwall]) cylinder(d2=screwsize,d1=2*screwsize,h=screwsize/2,$fn=32); }
  for (sc=screw) { translate([width/2,sc,bottomwall]) cylinder(d=borung,h=h3-bottomwall+s2,$fn=32 ); }
  for(sc=bsc) {
     if (sc != bsc[nscrew] || makelatch == 0 ) { 
       translate([sidewall+sidewall/2+2*s2,sc+screwsize+sidewall/2,bottomwall]) cuthole(width2-1*sidewall,dist-sidewall-2*screwsize,sidewall/2); 
    } else {
       if (  dist-sidewall-2*screwsize-latchlen-sidewall/2 > width2) {
         translate([sidewall+sidewall/2+2*s2,sc+screwsize+sidewall/2,bottomwall]) cuthole(width2-1*sidewall,dist-sidewall-2*screwsize-latchlen-sidewall/2,sidewall/2); }
      } 
    }    
  if (makelatch != 0 ) {
     translate([sidewall+spacing+(width2-latchwidth)/2,length-latchlen-sidewall,bottomwall+s2-latchheight-h3]) union() {
         cube([latchwidth,latchlen,2*h3]);
         translate([0,-latchheight,-h3]) cube([latchwidth,latchheight,4*h3]);
         translate([0,-latchheight,-h3]) cube([latchheight,latchlen+latchheight,4*h3]);
         translate([latchwidth-latchheight,-latchheight,-h3]) cube([latchheight,latchlen+latchheight,4*h3]);
     }  
  }     
}    

//color("red") {
// translate([sidewall+s2,bottomwall+s2,s2+ball]) sphere(d=ball); 
// translate([width-sidewall-s2,bottomwall+s2,s2+ball]) sphere(d=ball); 
//}
