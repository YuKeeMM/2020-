/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2020/7/4 14:35:05                            */
/*==============================================================*/


drop table if exists Address;

drop table if exists Admin;

drop table if exists Commodity_information;

drop table if exists Commodity_order;

drop table if exists Commodity_purchase;

drop table if exists Coupon;

drop table if exists Discount_commodity;

drop table if exists Discount_information;

drop table if exists Fresh;

drop table if exists Menu;

drop table if exists Order1;

drop table if exists Order_evaluation;

drop table if exists Recommended_menu;

drop table if exists Time_promotion;

drop table if exists User;

drop table if exists include;

/*==============================================================*/
/* Table: Address                                               */
/*==============================================================*/
create table Address
(
   Address_id           int not null auto_increment,
   User_id              int,
   Address_province     varchar(20),
   Address_city         varchar(20),
   Address_area         varchar(20),
   Address_location     char(50),
   Address_person       varchar(20),
   Address_telephone_number varchar(20),
   primary key (Address_id)
);

/*==============================================================*/
/* Table: Admin                                                 */
/*==============================================================*/
create table Admin
(
   Admin_id             int not null auto_increment,
   Admin_name           varchar(200),
   Admin_password       varchar(200),
   primary key (Admin_id)
);

/*==============================================================*/
/* Table: Commodity_information                                 */
/*==============================================================*/
create table Commodity_information
(
   Commodity_information_id int not null auto_increment,
   Fresh_id             int,
   Commodity_information_name varchar(20),
   Commodity_information_price float(10),
   Commodity_information_vip_price float(10),
   Commodity_information_number int,
   Commodity_information_specification varchar(5),
   Commodity_information_details varchar(100),
   primary key (Commodity_information_id)
);

/*==============================================================*/
/* Table: Commodity_order                                       */
/*==============================================================*/
create table Commodity_order
(
   Commodity_order_id   int not null auto_increment,
   Address_id           int,
   User_id              int,
   Commodity_order_original_amount float(10),
   Commodity_order_settlement_amount float(10),
   Commodity_order_required_time datetime,
   Commodity_order_order_status varchar(2000),
   primary key (Commodity_order_id)
);

/*==============================================================*/
/* Table: Commodity_purchase                                    */
/*==============================================================*/
create table Commodity_purchase
(
   Commodity_purchase_id int not null auto_increment,
   Admin_id             int,
   Commodity_purchase_number int,
   Commodity_purchase_status varchar(2000),
   primary key (Commodity_purchase_id)
);

/*==============================================================*/
/* Table: Coupon                                                */
/*==============================================================*/
create table Coupon
(
   Coupon_id            int not null auto_increment,
   Commodity_order_id   int,
   Coupon_content       varchar(200),
   Coupon_applicable_amount float(10),
   Coupon_deduction_amount float(10),
   Coupon_start_date    date,
   Coupon_end_date      date,
   primary key (Coupon_id)
);

/*==============================================================*/
/* Table: Discount_commodity                                    */
/*==============================================================*/
create table Discount_commodity
(
   Commodity_information_id int not null,
   Discount_information_id int not null,
   primary key (Commodity_information_id, Discount_information_id)
);

/*==============================================================*/
/* Table: Discount_information                                  */
/*==============================================================*/
create table Discount_information
(
   Discount_information_id int not null auto_increment,
   Discount_information_content varchar(200),
   Discount_information_number int,
   Discount_information_discount float(10),
   Discount_information_start_date date,
   Discount_information_end_date date,
   primary key (Discount_information_id)
);

/*==============================================================*/
/* Table: Fresh                                                 */
/*==============================================================*/
create table Fresh
(
   Fresh_id             int not null auto_increment,
   Fresh_name           varchar(10),
   Fresh_description    varchar(100),
   primary key (Fresh_id)
);

/*==============================================================*/
/* Table: Menu                                                  */
/*==============================================================*/
create table Menu
(
   Menu_id              int not null auto_increment,
   Menu_name            varchar(20),
   Menu_ingredients     varchar(100),
   Menu_steps           varchar(200),
   Menu_pictures        longblob,
   primary key (Menu_id)
);

/*==============================================================*/
/* Table: Order1                                                */
/*==============================================================*/
create table Order1
(
   Commodity_information_id int not null,
   Commodity_order_id   int not null,
   Discount_information_id int not null,
   Order1_number        int,
   Order1_price         float(10),
   Order1_discount      float(10),
   primary key (Commodity_information_id, Commodity_order_id, Discount_information_id)
);

