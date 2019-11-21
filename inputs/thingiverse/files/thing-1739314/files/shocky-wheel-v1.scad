//***** Shockflyer Wheel ******
//*    Henning Stöcklein              *
//*  Free for noncommercial use   *
//*  Version 27.8.2016                *
//*************************

// Axis hole diameter
dwelle = 3.8; // [2.0:0.1:4.0]

// Wheel disc thickness
dicke = 1.0; // [0.8:0.1:2.0]

// Wheel disc diameter (default = 38)
diam  = 38; // [25:45]

// Tire radius 
rkragen = 1.2; // [0.8:0.1:2.5]

// Tire height
hkragen = 1; // [0.8:0.1:2.5]

// Center hub height
hnabe = 5; // [1:0.2:6]

// Center hub diameter
dnabe = 9; // [5:12]

// Spoke height
hspeiche = 3 ; // [1:0.1:5]

// Show Spacer?
showspacer = 0 ; // [1:YES, 0:NO]

// Spacer height
hspacer = 3 ; // [1:0.1:4]

// Spacer hole diameter
dspacer = 3.6; // [2.0:0.1:4.0]


//*********** End of user parameters *************

module wheel ()
{
  difference() {
    union() {
	   // Scheibe und Nabe
       translate ([0,0,dicke/2]) cylinder (r=diam/2, h=dicke, $fn=50, center=true);
   	   translate ([0,0,hnabe/2]) cylinder (r1=dnabe/2, r2=dwelle/2+1.2, h=hnabe, $fn=30, center=true);

	   // Kragen aussenherum = Lauffläche
		difference ()
        {
     	  translate ([0,0,(dicke+hkragen)/2]) 
              cylinder (r=diam/2+rkragen, h=dicke+hkragen, $fn=75, center=true);
          cylinder (r=diam/2, h=20, $fn=50, center=true);
      } // diff
    } // union

    // Loch in der Nabe
    cylinder (r=dwelle/2, h=20, $fn=20, center=true);

    // 6 Aussparungen zwischen den Speichen
    for (x = [0:60:360]) {
      rotate ([0,0,x]) hull()
      {
          translate ([diam*0.35,0,0]) cylinder (r=diam/8, h=20, $fn=40, center=true);
          translate ([6.2,0,0]) cylinder (r=1.4, h=20, $fn=20, center=true);
      }
    }
  }

  // 6 Versteifungsrippen zwischen Nabe und Speichen
  for (x = [30:60:390])
  {
	   rotate ([0,0,x]) hull()
       {
           translate ([dwelle/2+0.1,0,(dicke+hspeiche)/2]) cube ([0.1, 1.4, dicke+hspeiche], center=true);
           translate ([diam/2,0,(dicke+hkragen)/2]) cube ([0.1, 1.4, dicke+hkragen], center=true);
       }
  } // for
} // module wheel

// Distanzröllchen
module spacer()
{
  translate ([0,0,hspacer/2]) 
    difference()
    {
      cylinder (r=0.7*dnabe/2, h=hspacer, $fn=30, center=true);
      cylinder (r=dspacer/2, h=20, $fn=20, center=true);
    }
}

wheel() ;

if (showspacer == 1) translate ([25,25,0]) spacer() ;
