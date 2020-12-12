CREATE TABLE IF NOT EXISTS Users(
    user_id  serial  NOT NULL,  
    username varchar(255) NOT NULL,
    user_password varchar(255) NOT NULL,
    primary key(user_id)
    );

CREATE TABLE  IF NOT EXISTS List(
    list_id serial NOT NULL, 
    description VARCHAR(255), 
    primary key(list_id)
);

CREATE TABLE IF NOT EXISTS Owns(
    user_id  serial  NOT NULL , 
    list_id serial NOT NULL , 
    foreign key (user_id) references Users(user_id) 
        on delete cascade                   
        on update cascade,
    foreign key (list_id) references List(list_id)
        on delete cascade                
        on update cascade,
    primary key(user_id, list_id)
);

CREATE TABLE IF NOT EXISTS Keyboard(
    keyboard_name VARCHAR(32) NOT NULL,
    keyboard_type VARCHAR(32) NOT NULL,
    mounting varchar(32),
    color varchar(32),
    PRIMARY KEY (keyboard_name,color)
);

CREATE TABLE IF NOT EXISTS Switch(
    switch_name VARCHAR (32) NOT NULL,
    switch_type VARCHAR (32) NOT NULL,
    actuation_distance NUMERIC(3,1),
    bottom_out_distance NUMERIC(3,1),
    operating_force NUMERIC(3,1),
    bottom_out_force NUMERIC(3,1), 
    manufacturer VARCHAR (32) NOT NULL,
    pins INT,
    PRIMARY KEY (switch_name)
);

CREATE TABLE  IF NOT EXISTS KeyCap(
    set_name VARCHAR (32) NOT NULL,
    cap_manufacturer VARCHAR (32) NOT NULL,
    cap_profile VARCHAR (6) NOT NULL,
    material VARCHAR (3) NOT NULL,
    PRIMARY KEY (set_name)
);

CREATE TABLE  IF NOT EXISTS Designer(
    designer_id serial NOT NULL ,
    designer_name VARCHAR(32) NOT NULL, 
    designer_description VARCHAR (255),
    PRIMARY KEY (designer_id)
);

CREATE TABLE IF NOT EXISTS Designed_Keyboard(
    designer_id serial NOT NULL  ,
    keyboard_name VARCHAR(32) NOT NULL,
    color varchar(32) NOT NULL,
    FOREIGN KEY (designer_id) references Designer(designer_id)
        on delete cascade                
        on update cascade,
    FOREIGN KEY (keyboard_name, color) references Keyboard(keyboard_name,color)
        on delete cascade                
        on update cascade, 
    PRIMARY KEY (designer_id, keyboard_name, color)
);

CREATE TABLE IF NOT EXISTS Designed_KeyCap(
    designer_id serial  NOT NULL ,
    set_name VARCHAR (32) NOT NULL,
    FOREIGN KEY (designer_id) references Designer(designer_id)
        on delete cascade                
        on update cascade,
    FOREIGN KEY (set_name) references KeyCap(set_name)
        on delete cascade                
        on update cascade, 
    PRIMARY KEY (designer_id, set_name)
);



CREATE TABLE IF NOT EXISTS user_comment(
    comment_id serial NOT NULL , 
    comment_text VARCHAR (255),
    user_id  serial NOT NULL , 
    list_id serial NOT NULL ,
    foreign key (list_id) references List(list_id)
        on delete cascade                
        on update cascade,
    foreign key (user_id) references Users(user_id)
        on delete cascade                
        on update cascade,
    PRIMARY KEY (comment_id, list_id, user_id, comment_text)
);

CREATE TABLE IF NOT EXISTS Build(
    build_id serial NOT NULL ,
    plate VARCHAR(32),
    layout varchar(32),
    stabilizer VARCHAR(32),
    lube VARCHAR(32),
    list_id INT,
    keyboard_name VARCHAR(32) NOT NULL,
    color varchar(32) NOT NULL,
    switch_name VARCHAR (32) NOT NULL,
    set_name VARCHAR (32) NOT NULL,
    foreign key (list_id) references List(list_id)
        on delete cascade                
        on update cascade,
    foreign key (keyboard_name, color) references Keyboard(keyboard_name,color)
        on delete cascade                
        on update cascade,
    foreign key (switch_name) references Switch(switch_name)
        on delete cascade                
        on update cascade,
    foreign key (set_name) references KeyCap(set_name)
        on delete cascade                
        on update cascade,
    PRIMARY KEY (list_id, build_id, keyboard_name, color, switch_name, set_name, plate, layout, stabilizer, lube)
);


