//number of facets
$fn = 1000;

//wall thickness
wall=4;

//size of large pipe
pipelarge=58.5;

//size of small pipe
pipesmall=49.5;

//end lip length
end=20;

//midsection length
midsection=30;

difference () {
    cylinder(midsection,d1=pipelarge+wall,d2=pipesmall+wall);
    cylinder(midsection,d1=pipelarge,d2=pipesmall);
}
translate ([0,0,midsection])
difference () {
    cylinder(end,d=pipesmall+wall);
    cylinder(end,d=pipesmall);
}
translate ([0,0,-end])
difference () {
    cylinder(20,d=pipelarge+wall);
    cylinder(20,d=pipelarge);
}