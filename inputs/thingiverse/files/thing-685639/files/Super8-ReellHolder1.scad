//Hub for super8 film reel
//Electronic components come on reels of varying widths


/*[Global]*/
//Choose Which parts to show
Show="all"; //[all,rod,cap]

//Choose the view
View="printable"; //[assembly, exploded, exploded-cutaway,printable]
//View="assembly";
//View="exploded-cutaway"; //[assembly, exploded, printable]

//Width of reel outside to outside
SpoolW=30;
RodL=SpoolW;
//allowance for UP printer making holes a little on the undersize
holeos=0.4;
/*[Axle / Bolt]*/
//Hole through holder. Probably should expect to clean rough bits out with drill rather than make too oversize 
AxleD=6.2;
AxleR=(AxleD+holeos)/2;
//As reels can get quite thick, the axle hole is oversized in the middle, and only this length at each end is running on the axle.
AxleContactL=8;
// radial clearance around shaft at the internal (non contacting) part
AxleClearance=0.5;

/*[Flange-Rod]*/
//Diameter of Flange
FlangeOD=19;
FlangeOR=FlangeOD/2;
//Thickness of straight part of flange
FlangeEdgeT=1;
//Bottom part of flange can be bevelled at 45deg-> less support and less friction area too.
FlangeBevelT=3;

//radius of inner rod of holder
RodR=25.4/4; //1/2"

//Castellations used to detent cap into locked position
CastleR=1.5;

//Width of fins
FinW=2;
//Length of fins
FinT=2.9;
//extra L of fins beyond spool
FinExtraL=0;
FinL=SpoolW+FinExtraL;

/*[Cap]*/
//Length of cap inclusing recess. Set the cap dimensions to suit the bolt you are using, and the spring pressing the cap in.
CapL=9;
//this is the recess where the cap spring and possibly the bolt head sits into
CapRecessD=7.5;
CapRecessH=7;
CapRecessR=(CapRecessD+holeos)/2;
//bevel top rim of cap
CapBevel=0.5;
//length of cap spring - used only to calculate bolt length, should allow 3*CastleR
CapSpringL=3;




echo(str("Bolt Length: ", H+CapL-CapRecessH+CapSpringL));

H=RodL+FlangeBevelT+FlangeEdgeT; //total length
$fn=50;
module cubec(size=1, center="xy", offset=[0,0,0]) {
    if (center=="xy")  translate( offset + [-size[0]/2, -size[1]/2, 0]) cube(size);
    if (center=="x")   translate(offset+[-size[0]/2, 0, 0]) cube(size);
    if (center=="y")   translate(offset+[0, -size[1]/2, 0]) cube(size);
    if (center=="yz")   translate(offset+[0, -size[1]/2, -size[2]/2]) cube(size);    
    if (center=="z")   translate(offset+[0,0,-size[2]/2]) cube(size);
    if (center==true || center=="xyz") translate(-size/2) cube(size);      
}//mod

module TZ(z=10) {
    translate([0,0,z]) children();
}//mod

module Castle(R) {
          intersection() {
               TZ(-CastleR) cylinder(r=RodR+0.01, h= CastleR*3);
               for (A=[0:2]) {
                rotate([0,0,A*120+60])
                   translate([0,0,CastleR/6]) //stope sides going vertical
                        rotate([0,90,0]) 
                            cylinder(r=CastleR, h=RodR*1.2,$fn=10);
            }//for 
        }//intersect
}

module FinRod(RodL=10,FinExtraL=0) {
                cylinder(r=RodR, h=RodL); //rod
            for (A=[0:2]) {
                rotate([0,0,A*120]) {
                    cubec([RodR+FinT, FinW, RodL+FinExtraL-FinW/2],center="y");
                    translate([RodR,0,RodL+FinExtraL-FinW/2]) rotate([0,90,0]) cylinder(r=FinW/2,h=FinT,$fn=20);
                }//rot
            }//for
}
module Cap() {
    color("red") 
    difference() {
        union() {
            rotate([0,0,60]) Castle();
            FinRod(CapL-CapBevel);
            TZ(CapL-CapBevel) cylinder(r1=RodR, r2=RodR-CapBevel,h=CapBevel);
        }//un
        TZ(-0.1-CastleR) cylinder(r=AxleR, h=CapL+1+CastleR);
        TZ(CapL-CapRecessH+0.01) cylinder(r1=CapRecessR, r2=RodR-CapBevel*2, h=CapRecessH);
    }//diff

}//mod

//-----------------------



if (Show=="all" || Show=="rod")
color("cyan")    
difference() {
union() {
    cylinder(r1=(FlangeOR-FlangeBevelT), r2=FlangeOR,h=FlangeBevelT); //bevelled flange part
    TZ(FlangeBevelT) {
        cylinder(r=FlangeOR, h=FlangeEdgeT); //straight flange part
        TZ(FlangeEdgeT) {
            FinRod(RodL);
            TZ(RodL) {
                //Castle();
            }//tz                
       }//tz
        
}//tz
}//union
//diff part
    TZ(-0.1) cylinder(r=AxleR, h=H+10); //axle hole all the way through
    //now fatten middle
    TZ(AxleContactL) {
        cylinder(r1=AxleR,r2=AxleR+AxleClearance,h=AxleClearance); //bottom cone
        TZ(AxleClearance) cylinder(r=AxleR+AxleClearance, h=H- AxleContactL*2 - 2*AxleClearance); //straight middle
    }
    TZ(H-AxleContactL-AxleClearance) cylinder(r2=AxleR,r1=AxleR+AxleClearance, h=AxleClearance);
    
    TZ(H) Castle(); //key for cap locking
    TZ(H+CastleR*0.25) rotate([0,0,60]) Castle(); //shallow key for installing reel
    if  (View=="exploded-cutaway") TZ(-0.1) cubec([FlangeOR*3,FlangeOR*3,H+1], "y");
}//diff

if (Show=="all" || Show=="cap")
   if (View=="assembly") {
        TZ(H) Cap();  
    } else {
         if (View=="exploded") {
            TZ(H+5) Cap();
         }else {
             if  (View=="exploded-cutaway") {
                 TZ(H+5) difference() {
                     Cap();
                    TZ(-0.1) cubec([FlangeOR*3,FlangeOR*3,H+1], "y");
                 }//diff
             }else{ //printable
           translate([FlangeOR*2+10,0,CapL]) rotate([0,180,0]) Cap();  //ready to print
         }
    }
}