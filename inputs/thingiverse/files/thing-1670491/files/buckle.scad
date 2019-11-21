//length (x axis)
length=60;

//width  (y axis)
width=40; 

//height (z axis) "thickness"
height=6;

//height of lip(z axis) 
lip_height=3;

//width of lip
lip_thickness=2;

//corner roundedness
rounded=5;

//resolution (shows in rounded corners
$fn=300; //[100,300,500]

strap_bar = "yes";  //[yes, no]

difference(){
  translate([.5*rounded, .5*rounded])minkowski(){
    cube([length-(rounded), width-(rounded), height+lip_height]);    
    cylinder(d=rounded);
  }
  translate([.5*rounded+lip_thickness, .5*rounded+lip_thickness, height])minkowski(){
    cube([length-(rounded)-(2*lip_thickness), width-(rounded)-(2*lip_thickness), height+lip_height]);    
    cylinder(d=rounded);
  }
}


if(strap_bar == "yes"){
  difference(){
    translate([rounded-10, rounded])minkowski(){
      cube([length-(2*rounded)+20, width-(2*rounded), 2]);    
       cylinder(r=rounded, h=2);
    }
    translate([rounded-6, rounded+4,-.5])minkowski(){
      cube([length-(2*rounded)+12,width-(2*rounded)-8, 2]);    
      cylinder(r=rounded, h=3);
    }
  }
}