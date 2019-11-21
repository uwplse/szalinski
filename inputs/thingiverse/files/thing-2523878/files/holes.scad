/* [Your Text Settings] */
textInput ="Sample";
textSize = 30;//[1:60]
textSpacing = 1;
textHeight = 5;//[2:15]
textFont = "oswald";//[indie flower,noto serif, anton, lobster, abril fatface, gloria hallelujah, acme, baloo tammudu, Sedgwick Ave Display, Playfair Display SC] 

$fn=150;
difference(){
union(){rotate ([180,0,180]){{translate ([-14,-45,0])
    mirror([90,0,0]) rotate ([0,0,90])
    linear_extrude(height=textHeight, center=true)   
    {
        text(textInput,textSize,textFont,spacing=textSpacing);
    }
}
translate ([0,75,8]) scale([1.0,1.5,1.0]) cylinder
   (7,100,100);translate ([0,75,0])scale([1.0,1.5,1.0]) cylinder
   (8,90,100);}
}
union (){translate ([0,20,-25]){;cylinder (20,10,10);}

translate ([0,160,-25]){;cylinder (20,10,10);}
}
}