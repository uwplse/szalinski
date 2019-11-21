/* [Global] */
//Custom Ruler 
//Written by Trevor Price <tprice2050@comcast.net>, February 2017
//Creative Commons - Attribution - Non-Commercial 

/*You are free to:

Share — copy and redistribute the material in any medium or format
Adapt — remix, transform, and build upon the material
The licensor cannot revoke these freedoms as long as you follow the license terms.

Under the following terms:

Attribution — You must give appropriate credit, provide a link to the license,and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
NonCommercial — You may not use the material for commercial purposes.

*/

/* [Ruler Dimensions] */
 
//What total ruler dimension do you want? Notes: All of these dimensions are in Inches. Any dimensions of shapes that are not selected do not matter. The recommended width is 2.5 inches. The recommended length is 7 inches.

ruler_width = 2.5;//2.5 //[2:0.5:5.0]
ruler_length = 7;//7 //[4:0.5:12]

/* [Number of Basic Shapes] */
//How many basic shapes do you want? (Does not include rectangles,cube stencils,angle stencils, etc.)
number_of_basicShapes = 0;//[0:Zero,1:One,2:Two,3:Three,4:Four]

/* [Basic Shape 1] */
//What type of shape do you want for your first stencil?
type_of_basicShape_1 = 3 ;//[3:Equilateral Triangle,4:Square,5:Pentagon,6:Hexagon,7:Heptagon,8:Octagon,90:Circle]

//Pick the x and y coordinates of your first shape, and also its size. The size corresponds to each side length of the respective shape, or the diameter if it's a circle. 

basicShape_1_x_position = .5;  //[.5:0.5:4.0]
basicShape_1_y_position = .5;  //[.5:0.5:11.5]
basicShape_1_size = .5;   //[.5:0.5:3]

/* [Basic Shape 2] */
//What type of shape do you want for your second stencil?
type_of_basicShape_2 = 3 ;//[3:Equilateral Triangle,4:Square,5:Pentagon,6:Hexagon,7:Heptagon,8:Octagon,90:Circle]

//Pick the x and y coordinates of your second shape, and also its size.

basicShape_2_x_position = .5;  //[.5:0.5:4.0]
basicShape_2_y_position = .5;  //[.5:0.5:11.5]
basicShape_2_size = .5;   //[.5:0.5:3]

/* [Basic Shape 3] */
//What type of shape do you want for your third stencil?
type_of_basicShape_3 = 3 ;//[3:Equilateral Triangle,4:Square,5:Pentagon,6:Hexagon,7:Heptagon,8:Octagon,90:Circle]

//Pick the x and y coordinates of your third shape, and also its size.

basicShape_3_x_position = .5;  //[.5:0.5:4.0]
basicShape_3_y_position = .5;  //[.5:0.5:11.5]
basicShape_3_size = .5;   //[.5:0.5:3]

/* [Basic Shape 4] */
//What type of shape do you want for your fourth stencil?
type_of_basicShape_4 = 3 ;//[3:Equilateral Triangle,4:Square,5:Pentagon,6:Hexagon,7:Heptagon,8:Octagon,90:Circle]

//Pick the x and y coordinates of your fourth shape, and also its size.

basicShape_4_x_position = .5;  //[.5:0.5:4.0]
basicShape_4_y_position = .5;  //[.5:0.5:11.5]
basicShape_4_size = .5;   //[.5:0.5:3]


/* [Number of Rectangles] */
//How many rectangular stencils do you want?
number_of_rectangles = 0;//[0:Zero,1:One,2:Two]

/* [Rectangle 1] */
//Pick the x and y coordinates of your first rectangle, and also its length/width.

rectangle_1_x_position = .5; //[.5:0.5:4.0]
rectangle_1_y_position = .5; //[.5:0.5:11.5]
rectangle_1_width = .5; //[.5:0.5:4.0]
rectangle_1_length = .5; //[.5:0.5:11.0]

