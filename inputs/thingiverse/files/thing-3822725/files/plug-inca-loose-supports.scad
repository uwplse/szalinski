d_full_disc = 61.5;
r_full_disc = d_full_disc/2;
thickness_base = 2;
d_inner_disc = 51;
r_inner_disc = d_inner_disc/2;
thickness_inner = 2;
pegsize = 5;
pegtolerance = .1;
         
function support_angles() = [125,65,270];
function disc_thickness() = thickness_inner + thickness_base;

module support_base(width=4)
{
    depth=disc_thickness();
    linear_extrude(depth,true)
        square(width);
    
}

module support(pegs)
{
    thickness_top = 1.5;
    //extension to back
    thickness_extension = 1.5;
    //protrusion of hook
    hook_protrusion = 2;
    hook_low = thickness_base+13-disc_thickness();
    hook_high = hook_low + 2;
    //height of hook above lowest point
    hook_peak = hook_low+1;
    support_base(pegs);
    rotate([0,90,0])
        linear_extrude(pegs)
            polygon([[0,0],[hook_high,0],[hook_high,pegs],[hook_low,pegs+hook_protrusion],[hook_low,pegs+.5],[0,pegs]]);
}



union(){
    difference(){
        //base circle
        union(){
            cylinder(h = thickness_base, r1 = r_full_disc, r2 = r_full_disc, $fn=100);
            translate([0,0,thickness_base])
                cylinder(h = thickness_inner, r1 = r_inner_disc, r2 = r_inner_disc-.3, $fn=100);
            //'peg', slightly undersized. slit in table is 3mm.
            peg_thickness = 2.8; 
            translate([-peg_thickness/2,r_inner_disc,1])
                cube([peg_thickness,10,3]);
        }
        union()
        {
         for (i=support_angles())
         {
         rotate([0,0,i])
            translate([r_inner_disc-pegsize,-pegsize/2,0])
                support_base(pegsize+pegtolerance);
         }


        //cutout for blade. -.1 in z to get "real" hole and no rendering errors
        translate([-3,0,-.10])
        union(){
            //pocket for sawblade
            translate([-0,-5,0])
                //width of pocket, length of pocket, height (should be > thickness_base + thickness_inner)
                cube([4,18,disc_thickness()]);
            //slit
            cube([2,r_full_disc,disc_thickness()]);

        }
        }

    }
    //supports under different angles
    for (i=support_angles())
     {
     rotate([0,0,i])
        translate([r_full_disc+5,pegsize/2,0])
         rotate([90,0,0])
            support(pegsize-pegtolerance);
     }
}
