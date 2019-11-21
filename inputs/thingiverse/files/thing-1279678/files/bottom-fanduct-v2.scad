/*[Fan Duct]*/
//Print right duct?
right_side = 1;	  //[1:yes,0:no]
//Print left duct?
left_side  = 1;   //[1:yes,0:no]
//Print guard?
guard      = 1;   //[1:yes,0:no]
//How to Print?
print_in_one = 1;   //[1:InOne,0:Seperate]

/*[Hidden]*/
$fa = 5;
$fn = 360 / $fa; 

module base()
{
  union()
  {
    difference()
    {
      hull() {
        translate([8,8])
          cylinder(h= 5, d=7);
        
        cylinder(h= 5, d=7);
      }
      
      cylinder(h= 5.0, d=3.5);
    }

    hull() {
      translate([8,8])
        cylinder(h= 5, d=7);
      
      translate([82,8])
        cylinder(h= 5, d=7);
    }

    difference()
    {
      hull() {
        translate([82,8])
          cylinder(h= 5, d=7);
        
        translate([90,0])
          cylinder(h= 5, d=7);
      }
      
      translate([90,0])
        cylinder(h= 5, d=3.5);
    }

    difference()
    {
      union () {
        hull() {
          translate([17.5,25])
            cylinder(h=3, d =10);

          translate([72.5,25])
            cylinder(h=3, d =10);
        }

        hull() {
          translate([17.5,25])
            cylinder(h=3, d =10);

          translate([17.5,10])
            cylinder(h=3, d =10);
        }

        hull() {
          translate([72.5,10])
            cylinder(h=3, d =10);

          translate([72.5,25])
            cylinder(h=3, d =10);
        }
      }
       
      translate([37.5,25-1.75,2])
        cube([35,3.5,1.05]);
      
      translate([37.5,25])
        cylinder(h=5, d =3.5);

      translate([72.5,25])
        cylinder(h= 5, d=3.5);
      
      translate([70,22.5,2])
        cube([5,5,1.51]);
    }

    translate([25,27,3])
    {
      // stuetzen
      if (left_side)
      {
        translate([-3.5,-22.5,2])
          cube([7,7,14]);
      }
      
      if (right_side)
      {
        translate([-3.5+40,-22.5,2])
          cube([7,7,14]);
      }
    }
  }
}

module duct(hollow)
{
  translate([25,27,3])  //translate([5,32,0])
  union() {
    difference()
    {
      union() {
        
        /*
        // fan
        translate([2,0,2]) minkowski()
        {
          cube([36,2,36]);
          
          rotate([-90,0,0])
            cylinder(d=4,h=1);
        }
        */
        
        hull()
        {
          cube([40,3,3]);
          
          translate([2,0,38])
            rotate([-90,0,0])
              cylinder(d=4, h=3);

          translate([38,0,38])
            rotate([-90,0,0])
              cylinder(d=4, h=3);
        }
        
        if (left_side)
        {
          // links
          hull(){
            hull() {
              translate([5,-25,20])
                rotate([-90,0,0])
                  cylinder(h=3, d = 15);
                  
              translate([-5,-25,20])
                rotate([-90,0,0])
                  cylinder(h=8, d = 15);
            }      
            
            translate([20,0,20])
              rotate([-90,0,0])
                cylinder(h=3, d = 40);
          }

          hull() {
            translate([5,-25,20])
              rotate([-90,0,0])
                cylinder(h=5, d = 15);
                
            translate([-5,-25,20])
              rotate([-90,0,0])
                cylinder(h=5, d = 15);
          }        
        }
        
        if (right_side)
        {
          //rechts
          hull(){
            hull() {
              translate([40+5,-25,20])
                rotate([-90,0,0])
                  cylinder(h=8, d = 15);
                  
              translate([40-5,-25,20])
                rotate([-90,0,0])
                  cylinder(h=3, d = 15);
            }      
            
            translate([20,0,20])
              rotate([-90,0,0])
                cylinder(h=3, d = 40);
          }

          hull() {
            translate([40+5,-25,20])
              rotate([-90,0,0])
                cylinder(h=5, d = 15);
                
            translate([40-5,-25,20])
              rotate([-90,0,0])
                cylinder(h=5, d = 15);
          }      
        }
      }

      if (hollow)
      {
        //hohlraum
        union() {
          if (left_side)
          {
            // links
            hull(){
              hull() {
                translate([5,-20,20])
                  rotate([-90,0,0])
                    cylinder(h=3, d = 12);
                    
                translate([-5,-20,20])
                  rotate([-90,0,0])
                    cylinder(h=3, d = 12);
              }      
              
              translate([20,0,20])
                rotate([-90,0,0])
                  cylinder(h=3.1, d = 35);
            }

            hull() {
              translate([5,-25.25,20])
                rotate([-90,0,0])
                  cylinder(h=5.5, d = 12);
                  
              translate([-5,-25.25,20])
                rotate([-90,0,0])
                  cylinder(h=5.5, d = 12);
            }      
          }
            
          if (right_side)
          {
            //rechts
            hull(){
              hull() {
                translate([40+5,-20,20])
                  rotate([-90,0,0])
                    cylinder(h=3, d = 12);
                    
                translate([40-5,-20,20])
                  rotate([-90,0,0])
                    cylinder(h=3, d = 12);
              }      
              
              translate([20,0,20])
                rotate([-90,0,0])
                  cylinder(h=3.1, d = 35);
            }

            hull() {
              translate([40+5,-25.25,20])
                rotate([-90,0,0])
                  cylinder(h=5.5, d = 12);
                  
              translate([40-5,-25.25,20])
                rotate([-90,0,0])
                  cylinder(h=5.5, d = 12);
            }           
          }
        }
      }
        
      if (!right_side && !left_side)  
      {
        translate([-9,3,4])          
          rotate([90,0,0])
           linear_extrude(height = 3, $fn = 100) 
            text("\u263b", 40);
      }
      
      // loecher
      translate([4,-1,4])
        rotate([-90,0,0])
          cylinder(h=5, d =3.5);

      translate([40-4,-1,4])
        rotate([-90,0,0])
          cylinder(h=5, d =3.5);

      translate([4,-1,40-4])
        rotate([-90,0,0])
          cylinder(h=5, d =3.5);

      translate([40-4,-1,40-4])
        rotate([-90,0,0])
          cylinder(h=5, d =3.5);

      // muttern
      translate([4,-5,4])
        rotate([-90,0,0])
          cylinder(h=5, d =7);

      translate([40-4,-5,4])
        rotate([-90,0,0])
          cylinder(h=5, d =7);

      translate([4,-5,40-4])
        rotate([-90,0,0])
          cylinder(h=5, d =7);

      translate([40-4,-5,40-4])
        rotate([-90,0,0])
          cylinder(h=5, d =7);
    }
    
    if (guard) 
    {
      if (left_side)
      {
        // gitter
        for (a =[1:4])
          translate([a*5-13,-25,14])
            cube([0.5,5,12]);
      }
      
      if (right_side)
      {
        for (a =[1:4])
          translate([a*5-13+40,-25,14])
            cube([0.5,5,12]);
      }
    }
  }
}  

difference()
{
  union () 
  {
    difference()
    {
      base();
        duct(false);
    }
    
    if (!print_in_one)
    {
      translate([0,40,30])
        rotate([-90,0,0])
          duct(true);
    } else {
      duct(true);
    }
  }
  
  
  translate([42.5,4,-0.1])
    cube([25,30,1.6]);
  
  /*
  translate([12.49,4,-0.1])
    cube([65.02,30,6]);
  */
  
}