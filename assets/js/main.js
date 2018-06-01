// Variables racourcis

const userDisplay = document.querySelector('header .user');
const infoDisplay = document.querySelector('header .info');
const timerDisplay = document.querySelector('header .timer');
const percentDisplay = document.querySelector('header .percent');


const homePage = document.querySelector('#home');
const homeTitle = document.querySelector('#home .heading h1');
const homeSubTitle = document.querySelector('#home .heading h2');
const homeIcon = document.querySelector('#home .heading h1 i');

const signupForm = document.querySelector('#home form');

const quizPage = document.querySelector('#quiz');

const profilePage = document.querySelector('#profilePage');

const resultPage = document.querySelector('#results');
const scoreList = document.querySelector('#results .scoreList');
const restartBtn = document.querySelector('#results .restart');
const thisScoreDisplay = document.querySelector('#results .thisScore');
const bestScoreDisplay = document.querySelector('#results .bestScore');

const questionTemplate = document.querySelector('#templates .questionPage');
const choiceTemplate = document.querySelector('#templates .choice');
const resultTemplate = document.querySelector('#templates .result');
const profileTemplate = document.querySelector('#templates .profileBox');



let user;


let timer;
let total_seconds = 0;
let correctAnswers = 0;
let totalAnswers = 0;


// Fonction qui crées un quiz via les données du micro-api, puis démarres le timer.
const startQuiz = () => {

	updateUserDisplay();
	
	setTimeout(() => {
		quizPage.classList.add('fadeIn');

			fetch('/api/api.php?action=getQuiz')
			.then(response => response.json())
			.then(data => {

				buildQuiz(data.data);

				timer = setInterval(() => {
					total_seconds++;
					updateInfoDisplay();
				}, 1000);
			});

	}, 300);
}





const buildQuiz = quiz => {

	quizPage.innerHTML = '';

	quizPage.dataset.id = quiz.id;

	totalAnswers = quiz.questions.length;
	updateInfoDisplay();

	let i = 0;
	quiz.questions.forEach(question => {

		i++;

		let questionPage = questionTemplate.cloneNode(true);

		if (i > 1) {
			questionPage.classList.add('slideRight');
		}

		questionPage.dataset.answer = question.answer;
		questionPage.children[0].children[0].innerHTML = "Question " + i;
		questionPage.children[0].children[1].innerHTML = i + "/" + quiz.questions.length;
		questionPage.children[1].children[0].innerHTML = quiz.title;
		questionPage.children[1].children[1].innerHTML = question.question;
		questionPage.children[1].children[3].children[0].innerHTML = question.hint;


		if (i == quiz.questions.length) {
			questionPage.classList.add('last');
		}

		question.choices.forEach(choice => {
			let choiceButton = choiceTemplate.cloneNode(true);

			choiceButton.children[0].value = choice;
			choiceButton.children[1].innerHTML = choice;

			if (choice == question.answer) {
				choiceButton.classList.add('correctAnswer');
			}

			choiceButton.onclick = () => {
				questionPage.classList.add('wasAnswered');
			};

			questionPage.children[1].children[2].append(choiceButton);
		});


		questionPage.onsubmit = validateQuestion;

		quizPage.append(questionPage);

		void questionPage.clientWidth;
	});
}


const validateQuestion = ev => {
	ev.preventDefault();

	if (ev.target.classList.contains('validated')) {

		if (ev.target.nextSibling) {
			ev.target.classList.add('slideLeft');
			setTimeout(() => {
				ev.target.nextSibling.classList.remove('slideRight');
			}, 250);
		} else {
			finishQuiz();
		}
	} else {
		ev.target.classList.add('validated');
		if (ev.target.dataset.answer == ev.target.choice.value) {
			correctAnswers++;
			updateInfoDisplay();
			ev.target.children[1].children[3].children[1].classList.add('fadeIn');
		} else {
			ev.target.children[1].children[3].children[0].classList.add('fadeIn');
		}
	}
}







const finishQuiz = () => {
	clearInterval(timer);
	quizPage.classList.remove('fadeIn');
	setTimeout(() => {
		fetch('/api/api.php?action=newQuizResult', {
			method: 'post',
			headers: {
				'content-type': 'application/json'
			},
			body: JSON.stringify({
				user_id: user.id,
				quiz_id: quizPage.dataset.id,
				total_seconds: total_seconds,
				score: (correctAnswers/totalAnswers)*100
			})
		})
		.then(response => response.json())
		.then(data => {

			resultPage.classList.add('fadeIn');

			user = data.data;

			thisScoreDisplay.innerHTML = (Math.floor(correctAnswers / totalAnswers)*100) + '% en ' + total_seconds + ' sec';
			bestScoreDisplay.innerHTML = user.highscore.score + '% en ' + user.highscore.total_seconds + ' sec';


			total_seconds = 0;
			correctAnswers = 0;
			totalAnswers = 0;


			infoDisplay.classList.remove('slideDown');

			updateUserDisplay();

			buildScoreBoard();
		});
	}, 300);
}



