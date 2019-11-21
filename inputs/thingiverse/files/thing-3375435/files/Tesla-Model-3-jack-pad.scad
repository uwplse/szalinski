
diameter_interior = 25;
high_interior = 23;
interior_fill_ration = 0.5; // set to 1 to have completely filled
diameter_base = 100;
high_base = 35;
base_clips_marge_ration=0.2; // set to -1 to remove the hole in the base
elastic_cut_length=2;
elastic_cut_deepness=1; // set to 0 to remove
elastic_cut_position_ratio=0.3;
texte="Andre's Tesla";
font_size = 8;
texte2="https://ts.la/andre31557";
font_size2 = 6;
text_depth = 1;
text_side_shift_from_center=25;
fn=20; // precision, higher better but slower


translate([0,0,high_base])
    difference()
    {
        cylinder(h=high_interior,r=(diameter_interior/2), $fn=fn);
        cylinder(h=high_interior,r=(diameter_interior/2)*(1-interior_fill_ration), $fn=fn);
    translate([0,0,high_interior*elastic_cut_position_ratio])
        difference()
        {
        cylinder(h=elastic_cut_length,r=(diameter_interior/2), $fn=fn);
        cylinder(h=elastic_cut_length,r=(diameter_interior/2)-elastic_cut_deepness, $fn=fn);
        }
    }
difference()
{
    cylinder(h=high_base,r=(diameter_base/2), $fn=fn);
    cylinder(h=high_interior*(1+base_clips_marge_ration),r=(diameter_interior/2)*(1+base_clips_marge_ration), $fn=fn);
    rotate([180,0,0]) translate([0,text_side_shift_from_center,0]) linear_extrude(height=text_depth) 
                text(text=texte, halign="center", valign="center",size=font_size );
    rotate([180,0,0]) translate([0,-text_side_shift_from_center,0]) linear_extrude(height=text_depth) 
                text(text=texte2, halign="center", valign="center",size=font_size2 );
}


        