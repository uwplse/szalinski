// 18650 holder
//
// http://www.thingiverse.com/mikegi/about

number_of_batteries = 2; // [1:8] 
battery_diameter =  18 + 3 ; 
holder_height = 17; // [10:30]
space_on_bottom = 3; // [2:5] 
space_between_holders_and_edges = 3; // [2:10]
clips = "true"; // [true, false]

difference()
{
translate( [-(battery_diameter + space_between_holders_and_edges *2)/2, 0,0])
cube([ battery_diameter + space_between_holders_and_edges *2  , battery_diameter * number_of_batteries + space_between_holders_and_edges * (number_of_batteries + 1) , holder_height]);

translate([0, -( battery_diameter/2) ,space_on_bottom ])
for (i = [ 1:number_of_batteries ])
{
translate([0,(space_between_holders_and_edges + battery_diameter) * i, 0])
cylinder( h = holder_height, d = battery_diameter);

}
}

if ( clips == "true" )
{
translate([0, -( battery_diameter/2) ,0])
for (i = [ 1:number_of_batteries ])
{
translate([0,(space_between_holders_and_edges + battery_diameter) * i, 0])
{
translate([ - (battery_diameter/2 + space_between_holders_and_edges + 7), -5, 0 ])
cube( [3,10,holder_height] );
translate([- (battery_diameter/2 + space_between_holders_and_edges + 6), -5,holder_height-5])
cube( [6,10,5] );
}
}

}

