/*
 * Update table T_RCA_DETAIL modified field DESCRIPTION, ACTION, and NOTE
 */
alter table T_RCA_DETAIL
alter column DESCRIPTION varchar(1024) not null;

alter table T_RCA_DETAIL
alter column ACTIONS varchar(1024);

alter table T_RCA_DETAIL
alter column NOTE varchar(1024);

/*
 * Update table R_K3PL add field REPO_PATH
 */
alter table R_K3PL
add REPO_PATH varchar(512) not null default '/repository';

