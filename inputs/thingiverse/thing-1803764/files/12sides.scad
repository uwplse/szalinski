difference()
{
    // 23.03 x 2.8mm, 12 sides
    cylinder($fn = 12, h = 2.8, d = 23.03, center=true);

    // keyring hole
    translate([7,0,0]) cylinder($fn=50, h=4, d=5, center=true);
}
