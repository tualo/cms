delimiter ; 
CREATE TABLE IF NOT EXISTS `tualocms_page` (
  `tualocms_page`varchar(36) PRIMARY KEY,

  `path` varchar(255) NOT NULL,
  `pug_file` varchar(50) DEFAULT NULL,

  `valid_from` datetime NOT null default current_timestamp,
  `valid_until` datetime NOT null default '2099-12-31 23:59:59',

  `title` longtext DEFAULT NULL,
  `content` longtext DEFAULT NULL,

  KEY `idx_tualocms_page_pug_file` (`pug_file`),

  CONSTRAINT `fk_tualocms_page_pug_file` 
    FOREIGN KEY (`pug_file`) 
    REFERENCES `ds_pug_templates` (`id`) 
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);



CREATE TABLE IF NOT EXISTS `tualocms_middleware` (
  `tualocms_middleware` varchar(50) NOT NULL,
  PRIMARY KEY (`tualocms_middleware`)
);

CREATE TABLE IF NOT EXISTS `tualocms_page_middleware` (
  `tualocms_page` varchar(36) NOT NULL,
  `tualocms_middleware` varchar(50) NOT NULL,

  `position` int(11) DEFAULT 0,

  `valid_from` datetime NOT null default current_timestamp,
  `valid_until` datetime NOT null default '2099-12-31 23:59:59',

  PRIMARY KEY (`tualocms_page`,`tualocms_middleware`),
  KEY `idx_tualocms_page_middleware_middleware` (`tualocms_middleware`),

  CONSTRAINT `fk_tualocms_page_middleware_middleware` 
    FOREIGN KEY (`tualocms_middleware`) 
    REFERENCES `tualocms_middleware` (`tualocms_middleware`) 
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
    
  CONSTRAINT `fk_tualocms_page_middleware_page` 
    FOREIGN KEY (`tualocms_page`) 
    REFERENCES `tualocms_page` (`tualocms_page`) 
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);


CREATE TABLE IF NOT EXISTS `tualocms_section` (

    `tualocms_section`varchar(36) PRIMARY KEY,
    `title` longtext DEFAULT NULL,
    `content` longtext DEFAULT NULL,

    `valid_from` datetime NOT null default current_timestamp,
    `valid_until` datetime NOT null default '2099-12-31 23:59:59',


    `pug_file` varchar(50) DEFAULT NULL,
    KEY `idx_tualocms_section_pug_file` (`pug_file`),
    CONSTRAINT `fk_tualocms_section_pug_file` 
        FOREIGN KEY (`pug_file`) 
        REFERENCES `ds_pug_templates` (`id`) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS `tualocms_attribute` (

    `tualocms_attribute`varchar(36) PRIMARY KEY,
    `name`varchar(255)

);


CREATE TABLE IF NOT EXISTS  `tualocms_section_tualocms_attributes` (
    
    `tualocms_attribute`varchar(36),
    `tualocms_section`varchar(36),
    `position` int(11) DEFAULT 0,
    
    `valid_from` datetime NOT null default current_timestamp,
    `valid_until` datetime NOT null default '2099-12-31 23:59:59',


    KEY `idx_tualocms_section_tualocms_attributes_attribute` (`tualocms_attribute`),
    KEY `idx_tualocms_section_tualocms_attributes_section` (`tualocms_section`),

    CONSTRAINT `fk_tualocms_section_tualocms_attributes_section` 
        FOREIGN KEY (`tualocms_section`) 
        REFERENCES `tualocms_section` (`tualocms_section`) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT `fk_tualocms_section_tualocms_attributes_attribute` 
        FOREIGN KEY (`tualocms_attribute`) 
        REFERENCES `tualocms_attribute` (`tualocms_attribute`) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    PRIMARY KEY (`tualocms_attribute`,`tualocms_section`)

);

CREATE OR REPLACE TABLE `tualocms_section_tualocms_page` (
    
    `tualocms_page`varchar(36),
    `tualocms_section`varchar(36),
    `position` int(11) DEFAULT 0,

    `valid_from` datetime NOT null default current_timestamp,
    `valid_until` datetime NOT null default '2099-12-31 23:59:59',
    
    KEY `idx_tualocms_section_tualocms_page_page` (`tualocms_page`),
    KEY `idx_tualocms_section_tualocms_page_section` (`tualocms_section`),

    CONSTRAINT `fk_tualocms_section_tualocms_page_section` 
        FOREIGN KEY (`tualocms_section`) 
        REFERENCES `tualocms_section` (`tualocms_section`) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT `fk_tualocms_section_tualocms_page_page` 
        FOREIGN KEY (`tualocms_page`) 
        REFERENCES `tualocms_page` (`tualocms_page`) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    PRIMARY KEY (`tualocms_page`,`tualocms_section`)

);

CREATE or replace view view_load_tualocms_page as 
select 
        tualocms_page.tualocms_page,
        tualocms_page.path,
        tualocms_page.pug_file,
        JSON_OBJECT(
                'id', tualocms_page.tualocms_page,
                'path', tualocms_page.path,
                'title', tualocms_page.title,
                'content', tualocms_page.content,
                'template',tualocms_page.pug_file,
                'sections', JSON_ARRAYAGG(
                        JSON_OBJECT(
                                'id', tualocms_section.tualocms_section,
                                'title',tualocms_section.title,
                                'content',tualocms_section.content,
                                'template',tualocms_section.pug_file
                        )
                        ORDER BY tualocms_section_tualocms_page.position
                )
        ) `page`
from 
        tualocms_page 
        join tualocms_section_tualocms_page
                on tualocms_section_tualocms_page.tualocms_page=tualocms_page.tualocms_page
                and (
                        now() between tualocms_page.valid_from and tualocms_page.valid_until
                )
                
                and (
                        now() between tualocms_section_tualocms_page.valid_from and tualocms_section_tualocms_page.valid_until
                )
                
        join tualocms_section 
                on tualocms_section.tualocms_section=tualocms_section_tualocms_page.tualocms_section
                
                and (
                        now() between tualocms_section.valid_from and tualocms_section.valid_until
                )
                
                

group by
        tualocms_page.tualocms_page
;