/*
Keyboard's data members

keyboard_name VARCHAR(32),
keyboard_type VARCHAR(32),
mounting varchar(32),
color varchar(32),
*/

INSERT INTO Keyboard (keyboard_name,keyboard_type, mounting,color)
    VALUES 
        ('NK65 - Olivia Edition', '65%', 'Top Mount', 'Light'), 
        ('NK65 - Olivia Edition', '65%', 'Top Mount', 'Dark'),
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
        ('No. 1/60 Rev. 1', '60%', 'Gasket Sandwich Mount', 'Black'),
        ('No. 1/60 Rev. 1', '60%', 'Gasket Sandwich Mount', 'White'),
        ('No. 2 Rev. 1', 'TKL', 'Gasket Sandwich Mount', 'Dark Gray'),
        ('No. 2 Rev. 1', 'TKL', 'Gasket Sandwich Mount', 'Brass'),
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

    set_name VARCHAR (32),
    cap_manufacturer VARCHAR (32),
    cap_profile VARCHAR (6),
    material VARCHAR (3),
    PRIMARY KEY (set_name)

*/

INSERT INTO KeyCap(set_name, cap_manufacturer, cap_profile, material)
    VALUES 
        ('GMK Olivia++', 'GMK', 'Cherry', 'ABS'), 
        ('GMK Mizu', 'GMK', 'Cherry', 'ABS'), 
        ('KAT Milkshake', 'Keyreative', 'KAT', 'ABS'),
        ('GMK Metropolis', 'GMK', 'Cherry', 'ABS'),
        ('GMK Alter', 'GMK', 'Cherry', 'ABS'),
        ('GMK Bento', 'GMK', 'Cherry', 'ABS'),
        ('GMK Taro', 'GMK', 'Cherry', 'ABS'),
        ('Infinikey Café', 'Infinikey', 'Cherry', 'PBT'),
        ('Infinikey Team Liquid', 'Infinikey', 'Cherry', 'PBT'),
        ('DSA Mafic Girl r2', 'Infinikey', 'DSA', 'PBT')
    ON CONFLICT DO NOTHING; 

/*
Switch
    switch_name VARCHAR (32),
    switch_type VARCHAR (32),
    actuation_distance INT,
    bottom_out_distance INT,
    operating_force INT,
    bottom_out_force INT, 
    manufacturer VARCHAR (32),
    pins INT,
*/
INSERT INTO Switch(switch_name, switch_type, actuation_distance, bottom_out_distance, operating_force, bottom_out_force, manufacturer, pins)
    VALUES 
        ('Cherry Red', 'Linear', 2, 4, 45, 75, 'Cherry', 5), 
        ('Cherry Black', 'Linear', 2, 4, 60, 85, 'Cherry', 5),
        ('Cherry Brown', 'Tactile', 2, 4, 55, 60, 'Cherry', 5),
        ('Cherry Blue', 'Clicky', 2, 4, 60, 60, 'Cherry', 5),
        ('Cherry Clear', 'Tactile', 2, 4, 65, 95, 'Cherry', 5),
        ('Gateron Red', 'Linear', 2, 4, 45, 55, 'Gateron', 5),
        ('Gateron Black', 'Linear', 2, 4, 60, 75, 'Gateron', 5),
        ('Gateron Brown', 'Tactile', 2, 4, 45, 55, 'Gateron', 5),
        ('Gateron Blue', 'Clicky', 2, 4, 55, 60, 'Gateron', 5),
        ('Gateron Clear', 'Linear', 2, 4, 35, 40, 'Gateron', 5),
        ('BOX Navy', 'Clicky', 2, 3.6, 60, 90, 'Kailh', 3),
        ('BOX Jade', 'Clicky', 2, 3.6, 50, 60, 'Kailh', 3),
        ('NovelKeys Cream', 'Linear', 2, 4, 55, 70, 'Kailh', 5),
        ('NovelKeys Cream', 'Linear', 2, 4, 55, 70, 'Kailh', 5)
    ON CONFLICT DO NOTHING; 
