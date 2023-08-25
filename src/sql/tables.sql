
drop table cms_links;

create table cms_links (
    id varchar(36)   not null PRIMARY KEY,
    href varchar(255) default '' not null,
    titel varchar(255) default
);

drop table cms_menus;
create table cms_menus (
    id varchar(36)   not null PRIMARY KEY,
    titel varchar(100) not null default '',
    menu_type varchar(36)   not null, 
    constraint fk_cms_menu_types_name FOREIGN KEY (menu_type) REFERENCES cms_menu_types(name) on update cascade on delete cascade
);
drop table cms_menu_types;
create table cms_menu_types (
    name varchar(50) not null PRIMARY KEY,
    description varchar(255) 
);

insert INTO cms_menu_types (name,description) values ('vertical list','senkrechte Liste');
insert INTO cms_menu_types (name,description) values ('horizontal list','waagerechte Liste');

drop table cms_menu_def;

create table cms_menu_def(
    cms_menu varchar(36) not null,
    cms_link varchar(36) not null,
    pos INTEGER default 0,
    new_window tinyint default 0,
    active tinyint default 1,
    cms_menu_def add noopener tinyint default 0,
    primary key (cms_menu,cms_link), 
    constraint fk_cms_menu FOREIGN KEY (cms_menu) REFERENCES cms_menus(id) on update cascade on delete cascade,
    constraint fk_cms_links FOREIGN KEY (cms_link) REFERENCES cms_links(id) on update cascade on delete cascade
);


CREATE TABLE `cms_footer_row` (
  `row_name` varchar(255) NOT NULL,
  `active` tinyint(4) DEFAULT 0,
  `pos` int(11) NOT NULL DEFAULT 0,
  `prefix` varchar(25) DEFAULT '',
  PRIMARY KEY (`row_name`),
  CONSTRAINT `chk_cms_footer_row_row_name` CHECK (`row_name` regexp '^([u0061-u007a]|[u0030-u0039]|-|\\_)*$' > 0)
);

CREATE TABLE `cms_footer_column` (
  `column_name` varchar(255) NOT NULL,
  `active` tinyint(4) DEFAULT 0,
  `pos` int(11) NOT NULL DEFAULT 0,
  `row_name` varchar(255) DEFAULT 'row-main',
  `prefix` varchar(25) DEFAULT '',
  PRIMARY KEY (`column_name`),
  KEY `fk_cms_footer_column_row_name` (`row_name`),
  CONSTRAINT `fk_cms_footer_column_row_name` FOREIGN KEY (`row_name`) REFERENCES `cms_footer_row` (`row_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_cms_footer_column_column_name` CHECK (`column_name` regexp '^([u0061-u007a]|[u0030-u0039]|-|\\_)*$' > 0)
);

CREATE TABLE `cms_footer_column_definition` (
  `column_field` varchar(255) NOT NULL,
  `column_name` varchar(255) NOT NULL,
  `pos` int(11) NOT NULL DEFAULT 0,
  `active` tinyint(4) DEFAULT 0,
  `htmltag` varchar(10) DEFAULT 'p',
  PRIMARY KEY (`column_field`,`column_name`),
  KEY `idx_cms_footer_column_definition_column_name` (`column_name`),
  CONSTRAINT `fk_cms_footer_column_definition_column_name` FOREIGN KEY (`column_name`) REFERENCES `cms_footer_column` (`column_name`) ON DELETE CASCADE ON UPDATE CASCADE
);