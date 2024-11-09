module case(t,l,h,r) {
    hull(){
        translate([-t/2, l/2, h])
            cylinder(h=h, r=r,center=true);
        translate([t/2, l/2, h])
            cube([r,r,h],center=true);
        translate([t/2, -l/2, h])
            cube([r,r,h],center=true);
        translate([-t/2, -l/2, h])
            cylinder(h=h, r=r,center=true);
    }
}


case(20, 100, 14, 5);