
RingRadius=35;//[30,35,40,45]
RingHeight=4;//[2,3,4,5,6]
StarPoints = 5;//[3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
StarHeight=4;//[3,4,5,6]
StarRotate = 348;//[0:360]
TopWord = "CUSTOM";
BtmWord = "TEXT HERE";
SelectedFont = "Stardos Stencil"; // [Arial, Stardos Stencil, Allerta Stencil, Sirin Stencil] 
TextSize = 7; //[5,6,7,8]
TopCharSpacing = 0;//[0,1,2,3]
BtmCharSpacing = 0;//[0,1,2,3]
TextPosition = 0; //[-5:5]
TextDepth = 1.5; //[1,1.5,2,2.5,3,3.5,4]

$fn=128;


charsTop = TopWord;
charsBtm = BtmWord;
radius = RingRadius-9+(TextPosition/5);

//Top Text
module revolveTop_text(radius, charsTop) {
    //PI = 3.14159;
    //circumference = 2 * PI * radius;
    charsTop_len = len(charsTop);
    font_size = TextSize;//circumference / chars_len;
    step_angle = (120-TopCharSpacing*20) / charsTop_len;
    for(i = [0 : charsTop_len - 1]) {
        rotate((0-TopCharSpacing*10)-i * step_angle) 
            translate([0, radius + font_size / 2, 0]) 
                text(
                    charsTop[i], 
                    font = SelectedFont, 
                    size = font_size, valign = "center", halign = "center"
                );
    }
}
//Bottom Text
module revolveBtm_text(radius, charsBtm) {
    //PI = 3.14159;
    //circumference = 2 * PI * radius;
    charsBtm_len = len(charsBtm);
    font_size = TextSize;//circumference / chars_len;
    step_angle = (-120+BtmCharSpacing*20) / charsBtm_len;
    for(i = [0 : charsBtm_len - 1]) {
        rotate((180-BtmCharSpacing*10) - (-i * step_angle)) 
            translate([0, radius + font_size / 2, 0])
               rotate(180,0,0)
                text(
                    charsBtm[charsBtm_len - i - 1], 
                    font = SelectedFont, 
                    size = font_size, valign = "center", halign = "center"
                );
    }
}
//Ring creation removing text
difference(){
 difference(){
  difference(){
    cylinder(h=RingHeight,r=RingRadius, center = false);
    translate([0,0,-1])cylinder(h=RingHeight+2,r=RingRadius-10,center=false);
  } translate([0,0,RingHeight-TextDepth])linear_extrude(RingHeight+2)revolveTop_text(radius, charsTop);
 } translate([0,0,RingHeight-TextDepth])linear_extrude(RingHeight+2)revolveBtm_text(radius, charsBtm);
}
//Star definition follows
// number of points on the star (3 or more makes sense)
_points = StarPoints;
// length of ech point from center.  1/2 the rounding value will be added to the length
_point_len = RingRadius-10;
// used to adjust width of each point +/-
_adjust = 0;
// point height at end of points (thinkness of objet at thinest part. Should be less than cent_h
_pnt_h = StarHeight / 3;
// height at center of star. set equal to pnt_h for flat object
_cent_h = StarHeight;
// diameter of rounding at end of point (must be greater than 0).
_rnd=1;

// resolution for rounded point
_fn = 25;


// modules in library:
module star_3d(points, point_len, adjust=0, pnt_h =1, cent_h=1, rnd=0.1, fn=25)
{
    // star_3d: star with raised center.
    //----------------------------------------------//
    // points = num points on star (should be >3.  
    //          Using 3 may require addisional 
    //          adjust be applied.)
    // point_len = len of point on star 
    //              (actual len of point will add 
    //              1/2 rnd to the length.)
    // adjust = +/- adjust of width of point
    // pnt_h = height of star at end of point
    // cent_h = height of star in center needs to be > pnt_h to have effect.
    // rnd = roundness of end of point (diameter)
    // fn = $fn value for rounded point
    //----------------------------------------------//
    
    point_deg= 360/points;
    point_deg_adjusted = point_deg + (-point_deg/2) +  adjust;
    
    if(points == 3 && adjust == 0)
    {  // make a pyramid (this is to avoid rendering 
       //            issues in this special case)
        hull()
        {
           for(i=[0:2])
           {
               rotate([0,0,i*point_deg])
               translate([point_len,0,0])
                    cylinder(pnt_h, d=rnd, $fn=fn);
           }
           cylinder(cent_h, d=.001);
        }
    }
    else
    { // use algorithm
        for(i=[0:points-1])
        {
            rotate([0,0,i * point_deg]) 
                translate([0,-point_len,0]) 
                point(point_deg_adjusted, 
                      point_len, 
                      rnd, 
                      pnt_h, 
                      cent_h, 
                      fn);
        }
    }

}

module point(deg, leng, rnd, h1, h2, fn=25)
{   // create a point of the star.
    hull()
    {
        cylinder(h1, d=rnd, $fn=fn);
        translate([0,leng,0]) cylinder(h2, d=.001);
        rotate([0,0,-deg/2]) 
            translate([0,leng,0]) cylinder(h1, d=rnd);
        rotate([0,0,deg/2]) 
            translate([0,leng,0]) cylinder(h1, d=rnd);
    }
}

// star object:
rotate([0,0,StarRotate])star_3d(points = _points,
        point_len = _point_len,
        adjust = _adjust, 
        pnt_h = _pnt_h, 
        cent_h =_cent_h, 
        rnd = _rnd,
        fn = _fn);


