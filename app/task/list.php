<?php
/**
* @file list.php
* @brief LISTA TASK
* @author JONATA CARDOSO DE SOUZA
* @date 10/03/2017
* @version 1.0
**/

require_once('../../config/conexao.php');

$strMethod = strtoupper($_SERVER['REQUEST_METHOD']);
$arrAllowedMethods = ['GET'];

if ( ! in_array($strMethod, $arrAllowedMethods)) {
	http_response_code(405);
	die;
}
$paramOrder = 1;
$codTask = isset($_GET['codTask']) ? (int) base64_decode($_GET['codTask']) : null;
$strCall = $dbaConexao->prepare("CALL sp_se_busca_task(?)");
$strCall->bindParam($paramOrder++, $codTask, PDO::PARAM_INT);
$strCall->execute();
$objRetorno = $strCall->fetchAll(PDO::FETCH_CLASS);
$strCall->closeCursor();

echo json_encode($objRetorno);
?>
