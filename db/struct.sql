
create schema CANDIDATE;

create table CANDIDATE.CANDIDATE_STATUS
(
    STATUSID    int GENERATED ALWAYS AS IDENTITY
        primary key,
    STATUS      varchar(250),
    DESCRIPTION varchar(250)
);

create table CANDIDATE.COHORT
(
    COHORTID    int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME        decimal,
    DESCRIPTION varchar(250)
)
;

create table CANDIDATE.COMPANY_TYPE
(
    COMPANY_TYPEID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME           varchar(150),
    DESCRIPTION    varchar(250)
)
;

create table CANDIDATE.CONTACT_TYPE
(
    CONTACT_TYPEID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME           varchar(250),
    DESCRIPTION    varchar(250)
)
;

create table CANDIDATE.CONTACT
(
    CONTACTID      int GENERATED ALWAYS AS IDENTITY
        primary key,
    FULLNAME       varchar(250) not null,
    RELATIONSHIP   varchar(250),
    PHONE_NUMBER   varchar(10),
    EMAIL_ADDRESS  varchar,
    CONTACT_TYPEID int
        references CANDIDATE.CONTACT_TYPE
);



create table CANDIDATE.COUNTRY
(
    COUNTRYID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME      varchar(150)
);



create table CANDIDATE.EVENT_TYPE
(
    EVENT_TYPEID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME         varchar(250),
    DESCRIPTION  varchar(250)
);


create table CANDIDATE.NQFLEVEL
(
    NQFLEVELID  int GENERATED ALWAYS AS IDENTITY
        primary key,
    DESCRIPTION varchar(250)
);


create table CANDIDATE.ROLE
(
    ROLEID      int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME        varchar(250),
    DESCRIPTION varchar(250)
);




create table CANDIDATE.STATE
(
    STATEID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME    varchar(150)
);




create table CANDIDATE.ADDRESS
(
    ADDRESSID   int GENERATED ALWAYS AS IDENTITY
        primary key,
    STREET      varchar(250) not null,
    CITY        varchar(150),
    POSTAL_CODE varchar,
    STATEID     int
        references CANDIDATE.STATE,
    COUNTRYID   int
        references CANDIDATE.COUNTRY
);




create table CANDIDATE.APP_USER
(
    APP_USERID    int GENERATED ALWAYS AS IDENTITY
        primary key,
    FIRST_NAME    varchar(150),
    LAST_NAME     varchar(150),
    USER_NAME     varchar(150),
    EMAIL_ADDRESS varchar(250),
    ADDRESSID     int not null
        references CANDIDATE.ADDRESS,
    ROLEID        int not null
        references CANDIDATE.ROLE
);



create table CANDIDATE.COMPANY
(
    COMPANYID          int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME               varchar(150),
    LINE_MANAGER_NAME  varchar(250),
    LINE_MANAGER_EMAIL varchar(250),
    BILL_CONTACT_NAME  varchar(250),
    BILL_CONTACT_EMAIL varchar(250),
    BILL_DETAILS       varchar(250),
    ADDRESSID          int not null
        references CANDIDATE.ADDRESS,
    COMPANY_TYPEID     int not null
        references CANDIDATE.CONTACT_TYPE
        references CANDIDATE.COMPANY_TYPE
);


create table CANDIDATE.QUALIFICATION
(
    QUALIFICATIONID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME            varchar(150),
    DESCRIPTION     varchar(250),
    COMPANYID       int not null
        references CANDIDATE.COMPANY,
    NQFLEVELID      int not null
        references CANDIDATE.NQFLEVEL
);



create table CANDIDATE.CANDIDATE
(
    CANDIDATEID     int GENERATED ALWAYS AS IDENTITY
        primary key,
    PHONE_NUMBER    varchar(150),
    ID_NUMBER       varchar(250) not null,
    START_DATE      timestamp,
    PLACEMENT_DATE  timestamp,
    END_DATE        timestamp,
    LAST_UPDATED    timestamp,
    APP_USERID      int           not null
        references CANDIDATE.APP_USER,
    QUALIFICATIONID int
        references CANDIDATE.QUALIFICATION,
    COMPANYID       int
        references CANDIDATE.COMPANY,
    COHORTID        int
        references CANDIDATE.COHORT,
    STATUSID        int
        references CANDIDATE.CANDIDATE_STATUS
);




create table CANDIDATE.CANDIDATE_EVENT
(
    EVENTID      int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME         varchar(150) not null,
    EVENT_DATE   timestamp      not null,
    NOTES        varchar(250),
    CANDIDATEID  int           not null
        references CANDIDATE.CANDIDATE,
    EVENT_TYPEID int           not null
        references CANDIDATE.EVENT_TYPE
);

CREATE SCHEMA SCORE_BOARD;

create table SCORE_BOARD.CATEGORY
(
    CATEGORYID  int GENERATED ALWAYS AS IDENTITY
        constraint PK__CATEGORY__A50F9896CC505A3B
        primary key ,
    NAME        varchar(250),
    DESCRIPTION varchar(250)
);

create table SCORE_BOARD.QUARTER
(
    QUARTERID   int GENERATED ALWAYS AS IDENTITY
        constraint PK__QUARTER__7F83366AB8685AFB
        primary key ,
    NAME        varchar(250),
    DESCRIPTION varchar(250)
);

create table SCORE_BOARD.SCORE
(
    SCOREID     int GENERATED ALWAYS AS IDENTITY
        constraint PK__SCORE__1811F43B810C6C2B
        primary key ,
    RATING      decimal,
    DESCRIPTION varchar(250)
);

create table SCORE_BOARD.SCORE_CARD
(
    SCORE_CARDID int GENERATED ALWAYS AS IDENTITY
        constraint PK__SCORE_CA__8F0A1347C8E7A72B
        primary key,
    NAME         varchar(150),
    CATEGORYID   int
        constraint FK__SCORE_CAR__CATEG__656C112C
            references SCORE_BOARD.CATEGORY (CATEGORYID),
    COHORTID     int
        constraint FK__SCORE_CAR__COHOR__66603565
            references CANDIDATE.COHORT (COHORTID),
    QUARTERID    int
        constraint FK__SCORE_CAR__QUART__6754599E
            references SCORE_BOARD.QUARTER (QUARTERID),
    CANDIDATEID  int
        constraint FK__SCORE_CAR__CANDI__68487DD7
            references CANDIDATE.CANDIDATE (CANDIDATEID)
);

create table SCORE_BOARD.QUARTER_RATING
(
    QUARTER_RATINGID int GENERATED ALWAYS AS IDENTITY
        constraint PK__QUARTER___F8297D27C2DA7BDB
        primary key ,
    NAME             varchar(150),
    DESCRIPTION      varchar(250),
    SCORE_CARDID     int
        constraint FK__QUARTER_R__SCORE__6B24EA82
            references SCORE_BOARD.SCORE_CARD (SCORE_CARDID)
);

create table SCORE_BOARD.SUBCATEGORY
(
    SUBCATEGORYID int GENERATED ALWAYS AS IDENTITY
        constraint PK__SUBCATEG__264A564C5D9166C7
        primary key ,
    NAME          varchar(250),
    DESCRIPTION   varchar(250),
    CATEGORYID    int not null
        constraint FK__SUBCATEGO__CATEG__2C3393D0
            references SCORE_BOARD.CATEGORY (CATEGORYID),
    SCOREID       int
        constraint FK__SUBCATEGO__SCORE__2D27B809
            references SCORE_BOARD.SCORE (SCOREID)
);

