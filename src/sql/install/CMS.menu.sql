DELIMITER ;
insert into macc_menu (id, title, path, component, path2, priority, iconcls, route_to) values ('984c3f2c-6410-11ee-9bdd-c6832147e485','CMS','','','','0','fa fa-globe','');
 insert into macc_menu (id, title, path, component, path2, priority, iconcls, route_to) values ('683e17be-6411-11ee-9bdd-c6832147e485','Seiten','','','984c3f2c-6410-11ee-9bdd-c6832147e485','1','typcn typcn-document-text','#ds/tualocms_page');
 insert into macc_menu (id, title, path, component, path2, priority, iconcls, route_to) values ('a069d9fc-6411-11ee-9bdd-c6832147e485','verfügbare Middlewares','','','984c3f2c-6410-11ee-9bdd-c6832147e485','2','typcn typcn-cog-outline','#ds/tualocms_middleware');
 insert into macc_menu (id, title, path, component, path2, priority, iconcls, route_to) values ('bc83ce86-6411-11ee-9bdd-c6832147e485','verfügbare Attribute','','','984c3f2c-6410-11ee-9bdd-c6832147e485','3','typcn typcn-cog-outline','#ds/tualocms_attribute');
 insert into macc_menu (id, title, path, component, path2, priority, iconcls, route_to) values ('d898c784-6411-11ee-9bdd-c6832147e485','Abschnitte','','','984c3f2c-6410-11ee-9bdd-c6832147e485','0','entypo et-documents','#ds/tualocms_section');

insert ignore into rolle_menu (id, rolle) values ('683e17be-6411-11ee-9bdd-c6832147e485','administration');
 insert ignore into rolle_menu (id, rolle) values ('984c3f2c-6410-11ee-9bdd-c6832147e485','administration');
 insert ignore into rolle_menu (id, rolle) values ('a069d9fc-6411-11ee-9bdd-c6832147e485','administration');
 insert ignore into rolle_menu (id, rolle) values ('bc83ce86-6411-11ee-9bdd-c6832147e485','administration');
 insert ignore into rolle_menu (id, rolle) values ('d898c784-6411-11ee-9bdd-c6832147e485','administration');