/*
Designer
    designer_id INT,
    designer_name VARCHAR(32), 
    designer_description VARCHAR (255),
    PRIMARY KEY (designer_id)
*/
INSERT INTO Designer(designer_id, designer_name, designer_description)
    VALUES 
        (1, 'NovelKeys', 'They make keyboards and sell keycap sets!'), 
        (2, 'RamaWorks', 'They make keyboards!'),
        (3, 'Olivia', 'They design keycaps!'),
        (4, 'Rensuya', 'They design keycaps!'),
        (5, 'biip', 'They design keycaps!'),
        (6, 'Nephlock', 'They design keycaps!'),
        (7, 'Sifo', 'They design keycaps!'),
        (8, 'pwade3', 'They design keycaps!'),
        (9, 'Langelandia', 'They design keycaps!'),
        (10, 'minterly', 'They design keycaps!')
    ON CONFLICT DO NOTHING; 

/*
Designed_Keyboard
    designer_id INT,
    keyboard_name VARCHAR(32),
    color varchar(32),

*/
INSERT INTO Designed_Keyboard(designer_id, keyboard_name, color)
    VALUES 
        (1, 'NK65 - Olivia Edition', 'Light'), 
        (1, 'NK65 - Olivia Edition', 'Dark'), 
        (1, 'NK65', 'N65 Purple'), 
        (1, 'NK65', 'Biege'), 
        (1, 'NK65', 'Blumen'), 
        (1, 'NK65', 'Frost'), 
        (1, 'NK65', 'Smoke'), 
        (1, 'NK65 - Milkshake Edition', 'E-White'), 
        (1, 'NK65 - RPF Edition', 'Translucent Green'), 
        (2, 'Kara', 'Noct'),
        (2, 'Kara', 'Moon'),
        (2, 'Kara', 'Soya'),
        (2, 'Kara', 'Iced'),
        (2, 'Kara', 'Azur'),
        (2, 'Kara', 'Haze'),
        (2, 'U80-A SEQ2',  'Kuro Stealth'),
        (2, 'U80-A SEQ2', 'Moon Stealth'),
        (2, 'U80-A SEQ2', 'Sage'),
        (2, 'U80-A SEQ2', 'Yolk'),
        (2, 'U80-A SEQ2', 'Soya'),
        (2, 'Jules', 'Kuro'),
        (2, 'Jules', 'Navy'),
        (2, 'Jules', 'Halt'),
        (2, 'Jules', 'Ouro')
    ON CONFLICT DO NOTHING; 

/*
CREATE TABLE IF NOT EXISTS Designed_KeyCap(
    designer_id INT,
    set_name VARCHAR (32),
    FOREIGN KEY (set_name) references KeyCap(set_name), 
    FOREIGN KEY (designer_id) references Designer(designer_id),
    PRIMARY KEY (set_name, designer_id)
);
*/

INSERT INTO Designed_KeyCap(designer_id, set_name)
    VALUES 
        (3,'GMK Olivia++'), 
        (4,'GMK Mizu'), 
        (5,'KAT Milkshake'),
        (6,'GMK Metropolis'),
        (7,'GMK Alter'),
        (5,'GMK Bento'),
        (8,'GMK Taro'),
        (9,'Infinikey Café'),
        (1,'Infinikey Team Liquid'),
        (10,'DSA Mafic Girl r2')
    ON CONFLICT DO NOTHING; 
/*
CREATE USER testUser WITH ENCRYPTED PASSWORD 'abc123';
    GRANT ALL PRIVILEGES ON DATABASE KeySwitch TO testUser;
*/

/*
CREATE TABLE IF NOT EXISTS Users(
    user_id  serial  NOT NULL,  
    username varchar(255) NOT NULL,
    user_password varchar(255) NOT NULL,
    primary key(user_id)
    );
*/

