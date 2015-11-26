include <configuration.scad>
include <shapes.scad>


module limitSwitchHolder(rod_dia = 8) {
    height=8;
    width = rod_dia + 9;
    length=rod_dia + 14;

    support_height=5;
    tol=0.1;
    
    rotate([0,0,90]) {
        difference() {
            union() {
                // clamp
                translate([-width/2,-length/2,0]) roundedCube(size=[width,length,height]);
                // support
                translate([0,0,0]) roundedCylinder(d=rod_dia + 4,h=height+support_height);
                // plate
                translate([-5,-42,0])roundedCube([10,33,height]);
            }
            // space for back-side electronics
            translate([-5+1.5,-35,height-1])roundedCube([7,13,height]);   
            // screw holes
            hull() {
                translate([0,-41+2.5,0])cylinder(d=m3_dia, h=height);
                translate([0,-41+4,0])cylinder(d=m3_dia, h=height);
            }
            hull() {
                translate([0,-41+21.5,0])cylinder(d=m3_dia, h=height);
                translate([0,-41+23,0])cylinder(d=m3_dia, h=height);
            }
            // nuts
            hull() {
                translate([0,-41+2.5,0])rotate([0,0,30])cylinder(d=m3_nut_dia, h=m3_nut_height, $fn=6);
                translate([0,-41+23,0])rotate([0,0,30])cylinder(d=m3_nut_dia, h=m3_nut_height, $fn=6);
            }

            // rod hole
            cylinder(r=rod_dia/2+tol,h=height+support_height+2*tol);

            // clamp space
            translate([(-rod_dia-tol)/2,rod_dia/4,0-tol]) cube(size=[rod_dia+tol,length+tol,height+support_height + 2*tol]);
            translate([-rod_dia,rod_dia/4,height]) cube(size=[rod_dia*2,12/2+tol,support_height+2*tol]);

            // screw hole
            translate([-width/2-tol,rod_dia/2+2,height/2]) rotate([0,90,0]) cylinder(d=m3_dia,h=width+2*tol);
            // nut space
            translate([-width/2-tol,rod_dia/2+2,height/2]) rotate([0,90,0]) rotate([0,0,30]) cylinder(r=m3_dia,h=1.3,$fn=6);
        }
        // print support
        color([1,0,0,1]) {
            translate([0,-41+3,m3_nut_height])cylinder(d=m3_nut_dia, h=print_layer_height);
            translate([0,-41+22,m3_nut_height])cylinder(d=m3_nut_dia, h=print_layer_height);
        }
    }
}

//$fs=0.3;
//$fa=3;
//limitSwitchHolder();
//translate([0,20,0])limitSwitchHolder(rod_dia = 12);