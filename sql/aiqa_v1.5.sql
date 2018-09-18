-- ----------------------------
-- Table structure for tax_unsolve_mail
-- ----------------------------
DROP TABLE IF EXISTS `tax_unsolve_mail`;
CREATE TABLE `tax_unsolve_mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  `desc` varchar(1000),
  `add_who` int(11) DEFAULT NULL,
  `add_time` datetime(6) NOT NULL,
  `edit_who` int(11) DEFAULT NULL,
  `edit_time` datetime(6) NOT NULL,
  `session_key` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tax_unsolve_mail_session_key_25493902_fk_tax_quest` (`session_key`),
  CONSTRAINT `tax_unsolve_mail_session_key_25493902_fk_tax_quest` FOREIGN KEY (`session_key`) REFERENCES `tax_question_session` (`session_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table tax_session_answer;
drop table tax_temp_knowledge;

delete from tax_bas_data where code = 'TEACHER_ONLINE';
delete from tax_bas_data where code = 'TEACHER_EMAIL';
INSERT INTO `tax_bas_data` (`code`, `name`, `value`, `sort`, `desc`, `type`, `type_desc`, `add_who`, `add_time`, `edit_who`, `edit_time`) VALUES ('TEACHER_EMAIL', 'xujunjian@yhsoft.com', NULL, NULL, '智能问答老师邮箱', 'PARAM_SETTINGS', '参数设置类', NULL, '2018-09-04', NULL, '2018-09-04');

INSERT INTO `tax_kbase`.`tax_knowledge` (`id`, `counter`, `sd_question`, `sd_answer`, `add_who`, `add_time`, `edit_who`, `edit_time`, `class_tag`) VALUES ('33127', '5', '工资xxx，应该缴纳多少个税？', '<p>您提出的问题中必须包含{0}数。<br/>在没有扣除各项社会保险/公积金的情况下，您应该缴纳{0}元个税。<br/>您应该缴纳{0}元个税。</p>', NULL, '2018-09-05 17:54:34.845861', NULL, '2018-09-12 17:45:43.230884', NULL);

INSERT INTO `tax_extend_question_header` (`id`, `desc`, `add_who`, `add_time`, `edit_who`, `edit_time`, `knowledge_id`) VALUES ('66370', '工资xxx，应该缴纳多少个税？', NULL, '2018-09-06 17:28:59.186065', NULL, '2018-09-06 17:28:59.186116', '33127');
INSERT INTO `tax_extend_question_header` (`id`, `desc`, `add_who`, `add_time`, `edit_who`, `edit_time`, `knowledge_id`) VALUES ('66371', '工资xxx，社会保险/五险一金/保险/公积金xxx，应该缴纳多少个税？', NULL, '2018-09-06 17:28:59.220912', NULL, '2018-09-06 17:28:59.220949', '33127');
INSERT INTO `tax_extend_question_header` (`id`, `desc`, `add_who`, `add_time`, `edit_who`, `edit_time`, `knowledge_id`) VALUES ('66372', '工资xxx，社会保险/五险/保险xxx，公积金xxx，应该缴纳多少个税？', NULL, '2018-09-06 17:28:59.270225', NULL, '2018-09-06 17:28:59.270266', '33127');
INSERT INTO `tax_extend_question_header` (`id`, `desc`, `add_who`, `add_time`, `edit_who`, `edit_time`, `knowledge_id`) VALUES ('66373', '工资xxx，公积金xxx，应该缴纳多少个税？', NULL, '2018-09-06 17:28:59.322458', NULL, '2018-09-06 17:28:59.322494', '33127');

INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349003', '0.333333', '5.103757', '5.103752', '3.00', NULL, '2018-09-06 17:28:59.187343', NULL, '2018-09-06 17:28:59.187378', '66370', '工资');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349004', '0.333333', '2.087740', '0.695913', '1.00', NULL, '2018-09-06 17:28:59.206696', NULL, '2018-09-06 17:28:59.206733', '66370', '缴纳');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349005', '0.333333', '7.605193', '2.535062', '1.00', NULL, '2018-09-06 17:28:59.215109', NULL, '2018-09-06 17:28:59.215143', '66370', '个税');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349006', '0.250000', '5.103757', '5.103757', '4.00', NULL, '2018-09-06 17:28:59.222124', NULL, '2018-09-06 17:28:59.222159', '66371', '工资');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349007', '0.250000', '7.605193', '1.901298', '1.00', NULL, '2018-09-06 17:28:59.242515', NULL, '2018-09-06 17:28:59.242551', '66371', '社会保险');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349008', '0.250000', '2.087740', '0.521935', '1.00', NULL, '2018-09-06 17:28:59.256116', NULL, '2018-09-06 17:28:59.256151', '66371', '缴纳');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349009', '0.250000', '7.605193', '1.901298', '1.00', NULL, '2018-09-06 17:28:59.264147', NULL, '2018-09-06 17:28:59.264182', '66371', '个税');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349010', '0.200000', '5.103757', '5.103757', '5.00', NULL, '2018-09-06 17:28:59.271715', NULL, '2018-09-06 17:28:59.271752', '66372', '工资');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349011', '0.200000', '7.605193', '1.521039', '1.00', NULL, '2018-09-06 17:28:59.291545', NULL, '2018-09-06 17:28:59.291581', '66372', '社会保险');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349012', '0.200000', '7.828337', '1.565667', '1.00', NULL, '2018-09-06 17:28:59.302494', NULL, '2018-09-06 17:28:59.302529', '66372', '公积金');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349013', '0.200000', '2.087740', '0.417548', '1.00', NULL, '2018-09-06 17:28:59.307837', NULL, '2018-09-06 17:28:59.307874', '66372', '缴纳');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349014', '0.200000', '7.605193', '1.521039', '1.00', NULL, '2018-09-06 17:28:59.316650', NULL, '2018-09-06 17:28:59.316698', '66372', '个税');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349015', '0.250000', '5.103757', '5.103757', '4.00', NULL, '2018-09-06 17:28:59.323632', NULL, '2018-09-06 17:28:59.323667', '66373', '工资');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349016', '0.250000', '7.828337', '1.957084', '1.00', NULL, '2018-09-06 17:28:59.344000', NULL, '2018-09-06 17:28:59.344036', '66373', '公积金');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349017', '0.250000', '2.087740', '0.521935', '1.00', NULL, '2018-09-06 17:28:59.349938', NULL, '2018-09-06 17:28:59.349975', '66373', '缴纳');
INSERT INTO `tax_extend_question` (`id`, `tf_value`, `idf_value`, `weighted_value`, `amplification`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`, `keyword`) VALUES ('349018', '0.250000', '7.605193', '1.901298', '1.00', NULL, '2018-09-06 17:28:59.358871', NULL, '2018-09-06 17:28:59.358909', '66373', '个税');

INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2630', '收入', NULL, '2018-09-06 17:28:59.192169', NULL, '2018-09-06 17:28:59.192210', '349003');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2631', '月薪', NULL, '2018-09-06 17:28:59.194757', NULL, '2018-09-06 17:28:59.194830', '349003');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2632', '人工', NULL, '2018-09-06 17:28:59.197398', NULL, '2018-09-06 17:28:59.197435', '349003');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2633', '薪水', NULL, '2018-09-06 17:28:59.200098', NULL, '2018-09-06 17:28:59.200144', '349003');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2634', '薪资', NULL, '2018-09-06 17:28:59.202977', NULL, '2018-09-06 17:28:59.203017', '349003');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2635', '薪酬', NULL, '2018-09-06 17:28:59.205556', NULL, '2018-09-06 17:28:59.205591', '349003');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2636', '交纳', NULL, '2018-09-06 17:28:59.211335', NULL, '2018-09-06 17:28:59.211375', '349004');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2637', '交', NULL, '2018-09-06 17:28:59.214008', NULL, '2018-09-06 17:28:59.214045', '349004');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2638', '个人所得税', NULL, '2018-09-06 17:28:59.219719', NULL, '2018-09-06 17:28:59.219865', '349005');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2639', '收入', NULL, '2018-09-06 17:28:59.227546', NULL, '2018-09-06 17:28:59.227588', '349006');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2640', '月薪', NULL, '2018-09-06 17:28:59.230234', NULL, '2018-09-06 17:28:59.230271', '349006');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2641', '人工', NULL, '2018-09-06 17:28:59.233319', NULL, '2018-09-06 17:28:59.233359', '349006');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2642', '薪水', NULL, '2018-09-06 17:28:59.236144', NULL, '2018-09-06 17:28:59.236181', '349006');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2643', '薪资', NULL, '2018-09-06 17:28:59.238881', NULL, '2018-09-06 17:28:59.238918', '349006');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2644', '薪酬', NULL, '2018-09-06 17:28:59.241400', NULL, '2018-09-06 17:28:59.241437', '349006');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2645', '五险一金', NULL, '2018-09-06 17:28:59.246862', NULL, '2018-09-06 17:28:59.246901', '349007');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2646', '五险', NULL, '2018-09-06 17:28:59.249582', NULL, '2018-09-06 17:28:59.249643', '349007');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2647', '保险', NULL, '2018-09-06 17:28:59.252283', NULL, '2018-09-06 17:28:59.252320', '349007');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2648', '社保', NULL, '2018-09-06 17:28:59.254998', NULL, '2018-09-06 17:28:59.255036', '349007');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2649', '交纳', NULL, '2018-09-06 17:28:59.260262', NULL, '2018-09-06 17:28:59.260299', '349008');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2650', '交', NULL, '2018-09-06 17:28:59.262952', NULL, '2018-09-06 17:28:59.262990', '349008');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2651', '个人所得税', NULL, '2018-09-06 17:28:59.268423', NULL, '2018-09-06 17:28:59.268463', '349009');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2652', '收入', NULL, '2018-09-06 17:28:59.277070', NULL, '2018-09-06 17:28:59.277112', '349010');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2653', '月薪', NULL, '2018-09-06 17:28:59.279903', NULL, '2018-09-06 17:28:59.279941', '349010');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2654', '人工', NULL, '2018-09-06 17:28:59.282580', NULL, '2018-09-06 17:28:59.282617', '349010');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2655', '薪水', NULL, '2018-09-06 17:28:59.285236', NULL, '2018-09-06 17:28:59.285273', '349010');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2656', '薪资', NULL, '2018-09-06 17:28:59.287708', NULL, '2018-09-06 17:28:59.287744', '349010');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2657', '薪酬', NULL, '2018-09-06 17:28:59.290380', NULL, '2018-09-06 17:28:59.290418', '349010');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2658', '五险', NULL, '2018-09-06 17:28:59.296049', NULL, '2018-09-06 17:28:59.296093', '349011');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2659', '保险', NULL, '2018-09-06 17:28:59.298807', NULL, '2018-09-06 17:28:59.298861', '349011');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2660', '社保', NULL, '2018-09-06 17:28:59.301391', NULL, '2018-09-06 17:28:59.301428', '349011');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2661', '住房公积金', NULL, '2018-09-06 17:28:59.306666', NULL, '2018-09-06 17:28:59.306703', '349012');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2662', '交纳', NULL, '2018-09-06 17:28:59.312475', NULL, '2018-09-06 17:28:59.312517', '349013');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2663', '交', NULL, '2018-09-06 17:28:59.315519', NULL, '2018-09-06 17:28:59.315587', '349013');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2664', '个人所得税', NULL, '2018-09-06 17:28:59.321402', NULL, '2018-09-06 17:28:59.321444', '349014');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2665', '收入', NULL, '2018-09-06 17:28:59.328193', NULL, '2018-09-06 17:28:59.328236', '349015');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2666', '月薪', NULL, '2018-09-06 17:28:59.331699', NULL, '2018-09-06 17:28:59.331740', '349015');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2667', '人工', NULL, '2018-09-06 17:28:59.334456', NULL, '2018-09-06 17:28:59.334493', '349015');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2668', '薪水', NULL, '2018-09-06 17:28:59.337169', NULL, '2018-09-06 17:28:59.337206', '349015');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2669', '薪资', NULL, '2018-09-06 17:28:59.339828', NULL, '2018-09-06 17:28:59.339870', '349015');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2670', '薪酬', NULL, '2018-09-06 17:28:59.342645', NULL, '2018-09-06 17:28:59.342686', '349015');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2671', '住房公积金', NULL, '2018-09-06 17:28:59.348611', NULL, '2018-09-06 17:28:59.348652', '349016');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2672', '交纳', NULL, '2018-09-06 17:28:59.354675', NULL, '2018-09-06 17:28:59.354717', '349017');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2673', '交', NULL, '2018-09-06 17:28:59.357610', NULL, '2018-09-06 17:28:59.357649', '349017');
INSERT INTO `tax_extend_question_synonym` (`id`, `word`, `add_who`, `add_time`, `edit_who`, `edit_time`, `extend_question_id`) VALUES ('2674', '个人所得税', NULL, '2018-09-06 17:28:59.363334', NULL, '2018-09-06 17:28:59.363374', '349018');
