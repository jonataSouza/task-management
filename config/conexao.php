<?php
/**
* @file conexao.php
* @brief CONEXÃO DOCUMENTO
* @author JONATA C. DE SOUZA
* @date 10/03/2017
* @version 1.0
**/
include ('setup.php');

$dbaConexao = new PDO("mysql:host=".STRSERVIDOR.";dbname=".STRBD."", "".STRUSUARIO."", "".STRSENHA."",
	array(
		PDO::MYSQL_ATTR_LOCAL_INFILE => true,
		PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"
		));
global $dbaConexao;
?>
