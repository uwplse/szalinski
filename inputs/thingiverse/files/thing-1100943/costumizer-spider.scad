//BEGIN CUSTOMIZER
//quality of spider
Render_Quality = 30; //[30:50]
//hieght of model 
Project_size = 25; //[25:50]
Parts_to_render = 1; //[1:no_supports, 2:supports(printable)]
//END CUSTOMIZER
$fn= Render_Quality;

scale([Project_size/25, Project_size/25, Project_size/25]){
if (Parts_to_render==1){
  difference(){
      union(){
        head();
        body();
        all_legs();
      }
      translate([0,-76,-4])
            cube([100,150,5]);
  }
}
if (Parts_to_render==2){
  difference(){
    union(){
        head();
        body();
        all_legs();
        all_supports();
    }
        translate([0,-10,-4])
            cube([100,100,5]);
    }
  }
 }
module all_supports(){
    //supports
        union(){
            translate([48,-3,0])
                cube([4,2,2.65]);
            translate([50,4,0])
                cylinder(h=3.02,r1=3,r2=1);
            translate([48,-5.5,0])
                cube([4,2,4.6]);
            }  
        union(){
            translate([27,1.5,.9])
                support();
            translate([21,13,.9])
                support();
            translate([21,26,.9])
                support();
            translate([25,40,.9])
                support();
            translate([73,2.5,.9])
                support();
            translate([78,13,.9])
                support();
            translate([79,26,.9])
                support();
            translate([74,40,.9])
                support();
            
        }
    }
module all_legs(){
    //legs
            translate([64,34,0])
               rotate([0,0,210])
                    leg();
            translate([67,26,0])
               rotate([0,0,180])
                    leg();
            translate([67,17,0])
               rotate([0,0,160])
                    leg();
            translate([64,10,0])
               rotate([0,0,140]) 
                    leg ();
            translate([35,34,0])
               rotate([0,0,330])
                    leg();
            translate([32.5,26,0])
               rotate([0,0,0])
                    leg();
            translate([32.5,17,0])
               rotate([0,0,20])
                    leg();
            translate([35.5,10,0])
               rotate([0,0,45]) 
                    leg ();
        }   
module leg(){
   translate([8,0,7])
    rotate([0,320,0])
        cylinder(r=2.2, h=15);
    translate([-2.5, 0, 19])
        sphere(r=2.6);
    translate([-10, 0, 12])
        rotate([0,45,0])
            cylinder(r=2.2, h=10);
     translate([-10,0,12])   
        sphere(r=2.5);
     rotate([0,10,0])
        translate([-12,0,-.5])  
            cylinder(r1=2.5, r2=2.2, h=9.5);
     translate([-11.9,0,1.5])
         sphere(r=3);
}   

module support(){
    cylinder(h=1.1, r=5);
}
module head(){
    //head
            translate([50,4,7])
                scale([6,6,4])
                    sphere(r=1);
    //eyes
            translate([49,-1,9])
                sphere(r=.5);
            translate([51,-1,9])
                sphere(r=.5);  
    //mouth
            translate([49,-3,5.5])
                rotate([200,0,0])
                    cylinder(h=3,r1=1,r2=.2);
            translate([51,-3,5.5])
                rotate([200,0,0])
                    cylinder(h=3,r1=1,r2=.2);
        minkowski(){
            sphere(r=1);
            union(){
                translate([48.5,-3,5.5])
                    cube([1,3,1]);
                translate([50.5,-3,5.5])
                    cube([1,3,1]);
            }
        }
    }
module body(){
     //body
             translate([50,22,7.5])
                   scale([4,5,2.5])
                        sphere(r=3);
}