INSERT INTO Users(username, user_password)
    VALUES 
        /*
        the user_passwords would be hashed by PHP's hash function.
        for the sake of inserting data into the table, they will be unhashed strings 
        */
        ('John Smith','password1'), 
        ('Jack Smith','password2'), 
        ('Joe Smith','password3')

    ON CONFLICT DO NOTHING; 

/*
CREATE TABLE  IF NOT EXISTS List(
    list_id serial NOT NULL, 
    description VARCHAR(255), 
    primary key(list_id)
);
*/
INSERT INTO List(description)
    VALUES 
        ('Board 1'),
        ('Board 2'),
        ('Board 3'),
        ('Board 4'),
        ('Board 5')
    ON CONFLICT DO NOTHING; 
/*
CREATE TABLE IF NOT EXISTS Owns(
    user_id  serial  NOT NULL , 
    list_id serial NOT NULL , 
    foreign key (user_id) references Users(user_id) 
        on delete cascade                   
        on update cascade,
    foreign key (list_id) references List(list_id)
        on delete cascade                
        on update cascade,
    primary key(user_id, list_id)
);
*/

INSERT INTO Owns(user_id,list_id)
    VALUES 
        (1,1),
        (1,2),
        (1,3),
        (2,4),
        (2,5)
    ON CONFLICT DO NOTHING; 

/*
CREATE TABLE IF NOT EXISTS user_comment(
    comment_id serial NOT NULL , 
    comment_text VARCHAR (255),
    user_id  serial NOT NULL , 
    list_id serial NOT NULL ,
    foreign key (list_id) references List(list_id)
        on delete cascade                
        on update cascade,
    foreign key (user_id) references Users(user_id)
        on delete cascade                
        on update cascade,
    PRIMARY KEY (comment_id, list_id, user_id, comment_text)
);
*/

INSERT INTO user_comment(list_id, user_id, comment_text)
    VALUES 
        (1,2,'wow nice keyboard'),
        (1,3,'cool beans'),
        (2,3,'how much did this cost?'),
        (3,2,'does doom run on this???'),
        (4,1,'this is a comment'),
        (5,1,'yes')
    ON CONFLICT DO NOTHING; 

/*
CREATE TABLE IF NOT EXISTS Build(
    build_id serial NOT NULL ,
    plate VARCHAR(32),
    layout varchar(32),
    stabilizer VARCHAR(32),
    lube VARCHAR(32),
    list_id INT,
    keyboard_name VARCHAR(32) NOT NULL,
    color varchar(32) NOT NULL,
    switch_name VARCHAR (32) NOT NULL,
    set_name VARCHAR (32) NOT NULL,
    foreign key (list_id) references List(list_id)
        on delete cascade                
        on update cascade,
    foreign key (keyboard_name, color) references Keyboard(keyboard_name,color)
        on delete cascade                
        on update cascade,
    foreign key (switch_name) references Switch(switch_name)
        on delete cascade                
        on update cascade,
    foreign key (set_name) references KeyCap(set_name)
        on delete cascade                
        on update cascade,
    PRIMARY KEY (list_id, build_id, keyboard_name, color, switch_name, set_name, plate, layout, stabilizer, lube)
);
*/

INSERT INTO Build(list_id, keyboard_name, color, switch_name, set_name, plate, layout, stabilizer, lube)
    VALUES 
        (1,'NK65 - Olivia Edition', 'Light', 'BOX Navy','GMK Olivia++', 'brass', 'ansi', 'c3 stabilizer', 'Krytox GPL 205 GRADE 0'),
        (2,'Jules', 'Kuro', 'Gateron Clear','GMK Mizu', 'aluminum', 'iso', 'cherry screw-in stabilizer', 'Krytox GPL 205 GRADE 0'),
        (3,'Kara', 'Noct','NovelKeys Cream','GMK Bento', 'fr4', 'ansi', 'durok stabilizer', 'Tribosys 3203'),
        (4,'7V', 'E-White','Cherry Black','GMK Taro', 'polycarbonate', 'ansi', 'durok stabilizer', 'Tribosys 3204'),
        (5,'No. 2 Rev. 1','Dark Gray','NovelKeys Cream','GMK Alter', 'carbon fibre', 'ansi', 'c3 stabilizer', 'Tribosys 3203')

    ON CONFLICT DO NOTHING; 
