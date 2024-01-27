CREATE TABLE users(
    "id" serial NOT NULL,
	"username" varchar(13) NOT NULL UNIQUE,
	"role" varchar (50) NOT NULL,
	"enabled" boolean DEFAULT 'TRUE',
	"password" varchar NOT NULL,
	"change_new_pass" boolean DEFAULT 'TRUE',
	"created" DATE NOT NULL,
	CONSTRAINT "User_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE patients (
	"id" serial NOT NULL,
	"rut" varchar(13) NOT NULL UNIQUE,
	"name" varchar(25) NOT NULL,
	"lastname" varchar(30) NOT NULL,
	"date_born" DATE NOT NULL,
	"id_comuna" integer NOT NULL,
	"address" varchar(50) NOT NULL,
	"phone" varchar(13) NOT NULL,
	"email" varchar(30),
	"id_provision" integer NOT NULL,
	"id_user" integer NOT NULL,
	CONSTRAINT "Patient_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE doctors (
	"id" serial NOT NULL,
	"rut" varchar(13) NOT NULL UNIQUE,
	"id_speciality" integer NOT NULL,
	"name" varchar(25) NOT NULL,
	"lastname" varchar(30) NOT NULL,
	"date_born" DATE NOT NULL,
	"id_comuna" integer NOT NULL,
	"address" varchar(50) NOT NULL,
	"phone" varchar(13) NOT NULL,
	"email" varchar(30),
	"id_user" integer NOT NULL,
	CONSTRAINT "Doctor_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE assistants(
	"id" serial NOT NULL,
	"rut" varchar(13) NOT NULL UNIQUE,
	"name" varchar(25) NOT NULL,
	"lastname" varchar(30) NOT NULL,
	"date_born" DATE NOT NULL,
	"id_comuna" integer NOT NULL,
	"address" varchar(50) NOT NULL,
	"phone" varchar(13) NOT NULL,
	"email" varchar(30),
	"id_user" integer NOT NULL,
	CONSTRAINT "Assistant_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE employees(
	"id" serial NOT NULL,
	"rut" varchar(13) NOT NULL UNIQUE,
	"name" varchar(25) NOT NULL,
	"lastname" varchar(30) NOT NULL,
	"id_user" integer NOT NULL,
	CONSTRAINT "Empoyees_pk" PRIMARY KEY ("id")
)WITH (
    OIDS=FALSE
  );

CREATE TABLE rel_assistant_doctor(
    "id_doctor" integer NOT NULL,
    "id_assistant" integer NOT NULL
)WITH (
   OIDS=FALSE
 );

CREATE TABLE doctor_specialities (
	"id" serial NOT NULL,
	"name" varchar(30) NOT NULL UNIQUE,
	CONSTRAINT "specialitiesDoctor_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE formato_farmaceutico (
	"id" serial NOT NULL,
	"name" varchar(20) NOT NULL UNIQUE,
	"id_unidadmedicion" integer NOT NULL,
	CONSTRAINT "formatoFarmaceutico_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE format_details(
	"id" serial NOT NULL,
	"name" varchar (25) NOT NULL,
	"id_format" integer NOT NULL,
	CONSTRAINT "detalleFormato_pk" PRIMARY KEY ("id")
)WITH (
  OIDS=FALSE
);

CREATE TABLE materia_prima (
	"id" serial NOT NULL,
	"name" varchar(40) NOT NULL UNIQUE,
	"id_unidadmedicion" integer NOT NULL,
	CONSTRAINT "materiaPrima_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE unidad_medicion (
	"id" serial NOT NULL,
	"name" varchar(10) NOT NULL UNIQUE,
	CONSTRAINT "unidadMedicion_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE receta (
	"id" serial NOT NULL,
	"id_doctor" integer NOT NULL,
	"id_patient" integer NOT NULL,
	"id_formatdetail" integer NOT NULL,
	"cantidad_preparado" FLOAT NOT NULL,
	"indicaciones" varchar(100) NOT NULL,
	"date" DATE NOT NULL,
	"expired" DATE NOT NULL,
	"prepared" integer DEFAULT 0,
	CONSTRAINT "Receta_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE detalle_receta (
	"id" serial NOT NULL,
	"id_receta" integer NOT NULL,
	"id_materia" integer NOT NULL,
	"cantidad_materia" FLOAT NOT NULL,
	CONSTRAINT "detalleReceta_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE provision (
	"id" serial NOT NULL,
	"name" varchar(20) NOT NULL UNIQUE,
	CONSTRAINT "Provision_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE region (
	"id" serial NOT NULL,
	"name" varchar(30) NOT NULL UNIQUE,
	CONSTRAINT "Region_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE comunas (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	"id_region" integer NOT NULL,
	CONSTRAINT "Comunas_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE customers(
	"id" serial NOT NULL,
	"rut" varchar(13) NOT NULL UNIQUE,
	"name" varchar(25) NOT NULL,
	"lastname" varchar(30) NOT NULL,
	"phone" varchar(13) NOT NULL,
	"email" varchar(30),
	CONSTRAINT "Customers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE method_pay(
    "id" serial NOT NULL,
    "name" varchar (30),
    CONSTRAINT "methodPay_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE orders(
    "id" serial NOT NULL,
    "date" Timestamp NOT NULL,
    "amount" integer not null,
    "id_receta" integer not null,
    "id_user" integer not null,
    "id_customer" integer not null,
    "status" varchar (20) not null,
    "id_method_pay" integer not null,
    CONSTRAINT "Orders_pk" PRIMARY KEY ("id")
)WITH (
   OIDS=FALSE
);