/* [Rectangle 2] */
//Pick the x and y coordinates of your second rectangle, and also its length/width.

rectangle_2_x_position = .5; //[.5:0.5:4.0]
rectangle_2_y_position = .5; //[.5:0.5:11.5]
rectangle_2_width = .5; //[.5:0.5:4.0]
rectangle_2_length = .5; //[.5:0.5:11.0]

/* [Number of Right Triangles] */
//How many right triangle stencils do you want?
number_of_rightTriangles = 0;//[0:Zero,1:One,2:Two]

/* [Right Triangle 1] */
//Pick the x and y coordinates of your first right triangle, and also its base/height.

rightTriangle_1_x_position = .5; //[.5:0.5:4.0]
rightTriangle_1_y_position = .5; //[.5:0.5:11.5]
rightTriangle_1_height = .5; //[.5:0.5:3.0]
rightTriangle_1_base = .5; //[.5:0.5:5.0]

/* [Right Triangle 2] */
//Pick the x and y coordinates of your second right triangle, and also its base/height.

rightTriangle_2_x_position = .5; //[.5:0.5:4.0]
rightTriangle_2_y_position = .5; //[.5:0.5:11.5]
rightTriangle_2_height = .5; //[.5:0.5:4.0]
rightTriangle_2_base = .5; //[.5:0.5:11.0]

/* [Number of Line Stencils] */
//How many line stencils do you want?
number_of_lines = 0;//[0:Zero,1:One,2:Two]

/* [Line 1] */
//Pick the x and y coordinates of your first line stencil, and also its length/angle.

line_1_x_position = .5; //[.5:0.5:4.0]
line_1_y_position = .5; //[.5:0.5:11.5]
line_1_length = .5; //[.5:0.5:4.0]
line_1_angle = 0; //[90:-90,60:-60,45:-45,30:-30,0,-30:30,-45:45,-60:60,-90:90]

/* [Line 2] */
//Pick the x and y coordinates of your second line stencil, and also its length/angle.

line_2_x_position = .5; //[.5:0.5:4.0]
line_2_y_position = .5; //[.5:0.5:11.5]
line_2_length = .5; //[.5:0.5:4.0]
line_2_angle = 0; //[90:-90,60:-60,45:-45,30:-30,0,-30:30,-45:45,-60:60,-90:90]

/* [Cube Stencil] */
//Do you want a cube stencil?
cubeStencil_y_or_n = 0; //[0:No,1:Yes]
//Where do you want your cube stencil?

cubeStencil_x_position = .5; //[.5:0.25:4.0]
cubeStencil_y_position = .5; //[.5:0.25:11.5]

/* [Angle Stencil] */
//Do you want angle stencils?
angles_y_or_n = 0; //[0:No,1:Yes]
//Where do you want your cube stencil?

angles_x_position = .5; //[.5:0.25:4.0]
angles_y_position = .5; //[.5:0.25:11.5]

/* [Text Emboss] */
//Do you want to emboss some text?
text_y_or_n = 0; //[0:No,1:Yes]
//What words would you like to emboss?
custom_text = "Custom Ruler";
//Where do you want your embossed text?

text_x_position = .5; //[.5:0.25:4.0]
text_y_position = .5; //[.5:0.25:11.5]


drawRuler();

module drawRuler() 
{
    difference() 
    {
        union() 
        {
         scale([25.4,25.4,25.4])  ruler();
         scale([25.4,25.4,25.4])  drawUnit();
          scale([25.4,25.4,25.4]) cubeStencil_support();
          scale([25.4,25.4,25.4]) angles2();
         scale([25.4,25.4,25.4])  text1();  
        }
        union() 
        {
          scale([25.4,25.4,25.4]) basicShapes();
          scale([25.4,25.4,25.4]) rectangles();
          scale([25.4,25.4,25.4]) rightTriangles();
         scale([25.4,25.4,25.4])  lines();
         scale([25.4,25.4,25.4])  angles();
          scale([25.4,25.4,25.4]) cubeStencil_cut();
        }
    }
}

