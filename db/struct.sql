
create schema CANDIDATE;

create table CANDIDATE.CANDIDATE_STATUS
(
    STATUS_ID    int GENERATED ALWAYS AS IDENTITY
        primary key,
    STATUS      varchar(250),
    DESCRIPTION varchar(250)
);

create table CANDIDATE.COHORT
(
    COHORT_ID    int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME        decimal,
    DESCRIPTION varchar(250)
)
;

create table CANDIDATE.COMPANY_TYPE
(
    COMPANY_TYPE_ID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME           varchar(150),
    DESCRIPTION    varchar(250)
)
;

create table CANDIDATE.CONTACT_TYPE
(
    CONTACT_TYPE_ID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME           varchar(250),
    DESCRIPTION    varchar(250)
)
;

create table CANDIDATE.CONTACT
(
    CONTACT_ID      int GENERATED ALWAYS AS IDENTITY
        primary key,
    FULLNAME       varchar(250) not null,
    RELATIONSHIP   varchar(250),
    PHONE_NUMBER   varchar(10),
    EMAIL_ADDRESS  varchar,
    CONTACT_TYPE_ID int
        references CANDIDATE.CONTACT_TYPE
);



create table CANDIDATE.COUNTRY
(
    COUNTRY_ID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME      varchar(150)
);



create table CANDIDATE.EVENT_TYPE
(
    EVENT_TYPE_ID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME         varchar(250),
    DESCRIPTION  varchar(250)
);


create table CANDIDATE.NQFLEVEL
(
    NQFLEVEL_ID  int GENERATED ALWAYS AS IDENTITY
        primary key,
    DESCRIPTION varchar(250)
);


create table CANDIDATE.ROLE
(
    ROLE_ID      int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME        varchar(250),
    DESCRIPTION varchar(250)
);




create table CANDIDATE.STATE
(
    STATE_ID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME    varchar(150)
);




create table CANDIDATE.ADDRESS
(
    ADDRESS_ID   int GENERATED ALWAYS AS IDENTITY
        primary key,
    STREET      varchar(250) not null,
    CITY        varchar(150),
    POSTAL_CODE varchar,
    STATE_ID     int
        references CANDIDATE.STATE,
    COUNTRY_ID   int
        references CANDIDATE.COUNTRY
);




create table CANDIDATE.APP_USER
(
    APP_USER_ID    int GENERATED ALWAYS AS IDENTITY
        primary key,
    FIRST_NAME    varchar(150),
    LAST_NAME     varchar(150),
    USER_NAME     varchar(150),
    EMAIL_ADDRESS varchar(250),
    ADDRESS_ID     int not null
        references CANDIDATE.ADDRESS,
    ROLE_ID        int not null
        references CANDIDATE.ROLE
);



create table CANDIDATE.COMPANY
(
    COMPANY_ID          int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME               varchar(150),
    LINE_MANAGER_NAME  varchar(250),
    LINE_MANAGER_EMAIL varchar(250),
    BILL_CONTACT_NAME  varchar(250),
    BILL_CONTACT_EMAIL varchar(250),
    BILL_DETAILS       varchar(250),
    ADDRESS_ID          int not null
        references CANDIDATE.ADDRESS,
    COMPANY_TYPE_ID     int not null
        references CANDIDATE.CONTACT_TYPE
        references CANDIDATE.COMPANY_TYPE
);


create table CANDIDATE.QUALIFICATION
(
    QUALIFICATION_ID int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME            varchar(150),
    DESCRIPTION     varchar(250),
    COMPANY_ID       int not null
        references CANDIDATE.COMPANY,
    NQFLEVEL_ID      int not null
        references CANDIDATE.NQFLEVEL
);



