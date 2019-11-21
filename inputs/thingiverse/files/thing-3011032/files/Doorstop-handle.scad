//Body height (mm).
Body_height = 15;
//Diameter for the door handle hole (mm).
Hole_diameter = 22;
//Length of body (mm). Measured from the center of the hole.
Body_length = 25;
//Radius of the corners (mm).
Fillet_radius = 3;
//Material thickness (mm).
Thickness = 3;
//Width of the body (mm).
Body_width = Hole_diameter+Thickness;
$fn=50;

difference(){ //Cutting out the hole and Fillet_radiuss  
union(){     
    //The main body, circle and a rectangle.
    cylinder(h=Body_height,d=Body_width);
        translate([0,-(Body_width)/2],0) cube([          Body_length,Hole_diameter+Thickness,Body_height]);
    }
//The hole
#cylinder(h=Body_height,d=Hole_diameter,center=false); 

//Creating radius 1
intersection(){     //Isolate the cutting shape for the corner
difference(){   //Create the shape of the corner
    translate([Body_length-(Fillet_radius*2),-Body_width/2,0])    cube([Fillet_radius*2,Fillet_radius*2,Body_height]);    
    translate([Body_length-Fillet_radius,-(Body_width/2)+Fillet_radius,0])    cylinder(h=Body_height,r=Fillet_radius);    
}
        translate([Body_length-Fillet_radius,-Body_width/2,0      ])    cube([Fillet_radius,Fillet_radius,Body_height]);
}
//Creating radius 2
intersection(){     //Isolate the cutting shape for the corner
difference(){   //Create the shape of the corner
translate([Body_length-(Fillet_radius*2),(Body_width/2)-Fillet_radius*2,0])    cube([Fillet_radius*2,Fillet_radius*2,Body_height]);    
    translate([Body_length-Fillet_radius,(Body_width/2)-Fillet_radius,0])    cylinder(h=Body_height,r=Fillet_radius);    
}
translate([Body_length-Fillet_radius,(Body_width/2)-Fillet_radius,0])    cube([Fillet_radius,Fillet_radius,Body_height]);
}
}