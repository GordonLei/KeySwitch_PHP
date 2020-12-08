CREATE TABLE IF NOT EXISTS Users(
    user_id  INT, 
    username varchar(255),
    user_password varchar(255),
    primary key(user_id)
    );

CREATE TABLE  IF NOT EXISTS List(
    list_id INT, 
    description VARCHAR(255),
    rating int not NULL, 
    primary key(list_id)
);

CREATE TABLE IF NOT EXISTS Owns(
    user_id  INT, 
    list_id INT, 
    foreign key (user_id) references Users(user_id),
    foreign key (list_id) references List(list_id),
    primary key(user_id, list_id)
);

CREATE TABLE IF NOT EXISTS Keyboard(
    keyboard_name VARCHAR(32),
    keyboard_type VARCHAR(32),
    mounting varchar(16),
    color varchar(16),
    PRIMARY KEY (keyboard_name,color)
);

CREATE TABLE IF NOT EXISTS Switch(
    switch_name VARCHAR (16),
    switch_type VARCHAR (16),
    actuation_distance INT,
    bottom_out_distance INT,
    operating_force INT,
    bottom_out_force INT, 
    manufacturer VARCHAR (16),
    pins INT,
    PRIMARY KEY (manufacturer, switch_name)
);

CREATE TABLE  IF NOT EXISTS KeyCap(
    set_name VARCHAR (32),
    cap_manufacturer VARCHAR (16),
    cap_profile VARCHAR (6),
    material VARCHAR (3),
    PRIMARY KEY (set_name)
);

CREATE TABLE  IF NOT EXISTS Designer(
    designer_id INT,
    designer_name VARCHAR(16), 
    designer_description VARCHAR (255),
    PRIMARY KEY (designer_id)
);

CREATE TABLE IF NOT EXISTS Designed_Keyboard(
    designer_id INT,
    keyboard_name VARCHAR(32),
    color varchar(16),
    FOREIGN KEY (keyboard_name, color) references Keyboard(keyboard_name,color), 
    FOREIGN KEY (designer_id) references Designer(designer_id),
    PRIMARY KEY (keyboard_name, color, designer_id)
);

CREATE TABLE IF NOT EXISTS Designed_KeyCap(
    designer_id INT,
    set_name VARCHAR (32),
    FOREIGN KEY (set_name) references KeyCap(set_name), 
    FOREIGN KEY (designer_id) references Designer(designer_id),
    PRIMARY KEY (set_name, designer_id)
);



CREATE TABLE IF NOT EXISTS user_comment(
    comment_id INT, 
    comment_text VARCHAR (255),
    user_id  INT, 
    list_id INT,
    foreign key (list_id) references List(list_id),
    foreign key (user_id) references Users(user_id),
    PRIMARY KEY (comment_id, list_id, user_id, comment_text)
);

CREATE TABLE IF NOT EXISTS Build(
    build_id INT,
    plate VARCHAR(32),
    layout varchar(32),
    stabilizer VARCHAR(32),
    lube VARCHAR(32),
    list_id INT,
    keyboard_name VARCHAR(32),
    color varchar(16),
    switch_name VARCHAR (16),
    manufacturer VARCHAR (16),
    set_name VARCHAR (32),
    foreign key (list_id) references List(list_id),
    foreign key (keyboard_name, color) references Keyboard(keyboard_name,color),
    foreign key (switch_name, manufacturer) references Switch(switch_name,manufacturer),
    foreign key (set_name) references KeyCap(set_name),
    PRIMARY KEY (list_id, build_id, keyboard_name, color, switch_name, manufacturer, set_name, plate, layout, stabilizer, lube)
);


/*
Keyboard's data members

keyboard_name VARCHAR(32),
keyboard_type VARCHAR(32),
mounting varchar(16),
color varchar(16),
*/

