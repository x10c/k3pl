insert into R_RISK_FREQUENCY (FREQUENCY_CATEGORY, DESCRIPTION, FREQUENCY, ID_USER) values ('F1', 'Very Likely to Occur', '1 to 10-1', '1');
insert into R_RISK_FREQUENCY (FREQUENCY_CATEGORY, DESCRIPTION, FREQUENCY, ID_USER) values ('F2', 'May occur once in the lifetime of process', '10-1 to 10-2', '1');
insert into R_RISK_FREQUENCY (FREQUENCY_CATEGORY, DESCRIPTION, FREQUENCY, ID_USER) values ('F3', 'Unlikely to occur once in the lifetime of process', '10-2 to 10-3', '1');
insert into R_RISK_FREQUENCY (FREQUENCY_CATEGORY, DESCRIPTION, FREQUENCY, ID_USER) values ('F4', 'Very Unlikely, not realistacally expected to occur', '10-3 to 10-5', '1');

insert into R_RISK_CATEGORY (CONSEQUENCE_CATEGORY, ID_USER) values ('C1', '1');
insert into R_RISK_CATEGORY (CONSEQUENCE_CATEGORY, ID_USER) values ('C2', '1');
insert into R_RISK_CATEGORY (CONSEQUENCE_CATEGORY, ID_USER) values ('C3', '1');
insert into R_RISK_CATEGORY (CONSEQUENCE_CATEGORY, ID_USER) values ('C4', '1');

insert into R_RISK_CONSEQUENCE (CONSEQUENCE, NOTE, ID_USER) values ('Safety', '', '1');
insert into R_RISK_CONSEQUENCE (CONSEQUENCE, NOTE, ID_USER) values ('Environmental', 'KEPMEN KLH 48/96', '1');
insert into R_RISK_CONSEQUENCE (CONSEQUENCE, NOTE, ID_USER) values ('Liability & Property Damage', '', '1');
insert into R_RISK_CONSEQUENCE (CONSEQUENCE, NOTE, ID_USER) values ('Company Image', '', '1');

insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Safety', 'C1', 'No Injury or healtheffects', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Safety', 'C2', 'Minor injury or reversible health effects', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Safety', 'C3', 'Injury or moderate health effects', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Safety', 'C4', 'Death or irreversiblehealth effects', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Environmental', 'C1', 'tolerance noise, under  55 dB (<55 dB)', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Environmental', 'C2', 'Unsual Noise, between 56-70 dB', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Environmental', 'C3', 'Significant Noise ( between 71-85 dB )', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Environmental', 'C4', 'Seriuos Noise effect ( > 85 dB )', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Liability & Property Damage', 'C1', '< 100 jt', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Liability & Property Damage', 'C2', '100 jt - 5M', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Liability & Property Damage', 'C3', '5 - 50M', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Liability & Property Damage', 'C4', '50M', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Company Image', 'C1', 'Minor Publicity, Local TV/Press', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Company Image', 'C2', 'Significant Local Pubicity, Interviews', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Company Image', 'C3', 'Considerable Local Publicity, Some National Publicity', '1');
insert into R_RISK_CONSEQUENCE_CATEGORY (CONSEQUENCE, CONSEQUENCE_CATEGORY, DESCRIPTION, ID_USER) values ('Company Image', 'C4', 'Headline Locally, Nationally & Internationally', '1');

insert into T_REPO values (1	,0	,'Kontraktor'	,'1'	,1	,0	,770	,'1'	,getdate());
insert into T_REPO values (2	,0	,'Dokumen Klaim','1'	,1	,0	,770	,'1'	,getdate());
