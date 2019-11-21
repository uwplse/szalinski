//Change "Name here" to anything you want, mess around with the font, the sizes, etc.. 

// Variables
F_Type = "Book Antiqua:style=Italic"; // Look in 'help' for fonts
F_Size = 8;
Name_1 = "Name 1 here"; //Name on top
Name_2 = "Name 2 here"; //Name on bottom
Color_1 = "black";
Color_2 = "white";

// The works
union(){
color(Color_1)
    cube([87,F_Size*3.5,3]);  // Change the length to fit the names
}       
color(Color_2){
    linear_extrude(height=5)translate([5,F_Size*2])
        text(Name_1,font=F_Type,size=F_Size); 
    linear_extrude(height=5)translate([5,F_Size/2])
        text(Name_2,font=F_Type,size=F_Size); 
}