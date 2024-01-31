CREATE TABLE `sys_role_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `delete_time` bigint(20) DEFAULT NULL COMMENT '删除时间',
  `create_by` varchar(64) NOT NULL COMMENT '创建人',
  `update_by` varchar(64) NOT NULL COMMENT '修改人',
  `delete_by` varchar(64) NOT NULL COMMENT '删除人',
  `tenant_id` bigint(20) DEFAULT NULL,
  `code` varchar(64) NOT NULL COMMENT '组代码',
  `name` varchar(64) NOT NULL COMMENT '组名',
  `tags` varchar(255) DEFAULT NULL COMMENT '标签，如|A|B|分隔',
  `role_ids` varchar(255) DEFAULT NULL COMMENT '多角色',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_form_designer1_unique_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='角色组';