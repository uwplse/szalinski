// The following paramters can be changed in customizer

//Begin Customizer

//Use draft to preview / production to print 
Render_Quality=30; // [30:Draft, 60:Production]

//Approximate size of present with bow tie 
Project_Size=75; // [75:150]

//Choose which parts to render *if the assembled view is printed then the bow tie might droop without modifications*
parts_to_render=5; //[1: Main Present, 2: Main hole of bow tie, 3: Loop of bow tie, 4: 2nd loop of bow tie, 5:Assembled view]

// End Customizer

//
//The following parameters cannot be changed in customizer 

  $fn=Render_Quality; 
  rotate ([0,0,45])   
    scale ([Project_Size/75,Project_Size/75,Project_Size/75]){ 
      if (parts_to_render==1){  // present box 
            box ();
      }
      if (parts_to_render==2) { // main hole of bow tie 
          hole();
      }
      if (parts_to_render==3) { // first loop of bow tie   
         loop1();
      }
      if (parts_to_render==4) { // second loop of bow tie 
          loop2();
      }
      if (parts_to_render==5) { // assembled view
          box();
       rotate ([90,0,0]){
       translate ([0,33,0]){      
          hole();
       }
   }
        rotate([90,-30,0]){
	    translate ([35,22,0]){
                loop1();
        }
    }
    rotate ([90,30,0]){
   translate ([-35,22,0]){
                loop2();
   }
   }
         
      }
  }

    module box () {
          difference(){

	             cube ([50,50,50], center=true); 
	             cube ([35,35,35], center=true);
	                }    
			 // main present hollowed out       
	        
	                translate ([0,0,.4])
	             cube ([51,16,50], center=true );
	                // horziontal tie 
	            
	                translate([0,0,.45])
	            cube ([16,51,50], center=true);             				// vertical tie finish of the box shape
                 
	        
	for (i=[0:2:2])
	     {  
	        for (u=[0:1:2])
	     {
	            translate ([(i*17)-17,25,(u*17)-15])
	            scale ([1,.2,1])
	          sphere(r=4);
	     }
	     } 
	        // side one of the polka dots 
	   for (i=[0:2:2])
	    {  
	        for (u=[0:1:2])
	    {
	            translate ([-25,(i*17)-18,(u*17)-17])
	            scale ([.2,1,1])
	        sphere(r=4);
	    }
	    }
	           // second side of polka dots 
	  for (i=[0:2:2])
	    {  
	        for (u=[0:1:2])
	    {
	            translate ([(i*17)-17,-25,(u*17)-15])
	            scale ([1,.2,1])
	         sphere(r=4);
	    }
	    }
	            //third side of polka dots 
	  for (i=[0:2:2])
	    {  
	        for (u=[0:1:2])
	    {
	            translate ([25,(i*17)-18,(u*17)-17])
	            scale ([.2,1,1])
	        sphere(r=4);
	    }
	    }
	            // fourth side of polka dots
	  for (i=[0:1:1])
	     {  
	        for (u=[0:1:1])
	    {
	            translate ([(i*30)-13,(u*30)-15,25])
	            scale ([1,1,.2])
	         sphere(r=4);
	    }
	    }
    }
	         //polka dots on top of the box 	 		
   module hole(){    
      
              difference (){
	             scale ([.75,.75,.66])
	          sphere (d=20,center=true);
	          cylinder(d=6,h=40, center=true);
	          
         }
	         // circle in the middle with hole for traditional wire hook   
    }
	module loop1() { 
          difference (){  
	            scale([1.4,1.1,1])
	          sphere (d=20,center=true);
	             scale ([1.4,1.1,5])
	         cylinder (h=10, r=5.4, center=true);}        
	  	       // created hollow loop
         }
	     
  module loop2() {
           difference (){
	            scale([1.4,1.1,1])
	         sphere (d=20,center=true);
	            scale ([1.4,1.1,5])
	        cylinder (h=15, r=5.4,center=true); 
	       }
       }
	         //finish of the bow tie 
       
	  