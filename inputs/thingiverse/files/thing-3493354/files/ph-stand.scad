
// Angle of the phone standing
Phone_Angle=30; //[10:80]
Phone_Height=160;
Phone_Width=76;
Phone_Depthd=9;
// Part of the phone on the stand
Phone_Ratio=66; // [55:95]
Stand_Wall_Width=6; //[1:20]
// Gap under the phone
Stand_Gap=20; // [3:50]
// Positioning of decorative cut in the walls
Stand_Decorations_Position= 0; // [0:odd, 1:even]
// Cables and speackers cut (can not be more then phone width minus double wall width)
Cable_Cut_length=50;
Cable_Cut_Width_Ratio= 75; // [10:100]
// (higher number mean sharper)
Wall_Rounding_Ratio=60; //[30:80]

/*[Hidden]*/

$fn=100;

Phone_Ratio1= Phone_Ratio/100.0;
Cable_Cut_Width_Ratio1= Cable_Cut_Width_Ratio/100.0;
Wall_Rounding_Ratio1= Wall_Rounding_Ratio/100.0;

Cable_Cut_length2= min(Phone_Width-2*Stand_Wall_Width, Cable_Cut_length);

st_ln_p= Phone_Height * Phone_Ratio1;
st_ln_g= Stand_Gap/sin(Phone_Angle);
st_ln_w= Stand_Wall_Width/sin(Phone_Angle);
st_ln= st_ln_p + st_ln_g + st_ln_w;
st_h= st_ln*sin(Phone_Angle);
echo("side length:", st_ln, st_ln_p, st_ln_g, st_ln_w, st_h);
st_cw= Stand_Wall_Width*Wall_Rounding_Ratio1;
st_sw= (Stand_Wall_Width - st_cw)/2;

st_o1= cos(Phone_Angle)*(Phone_Height*(1-Phone_Ratio1));
st_b=atan2(st_o1, st_ln);
echo("Beta:", st_b);
st_o2= sin(Phone_Angle)*Phone_Height*Phone_Ratio1 + cos(Phone_Angle)*Phone_Depthd;

Cable_Cut_lengthw= Phone_Width-2*Stand_Wall_Width;

Cable_Cut_length1=min (Cable_Cut_lengthw, st_ln_p - Stand_Wall_Width*2);


module cut1 (cut=60, gap= 5, h=100, w=20, step= 0)
{
    side= cut/sin(45)/2;
    interval= (step ? step : gap + cut);
    n= floor(h/interval);
    intersection()
    {

        cube([h, w, cut]);
        union()
        {
            for(s= [0:n])
            {
                translate([cut/2 + s*interval,0,cut/2])
                rotate([0,45,0])
                translate([-side/2, 0, -side/2])
                cube([side, w, side]);
    
            }
            if (cut/2 > gap)
            {
                new_cut= cut/2-gap;
                translate([-(gap + new_cut)/2, 0, (cut/2 - new_cut/2) -  (gap + new_cut)/2])
                cut1(cut=new_cut, gap= gap*1.5, h=h+(gap + new_cut)/2, w=w, step= interval/2);
                new_cut= cut/2-gap;
                translate([-(gap + new_cut)/2, 0, (cut/2 - new_cut/2) +  (gap + new_cut)/2])
                cut1(cut=new_cut, gap= gap*1.5, h=h+(gap + new_cut)/2, w=w, step= interval/2);
            }
        }
    }
}

module cut(gap= 5, h=100, l=50, w=6, step= 0)
{
    //%cube([h,w,l]);
    hw= h - 2*w;
    lw= l - 2*w;
    cut= min (hw, lw);
    if (h >= l)
    {
        n= ceil(h/(cut + gap));
        nn= ((Stand_Decorations_Position && (n % 2 == 1)) || (!Stand_Decorations_Position && (n % 2 == 0)) ) ? n+1 : n;
 
        hww= nn*(cut + gap);
        translate([w,0,w])
        intersection()
        {
            cube([hw,w,lw]);
            translate([-(hww-hw)/2 + gap/2, 0, 0])
            cut1 (cut=cut, gap=gap, h=hww, w= w);
        }
    }
    else
    {
        n= ceil(l/(cut + gap));
        nn= ((Stand_Decorations_Position && (n % 2 == 1)) || (!Stand_Decorations_Position && (n % 2 == 0)) ) ? n+1 : n;
        
        lww= nn*(cut + gap);
        translate([cut + w,0,w])
        rotate([0,-90,0])
        intersection()
        {
            cube([lw,w,hw]);
            translate([-(lww-lw)/2 + gap/2, 0, 0])
            cut1 (cut=cut, gap=gap, h=lww, w= w);
        }
    }
}


difference()
{
    linear_extrude(Phone_Width, center = false, convexity = 10)
    offset(r=st_sw)
    difference()
    {
        union()
        {
            rotate(Phone_Angle)
            union()
            {
                l= st_ln_p + st_sw;
                s= Phone_Depthd + Stand_Wall_Width*2 - st_sw * 4;
                translate([-l, -st_cw/2])
                square([l + st_cw, st_cw], center=false);
                translate([-l - st_cw, -(s-st_cw/2)])
                square([st_cw, s], center=false);
                translate([-l - st_cw, -s])
                square([st_cw + st_sw, st_cw], center=false);
            }
            rotate(-st_b)
            translate([-st_ln, -st_cw/2])
            square([st_ln + st_cw, st_cw], center=false);
            translate([-cos(st_b)*st_ln - st_cw/2, -st_o2])
            square([st_cw, st_o1+st_o2], center=false);
        }
        //clear artefacts around line joins
        rotate(-st_b)
        translate([-st_ln*2, st_cw/2])
        square([st_ln*4, st_cw*4], center=false);
        rotate(Phone_Angle)
        translate([-st_ln_p, -st_cw-st_cw*3.5])
        square([st_ln_p*2, st_cw*4], center=false);
    }
    // cut in the back wall
    rotate(-st_b)
    translate([-st_ln, -Stand_Wall_Width/2 - 0.01, 0])
    cut(gap=Stand_Wall_Width, h=st_ln, l=Phone_Width, w= Stand_Wall_Width+0.02);
    // cut in the front wall
    rotate(Phone_Angle)
    translate([-st_ln_p, -Stand_Wall_Width/2 - 0.01, 0])
    cut(gap=Stand_Wall_Width, h=st_ln_p, l= Phone_Width, w= Stand_Wall_Width+0.02);
    // cut in the stand
    translate([-cos(st_b)*st_ln - Stand_Wall_Width/2 - 0.01, st_o1, 0])
    rotate(-90)
    cut(gap=Stand_Wall_Width, h=st_o2+st_o1, l= Phone_Width, w=Stand_Wall_Width+0.02);

    // Cut for wires and speakers
    c1= Phone_Depthd*(1-Cable_Cut_Width_Ratio1)/2;
    c2= Phone_Depthd-c1;
    cs= Phone_Depthd*Cable_Cut_Width_Ratio1/2;
    rotate([90,0,Phone_Angle +90 +180])
    translate([Stand_Wall_Width/2, (Phone_Width-Cable_Cut_length2)/2 , st_ln_p - Stand_Wall_Width/2])
    linear_extrude(Stand_Wall_Width*2, center = false, convexity = 10)
    polygon(points=[[Phone_Depthd/2, 0],
                    [c2, cs],
                    [c2, Cable_Cut_length2-cs],
                    [Phone_Depthd/2, Cable_Cut_length2],
                    [c1, Cable_Cut_length2-cs],
                    [c1, cs]]);
}