module basicShapes() 
{
    if(number_of_basicShapes == 1)
    {
        draw_basicShapes(type_of_basicShape_1,basicShape_1_x_position,basicShape_1_y_position,basicShape_1_size);
    }
    else if (number_of_basicShapes == 2)
    {
        draw_basicShapes(type_of_basicShape_1,basicShape_1_x_position,basicShape_1_y_position,basicShape_1_size);
        draw_basicShapes(type_of_basicShape_2,basicShape_2_x_position,basicShape_2_y_position,basicShape_2_size);
    }
    else if (number_of_basicShapes == 3)
    {
        draw_basicShapes(type_of_basicShape_1,basicShape_1_x_position,basicShape_1_y_position,basicShape_1_size);
        draw_basicShapes(type_of_basicShape_2,basicShape_2_x_position,basicShape_2_y_position,basicShape_2_size);
        draw_basicShapes(type_of_basicShape_3,basicShape_3_x_position,basicShape_3_y_position,basicShape_3_size);
    }
    
    else if (number_of_basicShapes == 4)
    {
        draw_basicShapes(type_of_basicShape_1,basicShape_1_x_position,basicShape_1_y_position,basicShape_1_size);
        draw_basicShapes(type_of_basicShape_2,basicShape_2_x_position,basicShape_2_y_position,basicShape_2_size);
        draw_basicShapes(type_of_basicShape_3,basicShape_3_x_position,basicShape_3_y_position,basicShape_3_size);
        draw_basicShapes(type_of_basicShape_4,basicShape_4_x_position,basicShape_4_y_position,basicShape_4_size);   
    }  
}

module rectangles() 
{
    if(number_of_rectangles == 1)
    {
        draw_rectangles(rectangle_1_x_position,rectangle_1_y_position,rectangle_1_width,rectangle_1_length);
    }
    
    else if(number_of_rectangles == 2)
    {
        draw_rectangles(rectangle_1_x_position,rectangle_1_y_position,rectangle_1_width,rectangle_1_length);
        draw_rectangles(rectangle_2_x_position,rectangle_2_y_position,rectangle_2_width,rectangle_2_length);
    }
}

module lines() 
{
    if(number_of_lines == 1)
    {
        
        rotated_line_1_x_position=line_1_x_position*cos(line_1_angle)-line_1_y_position*sin(line_1_angle);
        
        rotated_line_1_y_position=line_1_x_position*sin(line_1_angle) + line_1_y_position*cos(line_1_angle);
        
        rotate([0,0,-line_1_angle])
        draw_lines(rotated_line_1_x_position,rotated_line_1_y_position,line_1_length,line_1_angle);
    }
    
    else if(number_of_lines == 2)
    {
        rotated_line_1_x_position=line_1_x_position*cos(line_1_angle)-line_1_y_position*sin(line_1_angle);
        
        rotated_line_1_y_position=line_1_x_position*sin(line_1_angle) + line_1_y_position*cos(line_1_angle);
        
        rotate([0,0,-line_1_angle])
        draw_lines(rotated_line_1_x_position,rotated_line_1_y_position,line_1_length,line_1_angle);
        
        //Line 2
        
        rotated_line_2_x_position=line_2_x_position*cos(line_2_angle)-line_2_y_position*sin(line_2_angle);
        
        rotated_line_2_y_position=line_2_x_position*sin(line_2_angle) + line_2_y_position*cos(line_2_angle);
        
        rotate([0,0,-line_2_angle])
        draw_lines(rotated_line_2_x_position,rotated_line_2_y_position,line_2_length,line_2_angle);
    }
}

module rightTriangles() 
{
    if(number_of_rightTriangles == 1)
    {
        draw_rightTriangles(rightTriangle_1_x_position,rightTriangle_1_y_position,rightTriangle_1_height,rightTriangle_1_base);
    }
    