const buildScoreBoard = () => {

	scoreList.innerHTML = '';

	fetch('/api/api.php?action=getScoreBoard')
	.then(response => response.json())
	.then(data => {
		let i = 0;
		data.data.forEach(result => {
			i++;
			let resultRow = resultTemplate.cloneNode(true);

			resultRow.children[0].innerHTML = i;
			resultRow.children[1].innerHTML = result.user.username;
			resultRow.children[2].innerHTML = result.score + "%";
			resultRow.children[3].innerHTML = getTimerString(result.total_seconds);
			resultRow.children[4].innerHTML = new Date(result.created_at).toLocaleString();


			resultRow.children[1].onclick = () => buildProfilePage(result.user);

			scoreList.append(resultRow);
		});
	});

}

const getTimerString = (total_seconds) => {

	let min = Math.floor(total_seconds/60);
	let sec = total_seconds%60;

	if (min > 0) {
		out = min + " min";
		if (sec > 0 ) {
			out += " " + sec + " sec";
		}
	} else {
		out =  sec + " sec";
	}

	return out;
}


const updateUserDisplay = () => {
	userDisplay.classList.add('slideDown');
	userDisplay.children[0].children[1].children[0].innerHTML = '#' + user.id;
	userDisplay.children[0].children[1].children[1].innerHTML = user.username;
	if (user.highscore) {
		userDisplay.children[1].innerHTML = 'Meilleur score: ' + user.highscore.score + '% en ' + user.highscore.total_seconds + ' sec';
	}
}
const updateInfoDisplay = () => {

	infoDisplay.classList.add('slideDown');

	// On met à jour le score en pourcentage
	if (totalAnswers > 0) {
		percentDisplay.innerHTML = Math.floor((correctAnswers/totalAnswers)*100) + "%";
	} else {
		percentDisplay.innerHTML = '';
	}


	// On met à jour les secondes
	timerDisplay.innerHTML = getTimerString(total_seconds);
}



const buildProfilePage = user => {

	resultPage.classList.remove('fadeIn');

	profilePage.innerHTML = '';

	let profileBox = profileTemplate.cloneNode(true);

	profileBox.children[0].children[0].innerHTML = 'Statistiques de ' + user.username;


	profileBox.children[1].children[0].children[0].children[1].innerHTML = user.highscore.score + '% en ' + user.highscore.total_seconds + ' sec';
	profileBox.children[1].children[0].children[0].children[2].innerHTML = new Date(user.highscore.created_at).toLocaleString();

	profileBox.children[1].children[0].children[1].children[1].innerHTML = user.lowest_score.score + '% en ' + user.lowest_score.total_seconds + ' sec';
	profileBox.children[1].children[0].children[1].children[2].innerHTML = new Date(user.lowest_score.created_at).toLocaleString();

	profileBox.children[1].children[1].children[1].innerHTML = Math.floor(user.average_score.avg_score) + '%';
	profileBox.children[1].children[2].children[1].innerHTML = getTimerString(Math.floor(user.average_time.avg_time));


	profileBox.children[0].children[1].onclick = () => {
		profilePage.classList.remove('fadeIn');
		setTimeout(() => {
			resultPage.classList.add('fadeIn');
		}, 300);
	}


	profilePage.append(profileBox);


	setTimeout(() => {
		profilePage.classList.add('fadeIn');
	}, 300);
	
}



// Gestion nouveaux utilisateurs
signupForm.onsubmit = ev => {
	ev.preventDefault();

	// On transform la soumission du formulaire en soumission AJAX, de facon progessive
	fetch(ev.target.action, {
		method: ev.target.method,
		headers: {
			'content-type': 'application/json'
		},
		body: JSON.stringify({
			username: ev.target.username.value
		})
	})
	.then(response => response.json())
	.then(data => {
		ev.target.reset();
		user = data.data;
		homePage.classList.remove('fadeIn');
		startQuiz();
	});

}




restartBtn.onclick = ev => {
	resultPage.classList.remove('fadeIn');
	startQuiz();
}








// Au chargement
document.body.onload = ev => {

	homePage.classList.add('fadeIn');

	setTimeout(() => {
		homeTitle.classList.remove('slideLeft');
	}, 300);

	setTimeout(() => {
		homeSubTitle.classList.remove('slideRight');
	}, 400);

	setTimeout(() => {
		homeIcon.classList.remove('scaleDown');
	}, 700);
}