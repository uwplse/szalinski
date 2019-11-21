

difference () {

union() {
linear_extrude (6.5)
circle (d=8.1, $fn=36);


union () {
linear_extrude (3)
circle (d=10, $fn=36);

linear_extrude (2)
circle (d=22, $fn=36);
}
}

translate ([0,0,2])
linear_extrude (10)
circle (d=6.5, $fn=36);
}