--liquibase formatted sql

--changeset arpan:1
--comment: adding leaves_by_tag
CREATE TABLE leaves_by_tag (
   tag text,
   title text,
   tags list<text>,
   url text,
   PRIMARY KEY ((tag), title)
);