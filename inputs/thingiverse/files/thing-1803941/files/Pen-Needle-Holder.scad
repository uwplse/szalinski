/* Created by Allon Stern
   A holder for BD Ultra-Fine™ Pen Needles.
   Please let me know of any adjustments you find that need to be made!
   Thanks.
   
*/

wfudge=0.45*1;        // fudge factor for outside diameters to fit original part

rim_w=15.5+wfudge;
rim_h=1.3*1;
base_wb=13.7+wfudge;
base_wt=13.5+wfudge;
base_h=10-rim_h;
cone_wb=11.5+wfudge;
cone_wt=8.25+wfudge;
cone_h=4.3*1;
tip_wb=7.35+wfudge;
tip_wt=6.2+wfudge;
tip_h=16*1;

total_h=rim_h+base_h+cone_h+tip_h;

fin_h=2*1;  // 1.25;
fin_w=1*1;  // 0.75;

Rows=3;     // [1:12]
Cols=4;     // [1:12]

$fn=50*1;

module needleunit() {
cylinder(rim_h, rim_w/2, rim_w/2);
translate([0,0,rim_h]) cylinder(base_h, base_wb/2, base_wt/2);
translate([0,0,rim_h+base_h]) cylinder(cone_h, cone_wb/2, cone_wt/2);
translate([0,0,rim_h+base_h+cone_h]) cylinder(tip_h, tip_wb/2,tip_wt/2);

translate([0,0,rim_h+base_h]) {
    intersection() {
    cylinder(cone_h, (cone_wb+fin_h)/2, (cone_wt+fin_h)/2);
    for (r=[0:3])
        rotate([0,0,45*r])
            translate([-(cone_wb/2+fin_h),-fin_w/2, 0]) cube([cone_wb+(2*fin_h),fin_w,cone_h]);
}
}
}


module every_other_flipped(rows,cols)
{
    for (r=[0:rows-1]) {
        translate([0,(tip_wb+rim_w)/2*r,0])
        for (c=[0:cols-1]) 
        {
            translate([(tip_wb+rim_w)/2*c,0,(total_h)*((c+r)%2)])
            rotate([0,180*((c+r)%2),0])
            needleunit();
        }
    }
}


module case(rows, cols) {
    buffer=1;

    difference() {
        translate([-(buffer+(rim_w)/2),-rim_w/2,rim_h+base_h])
            cube([(tip_wb+rim_w)/2*(cols)+tip_wb/2+(2*buffer),
                    (tip_wb+rim_w)/2*(rows)+tip_wb/2+(2*buffer),
                    cone_h+(total_h/2)-base_h-0.45]);
        every_other_flipped(rows,cols);
    }
}

case(Rows,Cols);
