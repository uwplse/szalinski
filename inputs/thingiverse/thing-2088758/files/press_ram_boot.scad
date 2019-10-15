Rl = 25.1;
Rw = 25.1;
outer_footprint_factor = 0.25;
total_boot_height = 20;
ram_depth = 10;

Bl = (Rl*outer_footprint_factor)+Rl;
Bw = (Rw*outer_footprint_factor)+Rw;

module boot() {
    cube([Bl, Bw, total_boot_height]);
}

module inset() {
    translate([(Bl-Rl)/2,(Bw-Rw)/2,total_boot_height-ram_depth]) cube([Rl,Rw,ram_depth]);
}


module fp () {
    difference()
    {
        boot();
        inset();
    }
}


fp();