    else if(number_of_rightTriangles == 2)
    {
        draw_rightTriangles(rightTriangle_1_x_position,rightTriangle_1_y_position,rightTriangle_1_height,rightTriangle_1_base);
        draw_rightTriangles(rightTriangle_2_x_position,rightTriangle_2_y_position,rightTriangle_2_height,rightTriangle_2_base);
    }
}

module cubeStencil_support() 
{
    if(cubeStencil_y_or_n == 1)
    {
     draw_cubeStencil_support(cubeStencil_x_position,cubeStencil_y_position);      
    }
}

module cubeStencil_cut() 
{
    if(cubeStencil_y_or_n == 1)
    {
     draw_cubeStencil_cut(cubeStencil_x_position,cubeStencil_y_position);      
    }
}

module angles() 
{
    if(angles_y_or_n == 1)
    {
     draw_angles(angles_x_position,angles_y_position); 
    }
}

module angles2() 
{
    if(angles_y_or_n == 1)
    {
     draw_angles2(angles_x_position,angles_y_position);    
    }
}

module text1() 
{
    if(text_y_or_n == 1)
    {
     draw_text(text_x_position,text_y_position,custom_text);    
    }
}



/* [Hidden] */
ruler_thickness=0.064015748;
tick_thickness=ruler_thickness+.02;
tick_width=.1;
tick_length=.03;
cube_thickness=ruler_thickness+.04;


module ruler()
{
    union()
    {
        cube([ruler_width,ruler_length,ruler_thickness]);
        color([1,0,0,1]) 
        translate([ruler_width-.03,-.0001,.0001]) cube([.0301,ruler_length+.0002,tick_thickness]);
        
        for(i=[1:ruler_length])
        {
            color([1,0,0,1])
            for(j=[1:10])
            {
               if (j==10 && i!=ruler_length) { 
                   translate([ruler_width-tick_width*2.0,i-1+(j/10)-(tick_length/2),.0001]) 
                    cube([tick_width*2.0,tick_length,tick_thickness]);
                    drawInches(i,i);   
               }
               if (j==5){
                  translate([ruler_width-tick_width*1.5,i-1+(j/10)-(tick_length/2),.0001]) 
               cube([tick_width*1.5,tick_length,tick_thickness]);
               }
               else if(j!=10){
                  translate([ruler_width-tick_width*1.0,i-1+(j/10)-(tick_length/2),.0001]) 
               cube([tick_width*1.0,tick_length,tick_thickness]);
               }      
            }              
        }
    }  
}
module drawInches(sent_text,number)
{
    font = "Roboto";
                
    rotate([0,0,90])
    
    if(number<10)
    {
        translate([number-.095, -ruler_width + .23, .0001]) 
        linear_extrude(height = tick_thickness) 
        text(text = str(sent_text), font = font, size = .22);
    }
    else
    {
        translate([number-.17, -ruler_width + .23, .0001])
        linear_extrude(height = tick_thickness) 
        text(text = str(sent_text), font = font, size = .22);
    }     
}
module drawUnit()
{
    rotate([0,0,90])
    color([1,0,0,1])
    translate([.17, -ruler_width + .23, .0001])
    linear_extrude(height = tick_thickness) 
    text(text = "IN", font = "Roboto", size = .22);   
}
module draw_basicShapes(fn_value,x,y,size)
{
        $fn=fn_value;
        translate([x,y,0])
        cylinder(ruler_thickness+2,d=size,center=true);
}
module draw_rectangles(rectangles_x,rectangles_y,rectangles_width,rectangles_length)
{
    translate([rectangles_x,rectangles_y,0])
    cube([rectangles_width,rectangles_length,ruler_thickness+2], center = true);
}

