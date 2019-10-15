////////////////////////////////////////////////
///////wedge for removing MT tapers//////
/*author:Rudiger Vanden Driessche
ruudoleo@skynet.be
date:10/09/2015
ABS   print with 100% innfill

about tapers:
http://www.beautifuliron.com/mttaper.htm
Had to replace the head of my drilling machine, but the taper was lodged after 20 years nonuse. 
*/
/*//parameters//////*/
/* [Wedge]*/
Wedgelenght=150;
Wedgeshaft=30;
Wedgewidth=6.3;//[5.2:MT1,6.3:MT2,7.9:MT3,11.9:MT4,15.9:MT5]
Rounding=true;
Hole=5;
taperw=10;
lenghtpercent=50;
slopepercent=4;
/* [Antiwarpears]*/
eardia=15;
earh=1;
/* [Hidden]*/
safety=0.1;

space=taperw-Wedgewidth;
slope=Wedgelenght-Wedgeshaft;
a1=space-(lenghtpercent/100*slope*slopepercent/100);
a2=space+(1-lenghtpercent/100)*slope*slopepercent/100;
angle=slopepercent/100*45;
echo(a1,a2);

difference(){
hull(){
    
    //shaft
    translate([0,Wedgewidth/2,Wedgewidth/2]){
rotate(-90,[0,1,0]){
cylinder(d=Wedgewidth,h=Wedgeshaft,$fn=100);
}//end rotate
}//end translate


//straight end
translate([slope,Wedgewidth/2+a2,Wedgewidth/2]){
rotate(-90,[0,1,0]){
cylinder(d=Wedgewidth,h=Wedgeshaft+slope,$fn=100);
 }//end rotate
}//end translate 
//sloped end
rotate(angle,[0,0,1]){
translate([0,Wedgewidth/2,Wedgewidth/2]){
    rotate(90,[0,1,0]){
      cylinder(d=Wedgewidth,h=slope,,$fn=100);
    }//end rotate
    }//end translate
}//end rotate

}//end hull
//bore
translate([-Wedgeshaft/2,Wedgewidth/2+a2/2,-safety/2])
    cylinder(d=Hole,h=Wedgewidth+safety,$fn=100);
}//end difference
//ears
translate([0.5*Wedgelenght-Wedgeshaft,a2,0.5*earh]) {
  antiwarpears(eardia,earh,Wedgelenght-eardia,0.5*eardia);

}//end translate
module antiwarpears(dia,h,xd,yd){
	for(x=[-1,1], y=[-1,1]) 
       {
		translate([xd/2*x,yd/2*y,0]) 
            cylinder(d=dia,h=1,center=true,$fn=50);
       }//end for
   }//end module

