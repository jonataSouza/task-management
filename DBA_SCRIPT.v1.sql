/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.15 : Database - task
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`task` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `task`;

/*Table structure for table `status` */

DROP TABLE IF EXISTS `status`;

CREATE TABLE `status` (
  `cod_status` int(11) NOT NULL AUTO_INCREMENT,
  `dsc_status` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`cod_status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `status` */

insert  into `status`(`cod_status`,`dsc_status`) values (0,'NOK'),(1,'OK');

/*Table structure for table `task` */

DROP TABLE IF EXISTS `task`;

CREATE TABLE `task` (
  `cod_task` int(11) NOT NULL AUTO_INCREMENT,
  `cod_status` int(11) DEFAULT NULL,
  `dsc_task` varchar(255) DEFAULT NULL,
  `dat_inc` datetime DEFAULT NULL,
  `dat_alt` datetime DEFAULT NULL,
  PRIMARY KEY (`cod_task`),
  KEY `FK_COD_STATUS` (`cod_status`),
  CONSTRAINT `FK_COD_STATUS` FOREIGN KEY (`cod_status`) REFERENCES `status` (`cod_status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `task` */

insert  into `task`(`cod_task`,`cod_status`,`dsc_task`,`dat_inc`,`dat_alt`) values (2,1,'Teste task','2017-03-10 13:37:30','2017-03-10 13:40:47'),(3,0,'Task YPTO','2017-03-10 13:40:14','2017-03-10 13:40:26');

/* Procedure structure for procedure `sp_de_task` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_de_task` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`admin`@`%` PROCEDURE `sp_de_task`(IN `p_cod_task` INT)
sp_de_task:BEGIN
/**
* @brief EXCLUI TASK
* @author JONATA CARDOSO DE SOUZA
* @date 09/03/2017
* @param p_cod_task - CODIGO DA TASK
* @return CASO ERRO DE SQL - RETORNO DA OPERACAO
* @version 1.0
*/
DECLARE v_excecao SMALLINT DEFAULT 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET v_excecao = 1;
START TRANSACTION;
-- DELETA REGISTRO
DELETE FROM task WHERE cod_task = p_cod_task;
	
-- TRATAMENTO RETORNO
IF v_excecao = 1 THEN
	ROLLBACK;
	SELECT v_excecao AS cod_retorno, 'Erro ao salvar registo!' AS str_retorno;
ELSE
	COMMIT;
	SELECT v_excecao AS cod_retorno, 'Registro salvo com sucesso!' AS str_retorno;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_in_task` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_in_task` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`admin`@`%` PROCEDURE `sp_in_task`(IN `p_dsc_task` varchar(255) ,`p_cod_status` TINYINT)
sp_in_task:BEGIN
/**
* @brief REALIZA A INCLUSAO TASK
* @author JONATA CARDOSO DE SOUZA
* @date 09/03/2017
* @param p_dsc_marca - DESCRICAO TASK
* @param p_cod_status - STATUS TASK
* @return COD_ERRO - RETORNO DA OPERACAO
* @version 1.0
*/
DECLARE v_excecao SMALLINT DEFAULT 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET v_excecao = 1;
START TRANSACTION;
-- TRATAMENTO REGISTRO DUPLICADO
SET v_excecao = (SELECT COUNT(*) FROM task WHERE dsc_task = p_dsc_task LIMIT 1);
IF (v_excecao = 1) THEN
	SELECT v_excecao AS cod_retorno, 'Registro duplicado!' AS str_retorno;
	LEAVE sp_in_task;
END IF;
-- INSERE REGISTRO
INSERT INTO task(
	dsc_task,
	cod_status,
	dat_inc
)
VALUES(
	p_dsc_task,
	p_cod_status,
	NOW()
);
-- TRATAMENTO RETORNO
IF v_excecao = 1 THEN
	ROLLBACK;
	SELECT v_excecao AS cod_retorno, 'Erro ao salvar registo!' AS str_retorno;
ELSE
	COMMIT;
	SELECT v_excecao AS cod_retorno, 'Registro salvo com sucesso!' AS str_retorno;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_se_busca_task` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_se_busca_task` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`admin`@`%` PROCEDURE `sp_se_busca_task`(IN `p_cod_task` int)
BEGIN
/**
* @brief BUSCA TASK
* @author JONATA CARDOSO DE SOUZA
* @date 09/03/2017
* @return RETORNA DATA
* @version 1.0
*/
SELECT 
	t.cod_task,
	t.cod_status,
	t.dsc_task,
	t.dat_inc,
	s.dsc_status
FROM
task AS t
inner join `status` as s
on t.cod_status=s.cod_status
where t.cod_task = if(p_cod_task is null, t.cod_task,p_cod_task);
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_up_task` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_up_task` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`admin`@`%` PROCEDURE `sp_up_task`(IN `p_cod_task` INT, IN `p_nom_task` VARCHAR(255), IN `p_cod_status` TINYINT)
sp_up_task:BEGIN
/**
* @brief ATUALIZACAO TASK
* @author JONATA CARDOSO DE SOUZA
* @date 09/03/2017
* @param p_cod_task - CODIGO TASK
* @param p_nom_task - NOME TASK
* @param p_cod_status - STATUS TASK
* @return CASO ERRO DE SQL - RETORNO DA OPERACAO
* @version 1.0
*/
DECLARE v_excecao SMALLINT DEFAULT 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET v_excecao = 1;
START TRANSACTION;
-- TRATAMENTO REGISTRO DUPLICADO
SET v_excecao = (SELECT COUNT(*) FROM task WHERE dsc_task = p_nom_task AND cod_task != p_cod_task LIMIT 1);
IF (v_excecao = 1) THEN
	SELECT v_excecao as cod_retorno, 'Registro duplicado!' as str_retorno;
	LEAVE sp_up_task;
END IF;
-- ATUALIZA REGISTRO
UPDATE task t SET
	t.dsc_task = p_nom_task,
	t.cod_status = p_cod_status,
	t.dat_alt = NOW()
WHERE
	t.cod_task = p_cod_task;
	
-- TRATAMENTO RETORNO
IF v_excecao = 1 THEN
	ROLLBACK;
	SELECT v_excecao as cod_retorno, 'Erro ao salvar registo!' as str_retorno;
ELSE
	COMMIT;
	SELECT v_excecao as cod_retorno, 'Registro salvo com sucesso!' as str_retorno;
END IF;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
