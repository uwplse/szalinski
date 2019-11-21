
module spheres()
{
  

    module duplicate(xpos, ypos ,obj)
    {
        // draw object		
        translate([ypos*50,xpos*50,0])
            sphere(r=20,h=0.75,$fa=3, $fs=0.05,center=true);
        //echo("Rending sphere");

        xpos=xpos+1;

        if ( xpos <= lvls ){
            duplicate(xpos,ypos);
        }
    }
    
    lvls=5;
    xpos = 1;

    duplicate(xpos,0);
    duplicate(xpos,1);
    duplicate(xpos,2);
    duplicate(xpos,3);
    duplicate(xpos,4);
    
}

module base()
{
     translate([-100,-200,0])
     difference(){
    
       translate([-25,75,-20])
        cube([250,250,20], center=false);
         spheres();
     }
}

module main()
{
       scale(0.6,0.6,0.6)
    union(){
    difference(){
   // difference(){
    base();
      /*  translate([0,0,-4])
        scale([1.001,1.001,1.001])
            base();
   }*/
   
      translate([75,75,-1])
    cylinder(r=8,h=4,center=true);
    translate([-75,-75,-1])
    cylinder(r=8,h=4,center=true);
   translate([75,-75,-1])
    cylinder(r=8,h=4,center=true);
   translate([-75,75,-1])
    cylinder(r=8,h=4,center=true);
   }
   
  
   translate([0,0,-50])
   difference(){
     translate([0,0,50])
        cube([256,256,10], center=true);
   translate([0,0,50])
        cube([250,250,15], center=true);
   }
   }
}

main();
