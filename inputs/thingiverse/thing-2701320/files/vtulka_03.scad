  difference()
      { 
     rotate([0,0,0])
       translate([0,0,0])
          //inside cylinder
      cylinder(r=6.15,h=35, $fn=300); 
      
      //малый диаметр
      rotate([0,0,0])
       translate([0,0,-1])
          //inside cylinder
     cylinder(r=5.2,h=37, $fn=300);     
          
          //нижняя обрезка
  //    rotate([0,0,0])
    //   translate([0,0,-0.1])
          //inside cylinder
     // cylinder(r=5.2,h=15.2, $fn=300);   
        
        //верхняя обрезка
   //   rotate([0,0,0])
   //    translate([0,0,19.9])
          //inside cylinder
  //    cylinder(r=5.2,h=15.2, $fn=300);      
          
          
      }