$fn=90;

SCALE =1.5;

HEIGHT   = 50*SCALE;
DIAMETER = 50*SCALE;
FLOOR    = 18*SCALE;

WEIGHT_CENTER = 32*SCALE;
WEIGHT_RADIUS = 12*SCALE;

TOP_RADIUS = 22*SCALE;
TOP_EXCENTER = 0*SCALE;

KABELOEFFNUNG = 7;
WANDDICKE = 1.8;
LOECHER_ANZAHL = 8;

schirm();


module innen()
{
   translate([-0.01,-0.01,0])
   difference()
   {
      union()
      {
         hull()
         {
 	       translate([0,HEIGHT-WANDDICKE-1,0]) square(1);
  	      
  	       translate([DIAMETER/2-13-WANDDICKE-1,WEIGHT_CENTER-5,0])  rotate([0,0,95])  circle(r=13, $fn=30);    

            square(FLOOR-WANDDICKE);
	      // translate([(DIAMETER/2)-WEIGHT_RADIUS-18,WEIGHT_CENTER+5,0]) #circle(r=WEIGHT_RADIUS-(WANDDICKE));
         }
      }
      translate([-HEIGHT,0,0])
      {
        square(HEIGHT);
      }
   }
}

module schirm()
{
   difference(){
        rotate_extrude(convexity = 30)
        difference()
        {
           grundkoerper();
           innen();
           kabeloeffnung();
        }
      for(i=[1:LOECHER_ANZAHL]){
         rotate([0,0,(360/LOECHER_ANZAHL)*i])
         translate([0,-12,HEIGHT-10])
         rotate([20,0,0])
         cylinder(h=20,r=3);
     }
   }
}

module grundkoerper()
{
   difference()
   {
      hull()
      {
	     translate([TOP_EXCENTER,HEIGHT-TOP_RADIUS-0.5,0]) circle(r=TOP_RADIUS);  
	     square(FLOOR);
	     translate([(DIAMETER/2)-WEIGHT_RADIUS,WEIGHT_CENTER,0]) circle(r=WEIGHT_RADIUS);
      }

	 translate([-HEIGHT*2,0,0])
      {
        square(HEIGHT*2);
      }
   }
}


module kabeloeffnung()
{
      
	 translate([-KABELOEFFNUNG/2,HEIGHT-KABELOEFFNUNG/2,0])
      {
        square(KABELOEFFNUNG);
      }
}


