CREATE TABLE "comm_channel" (
  "id" integer(20) NOT NULL,
  "created_at" integer(20),
  "updated_at" integer(20),
  "deleted_at" integer(20),
  "program_id" integer(20) NOT NULL,
  "number" text(64) NOT NULL,
  "name" text(64) NOT NULL,
  "connect_mode" integer(11) NOT NULL,
  "ip_address" text(64),
  "port" integer(11),
  "remote_ip_address" text(64),
  "remote_port" integer(11),
  "ssl_tls" text(64),
  "client_id" text(64),
  "login_user" text(64),
  "login_password" text(64),
  "baud_rate" integer(11),
  "parity" integer(11),
  "stop_bits" integer(11),
  "data_bits" integer(11),
  "flow_control" integer(11),
  PRIMARY KEY ("id")
);

CREATE TABLE "comm_channel_device" (
  "id" integer(20) NOT NULL,
  "channel_id" integer(20) NOT NULL,
  "device_id" integer(20) NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "comm_device" (
  "id" integer(20) NOT NULL,
  "created_at" integer(20),
  "updated_at" integer(20),
  "deleted_at" integer(20),
  "product_id" integer(20),
  "name" text(64) NOT NULL,
  "number" text(64) NOT NULL,
  "is_enable" integer(11) NOT NULL,
  "remark" text(255),
  "sync_iot_id_time" integer(20),
  "sync_iot_content_time" integer(20),
  PRIMARY KEY ("id")
);

CREATE TABLE "comm_device_attr" (
  "id" integer(20) NOT NULL,
  "device_id" integer(20) NOT NULL,
  "product_attr_id" integer(20) NOT NULL,
  "general_attr_id" integer(20) NOT NULL,
  "code" text(64) NOT NULL,
  "name" text(64) NOT NULL,
  "number" text(64) NOT NULL,
  "data_type" integer(11) NOT NULL,
  "min_value" real(20),
  "max_value" real(20),
  "max_length" integer(20),
  "unit_name" text(64),
  "remark" text(255),
  "serial_no" integer(11) NOT NULL,
  "sync_iot_id_time" integer(20),
  "sync_iot_content_time" integer(20),
  PRIMARY KEY ("id")
);

CREATE TABLE "comm_program" (
  "id" integer(20) NOT NULL,
  "path" text(255) NOT NULL,
  "dir" text(255),
  "args_string" text(255),
  "envs_string" text(255),
  "std_out_path" text(255),
  "max_count" integer(11),
  "max_error" integer(11),
  "min_exit_time" integer(11),
  "first_wait_time" integer(11),
  "start_wait_time" integer(11),
  "role" integer(11) NOT NULL,
  "enabled" integer(11) NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "comm_program" (
  "id" integer NOT NULL,
  "path" text DEFAULT '',
  "dir" text DEFAULT '',
  "args_string" text DEFAULT '',
  "envs_string" text DEFAULT '',
  "std_out_path" text DEFAULT '',
  "max_count" integer DEFAULT 0,
  "max_error" integer DEFAULT 9,
  "min_exit_time" integer DEFAULT 10,
  "first_wait_time" integer DEFAULT 0,
  "start_wait_time"integer DEFAULT 100,
  "role" integer DEFAULT 33,
  "enabled" integer DEFAULT 1,
  PRIMARY KEY ("id")
);

CREATE TABLE "comm_settings" (
  "key" text(255) NOT NULL,
  "value" text(255) NOT NULL
);

CREATE TABLE "sys_users" (
  "id" integer(20) NOT NULL,
  "created_at" integer(20),
  "updated_at" integer(20),
  "deleted_at" integer(20),
  "uuid" text(191),
  "username" text(191),
  "password" text(191),
  "nick_name" text(191),
  "side_mode" text(191),
  "header_img" text(191),
  "base_color" text(191),
  "active_color" text(191),
  "authority_id" integer(20),
  "phone" text(191),
  "email" text(191),
  "enable" integer(20),
  PRIMARY KEY ("id")
);