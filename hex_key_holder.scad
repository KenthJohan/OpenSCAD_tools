// https://www.lwfasteners.com.tw/index.php?option=module&lang=en&task=pageinfo&id=51&index=1

// https://github.com/openscad/openscad/issues/405

Bolt_M1_4 = 0;
Bolt_M1_6 = 1;
Bolt_M2 = 2;
Bolt_M2_5 = 3;
Bolt_M3 = 4;
Bolt_M4 = 5;
Bolt_M5 = 6;
// DIN 912 screws across flats sizes
//          M1.4 M1.6 M2   M2.5 M3   M4   M5   M6
DIN912_s = [1.5, 1.5, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0, 8.0, 10.0, 12.0, 14.0, 17.0];
hex_key_set1 = [1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0, 8.0];
hex_key_set2 = [4.0, 5.0, 6.0, 8.0, 10.0, 12.0];


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
                hex(arr[i], h);
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


module case(t,l,h,r) {
    hull(){
        translate([-t/2+r, l/2-r, 0])
            cylinder(h=h, r=r,center=true);
        translate([-t/2+r, -l/2+r, 0])
            cylinder(h=h, r=r,center=true);
        translate([t/2-r/2, l/2-r/2, 0])
            cube([r,r,h],center=true);
        translate([t/2-r/2, -l/2+r/2, 0])
            cube([r,r,h],center=true);
    }
}



corner_radius = 10;
magnet_thick = 4;
magnet_radius = 5;

translate([-20, 0, 0])
difference() {
    spacing = 12;
    thick = 20;
    length = 100;
    height = 14;
    case(thick, length, height, corner_radius);
    //cube([thick, length,height],center=true);
    group() {
        rotate ([0,90,0])
            translate([0, 0, thick/2])
            grid_linear_y(n=7, stride=14)
                color([1,0,1])
                cylinder(h=magnet_thick, r=magnet_radius,center=true);
        translate([0, 0, 0])
            hexes(height+1, spacing, hex_key_set1);
        translate([-thick/2, 0, 0])
            texes(spacing, hex_key_set1);
    }
}


translate([20, 0, 0])
difference() {
    spacing = 16;
    thick = 20;
    length = 100;
    height = 14;
    case(thick, length, height, corner_radius);
    //cube([thick, length,height],center=true);
    group() {
        rotate ([0,90,0])
            translate([0, 0, thick/2])
            color([1,0,1])
            grid_linear_y(n=7, stride=14)
                cylinder(h=magnet_thick, r=magnet_radius,center=true);
        translate([0, 0, 0])
            hexes(height+1, spacing, hex_key_set2);
        translate([-thick/2, 0, 0])
            texes(spacing, hex_key_set2);
    }
}


