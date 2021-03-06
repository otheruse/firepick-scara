include <configuration.scad>

//Base plate:
//
//49.5mm tussen motor gaten
//
//16 mm centrum gat tot dischtsbijzijnde motor gat (x) 
//
////50mm van centrum as to centrum motor (y)
////9mm van centrum as to centrum motor (x, naar binnen)
//
//16mm diameter centrum gat
//180 mm centrum gat tot rand (y)
//12mm diameter as gaten (Waarom as gaten?)
//400mm breed (x)
//460mm lang (y)
//
//Support arm (lang) 150mm van centrum (x) 0mm (y)
//Support arm (kort) 150mm van centrum (y) 70mm (x)
//
//Top plate:
//
//200mm lang (y)
//320mm breed (x)
//
//26mm diameter centrum gat
//
//Centrum assen 160mm van de rand (y) (60mm van centrum)
//
//Support arm (lang) 70mm van centrum (y) 20mm (x)
//
//Support arm (kort) 140mm van centrum (x) 0mm (y)
//
//motor gat 40mm van centrum (y) 0mm (x)
//
//22mm diameter motor gat 
//
//Pipes:
//Long: 458.476 - 20 = 438.476
//Short: 451.442 - 20 = 431.442

base_width = 400;
base_length = 460;

platform_width = 320;
platform_length = 200;

module ZMountHoles() {
    // Z-mount holes
    rotate(225)translate([19,19])circle(d=m4_dia);
    for (i=[-1, 1]) {
//            translate([i,0])circle(d=rod_diameter);
        for (j=[-(5+rod_diameter/2),(5+rod_diameter/2)]) {
            translate([i*(rodspacing/2+5+rod_diameter/2),j])circle(d=m4_dia);
        }
    }
}

module base() {
    difference() {
        // base
        translate([0,-50])hull() {
            translate([-base_width/2+25, base_length/2-25])circle(d=50);
            translate([base_width/2-25,  base_length/2-25])circle(d=50);
            translate([-base_width/2+5,  -base_length/2+5])circle(d=10);
            translate([base_width/2-5,  -base_length/2+5])circle(d=10);
        }
        // 
        translate([0,-base_length/2-50])circle(d=platform_width);
        // main axis
        circle(d=16);
        // long support 
        for (i=[-150,150]) {
            translate([i,0])circle(d=4);
        }
        // short support
        for (i=[-140,140]) {
            translate([i,160])circle(d=4);
        }
        // Z-mount holes
        ZMountHoles();
        // Motor mount holes
        for (i=[1,-1]) {
            translate([i*(rodspacing/2-10),-60]) {
//                #circle(d=m4_dia);
                for (j=[-40,40]) {
                    rotate(i*45)translate([j,0])circle(d=m4_dia);
                }
            }
        }

    }
}

module platform() {
    difference() {
        // platform
        hull() {
            difference() {
                circle(d=platform_width);
                translate([-platform_width/2, 0])square([platform_width, platform_width]);
            }
            translate([160-5,35])circle(d=10);
            translate([-160+5,35])circle(d=10);
        }
        // Center hole
        circle(d=26);
        // Z Motor
        translate([0,-40]) {
            // Motor hole
            circle(d=23);
            for (i = [45:90:360]) {
                rotate(i)translate([22,0])circle(d=m3_dia);
            }
            // Motor screw holes
        }
        // Z-mount holes
        rotate(180)ZMountHoles();
        // long support 
        for (i=[-20,20]) {
            translate([i,-130])circle(d=4);
        }
        // short support
        for (i=[-140,140]) {
            translate([i,0])circle(d=4);
        }
        
    }
}

//platform();
//base();