INSERT INTO Keyboard (keyboard_name,keyboard_type, mounting,color)
    VALUES 
        ('NK65 - Olivia Edition', '65%', 'Top Mount', 'Light'), 
        ('NK65 - Olivia Edition', '65%', 'Top Mount', 'DARK'),
        ('NK65', '65%', 'Top Mount', 'N65 Purple'),
        ('NK65', '65%', 'Top Mount', 'Biege'),
        ('NK65', '65%', 'Top Mount', 'Blumen'),
        ('NK65', '65%', 'Top Mount', 'Frost'),
        ('NK65', '65%', 'Top Mount', 'Smoke'),
        ('NK65 - Milkshake Edition', '65%', 'Top Mount', 'E-White'),
        ('NK65 - RPF Edition', '65%', 'Top Mount', 'Translucent Green'),
        ('7V', '75%', 'Leaf-spring PCB Mount', 'Blue'),
        ('7V', '75%', 'Leaf-spring PCB Mount', 'Black'),
        ('7V', '75%', 'Leaf-spring PCB Mount', 'Gray'),
        ('7V', '75%', 'Leaf-spring PCB Mount', 'E-White'),
        ('7V', '75%', 'Leaf-spring PCB Mount', 'E-White'),
        ('No.2/65', '65%', 'Gasket Sandwich Mount', 'Black'),
        ('No. 1/60 Rev. 1 ', '60%', 'Gasket Sandwich Mount', 'Black'),
        ('No. 1/60 Rev. 1 ', '60%', 'Gasket Sandwich Mount', 'White'),
        ('No. 2 Rev. 1 ', 'TKL', 'Gasket Sandwich Mount', 'Dark Gray'),
        ('No. 2 Rev. 1 ', 'TKL', 'Gasket Sandwich Mount', 'Brass'),
        ('Tofu 60%', '60%', 'Tray Mount', 'Black'),
        ('Tofu 60%', '60%', 'Tray Mount', 'Silver'),
        ('Tofu 60%', '60%', 'Tray Mount', 'White'),
        ('Tofu HHKB', 'HHKB', 'Tray Mount', 'Black'),
        ('Tofu HHKB', 'HHKB', 'Tray Mount', 'Gray'),
        ('KBD67V2 MKII', '65%', 'Top Mount', 'Black'),
        ('KBD67V2 MKII', '65%', 'Top Mount', 'White'),
        ('KBD67V2 MKII', '65%', 'Top Mount', 'Rose Gold'),
        ('KBD75V2', '75%', 'Top Mount', 'Black'),
        ('Kara', 'HHKB', 'MUTE Mount', 'Noct'),
        ('Kara', 'HHKB', 'MUTE Mount', 'Moon'),
        ('Kara', 'HHKB', 'MUTE Mount', 'Soya'),
        ('Kara', 'HHKB', 'MUTE Mount', 'Iced'),
        ('Kara', 'HHKB', 'MUTE Mount', 'Azur'),
        ('Kara', 'HHKB', 'MUTE Mount', 'Haze'),
        ('U80-A SEQ2', 'TKL', 'MUTE Mount', 'Kuro Stealth'),
        ('U80-A SEQ2', 'TKL', 'MUTE Mount', 'Moon Stealth'),
        ('U80-A SEQ2', 'TKL', 'MUTE Mount', 'Sage'),
        ('U80-A SEQ2', 'TKL', 'MUTE Mount', 'Yolk'),
        ('U80-A SEQ2', 'TKL', 'MUTE Mount', 'Soya'),
        ('Jules', '65%', 'Top Mount', 'Kuro'),
        ('Jules', '65%', 'Top Mount', 'Navy'),
        ('Jules', '65%', 'Top Mount', 'Halt'),
        ('Jules', '65%', 'Top Mount', 'Ouro')
    ON CONFLICT DO NOTHING; 
    
/*
KeyCap 

CREATE TABLE  IF NOT EXISTS KeyCap(
    set_name VARCHAR (32),
    cap_manufacturer VARCHAR (16),
    cap_profile VARCHAR (6),
    material VARCHAR (3),
    PRIMARY KEY (set_name)
);
*/

INSERT INTO KeyCap(set_name, cap_manufacturer, cap_profile, material)
    VALUES 
        ('GMK Olivia++', 'GMK', 'Cherry', 'ABS'), 
        ('GMK Mizu', 'GMK', 'Cherry', 'ABS'), 
        ('GMK Olivia++', 'GMK', 'Cherry', 'ABS'), 
        ('KAT Milkshake', 'Keyreative', 'KAT', 'ABS'),
    ON CONFLICT DO NOTHING; 

