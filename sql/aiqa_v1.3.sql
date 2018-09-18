-- ----------------------------
-- Table structure for tax_question_session
-- ----------------------------
DROP TABLE IF EXISTS `tax_question_session`;
CREATE TABLE `tax_question_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_key` varchar(50) NOT NULL,
  `source` varchar(10) NOT NULL,
  `status` varchar(1) NOT NULL,
  `add_who` int(11) DEFAULT NULL,
  `add_time` datetime(6) NOT NULL,
  `edit_who` int(11) DEFAULT NULL,
  `edit_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_key` (`session_key`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tax_session_answer
-- ----------------------------
DROP TABLE IF EXISTS `tax_session_answer`;
CREATE TABLE `tax_session_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer` longtext,
  `is_send` tinyint(1) NOT NULL,
  `add_who` int(11) DEFAULT NULL,
  `add_time` datetime(6) NOT NULL,
  `edit_who` int(11) DEFAULT NULL,
  `edit_time` datetime(6) NOT NULL,
  `session_key` varchar(50) NOT NULL,
  `is_check` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tax_session_answer_session_key_1448d464_fk_tax_quest` (`session_key`),
  CONSTRAINT `tax_session_answer_session_key_1448d464_fk_tax_quest` FOREIGN KEY (`session_key`) REFERENCES `tax_question_session` (`session_key`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tax_solve_unsolve
-- ----------------------------
DROP TABLE IF EXISTS `tax_solve_unsolve`;
CREATE TABLE `tax_solve_unsolve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(1000) NOT NULL,
  `solve` int(10) unsigned NOT NULL,
  `is_knowledge` tinyint(1) NOT NULL,
  `answer` longtext,
  `add_who` int(11) DEFAULT NULL,
  `add_time` datetime(6) NOT NULL,
  `edit_who` int(11) DEFAULT NULL,
  `edit_time` datetime(6) NOT NULL,
  `session_key` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tax_solve_unsolve_session_key_d5099fb4_fk_tax_quest` (`session_key`),
  CONSTRAINT `tax_solve_unsolve_session_key_d5099fb4_fk_tax_quest` FOREIGN KEY (`session_key`) REFERENCES `tax_question_session` (`session_key`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tax_temp_knowledge
-- ----------------------------
DROP TABLE IF EXISTS `tax_temp_knowledge`;
CREATE TABLE `tax_temp_knowledge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` longtext NOT NULL,
  `question_clear` varchar(1000) NOT NULL,
  `extend_question` varchar(1000) NOT NULL,
  `keyword` varchar(50) DEFAULT NULL,
  `answer` longtext NOT NULL,
  `answer_clear` longtext NOT NULL,
  `add_date` date NOT NULL,
  `add_who` int(11) DEFAULT NULL,
  `add_time` datetime(6) NOT NULL,
  `edit_who` int(11) DEFAULT NULL,
  `edit_time` datetime(6) NOT NULL,
  `session_key` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tax_temp_knowledge_session_key_c922d27b_fk_tax_quest` (`session_key`),
  CONSTRAINT `tax_temp_knowledge_session_key_c922d27b_fk_tax_quest` FOREIGN KEY (`session_key`) REFERENCES `tax_question_session` (`session_key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES ('23', 'mgbase', 'taxquestionsession');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES ('24', 'mgbase', 'taxsessionanswer');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES ('22', 'mgbase', 'taxtempknowledge');

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('84', 'Can view 专家调整', '21', 'view_taxknowledgeproxy');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('85', 'Can add 专家回复', '22', 'add_taxtempknowledge');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('86', 'Can change 专家回复', '22', 'change_taxtempknowledge');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('87', 'Can delete 专家回复', '22', 'delete_taxtempknowledge');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('88', 'Can add 问答会话', '23', 'add_taxquestionsession');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('89', 'Can change 问答会话', '23', 'change_taxquestionsession');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('90', 'Can delete 问答会话', '23', 'delete_taxquestionsession');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('91', 'Can add 会话答案', '24', 'add_taxsessionanswer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('92', 'Can change 会话答案', '24', 'change_taxsessionanswer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('93', 'Can delete 会话答案', '24', 'delete_taxsessionanswer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('94', 'Can view 问答会话', '23', 'view_taxquestionsession');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('95', 'Can view 会话答案', '24', 'view_taxsessionanswer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES ('96', 'Can view 专家回复', '22', 'view_taxtempknowledge');

INSERT INTO `tax_bas_data` (`id`, `code`, `name`, `value`, `sort`, `desc`, `type`, `type_desc`, `add_who`, `add_time`, `edit_who`, `edit_time`) VALUES ('8', 'TEACHER_ONLINE', '老师是否在线', '0.00', NULL, '0：离线，1在线', 'GLOBAL_VAL', '全局变量', NULL, '2018-07-19 18:20:51.202323', NULL, '2018-07-21 09:47:59.246268');
