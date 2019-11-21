//power tool vacuum adaptor
//vacuum hose side is female, covers vacuum nozzle 
//tool side is female, covers tool port

//set parameter for adaptor wall thickness
aw = 2;

//set parameter for mid-taper 
mh = 20;


//set parameters for vacuum adaptor
//this is set to the outside radius of your nozzle
//with the wall thickness added 
vr_top=(15 + aw);

//vr_end is the radius of your tool port plus wall
vr_end= (31 + aw);
vh=40;

//set adaptor length (fits tool and vac)

//set parameters for tool side
tr=vr_end;
th=40;

//code below creates two pipes and addes them together

$fn=100;
union() 
{
translate ([0,0,-th]) union() 
{
  //create size taper and hollow it 
  difference() 
      {
          cylinder(mh,vr_end, vr_top);
          cylinder(mh,vr_end-aw, vr_top-aw);
      }
  //create tool port cylinder and hollow it and move it
     translate([0,0,-th]) 
 {
          difference () 
    {
          cylinder(th, tr, tr, false );
          cylinder(th, tr-aw, tr-aw, false); 
    }
  }
}
   //create vacuum nozzle cylinder and hollow it  
          translate([0,0,-mh])
             difference ()
     {
         cylinder(th, vr_top, vr_top);
         cylinder(th, vr_top-aw, vr_top-aw);
     } 
}
//micheal.obraoin@gmail.com
