// How wide should the frame be on X-axis?
x_width = 200;
// How wide should the frame be on Y-axis?
y_width = 200;
// How wide should the frame be?
frame_width = 1;
// How high should the frame be?
frame_height = 0.2;

linear_extrude(frame_height)
difference() {
    square([x_width, y_width], center=true);
    square([x_width - 2 * frame_width, y_width - 2 * frame_width], center=true);
}