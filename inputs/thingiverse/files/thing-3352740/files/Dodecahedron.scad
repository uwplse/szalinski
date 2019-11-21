/* [Dimensions] */
// Length of the edges[mm]
edge_length = 20;

// Height of the outer surfaces [mm]
height = 1.2;

// Height of the Text
textsize = 8;    

// Depth of indentation of the text [mm]
textheight = 0.2;

// Extra clearance between faces [mm]
clearance  = 0.1;

/* [Labels] */
// text1 is opposite to text7, text2 to text8 ...
text1 = "1";
text2 = "5";
text3 = "11";
text4 = "3";
text5 = "9.";
text6 = "7";
text7 = "12";
text8 = "8";
text9 = "2";
text10 = "10";
text11 = "4";
text12 = "6.";


size = edge_length;


part = "Base"; // ["Base":Create only Cube, "Text": Create only the text, "Both":Create both]


/* [Hidden] */
numbers = [str(text1), str(text2), str(text3), str(text4), str(text5), str(text6), str(text7), str(text8), str(text9), str(text10), str(text11), str(text12)];

// creates a multiline Text from array
module textlines(text, textsize=10, lineheight=1.2, halign="left", valign="baseline") {
    text(text, size = textsize, halign=halign, valign=valign);
}

    

module pentagon_extruded_base(size, h, fillet=0, baseheight=0.2,num=1, i=0, textsize=10, textheight=0.2, clearance=0.1)
    {
    scale = 1 - fillet / size;    
    
    difference(){
        union()
            {
            translate([0,0,baseheight])linear_extrude(h, scale=scale)circle(r=size*0.8507-clearance, $fn=5);
            linear_extrude(baseheight)
                circle(r=size*0.8507, $fn=5);  
            }
        
        linear_extrude(textheight)
            rotate([0,0,54+72*i])scale([-1, 1, 1])
                textlines(numbers[num-1], halign="center", valign="center", textsize=textsize);  
        }
    } 


module pentagon_extruded_inner(size, h, fillet=0, textheight=0.2, num=1, i=0, textsize=10, clearance=0.1)
    {
    linear_extrude(textheight)
    rotate([0,0,54+72*i])scale([-1, 1, 1])
        textlines(numbers[num-1], halign="center", valign="center", textsize=textsize);  
    } 


module pentagon_6(side, h, fillet=0, num=1, textsize=10, textheight=0.2, clearance=0.1)
    {
    innerr = 0.6881 * side;
    innerd = 2 * innerr;
    pentagon_extruded_base(side, h, fillet=fillet, num=num*6-5, textsize=textsize, textheight=textheight, clearance=clearance);

    for (i=[0:4])
        {
        alpha = 36+72*i;
        translate([cos(alpha)*innerd, -sin(alpha)*innerd,0])rotate([0,0,180])
            pentagon_extruded_base(side, h, fillet=fillet, num=num*6-4+i, i=i, textsize=textsize, textheight=textheight, clearance=clearance);
        }
    }
    
    
module pentagon_6_inner(side, h, fillet=0, num=1, textsize=10, textheight=0.2, clearance=0.1)
    {
    innerr = 0.6881 * side;
    innerd = 2 * innerr;
    pentagon_extruded_inner(side, h, fillet=fillet, num=num*6-5, textheight=textheight, textsize=textsize, clearance=clearance);

    for (i=[0:4])
        {
        alpha = 36+72*i;
        translate([cos(alpha)*innerd, -sin(alpha)*innerd,0])
            rotate([0,0,180])pentagon_extruded_inner(side, h, fillet=fillet, num=num*6-4+i, i=i, textheight=textheight, textsize=textsize, clearance=clearance);
        }
    }    


angle = 2 * asin(sqrt((5+sqrt(5))/10)); // dihedral angle
    
fillet = height * tan(90 - angle/2);


// base
if (part == "Base" || part == "Both")
    {
    pentagon_6(size, height, fillet=fillet, num=1, textsize=textsize, textheight=textheight, clearance=clearance);
    translate([-0.425181*size, -3.926752*size, 0])rotate([0,0,180])     pentagon_6(size, height, fillet=fillet, num=2, textsize=textsize, textheight=textheight, clearance=clearance);
    }

// numbers    
if (part == "Text" || part == "Both")
    {
    pentagon_6_inner(size, height, fillet=fillet, num=1, textsize=textsize, textheight=textheight, clearance=clearance);
    translate([-0.425181*size, -3.926752*size, 0])rotate([0,0,180]) pentagon_6_inner(size, height, fillet=fillet, num=2, textsize=textsize, textheight=textheight, clearance=clearance);
    }

    
