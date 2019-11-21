//Specify the height
Height = 1 ; // [1:0.25:5]

2020_ProfileEndcap ();

module 2020_ProfileEndcap() {
    difference () {
        union () {
            translate ([0,0,0]) cube ([20,20,Height]);

            translate ([0,6.75,Height]) cube ([4,6.5,5]);
            translate ([16,6.75,Height]) cube ([4,6.5,5]);

            translate ([6.75,0,Height]) cube ([6.5,4,5]);
            translate ([6.75,16,Height]) cube ([6.5,4,5]);

        }
        *translate ([10,10,-2.5]) rotate ([0,0,0]) cylinder (d=InnerDiameter,h=10);
    }
}