CREATE TABLE details_order(
    "id" serial NOT NULL,
    "date" Timestamp NOT NULL,
    "id_order" integer not null,
    "id_user" integer not null,
    "detail_type" varchar (30),
    CONSTRAINT "Details_order_pk" PRIMARY KEY ("id")
)WITH (
   OIDS=FALSE
);

CREATE TABLE deliveries_order(
        "id" serial NOT NULL,
        "date" Timestamp NOT NULL,
        "id_order" integer not null,
        "id_user" integer not null,
        "id_customer" integer not null,
    CONSTRAINT "Deliveries_order_pk" PRIMARY KEY ("id")
)WITH (
   OIDS=FALSE
);

ALTER TABLE "patients" ADD CONSTRAINT "Patients_fk0" FOREIGN KEY ("id_comuna") REFERENCES "comunas"("id");
ALTER TABLE "patients" ADD CONSTRAINT "Patients_fk1" FOREIGN KEY ("id_provision") REFERENCES "provision"("id");
ALTER TABLE "patients" ADD CONSTRAINT "Patients_fk2" FOREIGN KEY ("id_user") REFERENCES "users"("id");

ALTER TABLE "doctors" ADD CONSTRAINT "Doctors_fk0" FOREIGN KEY ("id_speciality") REFERENCES "doctor_specialities"("id");
ALTER TABLE "doctors" ADD CONSTRAINT "Doctors_fk1" FOREIGN KEY ("id_comuna") REFERENCES "comunas"("id");
ALTER TABLE "doctors" ADD CONSTRAINT "Doctors_fk2" FOREIGN KEY ("id_user") REFERENCES "users"("id");

ALTER TABLE "assistants" ADD CONSTRAINT "Assistants_fk0" FOREIGN KEY ("id_user") REFERENCES "users"("id");
ALTER TABLE "assistants" ADD CONSTRAINT "Assistants_fk1" FOREIGN KEY ("id_comuna") REFERENCES "comunas"("id");

ALTER TABLE "employees" ADD CONSTRAINT "Employees_fk0" FOREIGN KEY ("id_user") REFERENCES "users"("id");

ALTER TABLE "rel_assistant_doctor" ADD CONSTRAINT "AssistantDoctor_fk0" FOREIGN KEY ("id_doctor") REFERENCES "doctors"("id");
ALTER TABLE "rel_assistant_doctor" ADD CONSTRAINT "AssistantDoctor_fk1" FOREIGN KEY ("id_assistant") REFERENCES "assistants"("id");

ALTER TABLE "formato_farmaceutico" ADD CONSTRAINT "formatoFarmaceutico_fk0" FOREIGN KEY ("id_unidadmedicion") REFERENCES "unidad_medicion"("id");

ALTER TABLE "format_details" ADD CONSTRAINT "detailsFormat_fk0" FOREIGN KEY ("id_format") REFERENCES "formato_farmaceutico"("id");

ALTER TABLE "materia_prima" ADD CONSTRAINT "materiaPrima_fk0" FOREIGN KEY ("id_unidadmedicion") REFERENCES "unidad_medicion"("id");

ALTER TABLE "receta" ADD CONSTRAINT "Receta_fk0" FOREIGN KEY ("id_doctor") REFERENCES "doctors"("id");
ALTER TABLE "receta" ADD CONSTRAINT "Receta_fk1" FOREIGN KEY ("id_patient") REFERENCES "patients"("id");
ALTER TABLE "receta" ADD CONSTRAINT "Receta_fk2" FOREIGN KEY ("id_formatdetail") REFERENCES "format_details"("id");

ALTER TABLE "detalle_receta" ADD CONSTRAINT "detalleReceta_fk0" FOREIGN KEY ("id_receta") REFERENCES "receta"("id");
ALTER TABLE "detalle_receta" ADD CONSTRAINT "detalleReceta_fk1" FOREIGN KEY ("id_materia") REFERENCES "materia_prima"("id");

ALTER TABLE "comunas" ADD CONSTRAINT "Comunas_fk0" FOREIGN KEY ("id_region") REFERENCES "region"("id");

ALTER TABLE "orders" ADD CONSTRAINT "Orders_fk0" FOREIGN KEY ("id_receta") REFERENCES "receta"("id");
ALTER TABLE "orders" ADD CONSTRAINT "Orders_fk1" FOREIGN KEY ("id_user") REFERENCES "users"("id");
ALTER TABLE "orders" ADD CONSTRAINT "Orders_fk2" FOREIGN KEY ("id_customer") REFERENCES "customers"("id");
ALTER TABLE "orders" ADD CONSTRAINT "Orders_fk3" FOREIGN KEY ("id_method_pay") REFERENCES "method_pay"("id");


ALTER TABLE "details_order" ADD CONSTRAINT "Details_order_fk0" FOREIGN KEY ("id_order") REFERENCES "orders"("id");
ALTER TABLE "details_order" ADD CONSTRAINT "Details_order_fk1" FOREIGN KEY ("id_user") REFERENCES "users"("id");

ALTER TABLE "deliveries_order" ADD CONSTRAINT "Details_order_fk0" FOREIGN KEY ("id_user") REFERENCES "users"("id");
ALTER TABLE "deliveries_order" ADD CONSTRAINT "Details_order_fk1" FOREIGN KEY ("id_customer") REFERENCES "customers"("id");







