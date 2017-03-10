<?php
/**
* @file persist.php
* @brief PERIST
* @author JONATA CARDOSO DE SOUZA
* @date 10/03/2017
* @version 1.0
**/

require_once('../../config/conexao.php');

$strMethod = strtoupper($_SERVER['REQUEST_METHOD']);
$arrAllowedMethods = ['POST'];

if ( ! in_array($strMethod, $arrAllowedMethods)) {
	http_response_code(405);
	die;
}

$objData = json_decode(file_get_contents('php://input'), true);

$codTask = $objData['cod_task'];

if ($codTask <> null) {
	$strSql = 'CALL sp_up_task(?, ?, ?)';
} else {
	$strSql = 'CALL sp_in_task(?, ?)';
}

$paramOrder = 1;
$strCall = $dbaConexao->prepare($strSql);

if ($codTask <> null) {
	$strCall->bindParam($paramOrder++, $codTask, PDO::PARAM_INT);
}

$strCall->bindParam($paramOrder++, $objData['dsc_task'], PDO::PARAM_STR);
$strCall->bindParam($paramOrder++, $objData['cod_status'], PDO::PARAM_INT);
$strCall->execute();
$objRetorno= $strCall->fetchObject();
$strCall->closeCursor();

if ($objRetorno->cod_retorno != 0) {
	http_response_code(400);
}

echo json_encode(['str_retorno' => $objRetorno->str_retorno]);
?>