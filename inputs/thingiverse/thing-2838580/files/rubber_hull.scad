// Defines the fit between your hull and the rubber
distance_between_rubber_and_hull = 0.5;
// Defines the thickness of the hull's wall in mm
tickness = 1;
// width of the rubber in mm
width = 10;
// height of the rubber in mm
height = 20;
// length of the rubber in mm
length = 30;
difference() {
  cube([((length + distance_between_rubber_and_hull) + tickness), ((width + distance_between_rubber_and_hull) + tickness), ((height + distance_between_rubber_and_hull) + tickness)], center=true);

  cube([(length + distance_between_rubber_and_hull * 3), (width + distance_between_rubber_and_hull), (height + distance_between_rubber_and_hull)], center=true);
}