//Customizable Book - to demonstrate basics of OpenSCAD for the Open Source Lab book
// Right now most 3d printers can only print 1 color -- soon you will be able to map the attached image onto this book design.

//Width of book
w=100; 
// Length of book
l=150; 
//Cover thicknes of book
c= 2;  
//Thickness of book
t= 50; 
// Page inset
i=5; 

module book (){
cube([w,l,c]); //book cover
translate([0,i,c])cube([w-i,l-i*2,t]); //pages
translate([0,0,c+t])cube([w,l,c]); //book cover
}

book();