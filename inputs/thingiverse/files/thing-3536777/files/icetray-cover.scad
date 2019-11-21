
module spheres()
{
  

    module duplicate(xpos, ypos ,obj)
    {
        // draw object		
        translate([ypos*50,xpos*50,0])
            sphere(r=20,h=0.75,$fa=3, $fs=0.05,center=true);
       // echo("Rending sphere");

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

module cylinders()
{
  

    module duplicate(xpos, ypos ,obj)
    {
        // draw object		
        translate([ypos*50,xpos*50,0])
           cylinder(r=5,h=55,center=true);
       // echo("Rending sphere");

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
        difference(){

        translate([-25,75,-20])
            cube([250,250,20], center=false);
                spheres();
        }
        
        translate([0,0,-20])
            cylinders();
    }
}

module extrudes()
{
    cylanders();
}

module main()
{
       scale([0.6,0.6,0.6])
    union(){
   // difference(){
    //difference(){
    base();
    /*    translate([0,0,-2])
        scale([1.001,1.001,1.001])
            base();
   }
   translate([0,0,-45])
    cube([250,250,50], center=true);
   }*/
   
   translate([75,75,0])
    cylinder(r=8,h=4,center=true);
    translate([-75,-75,0])
    cylinder(r=8,h=4,center=true);
   translate([75,-75,0])
    cylinder(r=8,h=4,center=true);
   translate([-75,75,0])
    cylinder(r=8,h=4,center=true);
    }
}

main();
