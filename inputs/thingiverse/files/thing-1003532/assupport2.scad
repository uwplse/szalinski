/////////////////////////////////////////////////////////////////////
////////////////////Support for filamentrolls ///////////////////
///////////////////iprusa 3 P3Steel www.printer3d.com////////////////////////
/*date:04-09-2015
programmed by: ruudoleo
license:
program: Openscad

*/

/////////////////////////////////////////////////////////////////////
////////////////////////////Parameters//////////////////////////

/*[roller and hexas]*/
    holedia=12;
    tolerance=0.2;  
    rollerdiameter=38.5;
/*[roller]*/
    rollerdepth=11;
    seamheightinside=1;
    brimoutsidethickness=2;
    brimoutsideheight=4;
    
/*[Hexas]*/
   supportdist=127;
   supportthickness=3.5;

/*[Print what]*/
part="both";//[hexas:hexas,centerring:centerring,both:both]

/*[Hidden]*/
   hexwidth=(holedia-tolerance)*sqrt(3)/2;
   hexlenght=supportdist/2+10;
   rollerdia=rollerdiameter-tolerance;
//////////////rendering//
if (part=="hexas"){ 
    translate([0,0,hexwidth/2])
 hex_As();   
}// endif
else{
    if (part=="centerring"){
     center_Ring();    
    }//end if
    else{
        translate([50,0,hexwidth/2])
      hex_As();
      center_Ring();  
    }//end else
} // end if
  
//////////////////modules///////
   //*****filamentrollersupport***
module hex_As(){
    rotate(a=270,v=[1,0,0])
     hexas(supportthickness,supportdist,hexlenght,holedia,hexwidth,tolerance);  
    
}// end module
module center_Ring(){
        support(rollerdia,rollerdepth,seamheightinside,brimoutsidethickness,brimoutsideheight);
}//end module


module support(rollerdia,rollerdepth,seamhightinside,brimoutsidethickness,brimoutsideheight){
      difference(){
      union(){
        //brim outside
          translate([0,0,brimoutsidethickness/2])
            cylinder(d=rollerdia+brimoutsideheight*2,h=brimoutsidethickness,center=true,$fn=100);
        //main cylinder
         translate([0,0,rollerdepth/2])
                 cylinder(d=rollerdia,h=rollerdepth,center=true,$fn=100);
         //brim inside 
         translate([0,0,rollerdepth-1])
            cylinder(r1=rollerdia/2,r2=rollerdia/2+seamheightinside/2,h=1,center=true,$fn=100);
         translate([0,0,rollerdepth])
             cylinder(r1=rollerdia/2+seamheightinside/2,r2=rollerdia/2,h=1,center=true,$fn=100);
    
  
}


// make hole
translate([0,0,rollerdepth/2])
                cylinder(d=holedia,h=rollerdepth+10,center=true,$fn=100);
}
}




     //*************hex as**********
     module hexas(supportthickness,supportdist,hexlenght,holedia,hexwidth,tolerance){
     halfhexas(supportthickness,supportdist,hexlenght,holedia,hexwidth,tolerance);
     mirror([0,0,1])
     halfhexas(supportthickness,supportdist,hexlenght,holedia,hexwidth,tolerance);
   }
     //*************halfhex as**********
     module halfhexas(supportthickness,supportdist,hexlenght,holedia,hexwidth,tolerance){
     difference(){
            //hexagonale as 
            translate([0,0,-hexlenght/2])
                cylinder(d=holedia-tolerance,h=hexlenght,center=true,$fn=6);
 
         
         //delete grooves
           translate([supportthickness/2,-hexwidth,-supportdist/2-supportthickness])
            cube(size=[hexwidth,hexwidth*2,supportthickness],center=false);
           translate([-hexwidth-supportthickness/2,-hexwidth,-supportdist/2-supportthickness])
             cube(size=[hexwidth,hexwidth*2,supportthickness],center=false);           
      }
               //////antiwarpsupport 3D print///
             translate([holedia*0.5,hexwidth/2-0.5,-hexlenght/2-supportdist/4+2])
                cube(size=[holedia/2,1,hexlenght-supportdist/2],center=true);
     
     
        translate([-holedia*0.5,hexwidth/2-0.5,-hexlenght/2-supportdist/4+2])
                cube(size=[holedia/2,1,hexlenght-supportdist/2],center=true);
  }
     