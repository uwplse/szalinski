/* [Customize] */
Nasty_Thing_for="Him";//[Both,Her,Him]
inner_diameter=36;//[30:50]
holder="yes";//[yes,no]
holder_height=9;//[5:9]
/* [For Her] */
number_of_spikes_for_her=9;//[0:35]
spike_length_for_her=30;//[0:50]
spike_base_for_her=5;//[1:5]
sharp_spikes_for_her="no";//[yes,no]
spike_tilt=20;//[0:40]
/* [For Him] */
number_of_spikes_for_him=9;//[0:21]
spike_length_for_him=6;//[0:15]
spike_base_for_him=5;//[1:10]
sharp_spikes_for_him="no";//[yes,no]
/* [Hidden] */
inner_radius=inner_diameter/2;
Col = Nasty_Thing_for=="Her" ? "MediumVioletRed" : (Nasty_Thing_for=="Him" ? "Navy" : "ForestGreen");
color(Col)
rotate_extrude(convexity = 10, $fn = 100)
translate([inner_radius+2.5, 2.5, 0])
roundedRect([4,4],1);
if (holder=="yes"){
color(Col)
translate([-inner_radius-2.5, -6.5, 0])
difference(){
linear_extrude(height = holder_height, convexity = 10)
hull($fn = 100){
    translate([0,1,0])
    circle(r=1);
    translate([0,12,0])
    circle(r=1);
    translate([-6.5,6.5,0])
    circle(r=4.5);
    }
translate([-8.7,4.9,0])cube([6.2,3.2,9]);
}}
if(Nasty_Thing_for=="Her" || Nasty_Thing_for=="Both"){
    color(Col)
if (number_of_spikes_for_her!=0){
for ( i = [0 : number_of_spikes_for_her-1] ){
    if(!(i==0 && holder=="yes")){
    rotate( (i * 360 / number_of_spikes_for_her)+90, [0, 0, 1])
    translate([0, inner_radius+2.5, 3])
    rotate(-spike_tilt,[1,0,0])
    rotate(45)
    hull(){
        if (sharp_spikes_for_her=="no"){
            translate([0,0,spike_length_for_her+1.5])
            sphere(0.5, $fn=100);
        }
        cylinder(h = spike_length_for_her+2, d1 = spike_base_for_her, d2 = 0, $fn = 100);
}}}}}
if(Nasty_Thing_for=="Him" || Nasty_Thing_for=="Both"){
    color(Col)
if (number_of_spikes_for_him!=0){
for ( i = [0 : number_of_spikes_for_him-1] ){
    rotate( (i * 360 / number_of_spikes_for_him)+90+spike_base_for_him*1.5, [0, 0, 1])
    translate([0, inner_radius+1.65, 0])
    rotate(268-(spike_base_for_him))
    hull(){
        if (sharp_spikes_for_him=="no"){
            translate([spike_length_for_him+1,spike_base_for_him/2,0])
            cylinder(r=0.5, center=false, h=5, $fn=100);
        }
        linear_extrude(height = 5, convexity = 10, twist = 0)
        polygon(points=[[0,0],[spike_length_for_him+1.5,spike_base_for_him/2],[0,spike_base_for_him]]);
}}}}
module roundedRect(size, radius) {
x = size[0];
y = size[1];
hull(){
    // place 4 circles in the corners, with the given radius
    translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius);

    translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius);

    translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius);

    translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius);
}}