<?php 

// Ce fichier contient une classe utilitaire qui fait le pont entre php et la base de données.
// Elle possède des methodes qui donne les données de facon structurés à l'api.
// Elle n'est pas, par elle même, l'api.

// Les méthodes acceptent en paramètres des tableaux associatifs pour paramétrer les requêtes et 
// retournent les données de facon structuré.



class Datalayer {
	

	protected $mysqli;



	public function __construct() {


		$host = 'localhost';
		$database = 'quiz';
		$username = 'root';
		$password = '';

		$this->mysqli = new mysqli($host, $username, $password, $database);

		if ($this->mysqli->connect_error) {
			die('Erreure lors de la connection à la base de données');
		}

	}








	public function getUser($data) {

		if (!isset($data['id'])) {
			die('User ID required');
		}

		$sql = 'SELECT * FROM users WHERE id = '.$data['id'].' LIMIT  1';

		$user = $this->mysqli->query($sql)->fetch_assoc();


		$sql = '
			SELECT 
				* 
			FROM 
				quiz_results
			WHERE
				user_id = '.$user['id'].'
			ORDER BY 
				score DESC ,
				total_seconds ASC
		';

		$result = $this->mysqli->query($sql);

		$user['total_plays'] = $result->num_rows;

		$user['highscore'] = $result->fetch_assoc();




		$sql = '
			SELECT 
				* 
			FROM 
				quiz_results
			WHERE
				user_id = '.$user['id'].'
			ORDER BY 
				score ASC ,
				total_seconds DESC
		';

		$user['lowest_score'] = $this->mysqli->query($sql)->fetch_assoc();


		$sql = 'SELECT AVG(score) as avg_score FROM quiz_results WHERE user_id = '.$user['id'] . '';

		$user['average_score'] = $this->mysqli->query($sql)->fetch_assoc();


		$sql = 'SELECT AVG(total_seconds) as avg_time FROM quiz_results WHERE user_id = '.$user['id'] . '';

		$user['average_time'] = $this->mysqli->query($sql)->fetch_assoc();



		return $user;
	}






	public function getUsers($data) {

		$sql = 'SELECT * FROM users ORDER BY created_at DESC ';

		$result = $this->mysqli->query($sql);

		$users = [];

		if ($result->num_rows > 0) {
			while ($row = $result->fetch_assoc()) {
				$users[] = $row;
			}
		}


		return $users;
	}





	public function loginOrCreateUser($data) {

		if (!isset($data['username'])) {
			die('Aucun nom choisis');
		}



		$sql = 'SELECT * FROM users WHERE username = "'.$data['username'].'" LIMIT  1';

		$result = $this->mysqli->query($sql);

		$user = $result->fetch_assoc();

		if ($user) {

			return $this->getUser(['id' => $user['id']]);

		} else {

			$sql = '
				INSERT INTO
					users (username)
				VALUES
					("'.$data['username'].'")
			';

			$this->mysqli->query($sql);

			return $this->getUser(['id' => $this->mysqli->insert_id]);
		}


	}




	public function getQuiz($data) {



		$sql = 'SELECT * FROM quizes ORDER BY RAND() LIMIT 1';


		$quiz = $this->mysqli->query($sql)->fetch_assoc();



		$sql = 'SELECT * FROM questions WHERE quiz_id = '.$quiz['id'].' ORDER BY RAND() LIMIT 5';


		$result = $this->mysqli->query($sql);



		$questions = [];

		if ($result->num_rows > 0) {
			while ($row = $result->fetch_assoc()) {
				$row['choices'] = json_decode($row['choices']);
				shuffle($row['choices']);
				$questions[] = $row;
			}
		}

		$quiz['questions'] = $questions;


		return $quiz;
	}







	public function getQuizResult($data) {

		if (!isset($data['id'])) {
			die('Pas de quiz spécifié');
		}

		$sql = 'SELECT * FROM quiz_results WHERE id = '.$data['id'].' LIMIT  1';

		$result = $this->mysqli->query($sql);

		$quizResult = $result->fetch_assoc();

		return $quizResult;
	}





	public function newQuizResult($data) {

		if (!isset($data['user_id'])) {
			die('Aucun utilisateur spécifié');
		}

		if (!isset($data['quiz_id'])) {
			die('Aucun quiz spécifié');
		}

		if (!isset($data['total_seconds'])) {
			die('Aucun temps spécifié');
		}

		if (!isset($data['score'])) {
			die('Aucun score spécifié');
		}



		$sql = '
			INSERT INTO
				quiz_results (user_id, quiz_id, total_seconds, score)
			VALUES
				('.$data['user_id'].', '.$data['quiz_id'].', '.$data['total_seconds'].', '.$data['score'].')
		';


		$this->mysqli->query($sql);


		return $this->getUser(['id' => $data['user_id']]);
	}






	public function getScoreBoard($data) {


		$sql = '
			SELECT 
				* 
			FROM 
				quiz_results
			ORDER BY 
				score DESC ,
				total_seconds ASC
			LIMIT 10
		';

		$result = $this->mysqli->query($sql);

		$scoreBoard = [];

		if ($result->num_rows > 0) {
			while ($row = $result->fetch_assoc()) {
				$row['user'] = $this->getUser(['id' => $row['user_id']]);
				$scoreBoard[] = $row;
			}
		}


		return $scoreBoard;
	}





}


?>