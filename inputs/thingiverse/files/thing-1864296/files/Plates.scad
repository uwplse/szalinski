//Plate Text (ideal 7 but plate will scale appropriatly)
P_Text = "D4N R4D";
//Top Text - The text at the top of the plate
T_Text = "My Plate";
//Bottom Text - The text at the bottom of the plate
B_Text = "By dan3008";
//corner radius. Must be a number
R_Corner = 2.5;
//Thickness of overall numberplate
P_Thick = 5;
//Hole Size - Size of the mounting holes (0 = no hole)
M_Size = 1;
//Font to use for the plate
P_Font = "Oswald";

module P_Base(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];
    difference(){
        linear_extrude(height=z)
        hull()
        {
            // place 4 circles in the corners, with the given radius
            translate([(radius), (radius), 0])
            circle(r=radius);
        
        translate([(radius), (y+radius), 0])
            circle(r=radius);
        
        translate([(x+radius), (radius), 0])
            circle(r=radius);
        
        translate([(x+radius), (y+radius), 0])
            circle(r=radius);
        }
        translate([0,0,z/2]){
            linear_extrude(height=z)
            hull()
            {
                // place 4 circles in the corners, with the given radius
                translate([(radius+1), (radius+1), 0])
                circle(r=radius);
            
            translate([(radius+1), (y+radius-1), 0])
                circle(r=radius);
            
            translate([(x+radius-1), (radius+1), 0])
                circle(r=radius);
            
            translate([(x+radius-1), (y+radius-1),0])
                circle(r=radius);
            }
        }
        linear_extrude(height=P_Thick){
        translate([5,50,0])
        circle(r=M_Size);
        translate([x,50,0])
        circle(r=M_Size);
        translate([5,5,0])
        circle(r=M_Size);
        translate([x,5,0])
        circle(r=M_Size);
        }
    }
    
}
module Make(val){
    x = len(val)*21;
    P_Base([x, 50, P_Thick], R_Corner, $fn=12);
    translate([x/2,25])
    {
        linear_extrude(height=P_Thick)
        text(val,font=P_Font,valign="center",halign="center", spacing = 0.9,size=25);
    }
    translate([x/2,47])
    {
        linear_extrude(height=P_Thick)
        text(T_Text,font=P_Font,valign="center",halign="center", spacing = 0.9,size=5);
    }
    translate([x/2,7])
    {
        linear_extrude(height=P_Thick)
        text(B_Text,font=P_Font,valign="center",halign="center", spacing = 0.9,size=5);
    }
    

}
Make(P_Text);