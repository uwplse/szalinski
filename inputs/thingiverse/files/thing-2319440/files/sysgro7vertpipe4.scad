// Select the desired part
part = "simple"; // [simple:Planter,stack:stackable Planter,double:twosided Planter, doublestack:stackable twosided Planter,Adapter:Adapter ]

// Outer diameter of used pipe or diameter of connection ring
outerpipe = 80;                 
// Hight of the planter without the overlapping part, for maximal hightcalculation add overlap
planterhight = 80;    
// Planter wall thickness, the thinnest part
plantthick = 1.6;    
// adapter wall thickness
adapterwall = 1.6;  
// How much the planter is overlapping the pipe for connection
overlap = 20;   
// Scalefactor of bottomholediameter
scaledhole = 4; //[0:10]   
// Wallthickness of used pipes
pipethick = 2;  
// tolerance for adapter
tol = 0.4;  
// Scalefactor of topholesdiameter
topholesscale = 2; //[1:5] 



/* [Hidden] */ 

output();

module output() {

	if (part == "simple") {
        color("Cornsilk")
		planter();
	} else if (part == "stack") {
	        color("Seashell")
        adapteredplanter();
	} else if (part == "double") {
        color("Bisque")
		doubleplanter();
    } else if (part == "doublestack") {
	        color("OldLace")
        adaptereddoubleplanter();
    } else if (part == "Adapter") {
	        color("Chocolate")
		adapter();
	} else {
		planter();
	}
}

pipelen = (planterhight+100);
bottomsphererad = (outerpipe/5);
topcirclerad = (bottomsphererad*3);
holescale = scaledhole/10;
diebloch = outerpipe/8;


module planter() {
          difference() {
union() {    
basebody();
mouth();
}
    
hole();
}
}
module adapteredplanter() {
         
union() {    
planter();
               translate([0, 0, -overlap])
adapter();

}
}


module doubleplanter() {
             difference() { 
union() {    
doublebasebody();
mouth();
    
    rotate([0,0,180])
mouth();
}
hole();
    rotate([0,0,180])
hole();

}
}


module adaptereddoubleplanter() {

         
union() {    
doubleplanter();
               translate([0, 0, -overlap])
adapter();

}
}


module dieb() {
    
   difference() {
    
    
        translate([0, 0, planterhight+(overlap/2)-plantthick]){

difference() {
 cylinder(  (overlap*2),((outerpipe)/2),diebloch);
        translate([0, 0, -plantthick])
 cylinder(  (overlap*2),((outerpipe-plantthick)/2),diebloch);
    
     cylinder(  (planterhight),r=diebloch);
    
}
}

translate([0, 0, planterhight+(overlap*2)+1])
overlap ();

}
}


module diebhole() {
     cylinder(  (plantthick*2)+1,r=1*topholesscale);
}

module thiefhole() {
    
  if (planterhight<45) 
 {
    
    translate([0,0,planterhight+(overlap/2)+1*topholesscale]) {
    
    
    rotate([30,90,0]) { 
    translate([0,0,(outerpipe/2)-(plantthick+0.5)])
     diebhole();
    }
    
        rotate([-30,90,0]) { 
    translate([0,0,(outerpipe/2)-(plantthick+0.5)])
     diebhole();
    }
}
}

 else 
{
    
    translate([0,0,planterhight+(overlap/2)+1*topholesscale]) {
    
    
    rotate([45,90,0]) { 
    translate([0,0,(outerpipe/2)-(plantthick+0.5)])
     diebhole();
    }
    
        rotate([-45,90,0]) { 
    translate([0,0,(outerpipe/2)-(plantthick+0.5)])
     diebhole();
    }
}



}
}
module hole() {
  translate([(outerpipe/2), 0, overlap+(bottomsphererad+plantthick)])
sphere(holescale*(bottomsphererad-(plantthick)), $fn=8);  
}
module mouth() {
 
  
  
  difference() {    
    intersection() {

hull() {
translate([(outerpipe/2), 0, overlap+(bottomsphererad+plantthick)])
sphere(bottomsphererad+0.25, $fn=36);

translate([(outerpipe/2), 0, planterhight+(2*overlap)-6])
cylinder(h=6,r=topcirclerad+0.25);
}
rotate([90,0,90])
 translate([0, planterhight+(2*overlap)-6-3, (outerpipe/1.5)+(2*plantthick)])
      linear_extrude(height = outerpipe*2) {
text(size=outerpipe/12,"SYSGRO7",halign="center");
   }
   
   
   
   }
   hull() {
translate([(outerpipe/2), 0, overlap+(bottomsphererad+plantthick)])
sphere(bottomsphererad-(plantthick), $fn=36);

translate([(outerpipe/2), 0, planterhight+(2*overlap)-6])
cylinder(h=6,r=topcirclerad-(plantthick));
}
   }
   
   
   
    
 difference() {        
    
hull() {
translate([(outerpipe/2), 0, overlap+(bottomsphererad+plantthick)])
sphere(bottomsphererad, $fn=36);

translate([(outerpipe/2), 0, planterhight+(2*overlap)-6])
cylinder(h=6,r=topcirclerad);
}
hull() {
translate([(outerpipe/2), 0, overlap+(bottomsphererad+plantthick)])
sphere(bottomsphererad-(plantthick), $fn=25);

translate([(outerpipe/2), 0, planterhight+(2*overlap)-6])
cylinder(h=6+2,r=topcirclerad-(plantthick));
}
      difference() {  
        translate([0, 0,1+planterhight+(overlap)])
          overlap();
             }
             
             
             
                   difference() {  
        innerpipe();
             }
}

}

module overlap() {
    translate([0, 0, -1])
        linear_extrude(height = (overlap+1))
 circle($fa =3,d=outerpipe);
}


module basebody() {
    
    union(){
    
      difference() {
        linear_extrude(height = planterhight+(2*overlap))
 circle(d=outerpipe+(2*plantthick));
          
          overlap();
       difference() {      
        translate([0, 0,1+planterhight+(overlap)])
                    overlap();    
         }
                 difference() {  
                innerpipe(); 
      }
            difference() {
                thiefhole();
            }
             
             }
            
     dieb();
     
         }        
}

module doublebasebody() {
    

    
      difference() {

    union(){
    
      difference() {
        linear_extrude(height = planterhight+(2*overlap))
 circle(d=outerpipe+(2*plantthick));
          
          overlap();
       difference() {      
        translate([0, 0,1+planterhight+(overlap)])
                    overlap();    
         }
                 difference() {  
                innerpipe(); 
      }
            difference() {
                thiefhole();
            }
             
             }
            
     dieb();
     
         }  
            
 mirror([1,0,0]) thiefhole();    thiefhole();
     
      }               
}


module innerpipe() {
    translate([0, 0, -1-overlap])
        linear_extrude(height = pipelen+2)
 circle($fa =3 ,d=outerpipe-(2*pipethick));
}

module adapter() {
difference() {
         linear_extrude(height = (2*overlap))
 circle($fa =3 ,d=outerpipe-tol);
    
           translate([0, 0, -1])
        linear_extrude(height = pipelen+2)
 circle($fa =3 ,d=outerpipe-tol-(2*adapterwall));
    
    }

 
}
module pipe() {
    color("gray")
difference() {
         linear_extrude(height = pipelen)
 circle($fa =3 ,d=outerpipe);
        innerpipe();
    
    }

}
