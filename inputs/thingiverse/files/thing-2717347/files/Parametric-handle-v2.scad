////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////
/// OpenSCAD File V2.0 by Ken_Applications /////
///            15 - 12 - 2017              /////
////////////////////////////////////////////////
/////Version 2 added show parts=4///////////////
/////which adds flat for easy print/////////////

//... Diameter of tube you intend to use for the pull handle, I also added 0.4mm for shrinkage [Default 15.4] 
diameter_pull_bar=15.4;

//... The clearence diameter for the screw hole [Default 4.5]
screw_dia=4.5;//[2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0,7.5,8.0]


//...  show   [1= 1 part   2= Assembled with section view  3= All  4=Print with flat]
show_parts=4;  // [1,2,3,4]

module the_hole(){
translate([0,0,0]) rotate([0,-0,0]) cylinder(h=handle_centre_line, d1=screw_dia, d2=screw_dia, center=false,$fn=30);

translate([0,0,handle_centre_line-screw_dia]) rotate([0,-0,0]) cylinder(h=screw_dia, d1=0, d2=screw_dia*2, center=false,$fn=30);

translate([0,0,handle_centre_line-0.5]) rotate([0,-0,0]) cylinder(h=screw_dia*6, d1=screw_dia*2, d2=screw_dia*2, center=false,$fn=30);

}




////// calculations  /////////
$fn=100;
handle_centre_line=(diameter_pull_bar/2)+20;
Move_height=handle_centre_line-diameter_pull_bar;
move_bit=16*tan(30);
//////////////////////////////
//echo(move_bit);

$vpt = [-3,14,12];
$vpr = [70, 0, 28];    
$vpd = [192];
    





module top(){
translate([0,-diameter_pull_bar,Move_height])
intersection(){
linear_extrude(height=diameter_pull_bar*2) translate([0,diameter_pull_bar,0])  circle(r=diameter_pull_bar);
rotate([0,-90,0])
rotate_extrude(angle = 90, convexity = 2)translate([2, 0, 0])
translate([diameter_pull_bar-2,0,0]) circle(r = diameter_pull_bar);
}
}


module top2(){
difference(){    
 top();   
translate([0,0,diameter_pull_bar+Move_height]) rotate([90,0,0]) cylinder(h=100, d1=diameter_pull_bar, d2=diameter_pull_bar, center=false,$fn=30);
}    
    
}

module all_without_hole(){
    union(){
top2();    
linear_extrude(height=Move_height+0) projection(cut = false) top2();
        //make model watertight
 translate([0,0,Move_height]) cylinder(h=2, r1=diameter_pull_bar+.001, r2=diameter_pull_bar+.01, center=false);

    }
}

module all (){
difference(){
all_without_hole ();
translate([0,-(move_bit/2),-8]) rotate([0,30,90]) the_hole();
}

}

module section(){
    difference(){
        all();
        translate([0,-50,-1]) rotate([0,0,90]) cube([100,100,100],false);
    }
}


if (show_parts==1){
 rotate([0,0,90])   

    
    
all();
}

if (show_parts==2){

    
 rotate([0,0,90]) section();   
  translate([100,0,0]) rotate([0,0,-90]) all(); 
   
   translate([0,0,diameter_pull_bar+Move_height]) rotate([0,90,0]) cylinder(h=100, d1=diameter_pull_bar, d2=diameter_pull_bar, center=false,$fn=30);
 
    
}    
    



if (show_parts==3){

    
 rotate([0,0,90]) all();   
  translate([100,0,0]) rotate([0,0,-90]) all(); 
   
   translate([0,0,diameter_pull_bar+Move_height]) rotate([0,90,0]) cylinder(h=100, d1=diameter_pull_bar, d2=diameter_pull_bar, center=false,$fn=30);
 
    
}    






module pro_j (){
projection(cut = false) 
rotate([90,0,0]) translate([0,100,0])all();
}


module part_with_flat (){
hull(){
linear_extrude(height=2) pro_j();
rotate([90,0,0]) translate([0,diameter_pull_bar,0])all();
}
}

module new_body(){
rotate([-90,0,90]) translate([0,0,-diameter_pull_bar])part_with_flat();
}

module finished_part (){
difference(){
new_body();
translate([(move_bit/2),-0,-8]) rotate([0,30,180]) the_hole();
translate([0,0,diameter_pull_bar+Move_height]) rotate([0,90,0]) cylinder(h=100, d1=diameter_pull_bar, d2=diameter_pull_bar, center=false,$fn=30);
}
}


module for_print(){
rotate([0,90,0])
finished_part();
}




if (show_parts==4){

translate([0,0,diameter_pull_bar]) for_print();
}