module draw_rightTriangles(rightTriangles_x,rightTriangles_y,rightTriangles_height,rightTriangles_base)
{
    polyhedron
        (
        points=[ 
        [rightTriangles_x + rightTriangles_height,rightTriangles_y,-10], //b
        [rightTriangles_x,rightTriangles_y,-10], //a
        [rightTriangles_x + rightTriangles_height,rightTriangles_y + rightTriangles_base,-10], //c
        [rightTriangles_x + rightTriangles_height,rightTriangles_y, ruler_thickness+2], //b 
        [rightTriangles_x,rightTriangles_y,ruler_thickness+2], //a 
        [rightTriangles_x + rightTriangles_height,rightTriangles_y + rightTriangles_base,ruler_thickness+2]] ,//c                                  
  
        faces=[ 
        [0,2,1],
        [3,5,2,0],
        [5,4,1,2],
        [4,3,0,1],           
        [3,4,5],] 
        );
}

module draw_lines(lines_x,lines_y,lines_length,lines_angle)
{    
    translate([lines_x,lines_y,-.0001])

    cube([.08,lines_length,ruler_thickness+2], center = false);
    
    $fn=90;
    translate([lines_x+.040,lines_y,0])
    cylinder(ruler_thickness+2,d=.08,center=true);
    

    translate([lines_x+.040,lines_y+lines_length,0])
    cylinder(ruler_thickness+2,d=.08,center=true);      
}

module draw_cubeStencil_cut(cube_x,cube_y)
{
    translate([cube_x+.04,cube_y+.04,-.0001])    
    cube([1.00,1.00,ruler_thickness+2], center = false);

    translate([cube_x-0.25586614,cube_y+1.44318898,-.0001])
    cube([0.954055118,.08,ruler_thickness+2], center = false);

    translate([cube_x-.29586614,cube_y+0.563188976,-.0001])
    cube([.08,0.92011811,ruler_thickness+2], center = false);
    
    $fn=90;
    translate([cube_x-.2585,cube_y+1.486,0])
    cylinder(ruler_thickness+2,d=.075,center=true);
    
   
    translate([cube_x-.08,cube_y+1.095,-.0001])
    rotate([0,0,32])
    cube([.08,0.4,ruler_thickness+2], center = false);
    
    translate([cube_x-.047,cube_y+1.118,0])
    cylinder(ruler_thickness+2,d=.08,center=true);
    
    translate([cube_x+.92,cube_y+1.086,-.0001])
    rotate([0,0,36.5])
    cube([.08,.48,ruler_thickness+2], center = false);
    
    translate([cube_x-.084,cube_y+.23,-.0001])
    rotate([0,0,32.4])
    cube([.08,.396,ruler_thickness+2], center = false);
    
        //Top Left Triangle
        polyhedron
        (
        points=[ 
        [cube_x-.084,cube_y+.230,-.1], //b
        [cube_x-.0165,cube_y+.273,-.1], //a
        [cube_x-.0165,cube_y+.128,-.1], //c
        [cube_x-.084,cube_y+.230,ruler_thickness+2], //b 
        [cube_x-.0165,cube_y+.273,ruler_thickness+2], //a 
        [cube_x-.0165,cube_y+.128,ruler_thickness+2]] ,//c                                  
  
        faces=[ 
        [0,2,1],
        [3,5,2,0],
        [5,4,1,2],
        [4,3,0,1],           
        [3,4,5],] 
        );
   
        //Bottom Right Triangle
        
  polyhedron
        (
        points=[ 
        [cube_x+.920,cube_y+1.086,-.1], //b
        [cube_x+.9844,cube_y+1.134,-.1], //a
        [cube_x+1.017,cube_y+1.086,-.1], //c
        [cube_x+.920,cube_y+1.086,ruler_thickness+2], //b 
        [cube_x+.9844,cube_y+1.134,ruler_thickness+2], //a 
        [cube_x+1.017,cube_y+1.086,ruler_thickness+2]] ,//c                                  
  
        faces=[ 
        [0,2,1],
        [3,5,2,0],
        [5,4,1,2],
        [4,3,0,1],           
        [3,4,5],] 
        );
        
        

}

