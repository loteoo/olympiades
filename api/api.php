<?php 

// Ce fichier est un micro API php, qui convertis les requetes GET, POST et l'entrée json en tableau associatif,
// puis appel les methodes appropriés de l'objet "DataLayer".

// Ensuite, cet API converti les données du DataLayer en JSON puis le retourne aux clients de facon standardisé.


include('DataLayer.class.php');

if (isset($_GET['action'])) {

	$dataLayer = new DataLayer();

	$action = $_GET["action"];


	$input = array_merge($_POST, $_GET);

	$jsonInput = json_decode(file_get_contents('php://input'), true);

	if (is_array($jsonInput)) {
		$input = array_merge($input, $jsonInput);
	}


	$output = $dataLayer->$action($input);

	if ($output) {
		$response = [
			'success' => true,
			'data' => $output
		];
	} else {
		$response = [
			'success' => false
		];
	}

	header('Content-Type: application/json');
	echo json_encode($response, JSON_PRETTY_PRINT);
	exit();

} else {
	echo "Invalid request";
}


?>