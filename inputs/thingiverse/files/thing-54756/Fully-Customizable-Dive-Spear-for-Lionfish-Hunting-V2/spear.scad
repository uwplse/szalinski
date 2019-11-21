// How thick the spear should be?
radius_cylinder=5;//[0:30]

// How long the spike should be?
height_spikes=120;//[0:200]

// How long the spike top should be?
spike_length=160;//[0:200]

sum=height_spikes+spike_length;

// How wide the spike bar should be?
spike_bar_width=90;//[15:300]
bar=spike_bar_width;



// Number of spikes?
Number_of_spikes=3;//[0,1,2,3,4,5,6,7,8,9,10,11,12]


a=Number_of_spikes-1;
//This option will not apear
rotate_z=90*1;
//This option will not apear
rotate_y=0*1;

//width of spikes
width_of_spikes=3;//[0,1,2,3,4,5,6,7,8,9,10,11,12]

//adjust size spike thing
radius_spike=5;

b=width_of_spikes;

dis=spike_bar_width/a;

module spear()
{
translate([0,bar/2,0])rotate([0,90,0])cylinder(100,r=radius_cylinder);
translate([0,bar,0])rotate([90,0,0])cylinder(spike_bar_width,r=radius_cylinder);

translate([0,0,0])sphere(5,r=radius_cylinder);
translate([0,bar,0])sphere(5,r=radius_cylinder);

//spikes

for(i=[0:a])
{

translate([-spike_length,dis*i,0])rotate([0,90,0])cylinder(spike_length,r=radius_cylinder);
translate([-sum,dis*i,0])rotate([0,90,0])cylinder(height_spikes,0,r2=radius_cylinder);
translate([-sum,dis*i,0])rotate([rotate_x,rotate_z,rotate_y])cylinder(height_spikes,0,r2=radius_spike);
for(y=[0:b])
{
translate([-sum,dis*i,0])rotate([y,rotate_z,rotate_y])cylinder(height_spikes,0,r2=radius_spike);
}
}
}
spear();