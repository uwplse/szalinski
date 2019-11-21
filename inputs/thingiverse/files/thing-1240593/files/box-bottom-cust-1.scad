
/* [Configurations] */
Object_Height = 90;
Object_Width = 45;
Object_Depth = 115;
Wall_Thickness = 3;// 5mm is good enough
Cover_Height = 25;

/* [hidden] */
$fn = 50;
Tolerance = 0.1;
Cover_Spacing = 0.5;
Rounded_Corner = 5;


caixa();


module caixa(){
    difference(){
    roundedcube(Object_Width + Tolerance + (Wall_Thickness * 2), Object_Depth + Tolerance + (Wall_Thickness * 2), Object_Height + Tolerance + Wall_Thickness, Rounded_Corner,Rounded_Corner,Rounded_Corner,Rounded_Corner);
    translate([Wall_Thickness, Wall_Thickness, Wall_Thickness]) cube([Object_Width + Tolerance, Object_Depth + Tolerance, Object_Height + Tolerance + 1]);
    // Recorte da tampa
    translate([0,-0,(Object_Height + 1) - Cover_Height + (Wall_Thickness * 2)]) tampa(Cover_Spacing);    
    }
    
}

module simbolo(rotation){
    union()
	{
		rotate([90,0,rotation]) resize([larguraLogo,alturaLogo,profundidadeLogo]) import("logo.stl");
	}
}

module tampa(folga){
    difference(){
    translate([-folga/2,-folga/2,0]) roundedcube(Object_Width + Tolerance + (Wall_Thickness * 2) + folga, Object_Depth + Tolerance + (Wall_Thickness * 2) + folga, Cover_Height, Rounded_Corner,Rounded_Corner,Rounded_Corner,Rounded_Corner);
    translate([(Wall_Thickness + folga)/2, (Wall_Thickness + folga) /2, -Wall_Thickness]) roundedcube(Object_Width + Tolerance + Wall_Thickness - folga, Object_Depth + Tolerance +Wall_Thickness - folga, Cover_Height , Rounded_Corner, Rounded_Corner, Rounded_Corner, Rounded_Corner);
    }
}

module cartas(){
#cube([Object_Width, Object_Depth, Object_Height]);
}

module roundedcube(xdim ,ydim ,zdim,rdim1, rdim2, rdim3, rdim4){
    hull(){
        translate([rdim1,rdim1,0]) cylinder(r=rdim1, h=zdim);
        translate([xdim-rdim2,rdim2,0]) cylinder(r=rdim2, h=zdim);

        translate([rdim3,ydim-rdim3,0]) cylinder(r=rdim3, h=zdim);
        translate([xdim-rdim4,ydim-rdim4,0]) cylinder(r=rdim4, h=zdim);
    }
}

