<?php
/**
* @file remove.php
* @brief REMOVE
* @author JONATA CARDOSO DE SOUZA
* @date 10/03/2017
* @version 1.0
**/
require_once('../../config/conexao.php');

$strMethod = strtoupper($_SERVER['REQUEST_METHOD']);
$arrAllowedMethods = ['DELETE'];

if ( ! in_array($strMethod, $arrAllowedMethods)) {
	http_response_code(405);
	die;
}

$strCall = $dbaConexao->prepare("CALL sp_de_task(?)");
$strCall->bindParam(1, $_GET['codTask'], PDO::PARAM_INT);
$strCall->execute();
$objRetorno= $strCall->fetchObject();
$strCall->closeCursor();

if ($objRetorno->cod_retorno != 0) {
	http_response_code(400);
}

echo json_encode(['str_retorno' => $objRetorno->str_retorno]);
?>
