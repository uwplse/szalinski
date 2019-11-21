$medal_diameter=50;
$medal_inner_diameter=46;
$medal_height=2.6;
$medal_inner_height=1.6;
$fn=100;

$holder_width=12;
$holder_height=5;
$holder_thickness=2.5;
$holder_rounding=1;

difference(){
union(){
difference(){
//******band_holder
translate([-$holder_width/2,$medal_diameter/2-$holder_height,0]){
minkowski()
{
cube([$holder_width,2*$holder_height,$medal_inner_height]);
 cylinder(r=$holder_rounding,h=0.01);
};
};

//******band_hole
translate([-($holder_width-2*$holder_thickness)/2,$medal_diameter/2-$holder_thickness,0]){
minkowski()
{
cube([$holder_width-2*$holder_thickness,2*$holder_height-2*$holder_thickness,$medal_inner_height]);
 cylinder(r=$holder_rounding,h=0.01);
};
};
};
//*******medal_body
cylinder(d=$medal_diameter,h=$medal_height);

};
//*******medal_cutting
translate([0,0,$medal_inner_height])cylinder(d=$medal_inner_diameter,h=$medal_height-
$medal_inner_heigh);


};