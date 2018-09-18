-- ----------------------------
-- Table structure for tax_extend_question_synonym
-- ----------------------------
DROP TABLE IF EXISTS `tax_extend_question_synonym`;
CREATE TABLE `tax_extend_question_synonym` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `add_who` int(11) DEFAULT NULL,
  `add_time` datetime(6) NOT NULL,
  `edit_who` int(11) DEFAULT NULL,
  `edit_time` datetime(6) NOT NULL,
  `extend_question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tax_extend_question__extend_question_id_76b4c85b_fk_tax_exten` (`extend_question_id`),
  CONSTRAINT `tax_extend_question__extend_question_id_76b4c85b_fk_tax_exten` FOREIGN KEY (`extend_question_id`) REFERENCES `tax_extend_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


alter table tax_knowledge add class_tag varchar(100);