module draw_cubeStencil_support(cube_x,cube_y)
{
    color([1,0,0,1])
    translate([cube_x,cube_y,.0001])    
    cube([1.08,1.08,cube_thickness], center = false);
}

module draw_angles(angles_x,angles_y)
{
    translate([angles_x,angles_y,-.0001])
    cube([.5,.08,cube_thickness], center = false);
    
    $fn=90;
    translate([angles_x+.5,angles_y+.04,-.0001])
    cylinder(ruler_thickness+2,d=.08,center=true);
    
    translate([angles_x+.5,angles_y+.54,-.0001])
    cylinder(ruler_thickness+2,d=.08,center=true);
    
    translate([angles_x,angles_y+.04,-.0001])
    cylinder(ruler_thickness+2,d=.08,center=true);
    
    translate([angles_x+.029,angles_y+.012,-.0001])
    rotate([0,0,45])
    cube([.5/sin(45),.08,cube_thickness], center = false);
    
    translate([angles_x+.53,angles_y +.567,-.0001])
    rotate([0,0,135])
    cube([.5/sin(45),.08,cube_thickness], center = false);
    
    translate([angles_x,angles_y+1.04,-.0001])
    cylinder(ruler_thickness+2,d=.08,center=true);
    
    translate([angles_x-.83,angles_y,-.0001])
    cube([.5,.08,cube_thickness], center = false);
    
    translate([angles_x-.33,angles_y+.04,-.0001])
    cylinder(ruler_thickness+2,d=.08,center=true);
    
    translate([angles_x-.83,angles_y+.04,-.0001])
    cylinder(ruler_thickness+2,d=.08,center=true);
    
    translate([angles_x-.80,angles_y+.011,-.0001])
    rotate([0,0,60])
    cube([.6,.08,cube_thickness], center = false);
    
    translate([angles_x-.535,angles_y+.51+.04,-.0001])
    cylinder(ruler_thickness+2,d=.08,center=true);
    
    translate([angles_x-.95,angles_y+.15,-.0001])
    rotate([0,0,60])
    cube([.54,.08,cube_thickness], center = false);
    
    translate([angles_x-.7134,angles_y+.6+.04,-.0001])
    cylinder(ruler_thickness+2,d=.08,center=true);
    
    translate([angles_x-.9846,angles_y+.17,-.0001])
    cylinder(ruler_thickness+2,d=.08,center=true);
    
    translate([angles_x-.9445,angles_y+.165,-.0001])
    rotate([0,0,90])
    cube([.49,.08,cube_thickness], center = false);
    
    translate([angles_x-.9845,angles_y+.65,-.0001])
    cylinder(ruler_thickness+2,d=.08,center=true);
}

module draw_angles2(angles_x,angles_y)
{
   
    color([1,0,0,1])
    translate([angles_x+.65,angles_y+.12, .0001])
    rotate([0,0,90])
    linear_extrude(height = tick_thickness) 
    text(text = "45", font = "Roboto", size = .18);
    
    color([1,0,0,1])
    translate([angles_x+.25,angles_y+.4, .0001])
    rotate([0,0,90])
    linear_extrude(height = tick_thickness) 
    text(text = "90", font = "Roboto", size = .18);
    
    color([1,0,0,1])
    translate([angles_x-.35,angles_y+.12, .0001])
    rotate([0,0,90])
    linear_extrude(height = tick_thickness) 
    text(text = "60", font = "Roboto", size = .18);
    
    color([1,0,0,1])
    translate([angles_x-.75,angles_y+.7, .0001])
    rotate([0,0,90])
    linear_extrude(height = tick_thickness) 
    text(text = "30", font = "Roboto", size = .18);
        
}

module draw_text(text_x,text_y,custom_text)
{
    color([1,0,0,1])
    translate([text_x,text_y, .0001])
    rotate([0,0,90])
    linear_extrude(height = tick_thickness) 
    text(text = custom_text, font = "Roboto", size = .28);
}

