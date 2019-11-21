name="Name";
// font name
font_name = "Courgette"; // [Gloria Hallelujah, Pacifico, Courgette, Permanent Marker, Domine:Domine bold, Ultra, Bevan]

// Manually set length to match name
length=50;
width=20;
height=10;

l=length; w=width; h=height;

translate([10,10,0])
linear_extrude(height)
text(name, font = font_name);



difference()
{
  face(l,w,h);
  translate([4,4,h/2]) face(l-8,w-8,h/2+1);
}

translate([-4,15,0]) difference()
{
  cylinder(h,6,6,0);
  cylinder(h+1,4,4,0);
}

module face(l, w, h)
{
    linear_extrude(h)
    translate([5,5,0])
    hull()
    {
      circle(5);
      translate([l,0,0]) circle(5);
      translate([0,w,0]) circle(5);
      translate([l,w,0]) circle(5);
    }
}