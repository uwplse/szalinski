// Which one would you like to see?
part = "all"; // [first:External piece,second:Internal piece,all:Both]
/* [Dimensions */
width = 20;
height = 10;
length = 30;

module color1(){
    difference(){
        cube([width,length,height],center=true);
        rotate([45,0,0]) cube([width,length,height],center=true);
    }
}
module color2(){
    intersection(){
        cube([width,length,height],center=true);
        rotate([45,0,0]) cube([width,length,height],center=true);
    }
}
print_part();

module print_part(){
    if(part=="first"){
       color1(); 
    }
    else if(part=="second"){
        color2();
    }
    else if(part=="all"){
        color1(); 
        color2();
    }
} 


