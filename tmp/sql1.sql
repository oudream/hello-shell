-- https://support.huaweicloud.com/api-iothub/iot_06_v5_3019.html

CREATE TABLE `DEVICE_CONF_TABLE`
(
    `ID`               integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    `PARENT_DEVICE_ID` text    default '',
    `NODE_ID`          text    default '',
    `DEVICE_ID`        text    default '',
    `TOKEN`            text    default '',
    `NAME`             text    default '',
    `CODE`             text    default '',
    `DESCRIPTION`      text    default '',
    `MANUFACTURER_ID`  text    default '',
    `MODEL`            text    default '',
    `PRODUCT_ID`       text    default '',
    `FW_VERSION`       integer default -1,
    `SW_VERSION`       integer default -1,
    `WRITE_TIME`       integer default -1,
    `STATUS`           integer default -1,
    `EXTENSION_INFO`   text    default ''
);
