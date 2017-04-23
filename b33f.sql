create table IF NOT EXISTS Users(
    user_id int(11) NOT NULL AUTO_INCREMENT,
    first_name varchar (25) NOT NULL,
    username varchar(50) NOT NULL, 
    user_type varchar(45) NOT NULL, 
    password varchar(45) NOT NULL, 
    email varchar(45) NOT NULL, 
    phone_number int(10) NOT NULL,
    account_created datetime NOT NULL,
    last_logn timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1; 

insert into Users (
    first_name,
    username,
    user_type,
    password,
    email,
    phone_number,
    account_created
)
values('justin', 'ledpipe', 'admin', 'onetwothreefour', 'justin@b33f.io', 4691231234, NOW()),
('kevin', 'thisisisk', 'admin', 'hashtagwinning', 'kevin@b33f.io', 4699879876, NOW()),
('seungki', 'notfrench', 'admin', 'learnedman', 'seungki@b33f.io', 4694564567, NOW()),
('luke', 'memer', 'admin', 'memeislifememeislove', 'luke@b33f.io', 4697897890, NOW());



create table IF NOT EXISTS Channels(
    channel_id int(11) NOT NULL AUTO_INCREMENT, 
    channel_name varchar(50) NOT NULL, 
    channel_created datetime NOT NULL,
    PRIMARY KEY (channel_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert into Channels(
    channel_name,
    channel_created
)
values("CS", NOW()),
("Politics", NOW());



create table IF NOT EXISTS Debates(
    debate_id int(11) NOT NULL AUTO_INCREMENT, 
    debate_name varchar(100) NOT NULL, 
    debate_channel int(11) NOT NULL, 
    debate_created datetime NOT NULL, 
    debate_updated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    proponent_id int NOT NULL, 
    opponent_id int,
    debate_state varchar(10) NOT NULL,
    PRIMARY KEY (debate_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

alter table Debates
add foreign key (proponent_id) references Users (user_id);
alter table Debates
add foreign key (opponent_id) references Users (user_id);
alter table Debates
add foreign key (debate_channel) references Channels (channel_id);

insert into Debates (
    debate_name,
    debate_channel,
    debate_created,
    proponent_id,
    opponent_id,
    debate_state
)
values ('vim is better than emac', 1, NOW(), 1, 2, 'active'),
('luke hansen is a not a memer but a dreamer', 1, NOW(), 2, NULL, 'pending');



create table IF NOT EXISTS Points(
    point_id int(11) NOT NULL AUTO_INCREMENT,
    point_debate int(11) NOT NULL, 
    point_type varchar(8) NOT NULL, 
    poster_id int NOT NULL, 
    point_created datetime NOT NULL, 
    point_name varchar(50), 
    PRIMARY KEY (point_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

alter table Points
add foreign key (poster_id) references Users (user_id);
alter table Points
add foreign key (point_debate) references Debates (debate_id);

insert into Points(
    point_debate,
    point_type,
    poster_id,
    point_created,
    point_name    
)
values(1, 'claim', 1, NOW(), 'emac is os'),
(1, 'response', 2, NOW(), 'vim is a meme');



create table IF NOT EXISTS Visted_channel(
    visited_time datetime NOT NULL, 
    visited_user int(11) NOT NULL, 
    visted_channel int(11) NOT NULL, 
    PRIMARY KEY (visited_time, visited_user)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

alter table Visited_channel
add foreign key (visited_user) references Users (user_id);
alter table Visited_channel
add foreign key (visited_channel) references Channels (channel_id);

insert into Visited_channel(
    visited_time,
    visited_user,
    visited_channel
)
values(NOW(), 2, 1);



create table IF NOT EXISTS Visited_debate(
    visited_time datetime NOT NULL, 
    visited_user int(11) NOT NULL, 
    visited_debate int(11) NOT NULL, 
    PRIMARY KEY(visited_time, visited_user)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

alter table Visited_debate
add foreign key (visited_user) references Users (user_id);
alter table Visited_debate
add foreign key (visited_debate) references Debates (debate_id);

insert into Visited_debate(
    visited_time,
    visited_user,
    visited_debate
)
values(NOW(), 2, 1);



create table IF NOT EXISTS Vote_channel(
    vote_id int(11) NOT NULL AUTO_INCREMENT, 
    voter_id int(11) NOT NULL, 
    vote_type varchar(1), 
    vote_channel int(11) NOT NULL, 
    PRIMARY KEY (vote_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

alter table Vote_channel
add foreign key (voter_id) references Users (user_id);
alter table Vote_channel
add foreign key (vote_channel) references Channels (channel_id);

insert into Vote_channel(
    voter_id,
    vote_type,
    vote_channel
)
values (2, "u", 1);


create table IF NOT EXISTS Vote_debate(
    vote_id int(11) NOT NULL AUTO_INCREMENT, 
    voter_id int(11) NOT NULL, 
    vote_type varchar(1) NOT NULL, 
    vote_debate int(11) NOT NULL, 
    PRIMARY KEY (vote_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

alter table Vote_debate
add foreign key (voter_id) references Users (user_id);
alter table Vote_debate
add foreign key (vote_debate) references Debates (debate_id);

insert into Vote_debate(
    voter_id,
    vote_type,
    vote_debate
)
values(2, "u", 1);


create table IF NOT EXISTS Vote_point(
    vote_id int(11) NOT NULL AUTO_INCREMENT, 
    voter_id int(11) NOT NULL, 
    vote_type varchar(1) NOT NULL, 
    vote_point int(11) NOT NULL, 
    PRIMARY KEY (vote_id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

alter table Vote_point
add foreign key (voter_id) references Users (user_id);
alter table Vote_point
add foreign key (vote_point) references Points (point_id);

insert into Vote_point(
    voter_id,
    vote_type,
    vote_point
)
values(2, "d", 1);