create table CANDIDATE.CANDIDATE
(
    CANDIDATE_ID     int GENERATED ALWAYS AS IDENTITY
        primary key,
    PHONE_NUMBER    varchar(150),
    ID_NUMBER       varchar(250) not null,
    START_DATE      timestamp,
    PLACEMENT_DATE  timestamp,
    END_DATE        timestamp,
    LAST_UPDATED    timestamp,
    APP_USER_ID      int           not null
        references CANDIDATE.APP_USER,
    QUALIFICATION_ID int
        references CANDIDATE.QUALIFICATION,
    COMPANY_ID       int
        references CANDIDATE.COMPANY,
    COHORT_ID        int
        references CANDIDATE.COHORT,
    STATUS_ID        int
        references CANDIDATE.CANDIDATE_STATUS
);




create table CANDIDATE.CANDIDATE_EVENT
(
    EVENT_ID      int GENERATED ALWAYS AS IDENTITY
        primary key,
    NAME         varchar(150) not null,
    EVENT_DATE   timestamp      not null,
    NOTES        varchar(250),
    CANDIDATE_ID  int           not null
        references CANDIDATE.CANDIDATE,
    EVENT_TYPE_ID int           not null
        references CANDIDATE.EVENT_TYPE
);

CREATE SCHEMA SCORE_BOARD;

create table SCORE_BOARD.CATEGORY
(
    CATEGORY_ID  int GENERATED ALWAYS AS IDENTITY
        constraint PK__CATEGORY__A50F9896CC505A3B
        primary key ,
    NAME        varchar(250),
    DESCRIPTION varchar(250)
);

create table SCORE_BOARD.QUARTER
(
    QUARTER_ID   int GENERATED ALWAYS AS IDENTITY
        constraint PK__QUARTER__7F83366AB8685AFB
        primary key ,
    NAME        varchar(250),
    DESCRIPTION varchar(250)
);

create table SCORE_BOARD.SCORE
(
    SCORE_ID     int GENERATED ALWAYS AS IDENTITY
        constraint PK__SCORE__1811F43B810C6C2B
        primary key ,
    RATING      decimal,
    DESCRIPTION varchar(250)
);

create table SCORE_BOARD.SCORE_CARD
(
    SCORE_CARD_ID int GENERATED ALWAYS AS IDENTITY
        constraint PK__SCORE_CA__8F0A1347C8E7A72B
        primary key,
    NAME         varchar(150),
    CATEGORY_ID   int
        constraint FK__SCORE_CAR__CATEG__656C112C
            references SCORE_BOARD.CATEGORY (CATEGORY_ID),
    COHORT_ID     int
        constraint FK__SCORE_CAR__COHOR__66603565
            references CANDIDATE.COHORT (COHORT_ID),
    QUARTER_ID    int
        constraint FK__SCORE_CAR__QUART__6754599E
            references SCORE_BOARD.QUARTER (QUARTER_ID),
    CANDIDATE_ID  int
        constraint FK__SCORE_CAR__CANDI__68487DD7
            references CANDIDATE.CANDIDATE (CANDIDATE_ID)
);

create table SCORE_BOARD.QUARTER_RATING
(
    QUARTER_RATING_ID int GENERATED ALWAYS AS IDENTITY
        constraint PK__QUARTER___F8297D27C2DA7BDB
        primary key ,
    NAME             varchar(150),
    DESCRIPTION      varchar(250),
    SCORE_CARD_ID     int
        constraint FK__QUARTER_R__SCORE__6B24EA82
            references SCORE_BOARD.SCORE_CARD (SCORE_CARD_ID)
);

create table SCORE_BOARD.SUB_CATEGORY
(
    SUB_CATEGORY_ID int GENERATED ALWAYS AS IDENTITY
        constraint PK__SUBCATEG__264A564C5D9166C7
        primary key ,
    NAME          varchar(250),
    DESCRIPTION   varchar(250),
    CATEGORY_ID    int not null
        constraint FK__SUBCATEGO__CATEG__2C3393D0
            references SCORE_BOARD.CATEGORY (CATEGORY_ID),
    SCORE_ID       int
        constraint FK__SUBCATEGO__SCORE__2D27B809
            references SCORE_BOARD.SCORE (SCORE_ID)
);

