/* [Hex key] */
global_hex_key_set1 = [1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0, 8.0];
global_hex_key_set2 = [4.0, 5.0, 6.0, 8.0, 10.0, 12.0];
global_spacing1 = 12;
global_spacing2 = 16;
global_hex_margin = 0.3;

/* [Box] */
global_corner_radius = 8;
global_h1 = 8;
global_h2 = 13;
global_thick = 20;

/* [Magnet] */
global_magnet_thick = 4;
global_magnet_radius = 5;



module hex(s,h) {
    n = 6;
    rm = s / 2;
    r = rm / cos(180/n);
    cylinder(h=h, r=r,$fn=n,center=true);
}

module t(t, s = 7, style = ":style=Bold", spacing = 1) {
  rotate([90, 0, 0])
    mirror([0,0,1])
    mirror([0,1,0])
    linear_extrude(height = 3, center=true)
      text(t, size = s,
           spacing=spacing,
           halign = "center",
           font = str("Liberation Sans", style),
           $fn = 16);
}

module hexes(h, spacing, arr) {
    //spaces = [for (x = [0:len(arr)-1]) x*spacing];
    //y = -arr[0]*spacing - spaces[len(spaces)-1]/2;
    //y = -spaces[0] - spaces[len(spaces)-1]/3;
    //y = 0;
    y = spacing * ((len(arr)-1) / 2.0);
    color([0,1,0])
    translate([0, -y, 0]) {
        for ( i = [0:len(arr)-1] ){
            translate([0, i * spacing, 0]) {
                hex(arr[i]+global_hex_margin, h);
            }
        }
    }
}

module texes(spacing, arr) {
    s = 5;
    y = spacing * ((len(arr)-1) / 2.0);
    translate([0, -y, 0])
    color([1,0,0])
    for ( i = [0:len(arr)-1] ){
        translate([0, i * spacing, -s/2])
        rotate ([0,180,90])
        t(t=str(arr[i]),s=s);
    }
}

module grid_linear_y(n, stride) {
    translate([0, ((n-1)/2) * -stride, 0])
    for ( i = [0:n-1] ){
        translate([0, i*stride, 0])
            children();
    }
}


module case(t,l,h,r,h2) {
    th = 1;
    //translate([t/2-th/2, 0, 0]) cube([th,l,h*2],center=true);
    hull(){
        translate([-t/2+r, l/2-r, -h/2])
            rotate ([0,0,90]) rotate_extrude(angle=90) square([r,h]);
        translate([-t/2+r, -l/2+r, -h/2])
            rotate ([0,0,180]) rotate_extrude(angle=90) square([r,h]);
        translate([t/2-th/2, 0, 0])
            cube([th,l,h2],center=true);
    }
}



module product(thick = 20, corner_radius = 10, magnet_thick = 4, magnet_radius = 5, length = 100, h1 = 14, h2 = 14, spacing, arr) {
    difference() {
        case(thick, length, h1, corner_radius, h2);
        //cube([thick, length,height],center=true);
        group() {
            rotate ([0,90,0])
                translate([0, 0, thick/2])
                grid_linear_y(n=7, stride=14)
                    color([1,0,1])
                    cylinder(h=magnet_thick, r=magnet_radius, center=true);
            translate([0, 0, 0])
                hexes(h1+10, spacing, arr);
            translate([-thick/2, 0, 0])
                texes(spacing, arr);
        }
    }
}






translate([-20, 0, 0])
product(
thick = global_thick,
h1 = global_h1,
h2 = global_h2,
corner_radius = global_corner_radius, 
magnet_thick = global_magnet_thick, 
magnet_radius = global_magnet_radius, 
spacing = global_spacing1, 
arr = global_hex_key_set1);

translate([20, 0, 0])
product(
thick = global_thick,
h1 = global_h1,
h2 = global_h2,
corner_radius = global_corner_radius, 
magnet_thick = global_magnet_thick, 
magnet_radius = global_magnet_radius, 
spacing = global_spacing2, 
arr = global_hex_key_set2);
