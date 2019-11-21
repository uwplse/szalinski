height = 20;
// 6.35 is exactly 1/4". Make it undersized so it will slip out.
distance_across_flats = 6;

linear_extrude(20) circle(distance_across_flats / 2 / cos(30), $fn = 6);