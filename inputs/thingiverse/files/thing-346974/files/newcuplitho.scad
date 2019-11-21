height_picture = 3; // [1:5]
  
Cylinder_radius= 50+0;

Cup_Radius=22.5;//in mm

Top_Minimum_Thickness=2.5;
Wall_Thickness=2.5;
Wall_Height=10;
Rc=Cup_Radius+Wall_Thickness;
Base_Incut=1.25;
Base_Thickness=2.5;
Base_Radius=Cup_Radius+Base_Incut;


// Load a 100x100 pixel image. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
image_file = "image-surface.dat"; // [image_surface:100x100] 
 
union (){

difference(){
cylinder(Wall_Height+Base_Thickness,Rc,Rc);
translate([0,0,-1])cylinder(Wall_Height+2+Base_Thickness,Base_Radius,Base_Radius);
}

difference(){
translate([0,0,-Top_Minimum_Thickness])cylinder(Wall_Height+Top_Minimum_Thickness,Rc,Rc);
translate([0,0,-1-Top_Minimum_Thickness])cylinder(Wall_Height+2+Top_Minimum_Thickness,Cup_Radius,Cup_Radius);
}

translate([0,0,0-Top_Minimum_Thickness])cylinder(Top_Minimum_Thickness,Rc,Rc);

scale([Cup_Radius/50,Cup_Radius/50,1]) intersection(){
translate([0,0,0-Top_Minimum_Thickness])cylinder(height_picture+Top_Minimum_Thickness+1,Cylinder_radius,Cylinder_radius);

scale([1,1,height_picture]) surface(file=image_file, center=true, convexity=5);
//};

}

}