/*==============================================================*/
/* Table: Order_evaluation                                      */
/*==============================================================*/
create table Order_evaluation
(
   Commodity_order_id   int not null,
   User_id              int not null,
   Order_evaluation_content varchar(100),
   Order_evaluation_date date,
   Order_evaluation_star_level varchar(20),
   Order_evaluation_photo longblob,
   primary key (Commodity_order_id, User_id)
);

/*==============================================================*/
/* Table: Recommended_menu                                      */
/*==============================================================*/
create table Recommended_menu
(
   Commodity_information_id int not null,
   Menu_id              int not null,
   "Product menu recommendation table_description" varchar(200),
   primary key (Commodity_information_id, Menu_id)
);

/*==============================================================*/
/* Table: Time_promotion                                        */
/*==============================================================*/
create table Time_promotion
(
   Time_promotion_id    int not null auto_increment,
   Commodity_information_id int,
   Time_promotion_price float(10),
   Time_promotion_number int,
   Time_promotion_start_date date,
   Time_promotion_end_date date,
   primary key (Time_promotion_id)
);

/*==============================================================*/
/* Table: User                                                  */
/*==============================================================*/
create table User
(
   User_id              int not null auto_increment,
   User_name            varchar(5),
   User_gender          varchar(5),
   User_password        varchar(20),
   User_phone_number    varchar(20),
   User_email_address   varchar(20),
   User_city            varchar(20),
   User_registration_time date,
   User_vip             bool,
   User_vip_deadline    date,
   primary key (User_id)
);

/*==============================================================*/
/* Table: include                                               */
/*==============================================================*/
create table include
(
   Commodity_purchase_id int not null,
   Commodity_information_id int not null,
   primary key (Commodity_purchase_id, Commodity_information_id)
);

alter table Address add constraint FK_delivery foreign key (User_id)
      references User (User_id) on delete restrict on update restrict;

alter table Commodity_information add constraint FK_belong_to foreign key (Fresh_id)
      references Fresh (Fresh_id) on delete restrict on update restrict;

alter table Commodity_order add constraint FK_Send_out foreign key (Address_id)
      references Address (Address_id) on delete restrict on update restrict;

alter table Commodity_order add constraint FK_order foreign key (User_id)
      references User (User_id) on delete restrict on update restrict;

alter table Commodity_purchase add constraint FK_buy foreign key (Admin_id)
      references Admin (Admin_id) on delete restrict on update restrict;

alter table Coupon add constraint FK_use foreign key (Commodity_order_id)
      references Commodity_order (Commodity_order_id) on delete restrict on update restrict;

alter table Discount_commodity add constraint FK_Discount_commodity foreign key (Commodity_information_id)
      references Commodity_information (Commodity_information_id) on delete restrict on update restrict;

alter table Discount_commodity add constraint FK_Discount_commodity2 foreign key (Discount_information_id)
      references Discount_information (Discount_information_id) on delete restrict on update restrict;

alter table Order1 add constraint FK_Order1 foreign key (Commodity_information_id)
      references Commodity_information (Commodity_information_id) on delete restrict on update restrict;

alter table Order1 add constraint FK_Order2 foreign key (Commodity_order_id)
      references Commodity_order (Commodity_order_id) on delete restrict on update restrict;

alter table Order1 add constraint FK_Order3 foreign key (Discount_information_id)
      references Discount_information (Discount_information_id) on delete restrict on update restrict;

alter table Order_evaluation add constraint FK_Order_evaluation foreign key (Commodity_order_id)
      references Commodity_order (Commodity_order_id) on delete restrict on update restrict;

alter table Order_evaluation add constraint FK_Order_evaluation2 foreign key (User_id)
      references User (User_id) on delete restrict on update restrict;

alter table Recommended_menu add constraint FK_Recommended_menu foreign key (Commodity_information_id)
      references Commodity_information (Commodity_information_id) on delete restrict on update restrict;

alter table Recommended_menu add constraint FK_Recommended_menu2 foreign key (Menu_id)
      references Menu (Menu_id) on delete restrict on update restrict;

alter table Time_promotion add constraint FK_sales_promotion foreign key (Commodity_information_id)
      references Commodity_information (Commodity_information_id) on delete restrict on update restrict;

alter table include add constraint FK_include foreign key (Commodity_purchase_id)
      references Commodity_purchase (Commodity_purchase_id) on delete restrict on update restrict;

alter table include add constraint FK_include2 foreign key (Commodity_information_id)
      references Commodity_information (Commodity_information_id) on delete restrict on update restrict;

