///////////////////////////////////

// Customizable Grid of Towers


///////////////////////////////////

// Width of grid
w=5;
// Length of grid
l=5;

// X width of tower
x=10;
// Y length of tower
y=10;
// Height of tower (see below)
z=1;

// Minimum tower height as a multiple of cell height, so 40 will be minimum 5 times the height of cell.
mn=5;

// Maximum tower height as a multiple of cell height, so 40 will be maximum 40 times the height of cell.
mx=40;




//////////////////////////////////




/////////////////////////////////////////////////////

module row(c){
    for(a =[0:w-1]){
        clr1=rands(-1,2,w);
        clr2=rands(-1,2,w);
        clr3=rands(-1,2,w);
        translate([a*x,0,0]) scale([x,y,z*c[a]]) color([clr1[a],clr2[a],clr3[a]]) cube(1);
    
    }
}
module grid(){
    for(b =[0:1:l-1]){
            h=rands(mn,mx,w*l);
            translate([0,b*y,0]) row(h);
        
    }   
}
//minkowski(){
    grid();
   // sphere(1);
//}











/////////////////////////////////////////////////////