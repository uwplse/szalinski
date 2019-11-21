/* [Box] */
Box_Width = 77;
Box_Depth = 55;
Box_Height = 20;
Box_Color = "Orange";

/* [Circle] */
Circle_Radius = 2;
Circle_Space = 6;

/* [Support] */
// Select the support for you box.
Support_Side = 0; //[0:Side 1 and 2, 1:Only Side 1, 2:Only Side 2]

/* [Text] */
Print_Text = 1; //[0:No, 1:Yes]
Text_Align_Side1 = 0; //[0:Horizontal, 1:Vertical]
Text_Align_Side2 = 0; //[0:Horizontal, 1:Vertical]
Text_Value = "Thiago";
Text_Size = 4;
Text_Font = "Impact:style=Regular";
Text_Offset = 0;
Text_Color = "White";

/* [Hidden] */
$fn=50;
Circle_Radius_Control = (Circle_Radius*2.5)+Circle_Space;
Text_Height = 2;

module support_print() {
    difference() {
        union() {
            support(0,0,0);
            if(Print_Text == 1) {
                text_print_control();
            }
        }
        support_control();
        circles();
    }
}

module support(w,d,h) {
    color(Box_Color)
    cube([Box_Width-w,Box_Depth-d,Box_Height-h], center=true);
}

module support_control() {
    if(Support_Side == 0) {
        translate([0,0,-2])
        support(4,4,1.5);
    } else if(Support_Side == 1) {
        translate([0,2,-1.5])
        support(4,2,0);
        
        translate([0,-2,-1.5])
        support(4,2,0);
    } else {
        translate([2,0,-1.5])
        support(2,4,2);
        
        translate([-2,0,-1.5])
        support(2,4,2);
    }
}

module circles() {
    qd = Box_Depth/Circle_Radius_Control/2;
    qw = Box_Width/Circle_Radius_Control/2;
    for(d=[0:qd]) {
        for(w=[0:qw]) {  
            translate([w*Circle_Radius_Control,d*Circle_Radius_Control,0])
            cylinder_box();
            
            translate([-w*Circle_Radius_Control,d*Circle_Radius_Control,0])
            cylinder_box();
            
            translate([w*Circle_Radius_Control,-d*Circle_Radius_Control,0])
            cylinder_box();
            
            translate([-w*Circle_Radius_Control,-d*Circle_Radius_Control,0])
            cylinder_box();
        }
    }
}

module cylinder_box() {
    cylinder(Box_Height,Circle_Radius,Circle_Radius);
}

module text_print() {
    color(Text_Color)
    linear_extrude(height=Text_Height) {
        offset(Text_Offset)
        text(Text_Value, size=Text_Size, font=Text_Font, halign="center", valign="center");
  }
}

module text_print_control() {
    if(Support_Side!=2) {
        align=Text_Align_Side1==0 ? 0 : -90;
        
        translate([-(Box_Width/2-1), 0, 0]) 
        rotate([90,align,-90]) 
        text_print();
        
        translate([(Box_Width/2-1), 0, 0]) 
        rotate([90,align,90]) 
        text_print();
    }
    
    if(Support_Side!=1) {
        align=Text_Align_Side2==0 ? 0 : -90;
        
        translate([0,-(Box_Depth/2-1), 0]) 
        rotate([90,align,0]) 
        text_print();
        
        translate([0,(Box_Depth/2-1), 0]) 
        rotate([90,align,180]) 
        text_print();
    }
}

support_print();