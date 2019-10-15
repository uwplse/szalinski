//#import("lipo-protector.stl");

//size of battery
width=35;
length=75;


//base plate
difference(){
hull(){
translate([(length/2)-6.5,width/2-1.25,0])  cylinder(2.5,6.5,6.5);
translate([(-length/2)+6.5,width/2-1.25,0]) cylinder(2.5,6.5,6.5);
translate([(length/2)-6.5,-width/2+1.25,0]) cylinder(2.5,6.5,6.5);
translate([(-length/2)+6.5,-width/2+1.25,0]) cylinder(2.5,6.5,6.5); 
}
//grub holes
translate([(length/2)-6.5,width/2-1.25,-10]) cylinder(20,2,2);  
translate([(-length/2)+6.5,width/2-1.25,-10]) cylinder(20,2,2); 
translate([(length/2)-6.5,-width/2+1.25,-10]) cylinder(20,2,2);
translate([(-length/2)+6.5,-width/2+1.25,-10]) cylinder(20,2,2);

//strap holes
hull(){
translate([10,width/2+2,-0.1]) cylinder(10,1.5,1.5);
translate([-10,width/2+2,-0.1]) cylinder(10,1.5,1.5);
}
hull(){
translate([10,-width/2-2,-0.1]) cylinder(10,1.5,1.5);
translate([-10,-width/2-2,-0.1]) cylinder(10,1.5,1.5);
}



//outer cuts - /weight saving
if (length >=80){
    hull(){
    translate([(((10/2)+2 + length/2)-6.5)/2,-width/2-4,-0.1]) cylinder(10,6,6);
    translate([(((10/2)+2 + length/2)-6.5)/2,-width/2-10,-0.1]) cylinder(10,9,9);
    }
    hull(){
    translate([(((10/2)+2 + length/2)-6.5)/2,width/2+4,-0.1]) cylinder(10,6,6);
    translate([(((10/2)+2 + length/2)-6.5)/2,width/2+10,-0.1]) cylinder(10,9,9);
    }
    hull(){
    translate([-(((10/2)+2 + length/2)-6.5)/2,-width/2-4,-0.1]) cylinder(10,6,6);
    translate([-(((10/2)+2 + length/2)-6.5)/2,-width/2-10,-0.1]) cylinder(10,9,9);
    }
    hull(){
    translate([-(((10/2)+2 + length/2)-6.5)/2,width/2+4,-0.1]) cylinder(10,6,6);
    translate([-(((10/2)+2 + length/2)-6.5)/2,width/2+10,-0.1]) cylinder(10,9,9);
    }
}

if (width >=30){
hull(){
translate([length/2,0,-0.1]) cylinder(10,8,8);
translate([length/2+10,0,-0.1]) cylinder(10,12,12);
}
hull(){
translate([-length/2,0,-0.1]) cylinder(10,8,8);
translate([-length/2-10,0,-0.1]) cylinder(10,12,12);
}
}

//inner cuts - weight saving
if (width >=30 && length >=65){
translate([(((10/2)+2 + length/2)-6.5)/2,0,-0.1]) cylinder(10,6,6);
translate([-(((10/2)+2 + length/2)-6.5)/2,0,-0.1]) cylinder(10,6,6);
}

if (width >=30 && length >=50){
translate([0,0,-0.1]) cylinder(10,8,8);
} else {
translate([0,0,-0.1]) cylinder(10,6,6);    
}    

}






//grubs & holes
difference(){
translate([(length/2)-6.5,width/2-1.25,2.5]) sphere(6.5);
translate([(length/2)-6.5,width/2-1.25,-10]) cylinder(10,6.5,6.5);
translate([(length/2)-6.5,width/2-1.25,-10]) cylinder(20,2,2);    
}
difference(){
translate([(-length/2)+6.5,width/2-1.25,2.5]) sphere(6.5);
translate([(-length/2)+6.5,width/2-1.25,-10]) cylinder(10,6.5,6.5);
translate([(-length/2)+6.5,width/2-1.25,-10]) cylinder(20,2,2);   
} 
difference(){
translate([(length/2)-6.5,-width/2+1.25,2.5]) sphere(6.5);
translate([(length/2)-6.5,-width/2+1.25,-10]) cylinder(10,6.5,6.5);
translate([(length/2)-6.5,-width/2+1.25,-10]) cylinder(20,2,2); 
}
difference(){
translate([(-length/2)+6.5,-width/2+1.25,2.5]) sphere(6.5);
translate([(-length/2)+6.5,-width/2+1.25,-10]) cylinder(10,6.5,6.5);   
translate([(-length/2)+6.5,-width/2+1.25,-10]) cylinder(20,2,2); 
}    