    //
    // João Sá
    // Escola Secundária de Avelar Brotero
    // Coimbra, Portugal
    //
    
    // Change to set the number of discs
    quant = 8;
    
    diameter = 7.0;
    
    union() {
        for (a=[2:1:quant+1]) {
            
            difference() {
                //echo(a);
                translate([(a*(diameter/2))*a+(a-4)*3.0,0,0])
                // Cilindro menor
                linear_extrude(height = diameter, center = false, convexity = 0, twist = 0, $fn = 50)
                circle(d=a*diameter, $fn = a*20, $fa = 10, $fs = 10);
            
                // Furo
                translate([(a*(diameter/2))*a+(a-4)*3.0,0,0])
                linear_extrude(height = 8.0, center = false, convexity = 0, twist = 0, $fn = 50)
                circle(d=9.1, $fn = 20, $fa = 10, $fs = 10);
            }
        }
    }